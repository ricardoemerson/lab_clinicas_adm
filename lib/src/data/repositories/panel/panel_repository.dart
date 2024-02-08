import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'i_panel_repository.dart';

class PanelRepository implements IPanelRepository {
  final RestClient _restClient;

  PanelRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, String>> callOnPanel(String password, int attendantDesk) async {
    try {
      final Response(data: {'id': id}) = await _restClient.auth.post(
        '/painelCheckin',
        data: {
          'password': password,
          'time_called': DateTime.now().toIso8601String(),
          'attendant_desk': attendantDesk,
        },
      );

      return Right(id);
    } on DioException catch (e, s) {
      log('Erro ao chamar paciente no painel.', error: e, stackTrace: s);

      return Left(RepositoryException('Erro ao chamar paciente no painel.'));
    }
  }
}
