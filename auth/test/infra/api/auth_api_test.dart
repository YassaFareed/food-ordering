import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import '../../../src/infra/api/auth_api.dart';
import 'package:mockito/mockito.dart';
import '../../../src/domain/credential.dart';
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client {}

void main(){
    MockClient client;
    AuthApi sut;


    setUp(() {
        client = MockClient();
        sut = AuthApi('http:baseUrl',client); //mock client and base url

    });

    group('signin', () {
        var credential = Credential(
          type: AuthType.email,
          email: 'email@email',
          password: 'pass'
          );
        test('should return error when status code is not 200', () async{
          //arrange
            when(client.post(any, body: anyNamed('body')))
                .thenAnswer((_) async => http.Response('{}',404));
        //act
        var result = await sut.signIn(credential);

        //assert
        expect(result,isA<ErrorResult>());

        });

        test('should return error when status code is 200 but malformed json', () async{
          //arrange
            when(client.post(any, body: anyNamed('body')))
                .thenAnswer((_) async => http.Response('{}',200));
        //act
        var result = await sut.signIn(credential);

        //assert
        expect(result,isA<ErrorResult>());

        });

        test('should return token string when successful', () async{
          //arrange
            var tokenStr= 'Abbggs..';
            when(client.post(any, body: anyNamed('body')))
                .thenAnswer((_) async => http.Response(jsonEncode({'auth_token':tokenStr}),200));
        //act
        var result = await sut.signIn(credential);

        //assert
        //print(result.asValue.value);
        expect(result.asValue.value,tokenStr);

        });

    });
}



//ftest to get template
//first test is used to check if status code is 200 or not

//second test is status code=200 but json object is malformed(token not present (there is an error creating a token using api))