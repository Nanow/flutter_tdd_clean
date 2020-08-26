import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_study/domain/helpers/helpers.dart';
import 'package:flutter_clean_study/domain/usecases/usecases.dart';

import 'package:flutter_clean_study/data/http/http.dart';
import 'package:flutter_clean_study/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;
  AuthenticationParams params;

  Map<String, dynamic> mcokValidData() => {
        'accessToken': faker.guid.guid(),
        'name': faker.person.name(),
      };

  PostExpectation _mockRequest() {
    return when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body'),
    ));
  }

  void mockHttpData(Map<String, dynamic> data) async {
    return _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttoError(HttpError error) {
    return _mockRequest().thenThrow(error);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
      secret: faker.internet.email(),
      username: faker.internet.userName(),
    );
    mockHttpData(mcokValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(
      httpClient.request(
          method: 'post',
          url: url,
          body: {'email': params.username, 'password': params.secret}),
    );
  });

  test('Should throw UnexpectedError if Httpclient return 400', () async {
    mockHttoError(HttpError.badRequest);

    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if Httpclient return 404', () async {
    mockHttoError(HttpError.notFound);

    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if Httpclient return 500', () async {
    mockHttoError(HttpError.serverError);

    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError  if Httpclient return 401',
      () async {
    mockHttoError(HttpError.unauthorized);

    final response = sut.auth(params);
    expect(response, throwsA(DomainError.invalidCredentails));
  });

  test('Should return an Account if  HttpClient return 200', () async {
    final accessToken = faker.guid.guid();
    mockHttpData({'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);

    expect(account.token, accessToken);
  });
  test(
      'Should throw an UnexpectedError if Httpclient return 200 with invalid data',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});
    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });
}
