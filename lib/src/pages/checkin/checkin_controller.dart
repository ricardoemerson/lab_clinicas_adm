import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/models/patient_information_form_model.dart';

class CheckinController with MessageStateMixin {
  final patientInformationForm = signal<PatientInformationFormModel?>(null);
}
