import 'package:lab_clinicas_core/lab_clinicas_core.dart';

abstract interface class IUserRepository {
  Future<Either<AuthException, String>> login(String email, String password);
}
