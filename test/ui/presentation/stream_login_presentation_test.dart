import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({@required this.validation});
  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }
}

class ValidationSpy extends Mock implements Validation {}

main() {
  test('Should  call Validation with correct email', () {
    final validation = ValidationSpy();
    final sut = StreamLoginPresenter(validation: validation);
    final String email = faker.internet.email();
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });
}
