import 'package:flutter_test/flutter_test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  String field;

  RequiredFieldValidation({this.field});

  @override
  String validate(String value) {
    return null;
  }
}

main() {
  test('Should return null  if  value is not empity', () {
    final sut = RequiredFieldValidation(field: 'any field');
    final error = sut.validate('any_value');
    expect(error, null);
  });
}
