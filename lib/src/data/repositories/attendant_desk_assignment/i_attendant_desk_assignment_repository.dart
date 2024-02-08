import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class IAttendantDeskAssignmentRepository {
  Future<Either<RepositoryException, Unit>> startService(int deskNumber);

  Future<Either<RepositoryException, int>> getDeskAssignment();
}
