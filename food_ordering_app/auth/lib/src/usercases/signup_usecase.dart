import '../domain/signup_service_contract.dart';
import '../domain/token.dart';
import 'package:async/async.dart';

class SignUpUseCase {
  final ISignUpService signUpService;
  SignUpUseCase({
    required this.signUpService,
  });

  Future<Result<Token>> execute(
      String name, String email, String password) async {
    return await signUpService.signUp(name, email, password);
  }
}
