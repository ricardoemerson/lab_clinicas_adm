import 'dart:developer';

import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';
import '../../repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import '../../repositories/panel/i_panel_repository.dart';
import '../../repositories/patient_information_form/i_patient_information_form_repository.dart';

class CallNextPatientService {
  final IPatientInformationFormRepository _patientInformationFormRepository;
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final IPanelRepository _panelRepository;

  CallNextPatientService({
    required IPatientInformationFormRepository patientInformationFormRepository,
    required IAttendantDeskAssignmentRepository attendantDeskAssignmentRepository,
    required IPanelRepository panelRepository,
  })  : _patientInformationFormRepository = patientInformationFormRepository,
        _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _panelRepository = panelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>> execute() async {
    final response = await _patientInformationFormRepository.callNextToCheckin();

    switch (response) {
      case Left(value: final exception):
        return Left(exception);

      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
    PatientInformationFormModel form,
  ) async {
    final response = await _attendantDeskAssignmentRepository.getDeskAssignment();

    switch (response) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final panelResponse = await _panelRepository.callOnPanel(form.password, deskNumber);

        switch (panelResponse) {
          case Left(value: final exception):
            log(
              'ATENÇÃO: Não foi possível chamar o paciente.',
              error: exception,
              stackTrace: StackTrace.fromString('ATENÇÃO: Não foi possível chamar o paciente.'),
            );

            return Right(form);

          case Right():
            return Right(form);
        }
    }
  }
}
