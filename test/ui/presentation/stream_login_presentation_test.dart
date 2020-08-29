import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_study/presentation/presenters/presenters.dart';
import 'package:flutter_clean_study/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

main() {
  ValidationSpy validation;
  StreamLoginPresenter sut;
  String email;

  PostExpectation mockValidationCall({String field}) => when(
        validation.validate(
          field: field == null ? anyNamed('field') : field,
          value: anyNamed('value'),
        ),
      );

  void mockValidation({String field, String value}) {
    mockValidationCall(
      field: field,
    ).thenReturn(value);
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });
  test('Should  call Validation with correct email', () {
    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidController
        .listen(expectAsync1((error) => expect(error, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
  test('Should emit email null if validation fails', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidController
        .listen(expectAsync1((error) => expect(error, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
}
