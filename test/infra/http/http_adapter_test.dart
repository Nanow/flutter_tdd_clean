import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

import 'package:mockito/mockito.dart';

class HttpAdatper {
  final Client dio;

  HttpAdatper(this.dio);

  Future<void> request({
    @required String url,
    @required String method,
    Map<String, dynamic> body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    await this.dio.post(url, headers: headers);
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  setUp(() {});
  group('post', () {
    test('Should call post  with  correct values', () {
      final client = ClientSpy();
      final sut = HttpAdatper(client);
      final url = faker.internet.httpUrl();
      sut.request(url: url, method: 'post');

      verify(
        client.post(url, headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        }),
      );
    });
  });
}
