class ListaPartModal {
  final String? status;
  final int? codigoHttp;
  final List<Participante>? respuesta;
  final String? error;

  ListaPartModal({
    this.status,
    this.codigoHttp,
    this.respuesta,
    this.error,
  });

  factory ListaPartModal.fromJson(Map<String, dynamic> json) {
    return ListaPartModal(
      status: json['status'] as String?,
      codigoHttp: json['codigo_http'] as int?,
      respuesta: (json['respuesta'] as List<dynamic>?)
          ?.map((e) => Participante.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'codigo_http': codigoHttp,
      'respuesta': respuesta?.map((e) => e.toJson()).toList(),
      'error': error,
    };
  }
}

class Participante {
  int? ci;
  String? nombre;
  String? apellido1;
  String? apellido2;
  String? fechaNacimiento;
  String? celular;
  int? asistencia; // 1 o 0

  Participante({
    this.ci,
    this.nombre,
    this.apellido1,
    this.apellido2,
    this.fechaNacimiento,
    this.celular,
    this.asistencia,
  });

  factory Participante.fromJson(Map<String, dynamic> json) {
    return Participante(
      ci: json['eve_per_ci'] as int?,
      nombre: json['eve_per_nombre_1'] as String?,
      apellido1: json['eve_per_apellido_1'] as String?,
      apellido2: json['eve_per_apellido_2'] as String?,
      fechaNacimiento: json['eve_per_fecha_nacimiento'] as String?,
      celular: json['eve_per_celular'] as String?,
      asistencia: json['eve_ins_asistencia'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eve_per_ci': ci,
      'eve_per_nombre_1': nombre,
      'eve_per_apellido_1': apellido1,
      'eve_per_apellido_2': apellido2,
      'eve_per_fecha_nacimiento': fechaNacimiento,
      'eve_per_celular': celular,
      'eve_ins_asistencia': asistencia,
    };
  }
}