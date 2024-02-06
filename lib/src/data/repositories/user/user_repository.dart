import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'i_user_repository.dart';

class UserRepository implements IUserRepository {
  final RestClient _restClient;

  UserRepository({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<AuthException, String>> login(String email, String password) async {
    try {
      final Response(data: {'access_token': accessToken}) = await _restClient.unAuth.post(
        '/auth',
        data: {
          'email': email,
          'password': password,
        },
      );

      return Right(accessToken);
    } on DioException catch (e, s) {
      log('Erro ao realizar login.', error: e, stackTrace: s);

      return switch (e) {
        DioException(response: Response(statusCode: HttpStatus.forbidden)?) =>
          Left(AuthException('Usuário ou senha inválidos.')),
        _ => Left(AuthException('Erro ao realizar login.')),
      };
    }
  }
}
