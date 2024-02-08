import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../../data/repositories/user/i_user_repository.dart';
import '../../data/repositories/user/user_repository.dart';
import '../../data/services/user/user_login_service.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginRouter extends FlutterGetItPageRouter {
  const LoginRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<IUserRepository>((i) => UserRepository(restClient: i())),
        Bind.lazySingleton((i) => UserLoginService(userRepository: i())),
        Bind.lazySingleton((i) => LoginController(userLoginService: i())),
      ];

  @override
  String get routeName => '/login';

  @override
  WidgetBuilder get view => (_) => const LoginPage();
}
