import 'package:async/async.dart';
import '../../domain/auth_service_contract.dart';
import '../../domain/credential.dart';
import '../../domain/signup_service_contract.dart';
import '../../domain/token.dart';
import '../../infra/api/auth_api_contract.dart';

class EmailAuth implements IAuthService, ISignUpService {
  final IAuthApi _api;
  Credential? _credential;
  EmailAuth(
    this._api,
  );

  void credential({
    required String email,
    required String password,
  }) {
    _credential = Credential(
      type: AuthType.email,
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<Token>> signIn() async {
    assert(_credential != null);
    var result = await _api.signIn(_credential!);
    if (result.isError) {
      return Result<Token>.error(result);
    }
    return Result.value(Token(value: result.asValue!.value));
  }

  @override
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
  ) async {
    Credential credential = Credential(
      type: AuthType.email,
      email: email,
      name: name,
      password: password,
    );

    var result = await _api.signUp(credential);
    if (result.isError) {
      return Result<Token>.error(result);
    }
    return Result.value(Token(value: result.asValue!.value));
  }

  @override
  Future<void> singOut() {
    // TODO: implement singOut
    throw UnimplementedError();
  }
}
