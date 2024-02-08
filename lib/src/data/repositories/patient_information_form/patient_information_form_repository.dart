import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';
import 'i_patient_information_form_repository.dart';

class PatientInformationFormRepository implements IPatientInformationFormRepository {
  final RestClient _restClient;

  PatientInformationFormRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>> callNextToCheckin() async {
    try {
      final Response(:List data) = await _restClient.auth.get(
        '/patientInformationForm',
        queryParameters: {
          'status': PatientInformationFormStatus.waiting.id,
          'page': 1,
          'limit': 1,
        },
      );

      if (data.isEmpty) {
        return Right(null);
      }

      final formData = data.first;
      final updateStatusResponse = await updateStatus(formData['id'], PatientInformationFormStatus.checkIn);

      switch (updateStatusResponse) {
        case Left(value: final exception):
          return Left(exception);
        case Right():
          formData['status'] = PatientInformationFormStatus.checkIn;
          formData['patient'] = await _getPatient(formData['patient_id']);

          return Right(PatientInformationFormModel.fromJson(formData));
      }
    } on DioException catch (e, s) {
      log('Erro ao chamar próxima senha.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao chamar próxima senha.'));
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus(String id, PatientInformationFormStatus status) async {
    try {
      await _restClient.auth.put(
        'patientInformationForm/$id',
        data: {'status': status.id},
      );

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar status do form.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao atualizar status do form.'));
    }
  }

  Future<Map<String, dynamic>> _getPatient(String id) async {
    final Response(:data) = await _restClient.auth.get('/patient/$id');

    return data;
  }
}
