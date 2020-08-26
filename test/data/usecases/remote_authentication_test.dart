import 'package:meta/meta.dart';

import 'package:flutter_clean_study/domain/usecases/authentication.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  Future<void> auth(AuthenticationParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toMap());
  }
}

abstract class HttpClient {
  Future<void> request({
    @required String url,
    @required String method,
    Map<String, dynamic> body,
  }) async {}
}

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
