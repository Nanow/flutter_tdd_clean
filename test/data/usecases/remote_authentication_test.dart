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

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
      secret: faker.internet.email(),
      username: faker.internet.userName(),
    );
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
    when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body'),
    )).thenThrow(HttpError.badRequest);
    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });
  test('Should throw UnexpectedError if Httpclient return 404', () async {
    when(httpClient.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body'),
    )).thenThrow(HttpError.notFound);
    final response = sut.auth(params);
    expect(response, throwsA(DomainError.unexpected));
  });
}
