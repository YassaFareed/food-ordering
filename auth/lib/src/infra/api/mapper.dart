

import '../../domain/credential.dart';

class Mapper{
  static Map<String, dynamic> toJson(Credential credential) => { //takes credentail object and creates json object 
        "auth_type": credential.type.toString().split('.').last,
        "name": credential.name,
        "email": credential.email,
        "password": credential.password
  };

}