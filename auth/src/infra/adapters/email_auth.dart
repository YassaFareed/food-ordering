import 'package:async/src/result/result.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/auth_service_contract.dart';
import '../../domain/credential.dart';
import '../../domain/signup_service_contract.dart';
import '../../domain/token.dart';
import '../api/auth_api_contract.dart';


class EmailAuth implements IAuthService, ISignUpService{

  final IAuthApi _api;
  Credential _credential; 

  EmailAuth(this._api);
   
  void credential({
    @required String email,
    @required String password,
  }){ 
  _credential = Credential(
    type: AuthType.email, 
    email: email,
    password: password,
    );
}

  @override
  Future<Result<Token>> signIn() async{
    assert(_credential != null);
    var result = await _api.signIn(_credential); //confusion about how params of cread will be passed
    if(result.isError) {
         return result.asError;
    }
    return Result.value(Token(result.asValue.value)); 
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError(); 
  }

  @override
  Future<Result<Token>> signup(String name, String email, String password) async {
    Credential credential = Credential(type: AuthType.email, email: email, name: name, password: password);
    var result = await _api.signup(credential);
    if(result.isError) {
      return result.asError;
    }
    return Result.value(Token(result.asValue.value));
  }

}