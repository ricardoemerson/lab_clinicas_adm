import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/user/i_user_repository.dart';

class UserLoginService {
  final IUserRepository _userRepository;

  UserLoginService({
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Either<ServiceException, Unit>> execute(String email, String password) async {
    final loginResponse = await _userRepository.login(email, password);

    switch (loginResponse) {
      case Left(value: AuthException(:final message)):
        return Left(ServiceException(message ?? 'Erro ao realizar o login.'));
      case Right(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, accessToken);

        return Right(unit);
    }
  }
}
