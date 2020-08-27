import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_clean_study/data/http/http.dart';
import 'package:flutter_clean_study/infra/http/http.dart';

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('post', () {
    PostExpectation mockRequest() => when(
          client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')),
        );

    void mockResponse(
      int statusCode, {
      String body = '{"any_key":"any_value"}',
    }) {
      return mockRequest().thenAnswer(
        (_) async => Response(body, statusCode),
      );
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post  with  correct values', () {
      sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        client.post(url,
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}'),
      );
    });
    test('Should call post  without body', () {
      sut.request(url: url, method: 'post');

      verify(
        client.post(any, headers: anyNamed('headers')),
      );
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should returns 200 if post returns 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should returns 200 if post returns 200 with no data', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should returns 200 if post returns 200 with data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    test('Should returns BadRequestError if post returns 400', () async {
      mockResponse(400, body: '');

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.badRequest));
    });
    test('Should returns BadRequestError if post returns 400', () async {
      mockResponse(400);

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.badRequest));
    });
    test('Should returns ServerError if post returns 500', () async {
      mockResponse(500);

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.serverError));
    });

    test('Should returns UnauthorizedError if post returns 401', () async {
      mockResponse(401);

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.unauthorized));
    });

    test('Should returns Forbidden if post returns 403', () async {
      mockResponse(403);

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.forbidden));
    });
    test('Should returns NotFoundError if post returns 404', () async {
      mockResponse(404);

      final feature = sut.request(url: url, method: 'post');

      expect(feature, throwsA(HttpError.notFound));
    });
  });
}
