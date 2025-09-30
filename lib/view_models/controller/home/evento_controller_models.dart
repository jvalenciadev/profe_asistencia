import 'package:get/get.dart';
import '../../../data/response/api_response.dart';
import '../../../data/response/status.dart';
import '../../../models/asistencia_model.dart';
import '../../../models/participante_model.dart';
import '../../../models/reporte_model.dart';
import '../../../repository/app_repository.dart';

class EventoController extends GetxController {
  final _evento = AppInfoRepository();



  final participanteList = ListaPartModal().obs;
  final participanteLisStatus = Status.LOADING.obs;
  final error = ''.obs;
  void loadListaParticipantes() {
    participanteLisStatus.value = Status.LOADING;
    _evento
        .listParticipantesApi()
        .then((res) {
          participanteList.value = res;
          participanteLisStatus.value = Status.COMPLETED;
        })
        .catchError((err) {
          error.value = err.toString();
          participanteLisStatus.value = Status.ERROR;
        });
  }

  final inscripcionResponse =
      ApiResponse<AsistenciaModal>(Status.IDLE, null, null).obs;
  void eventoAsistenciaPost(Map<String, dynamic> data) {
    // Cambiar estado a "cargando" mientras se realiza la petición
    inscripcionResponse.value = ApiResponse.loading();

    // Llamar al método de inscripción que retorna un Future
    _evento
        .asistenciaBarcodeApi(data)
        .then((personaModel) {
          inscripcionResponse.value = ApiResponse.completed(personaModel);
          print("📦 Contenido completo: ${personaModel.toJson()}");
        })
        .catchError((err, stackTrace) {
          // Si ocurre un error, actualizar el estado a "error"
          inscripcionResponse.value = ApiResponse.error(err.toString());

          // Mostrar el error básico
          print("❌ Error en inscripción: ${err.toString()}");

          // Mostrar el stack trace para mayor contexto (ayuda a depurar)
          print("📌 StackTrace:");
          print(stackTrace);

          // Si el error tiene más detalles, intenta mostrarlos
          if (err is Exception) {
            print("⚠️ Error tipo Exception: ${err.runtimeType}");
          } else {
            print("⚠️ Error desconocido: ${err}");
          }
        });
  }
  final noInscripcionResponse =
      ApiResponse<AsistenciaModal>(Status.IDLE, null, null).obs;
  void eventoNoAsistenciaPost(Map<String, dynamic> data) {
    // Cambiar estado a "cargando" mientras se realiza la petición
    inscripcionResponse.value = ApiResponse.loading();

    // Llamar al método de inscripción que retorna un Future
    _evento
        .noAsistenciaBarcodeApi(data)
        .then((personaModel) {
          inscripcionResponse.value = ApiResponse.completed(personaModel);
          print("📦 Contenido completo: ${personaModel.toJson()}");
        })
        .catchError((err, stackTrace) {
          // Si ocurre un error, actualizar el estado a "error"
          inscripcionResponse.value = ApiResponse.error(err.toString());

          // Mostrar el error básico
          print("❌ Error en inscripción: ${err.toString()}");

          // Mostrar el stack trace para mayor contexto (ayuda a depurar)
          print("📌 StackTrace:");
          print(stackTrace);

          // Si el error tiene más detalles, intenta mostrarlos
          if (err is Exception) {
            print("⚠️ Error tipo Exception: ${err.runtimeType}");
          } else {
            print("⚠️ Error desconocido: ${err}");
          }
        });
  }

  final reporteIns = ReporteInscritosModal().obs;
  final reporteInsStatus = Status.LOADING.obs;
  void loadReporteIns() {
    reporteInsStatus.value = Status.LOADING;
    _evento
        .reporteEventotApi()
        .then((res) {
          reporteIns.value = res;
          reporteInsStatus.value = Status.COMPLETED;
        })
        .catchError((err) {
          error.value = err.toString();
          reporteInsStatus.value = Status.ERROR;
        });
  }

}