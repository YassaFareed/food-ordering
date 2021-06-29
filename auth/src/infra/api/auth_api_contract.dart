
import '../../domain/credential.dart';
import 'package:async/async.dart'; 

abstract class IAuthApi {
  Future<Result<String>> signIn(Credential credential);
  Future<Result<String>> signup(Credential credential);
  
}