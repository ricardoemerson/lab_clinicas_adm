import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/models/patient_information_form_model.dart';
import '../../data/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import '../../data/services/call_next_patient/call_next_patient_service.dart';

class HomeController with MessageStateMixin {
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;

  final _informationForm = signal<PatientInformationFormModel?>(null);

  PatientInformationFormModel? get informationForm => _informationForm();

  HomeController({
    required IAttendantDeskAssignmentRepository attendantDeskAssignmentRepository,
    required CallNextPatientService callNextPatientService,
  })  : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final response = await _attendantDeskAssignmentRepository.startService(deskNumber);

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        asyncstate.AsyncState.hide();
        showError(message);
      case Right():
        final nextPatientResponse = await _callNextPatientService.execute();

        switch (nextPatientResponse) {
          case Left(value: RepositoryException(:final message)):
            asyncstate.AsyncState.hide();
            showError(message);
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _informationForm.value = form;
          case Right(value: _):
            asyncstate.AsyncState.hide();
            showInfo('Nenhum paciente aguardando, pode ir tomar um cafezinho.');
        }
    }
  }
}
