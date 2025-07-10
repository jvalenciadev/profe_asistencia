// 📁 lib/utils/auth_util.dart

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AuthUtil {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Verifica si el dispositivo soporta autenticación (biométrica o de otro tipo)
  static Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Verifica si el dispositivo puede usar biometría
  static Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  /// Retorna los tipos de biometría disponibles (fingerprint, face, etc.)
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return [];
    }
  }

  /// Realiza la autenticación biométrica o de sistema
  static Future<bool> authenticate({
    String reason = 'Por favor autentíquese para continuar',
    bool biometricOnly = false,
    bool useErrorDialogs = true,
    bool stickyAuth = false,
  }) async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      switch (e.code) {
        case auth_error.notAvailable:
          print('Biometría no disponible');
          break;
        case auth_error.notEnrolled:
          print('Biometría no registrada');
          break;
        case auth_error.lockedOut:
        case auth_error.permanentlyLockedOut:
          print('Sensor bloqueado');
          break;
        default:
          print('Error de autenticación: \${e.message}');
      }
      return false;
    }
  }

  /// Cancela cualquier autenticación activa
  static Future<void> cancelAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      print('No se pudo cancelar la autenticación');
    }
  }
}