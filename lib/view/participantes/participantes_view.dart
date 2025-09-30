import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/response/status.dart';
import '../../view_models/controller/home/evento_controller_models.dart';

class ParticipantesView extends StatefulWidget {
  const ParticipantesView({Key? key}) : super(key: key);

  @override
  State<ParticipantesView> createState() => _ParticipantesViewState();
}

class _ParticipantesViewState extends State<ParticipantesView> {
  final TextEditingController _searchController = TextEditingController();
  final EventoController _eventoController = Get.put(EventoController());

  String filtro = "";

  @override
  void initState() {
    super.initState();
    _eventoController.loadListaParticipantes();
    _eventoController.loadReporteIns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Participantes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Datos generales ---
            Obx(() {
              if (_eventoController.reporteInsStatus.value == Status.LOADING) {
                return const Center(child: CircularProgressIndicator());
              } else if (_eventoController.reporteInsStatus.value == Status.ERROR) {
                return Text("Error: ${_eventoController.error.value}");
              } else {
                final reporte = _eventoController.reporteIns.value.respuesta;
                if (reporte == null) return const Text("Sin datos de reporte");

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text("Datos Generales", style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text("Inscritos P", style: TextStyle(color: Colors.grey[600])),
                                Text("${reporte.inscritos?.presencial ?? 0}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Inscritos V", style: TextStyle(color: Colors.grey[600])),
                                Text("${reporte.inscritos?.virtual ?? 0}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Asistencia P", style: TextStyle(color: Colors.grey[600])),
                                Text("${reporte.asistencias?.presencial ?? 0}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Asistencia V", style: TextStyle(color: Colors.grey[600])),
                                Text("${reporte.asistencias?.virtual ?? 0}",
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),

            const SizedBox(height: 16),

            // --- Buscador ---
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Buscar participante por nombre o carnet",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  filtro = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // --- Lista de Participantes ---
            Expanded(
              child: Obx(() {
                if (_eventoController.participanteLisStatus.value == Status.LOADING) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_eventoController.participanteLisStatus.value == Status.ERROR) {
                  return Text("Error: ${_eventoController.error.value}");
                } else {
                  final lista = _eventoController.participanteList.value.respuesta ?? [];

                  final listaFiltrada = lista.where((p) {
                    final nombreCompleto = "${p.nombre ?? ''} ${p.apellido1 ?? ''} ${p.apellido2 ?? ''}";
                    return nombreCompleto.toLowerCase().contains(filtro.toLowerCase()) ||
                           (p.ci?.toString().contains(filtro) ?? false);
                  }).toList();

                  if (listaFiltrada.isEmpty) {
                    return const Center(child: Text("No se encontraron participantes"));
                  }

                  return ListView.builder(
                    itemCount: listaFiltrada.length,
                    itemBuilder: (context, index) {
                      final p = listaFiltrada[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: (p.asistencia == 1) ? Colors.green : Colors.red,
                            child: Icon(
                              (p.asistencia == 1) ? Icons.check : Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          title: Text("${p.nombre ?? ''} ${p.apellido1 ?? ''} ${p.apellido2 ?? ''}"),
                          subtitle: Text("CI: ${p.ci ?? ''}"),
                          trailing: Text(
                            (p.asistencia == 1) ? "Asistió" : "No asistió",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (p.asistencia == 1) ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}