import 'dart:convert';

import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  setUp(() {
    registerFallbackValue(FakeUri());
  });
  group('signin', () {
    var credential = Credential(
      type: AuthType.email,
      email: 'email@email.com',
      password: 'pass',
    );
    test('should return error when status code is not 200', () async {
      MockClient client = MockClient();
      AuthApi sut = AuthApi(baseUrl: 'http:baseUrl', client: client);
      // arrange
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{}', 400));
      // act
      var result = await sut.signIn(credential);
      // assert
      expect(result, isA<ErrorResult>());
    });

    test('should return error when status code is 200 but malformed json',
        () async {
      MockClient client = MockClient();
      AuthApi sut = AuthApi(baseUrl: 'http:baseUrl', client: client);
      // arrange
      when(() => client.post(any(), body: any(named: 'body')))
          .thenAnswer((_) async => http.Response('{}', 200));
      // act
      var result = await sut.signIn(credential);
      // assert
      expect(result, isA<ErrorResult>());
    });

    test('should return token string when successful', () async {
      MockClient client = MockClient();
      AuthApi sut = AuthApi(baseUrl: 'http:baseUrl', client: client);
      // arrange
      var tokenStr = "AdADSFa..";
      when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async =>
              http.Response(jsonEncode({'auth_token': tokenStr}), 200));
      // act
      var result = await sut.signIn(credential);
      // assert
      expect(result.asValue!.value, tokenStr);
    });
  });
}
