

import '../../domain/credential.dart';

class Mapper{
  static Map<String, dynamic> toJson(Credential credential) => { //takes credentail object and creates json object 
        "type": credential.type,
        "name": credential.name,
        "email": credential.email,
        "password": credential.password
  };

}