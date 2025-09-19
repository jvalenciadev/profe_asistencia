import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as ms;

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key});

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String? scannedCode; // código leído (temporal)
  String? confirmedCode; // código confirmado (muestra en el panel)

  final ms.MobileScannerController controller = ms.MobileScannerController();

  void resetScanner() {
    setState(() {
      scannedCode = null;
      confirmedCode = null;
    });
  }

  void confirmCode() {
    if (scannedCode != null) {
      setState(() {
        confirmedCode = scannedCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escáner de Barras"),
      ),
      body: Column(
        children: [
          // Cámara + ventana de escaneo
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                ms.MobileScanner(
                  controller: controller,
                  fit: BoxFit.cover,
                  onDetect: (ms.BarcodeCapture capture) {
                    if (scannedCode != null) return; // evita múltiples lecturas
                    final List<ms.Barcode> barcodes = capture.barcodes;
                    for (final code in barcodes) {
                      setState(() {
                        scannedCode =
                            code.rawValue ?? "Código no reconocido";
                      });
                    }
                  },
                ),
                // Ventana rectangular elegante
                Center(
                  child: Container(
                    width: 220,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Panel inferior con resultado y botones
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Resultado confirmado",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    confirmedCode ??
                        "Escanea un código y presiona Confirmar",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Botón principal de confirmar
                  ElevatedButton.icon(
                    onPressed: scannedCode == null ? null : confirmCode,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text("Confirmar código"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Botones de acción secundarios
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionButton(
                        icon: Icons.flash_on,
                        label: "Flash",
                        onTap: () => controller.toggleTorch(),
                      ),
                      _ActionButton(
                        icon: Icons.flip_camera_ios,
                        label: "Cámara",
                        onTap: () => controller.switchCamera(),
                      ),
                      _ActionButton(
                        icon: Icons.refresh,
                        label: "Resetear",
                        onTap: resetScanner,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ==== Botón personalizado minimalista ====
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18, color: Colors.black87),
      label: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
    );
  }
}
