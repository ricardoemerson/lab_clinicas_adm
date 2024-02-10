import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/models/patient_information_form_model.dart';
import '../../data/repositories/patient_information_form/i_patient_information_form_repository.dart';

class CheckinController with MessageStateMixin {
  final IPatientInformationFormRepository _patientInformationFormRepository;

  final patientInformationForm = signal<PatientInformationFormModel?>(null);
  final endProcess = signal(false);

  CheckinController({
    required IPatientInformationFormRepository patientInformationFormRepository,
  }) : _patientInformationFormRepository = patientInformationFormRepository;

  Future<void> endCheckin() async {
    if (patientInformationForm.value != null) {
      final response = await _patientInformationFormRepository.updateStatus(
        patientInformationForm.value!.id,
        PatientInformationFormStatus.beingAttended,
      );

      switch (response) {
        case Left(value: RepositoryException(:final message)):
          showError(message);
        case Right():
          endProcess.value = true;
      }
    } else {
      showError('Formulário não pode ser nulo.');
    }
  }
}
