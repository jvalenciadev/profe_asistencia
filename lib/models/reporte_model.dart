class ReporteInscritosModal {
  final String? status;
  final int? codigoHttp;
  final ReporteRespuesta? respuesta;
  final String? error;

  ReporteInscritosModal({
    this.status,
    this.codigoHttp,
    this.respuesta,
    this.error,
  });

  factory ReporteInscritosModal.fromJson(Map<String, dynamic> json) {
    return ReporteInscritosModal(
      status: json['status'] as String?,
      codigoHttp: json['codigo_http'] as int?,
      respuesta: json['respuesta'] != null
          ? ReporteRespuesta.fromJson(json['respuesta'])
          : null,
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'codigo_http': codigoHttp,
      'respuesta': respuesta?.toJson(),
      'error': error,
    };
  }
}

class ReporteRespuesta {
  final Inscritos? inscritos;
  final Asistencias? asistencias;

  ReporteRespuesta({
    this.inscritos,
    this.asistencias,
  });

  factory ReporteRespuesta.fromJson(Map<String, dynamic> json) {
    return ReporteRespuesta(
      inscritos: json['inscritos'] != null
          ? Inscritos.fromJson(json['inscritos'])
          : null,
      asistencias: json['asistencias'] != null
          ? Asistencias.fromJson(json['asistencias'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inscritos': inscritos?.toJson(),
      'asistencias': asistencias?.toJson(),
    };
  }
}

class Inscritos {
  final int? presencial;
  final int? virtual;

  Inscritos({this.presencial, this.virtual});

  factory Inscritos.fromJson(Map<String, dynamic> json) {
    return Inscritos(
      presencial: json['presencial'] as int?,
      virtual: json['virtual'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'presencial': presencial,
      'virtual': virtual,
    };
  }
}

class Asistencias {
  final int? presencial;
  final int? virtual;

  Asistencias({this.presencial, this.virtual});

  factory Asistencias.fromJson(Map<String, dynamic> json) {
    return Asistencias(
      presencial: json['presencial'] as int?,
      virtual: json['virtual'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'presencial': presencial,
      'virtual': virtual,
    };
  }
}
