class AsistenciaModal {
  final String? status;
  final int? codigoHttp;
  final AsistenciaRespuesta? respuesta;
  final String? error;

  AsistenciaModal({
    this.status,
    this.codigoHttp,
    this.respuesta,
    this.error,
  });

  factory AsistenciaModal.fromJson(Map<String, dynamic> json) {
    return AsistenciaModal(
      status: json['status'] as String?,
      codigoHttp: json['codigo_http'] as int?,
      respuesta: json['respuesta'] != null
          ? AsistenciaRespuesta.fromJson(json['respuesta'])
          : null,
      error: json['error'] as String?,
    );
  }

  get ci => null;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'codigo_http': codigoHttp,
      'respuesta': respuesta?.toJson(),
      'error': error,
    };
  }
}

class AsistenciaRespuesta {
  final String? estado;
  final bool? inscrito;
  final Persona? persona;

  AsistenciaRespuesta({
    this.estado,
    this.inscrito,
    this.persona,
  });

  factory AsistenciaRespuesta.fromJson(Map<String, dynamic> json) {
    return AsistenciaRespuesta(
      estado: json['estado'] as String?,
      inscrito: json['inscrito'] as bool?,
      persona: json['persona'] != null
          ? Persona.fromJson(json['persona'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'inscrito': inscrito,
      'persona': persona?.toJson(),
    };
  }
}

class Persona {
  final int? ci;
  final String? complemento;
  final String? nombre1;
  final String? apellido1;
  final String? apellido2;
  final String? celular;
  final String? correo;
  final String? fechaNacimiento;
  final String? pmNombre;
  final String? depNombre;
  final String? eveNombre;
  final String? etNombre;

  Persona({
    this.ci,
    this.complemento,
    this.nombre1,
    this.apellido1,
    this.apellido2,
    this.celular,
    this.correo,
    this.fechaNacimiento,
    this.pmNombre,
    this.depNombre,
    this.eveNombre,
    this.etNombre,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      ci: json['ci'] as int?,
      complemento: json['complemento'] as String?,
      nombre1: json['nombre1'] as String?,
      apellido1: json['apellido1'] as String?,
      apellido2: json['apellido2'] as String?,
      celular: json['celular'] as String?,
      correo: json['correo'] as String?,
      fechaNacimiento: json['fecha_nacimiento'] as String?,
      pmNombre: json['pm_nombre'] as String?,
      depNombre: json['dep_nombre'] as String?,
      eveNombre: json['eve_nombre'] as String?,
      etNombre: json['et_nombre'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ci': ci,
      'complemento': complemento,
      'nombre1': nombre1,
      'apellido1': apellido1,
      'apellido2': apellido2,
      'celular': celular,
      'correo': correo,
      'fecha_nacimiento': fechaNacimiento,
      'pm_nombre': pmNombre,
      'dep_nombre': depNombre,
      'eve_nombre': eveNombre,
      'et_nombre': etNombre,
    };
  }
}