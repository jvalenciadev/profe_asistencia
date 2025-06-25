import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {

  // COLORES COMUNES
  static const Color blackColor               =  Color.fromARGB(255, 37, 37, 37) ;
  static const Color whiteColor               =  Color(0xffffffff) ;
  static const Color transparentColor         =  Colors.transparent;
  static const Color greyColor                =  Color.fromARGB(255, 95, 95, 95);
  static const Color debugColor               =  Color.fromARGB(255, 96, 125, 139);
  static const Color infoColor                =  Color.fromARGB(255, 33, 150, 243);
  static const Color warningColor             =  Color.fromARGB(255, 255, 193, 7);
  static const Color errorColor               =  Color.fromARGB(255, 244, 67, 54);
  static const Color dangerColor              =  Color.fromARGB(255, 218, 6, 38);
  static const Color criticalColor            =  Color.fromARGB(255, 183, 28, 28);
  static const Color sentColor                =  Color.fromARGB(255, 76, 175, 80); // Verde típico "success"


  static const Color primaryColor             =  Color.fromARGB(255, 33, 189, 165);
  static const Color secondaryColor           =  Color.fromARGB(255, 92, 197, 181);
  //static const Color secondaryColor           =  Color(0xff47ac66);

  // CHAT IA
  static const Color iaChatColor              = Color(0xff9224ac);

  // COLORES TEXTOS
  static const Color primaryTextColor         =  Color.fromARGB(255, 46, 46, 46);
  static const Color secondaryTextColor       =  Color(0xff444648);
  static const Color primaryDarkTextColor     =  Color.fromARGB(255, 255, 255, 255);
  static const Color secondaryDrakTextColor   =  Color.fromARGB(255, 180, 187, 194);
  
  
  
  // Redes sociales principales
  static const Color facebookColor       = Color(0xFF4267B2);  // Azul de Facebook
  static const Color instagramColor      = Color(0xFFC13584);  // Degradado, se usa este rosa predominante
  static const Color whatsappColor       = Color(0xFF25D366);  // Verde de WhatsApp
  static const Color messengerColor      = Color(0xFF0084FF);  // Azul de Messenger
  static const Color tiktokColor         = Color(0xFF010101);  // Negro, TikTok también usa cian y fucsia
  static const Color youtubeColor        = Color(0xFFFF0000);  // Rojo de YouTube
  static const Color twitterColor        = Color(0xFF1DA1F2);  // Azul de Twitter (X)
  static const Color snapchatColor       = Color(0xFFFFFC00);  // Amarillo de Snapchat
  static const Color linkedinColor       = Color(0xFF0077B5);  // Azul de LinkedIn
  static const Color pinterestColor      = Color(0xFFE60023);  // Rojo de Pinterest
  static const Color redditColor         = Color(0xFFFF4500);  // Naranja de Reddit
  static const Color telegramColor       = Color(0xFF0088CC);  // Azul de Telegram
  static const Color discordColor        = Color(0xFF5865F2);  // Azul lavanda de Discord
  static const Color twitchColor         = Color(0xFF9146FF);  // Morado de Twitch
  static const Color signalColor         = Color(0xFF3A76F0);  // Azul de Signal

  // Plataformas populares
  static const Color spotifyColor        = Color(0xFF1DB954);  // Verde de Spotify
  static const Color appleColor          = Color(0xFF000000);  // Negro para Apple
  static const Color googleColor         = Color(0xFF4285F4);  // Azul principal de Google
  static const Color gmailColor          = Color(0xFFD93025);  // Rojo del ícono de Gmail
  static const Color playstoreColor      = Color(0xFF34A853);  // Verde del Play Store

  // Redes chinas / emergentes
  static const Color wechatColor         = Color(0xFF09B83E);  // Verde de WeChat
  static const Color qqColor             = Color(0xFF000000);  // Negro (usualmente con blanco y rojo)
  static const Color weiboColor          = Color(0xFFE6162D);  // Rojo de Weibo
  static const Color douyinColor         = Color(0xFF010101);  // Igual que TikTok, su versión china

  // Profesional / desarrolladores
  static const Color githubColor         = Color(0xFF171515);  // Negro de GitHub
  static const Color stackoverflowColor  = Color(0xFFf48024);  // Naranja de Stack Overflow
  static const Color mediumColor         = Color(0xFF00AB6C);  // Verde de Medium
  static const Color devtoColor          = Color(0xFF0A0A0A);  // Negro de DEV.to
}

final Map<String, Color> colorMap = {
  // COLORES COMUNES
  'blackColor'              : AppColor.blackColor,
  'whiteColor'              : AppColor.whiteColor,
  'transparentColor'        : AppColor.transparentColor,
  'greyColor'               : AppColor.greyColor,
  'debugColor'              : AppColor.debugColor,
  'infoColor'               : AppColor.infoColor,
  'warningColor'            : AppColor.warningColor,
  'errorColor'              : AppColor.errorColor,
  'dangerColor'             : AppColor.dangerColor,
  'criticalColor'           : AppColor.criticalColor,

  // PRINCIPALES
  'primaryColor'            : AppColor.primaryColor,
  'secondaryColor'          : AppColor.secondaryColor,

  // CHAT IA
  'iaChatColor'             : AppColor.iaChatColor,

  // TEXTOS
  'primaryTextColor'        : AppColor.primaryTextColor,
  'secondaryTextColor'      : AppColor.secondaryTextColor,
  'primaryDarkTextColor'    : AppColor.primaryDarkTextColor,
  'secondaryDrakTextColor'  : AppColor.secondaryDrakTextColor,

  // REDES SOCIALES PRINCIPALES
  'facebookColor'           : AppColor.facebookColor,
  'instagramColor'          : AppColor.instagramColor,
  'whatsappColor'           : AppColor.whatsappColor,
  'messengerColor'          : AppColor.messengerColor,
  'tiktokColor'             : AppColor.tiktokColor,
  'youtubeColor'            : AppColor.youtubeColor,
  'twitterColor'            : AppColor.twitterColor,
  'snapchatColor'           : AppColor.snapchatColor,
  'linkedinColor'           : AppColor.linkedinColor,
  'pinterestColor'          : AppColor.pinterestColor,
  'redditColor'             : AppColor.redditColor,
  'telegramColor'           : AppColor.telegramColor,
  'discordColor'            : AppColor.discordColor,
  'twitchColor'             : AppColor.twitchColor,
  'signalColor'             : AppColor.signalColor,

  // PLATAFORMAS POPULARES
  'spotifyColor'            : AppColor.spotifyColor,
  'appleColor'              : AppColor.appleColor,
  'googleColor'             : AppColor.googleColor,
  'gmailColor'              : AppColor.gmailColor,
  'playstoreColor'          : AppColor.playstoreColor,

  // REDES CHINAS / EMERGENTES
  'wechatColor'             : AppColor.wechatColor,
  'qqColor'                 : AppColor.qqColor,
  'weiboColor'              : AppColor.weiboColor,
  'douyinColor'             : AppColor.douyinColor,

  // PROFESIONAL / DESARROLLADORES
  'githubColor'             : AppColor.githubColor,
  'stackoverflowColor'      : AppColor.stackoverflowColor,
  'mediumColor'             : AppColor.mediumColor,
  'devtoColor'              : AppColor.devtoColor,
};
