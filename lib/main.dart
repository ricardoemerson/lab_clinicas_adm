import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'src/core/bindings/lab_clinica_application_bindings.dart';
import 'src/pages/home/home_router.dart';
import 'src/pages/login/login_router.dart';
import 'src/pages/pre_checkin/pre_checkin_router.dart';
import 'src/pages/splash/splash_page.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const LabClinicasAdmApp());
  }, (error, stack) {
    log('Erro não tratado.', error: error, stackTrace: stack);

    throw error;
  });
}

class LabClinicasAdmApp extends StatelessWidget {
  const LabClinicasAdmApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clínicas ADM',
      bindings: LabClinicaApplicationBindings(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (context) => const SplashPage(),
          path: '/',
        ),
      ],
      pages: const [
        LoginRouter(),
        HomeRouter(),
        PreCheckinRouter(),
      ],
    );
  }
}
