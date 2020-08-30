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
  test('Should  return  null if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate('');
    expect(error, null);
  });
  test('Should  return  null if email is empty', () {
    final sut = EmailValidation('any_field');

    final error = sut.validate(null);
    expect(error, null);
  });
}
