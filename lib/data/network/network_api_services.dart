import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../data/network/base_api_services.dart';
import '../app_exceptions.dart';

class NetworkApiServices extends BaseApiServices {
  // Instancia de Dio con configuración base: tiempo de espera y encabezados globales
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': dotenv.env['API_KEY'] ?? '', // Clave API desde archivo .env
      },
    ),
  );

  // Método GET que realiza una solicitud a la URL especificada
  @override
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print('[GET] $url');
    }

    try {
      final response = await _dio.get(url);
      return returnResponse(response); // Manejo centralizado de la respuesta
    } on DioException catch (e) {
      return handleDioError(e); // Manejo de errores específicos de Dio
    } on SocketException {
      throw InternetException('No hay conexión a Internet');
    }
  }

  // Método POST que envía datos en formato JSON a la URL especificada
  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print('[POST] $url');
      print('[DATA] $data');
    }

    try {
      final response = await _dio.post(url, data: data);
      return returnResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
    } on SocketException {
      throw InternetException('No hay conexión a Internet');
    }
  }

  // Manejo de respuestas HTTP según código de estado
  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200: // OK
      case 400: // Error del cliente
      case 403: // Prohibido
      case 404: // No encontrado
      case 500: // Error interno del servidor
        return response.data;
      case 429: // Demasiadas solicitudes
        return {
          "status": "error",
          "codigo_http": 429,
          "respuesta": null,
          "error": "Has realizado demasiadas solicitudes. Por favor, espera un momento antes de volver a intentar."
        };
      default:
        throw FetchDataException(
          'Error al comunicarse con el servidor: ${response.statusCode}',
        );
    }
  }

  // Manejo de errores específicos que pueden ocurrir al usar Dio
  dynamic handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw RequestTimeOut('Tiempo de espera agotado');
    } else if (e.type == DioExceptionType.badResponse && e.response != null) {
      return returnResponse(e.response!);
    } else if (e.type == DioExceptionType.unknown && e.error is SocketException) {
      throw InternetException('No hay conexión a Internet');
    } else {
      throw FetchDataException('Ocurrió un error inesperado');
    }
  }
}
