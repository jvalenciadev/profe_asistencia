import 'package:flutter/material.dart';

import '../../widgets/font_select.dart';
import '../../widgets/lenguaje_select.dart';
import '../../widgets/modo_select.dart';

class ConfiguracionSistemaWidget extends StatelessWidget {
  const ConfiguracionSistemaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración del Sistema',
          style: textTheme.titleLarge?.copyWith(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.primary,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Preferencias Generales', colorScheme, textTheme),
          LanguageSelectorWidget(),
          SizedBox(height: 10),
          FontSelectorWidget(),
          SizedBox(height: 12),
          ThemeModeSelectorWidget(),
          

          Divider(height: 25, color: colorScheme.onSurface.withValues(alpha:0.2),),

          _buildSectionTitle('Privacidad y Seguridad', colorScheme, textTheme),
          _buildSettingTile(
            icon: Icons.notifications_active_rounded,
            title: 'Notificaciones',
            subtitle: 'Activadas',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _buildSettingTile(
            icon: Icons.lock_outline_rounded,
            title: 'Cambiar contraseña',
            subtitle: 'Último cambio: hace 3 meses',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _buildSettingTile(
            icon: Icons.fingerprint_rounded,
            title: 'Autenticación biométrica',
            subtitle: 'Desactivado',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _buildSettingTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Política de privacidad',
            subtitle: 'Lee cómo protegemos tus datos',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),

          Divider(height: 25, color: colorScheme.onSurface.withValues(alpha:0.2),),

          _buildSectionTitle('Sistema', colorScheme, textTheme),
          _buildSettingTile(
            icon: Icons.info_outline_rounded,
            title: 'Versión del sistema',
            subtitle: 'v2.0.3 (actualizado)',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _buildSettingTile(
            icon: Icons.storage_rounded,
            title: 'Almacenamiento',
            subtitle: '420 MB usados',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
          _buildSettingTile(
            icon: Icons.bug_report_rounded,
            title: 'Reportar un problema',
            subtitle: 'Ayúdanos a mejorar',
            onTap: () {},
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),

          Divider(height: 25, color: colorScheme.onSurface.withValues(alpha:0.2),),

          _buildSettingTile(
            icon: Icons.logout_rounded,
            title: 'Cerrar sesión',
            subtitle: 'Finalizar tu sesión actual',
            onTap: () {
              // Lógica de logout
            },
            colorScheme: colorScheme,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String title,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.primary.withValues(alpha: 0.85),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
        child: Icon(icon, color: colorScheme.primary),
      ),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    );
  }
}
