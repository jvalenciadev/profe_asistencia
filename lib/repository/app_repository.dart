

import '../models/app_model.dart';

import '../../data/network/network_api_services.dart';
import '../../res/app_url/app_url.dart';
import '../models/asistencia_model.dart';
import '../models/participante_model.dart';
import '../models/reporte_model.dart';

class AppInfoRepository {

  final _apiService  = NetworkApiServices() ;
 

  Future<AppInfoModel> appInfoApi() async{
    dynamic response = await _apiService.getApi(AppUrl.appInfo);
    return AppInfoModel.fromJson(response) ;
  }

  Future<ListaPartModal> listParticipantesApi() async{
    dynamic response = await _apiService.getApi(AppUrl.listPart);
    return ListaPartModal.fromJson(response) ;
  }
  Future<ReporteInscritosModal> reporteEventotApi() async{
    dynamic response = await _apiService.getApi(AppUrl.reporteEvento);
    return ReporteInscritosModal.fromJson(response) ;
  }
  Future<AsistenciaModal> asistenciaBarcodeApi(
    Map<String, dynamic> data,
  ) async {
    dynamic response = await _apiService.postApi(
      data,
      AppUrl.asistenciaBarcode,
    );
    return AsistenciaModal.fromJson(response);
  }
  Future<AsistenciaModal> noAsistenciaBarcodeApi(
    Map<String, dynamic> data,
  ) async {
    dynamic response = await _apiService.postApi(
      data,
      AppUrl.noAsistenciaBarcode,
    );
    return AsistenciaModal.fromJson(response);
  }
}