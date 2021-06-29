import './token.dart';
import 'package:async/async.dart';

abstract class IAuthService{
  Future<Result<Token>> signIn(); //returns a future result with the token
  Future<void> signOut();

}