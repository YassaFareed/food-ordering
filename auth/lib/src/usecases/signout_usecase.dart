import '../domain/auth_service_contract.dart';
import '../domain/token.dart';
import 'package:async/async.dart';

class SignOutUseCase {
  final IAuthService _authService;

  SignOutUseCase(this._authService);

  Future<Result<bool>> execute(Token token) async{
    return await _authService.signOut(token);
  }


}