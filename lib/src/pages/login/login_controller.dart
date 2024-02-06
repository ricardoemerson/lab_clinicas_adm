import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../data/services/user/i_user_login_service.dart';

class LoginController with MessageStateMixin {
  final IUserLoginService _userLoginService;

  final _obscurePassword = signal(true);
  final _logged = signal(false);

  bool get obscurePassword => _obscurePassword();

  bool get logged => _logged();

  LoginController({
    required IUserLoginService userLoginService,
  }) : _userLoginService = userLoginService;

  void passwordToggle() => _obscurePassword.value = !_obscurePassword.value;

  Future<void> login(String email, String password) async {
    final response = await _userLoginService.execute(email, password).asyncLoader();

    switch (response) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        _logged.value = true;
    }
  }
}
