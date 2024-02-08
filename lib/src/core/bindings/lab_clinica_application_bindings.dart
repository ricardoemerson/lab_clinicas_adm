import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../data/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import '../../data/repositories/attendant_desk_assignment/i_attendant_desk_assignment_repository.dart';
import '../../data/repositories/panel/i_panel_repository.dart';
import '../../data/repositories/panel/panel_repository.dart';
import '../../data/repositories/patient_information_form/i_patient_information_form_repository.dart';
import '../../data/repositories/patient_information_form/patient_information_form_repository.dart';
import '../../data/services/call_next_patient/call_next_patient_service.dart';
import '../env/env.dart';

class LabClinicaApplicationBindings extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton<RestClient>(
          (i) => RestClient(Env.backendBaseUrl),
        ),
        Bind.lazySingleton<IPatientInformationFormRepository>(
          (i) => PatientInformationFormRepository(restClient: i()),
        ),
        Bind.lazySingleton<IAttendantDeskAssignmentRepository>(
          (i) => AttendantDeskAssignmentRepository(restClient: i()),
        ),
        Bind.lazySingleton<IPanelRepository>(
          (i) => PanelRepository(restClient: i()),
        ),
        Bind.lazySingleton(
          (i) => CallNextPatientService(
            patientInformationFormRepository: i(),
            attendantDeskAssignmentRepository: i(),
            panelRepository: i(),
          ),
        ),
      ];
}
