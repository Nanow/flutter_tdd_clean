import 'package:faker/faker.dart';
import 'package:flutter_clean_study/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_study/domain/entities/entities.dart';
import 'package:flutter_clean_study/domain/usecases/usecases.dart';

import 'package:flutter_clean_study/presentation/presenters/presenters.dart';
import 'package:flutter_clean_study/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

main() {
  ValidationSpy validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  String email;
  String password;

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

  PostExpectation mockAuthenticationCall() => when(
        authentication.auth(any),
      );

  void mockAuthentication() {
    mockAuthenticationCall()
        .thenAnswer((_) => AccountEntity(token: faker.guid.guid()));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();

    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
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
    sut.isFormValidStream.listen(expectAsync1((error) => expect(error, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });
  test('Should emit email null if validation fails', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((error) => expect(error, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should  call Validation with correct password', () {
    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((error) => expect(error, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });
  test('Should emit password error if validation fails', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(password);
    sut.validatePassword(email);
  });
  test(
      'Should return in order the state of isFormValidStream if Form  is valid',
      () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(print);
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateEmail('email');
    await Future.delayed(Duration.zero);
    sut.validatePassword('password');
  });

  test('Shohuld call Authentication with correct values', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();
    verify(
      authentication
          .auth(AuthenticationParams(username: email, secret: password)),
    ).called(1);
  });
  test('Should emit correct events on Authentication sucess', () async {
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validateEmail(email);
    sut.validatePassword(password);
    expectLater(sut.isLoadingStream, emits(false));

    sut.mainErrorStream.listen(expectAsync1((error) =>
        expect(error, 'Algo errado aconteceu. Tente novamente em breve.')));
    await sut.auth();
  });
  test('Should not emit after  dispose', () async {
    expectLater(sut.emailErrorStream, neverEmits(null));
    sut.dispose();
    sut.validateEmail(email);
  });
}
