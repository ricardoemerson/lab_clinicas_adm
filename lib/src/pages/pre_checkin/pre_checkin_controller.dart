import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/models/patient_information_form_model.dart';
import '../../data/services/call_next_patient/call_next_patient_service.dart';

class PreCheckinController with MessageStateMixin {
  final CallNextPatientService _callNextPatientService;

  final patientInformationForm = signal<PatientInformationFormModel?>(null);

  PreCheckinController({
    required CallNextPatientService callNextPatientService,
  }) : _callNextPatientService = callNextPatientService;

  Future<void> next() async {
    final response = await _callNextPatientService.execute();
    switch (response) {
      case Left(value: RepositoryException(:final message)):
        showError(message);
      case Right(value: final form?):
        patientInformationForm.value = form;
      case Right():
        showInfo('Nenhum paciente aguardando, pode ir tomar umc café.');
    }
  }
}
