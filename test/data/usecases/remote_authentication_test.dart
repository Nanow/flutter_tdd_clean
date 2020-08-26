import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_study/domain/usecases/usecases.dart';

import 'package:flutter_clean_study/data/http/http.dart';
import 'package:flutter_clean_study/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteAuthentication sut;
  HttpClientSpy httpClient;
  String url;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(
        secret: faker.internet.email(), username: faker.internet.userName());
    await sut.auth(params);

    verify(
      httpClient.request(
          method: 'post',
          url: url,
          body: {'email': params.username, 'password': params.secret}),
    );
  });
}
