import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

class HttpAdatper {
  final Dio dio;

  HttpAdatper(this.dio);

  Future<void> request({
    @required String url,
    @required String method,
    Map<String, dynamic> body,
  }) async {
    await this.dio.post(url);
  }
}

class DioSpy extends Mock implements Dio {}

void main() {
  group('post', () {
    test('Should call post  with  correct values', () {
      final client = DioSpy();
      final sut = HttpAdatper(client);
      final url = faker.internet.httpUrl();
      sut.request(url: url, method: 'post');
      verify(client.post(url));
    });
  });
}
