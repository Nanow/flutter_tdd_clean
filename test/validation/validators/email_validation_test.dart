import 'package:flutter_clean_study/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  String field;

  EmailValidation(this.field);

  String validate(String value) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value == null || value.isEmpty) return null;

    final isValid = regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }
}

main() {
  EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should  return  null if email is empty', () {
    final error = sut.validate('');
    expect(error, null);
  });
  test('Should  return  null if email is empty', () {
    final error = sut.validate(null);
    expect(error, null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate("dgssantos@hotmail.com"), null);
  });
  test('Should return error if email is invalid', () {
    expect(sut.validate("dgssantos"), 'Campo inválido');
  });
}
