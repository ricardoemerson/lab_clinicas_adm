import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';

abstract interface class IPatientInformationFormRepository {
  Future<Either<RepositoryException, PatientInformationFormModel?>> callNextToCheckin();

  Future<Either<RepositoryException, Unit>> updateStatus(String id, PatientInformationFormStatus status);
}
