import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;
import 'package:get/get.dart';
import '../../repository/app_repository.dart';
import '../../models/asistencia_model.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final AppInfoRepository _ctrl = Get.put(AppInfoRepository());
  final ms.MobileScannerController controller = ms.MobileScannerController();
  final TextEditingController ciController = TextEditingController();

  String? scannedCode;
  AsistenciaModal? asistencia;
  String mensaje = '';
  bool isLoading = false;

  void resetScanner() {
    setState(() {
      scannedCode = null;
      asistencia = null;
      ciController.clear();
      mensaje = '';
    });
  }

  Future<void> registrarAsistencia({String? ci, required bool confirmar}) async {
    final codigo = ci ?? scannedCode;
    if (codigo == null || codigo.isEmpty) return;

    setState(() {
      isLoading = true;
      mensaje = '';
      asistencia = null;
    });

    try {
      final response = confirmar
          ? await _ctrl.asistenciaBarcodeApi({"per_ci": int.tryParse(codigo)})
          : await _ctrl.noAsistenciaBarcodeApi({"per_ci": int.tryParse(codigo)});

      setState(() {
        asistencia = response;
        if (asistencia?.respuesta == null) {
          mensaje = asistencia?.error ?? "La asistencia no se encuentra habilitada.";
        } else {
          mensaje = confirmar
              ? 'Asistencia registrada correctamente'
              : 'Se quitó la asistencia correctamente';
        }
      });
    } catch (e) {
      setState(() => mensaje = confirmar
          ? 'No se pudo registrar asistencia'
          : 'No se pudo quitar asistencia');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void mostrarDialogoAccion({String? ci}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Seleccione acción"),
        content: const Text("¿Qué desea hacer con este registro?"),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              registrarAsistencia(ci: ci, confirmar: true);
            },
            icon: const Icon(Icons.check, color: Colors.green),
            label: const Text("Confirmar"),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              registrarAsistencia(ci: ci, confirmar: false);
            },
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            label: const Text("Quitar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escáner de Asistencia"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Cámara
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 250,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      ms.MobileScanner(
                        controller: controller,
                        fit: BoxFit.cover,
                        onDetect: (ms.BarcodeCapture capture) {
                          if (scannedCode != null) return;
                          for (final code in capture.barcodes) {
                            setState(() {
                              scannedCode = code.rawValue ?? 'Código no reconocido';
                            });
                            mostrarDialogoAccion(ci: scannedCode);
                          }
                        },
                      ),
                      Center(
                        child: Container(
                          width: 220,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white70, width: 3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Campo de CI manual
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        controller: ciController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Ingrese CI manualmente",
                          prefixIcon: const Icon(Icons.badge),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: isLoading
                            ? null
                            : () => mostrarDialogoAccion(ci: ciController.text.trim()),
                        icon: isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Icon(Icons.playlist_add_check),
                        label: const Text("Acción"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
              if (scannedCode != null)
                Text('Código escaneado: $scannedCode',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

              const SizedBox(height: 16),
              if (asistencia?.respuesta != null)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asistencia!.respuesta!.estado ?? "Estado desconocido",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: (asistencia!.respuesta!.inscrito ?? false) ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Nombre: ${asistencia!.respuesta!.persona?.nombre1 ?? ''} ${asistencia!.respuesta!.persona?.apellido1 ?? ''} ${asistencia!.respuesta!.persona?.apellido2 ?? ''}"),
                        Text("CI: ${asistencia!.respuesta!.persona?.ci ?? ''}"),
                        Text("Modalidad: ${asistencia!.respuesta!.persona?.pmNombre ?? ''}"),
                        Text("Evento: ${asistencia!.respuesta!.persona?.eveNombre ?? ''}"),
                      ],
                    ),
                  ),
                ),

              if (mensaje.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    mensaje,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],

              const Divider(height: 32),

              Wrap(
                spacing: 12,
                children: [
                  _ActionButton(icon: Icons.flash_on, label: "Flash", onTap: () => controller.toggleTorch()),
                  _ActionButton(icon: Icons.flip_camera_ios, label: "Cámara", onTap: () => controller.switchCamera()),
                  _ActionButton(icon: Icons.refresh, label: "Resetear", onTap: resetScanner),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
