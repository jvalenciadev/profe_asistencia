// ignore_for_file: depend_on_referenced_packages
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:profe_asistencia/widgets/loading.dart';
import '../models/app_model.dart';
import '../res/icons/icons.dart' show iconMap;
import 'package:url_launcher/url_launcher.dart';

import '../data/response/status.dart';
import '../res/fonts/app_fonts.dart';
import '../res/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_models/controller/app_view_models.dart';

class PresentacionScreen extends StatefulWidget {
  PresentacionScreen({Key? key}) : super(key: key);

  @override
  _PresentacionScreenState createState() => _PresentacionScreenState();
}

class _PresentacionScreenState extends State<PresentacionScreen> {
  final _controller = Get.find<AppInfoController>();
  void _goHome() => Get.offAllNamed(RouteName.homeView);

  @override
  void initState() {
    super.initState();
    _controller.appInfoApi();
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      showCustomSnackbar(
        title: "Error",
        message: 'No se pudo abrir: \$url',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Obx(() {
        switch (_controller.rxRequestStatus.value) {
          case Status.LOADING:
            return const LoadingWidget();
          case Status.ERROR:
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.exclamationTriangle,
                      size: 48,
                      color: Colors.redAccent.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '¡Vaya! Algo salió mal.',
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        fontFamily: AppFonts.mina,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _controller.error.value,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        fontFamily: AppFonts.mina,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _controller.appInfoApi(),
                      icon: FaIcon(
                        FontAwesomeIcons.undo,
                        size: 18,
                        color: colorScheme.onPrimary,
                      ),
                      label: Text(
                        'Reintentar',
                        style: textTheme.bodyMedium?.copyWith(
                          fontFamily: AppFonts.mina,
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        shadowColor: colorScheme.primary.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case Status.COMPLETED:
            final data = _controller.appInfo.value.respuesta!;
            return Stack(
              children: [
                Container(
                  color: colorScheme.onPrimary.withValues(alpha: 0.1),
                ),
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ZoomIn(
                      duration: const Duration(milliseconds: 900),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colorScheme.onPrimary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onSurface.withValues(alpha: 0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logos/logoprofe.png',
                          width: 220,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: IntroductionScreen(
                    pages:
                        data.pages
                            ?.map((p) => _buildPage(p, colorScheme, textTheme))
                            .toList(),
                    globalBackgroundColor: Colors.transparent,
                    showSkipButton: true,
                    skip: FadeInLeft(
                      child: Text(
                        'Saltar',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    next: BounceInRight(
                      child: CircleAvatar(
                        backgroundColor: colorScheme.onPrimary.withValues(alpha: 
                          0.85,
                        ),
                        radius: 26,
                        child: Icon(
                          Icons.arrow_forward,
                          color: colorScheme.primary,
                          size: 26,
                        ),
                      ),
                    ),
                    done: BounceInUp(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.onSurface.withValues(alpha: 0.3),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          'Comenzar',
                          style: textTheme.bodyMedium?.copyWith(
                            color:colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    onDone: _goHome,
                    onSkip: _goHome,
                    dotsDecorator: DotsDecorator(
                      size: const Size(12, 12),
                      activeSize: const Size(26, 12),
                      activeColor: colorScheme.primary,
                      color: colorScheme.primary.withValues(alpha: 0.4),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    animationDuration: 650,
                    curve: Curves.easeInOutCubic,
                  ),
                ),
              ],
            );
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }

  PageViewModel _buildPage(
    PageData p,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return PageViewModel(
      decoration: const PageDecoration(
        pageColor: Colors.transparent,
        imagePadding: EdgeInsets.zero,
        contentMargin: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
      titleWidget: FadeInDown(
        child: Text(
          p.title ?? '',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium
          ,
        ),
      ),
      bodyWidget: FadeIn(
        delay: const Duration(milliseconds: 350),
        child: Text(
          p.body ?? '',
          textAlign: TextAlign.center,
          style: textTheme.bodyMedium,
        ),
      ),
      image: Stack(
        alignment: Alignment.center,
        children: [
          Pulse(
            duration: const Duration(seconds: 3),
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.12),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
          ),
          ZoomIn(
            delay: const Duration(milliseconds: 600),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: CachedNetworkImage(
                imageUrl: p.imageUrl ?? '',
                width: 360,
                height: 210,
                fit: BoxFit.cover,
                placeholder:
                    (c, u) => Container(
                      height: 270,
                      color: colorScheme.onPrimary.withValues(alpha: 0.06),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                errorWidget:
                    (c, u, e) => Container(
                      height: 270,
                      color: colorScheme.onPrimary.withValues(alpha: 0.06),
                      child: const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.only(top: 36, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              p.socials?.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: InkWell(
                    onTap: () => _launchURL(s.url ?? ''),
                    borderRadius: BorderRadius.circular(30),
                    child: Pulse(
                      infinite: true,
                      child: FaIcon(
                        iconMap[s.icon] ?? FontAwesomeIcons.circleQuestion,
                        size: 30,
                        color: colorScheme.onSurface.withValues(alpha: 
                          0.85,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
