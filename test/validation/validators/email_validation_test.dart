import 'package:flutter_clean_study/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  String field;

  EmailValidation(this.field);

  String validate(String value) {
    return null;
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
}
