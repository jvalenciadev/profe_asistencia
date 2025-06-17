import 'package:flutter/material.dart';
import 'package:profe_asistencia/res/colors/app_color.dart';
import 'package:profe_asistencia/res/fonts/app_fonts.dart';

Widget loading() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo o imagen de tu app
        Image.asset('assets/logos/logoprofe.png', width: 150, height: 80),
        const SizedBox(height: 16),
        // Texto amigable
        const Text(
          'Cargando información...',
          style: TextStyle(
            fontFamily: AppFonts.mina,
            fontSize: 16,
            color: AppColor.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        // Indicador personalizado
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    ),
  );
}
