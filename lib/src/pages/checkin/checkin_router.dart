import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../data/models/patient_information_form_model.dart';
import 'checkin_controller.dart';
import 'checkin_page.dart';

class CheckinRouter extends FlutterGetItPageRouter {
  const CheckinRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => CheckinController()),
      ];

  @override
  String get routeName => '/checkin';

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments as PatientInformationFormModel;
        context.get<CheckinController>().patientInformationForm.value = form;

        return const CheckinPage();
      };
}
