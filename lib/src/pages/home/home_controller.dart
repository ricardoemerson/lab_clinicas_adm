import 'package:asyncstate/asyncstate.dart' as asyncstate;
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../data/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';

class HomeController with MessageStateMixin {
  final IAttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;

  HomeController({
    required IAttendantDeskAssignmentRepository attendantDeskAssignmentRepository,
  }) : _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository;

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final response = await _attendantDeskAssignmentRepository.startService(deskNumber);

    switch (response) {
      case Left(value: RepositoryException(:final message)):
        asyncstate.AsyncState.hide();
        showError(message);
      case Right():
        asyncstate.AsyncState.hide();
        showInfo('Registrou com sucesso.');
    }
  }
}
