import 'package:async/src/result/result.dart';

import '../../domain/auth_service_contract.dart';
import '../../domain/credential.dart';
import '../../domain/token.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/auth_api_contract.dart';

class GoogleAuth implements IAuthService{
  final IAuthApi _authApi;
  GoogleSignIn _googleSignIn;
  GoogleSignInAccount _currentUser;

  GoogleAuth(this._authApi,[GoogleSignIn googleSignIn])  //check if google sign in if not then signin using scopes
           : this._googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: ['email','profile'], 
            );

  @override
  Future<Result<Token>> signIn() async{
    await _handleGoogleSignIn();
    if(_currentUser == null)//failure of google sign in
      return Result.error('Failed to signin with google');
    Credential credential = Credential(  
      type: AuthType.google, 
      email: _currentUser.email,
      name: _currentUser.displayName,      
      );
      var result = await _authApi.signIn(credential);
      if(result.isError) return result.asError;
      return Result.value(Token(result.asValue.value)); //result will be token string from the api
  }

  @override
  Future<void> signOut() async{
    _googleSignIn.disconnect();
  }
  _handleGoogleSignIn()async{
    try{
      _currentUser = await _googleSignIn.signIn();
    }catch(error){
      return;
    }
  }

}