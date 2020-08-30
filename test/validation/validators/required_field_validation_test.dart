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
    if (value.isEmpty) return 'Campo obrigatório';
    return null;
  }
}

main() {
  test('Should return null  if  value is not empity', () {
    final sut = RequiredFieldValidation(field: 'any field');
    final error = sut.validate('any_value');
    expect(error, null);
  });
  test('Should return error if value is empty', () {
    final sut = RequiredFieldValidation(field: 'any field');
    final error = sut.validate('');
    expect(error, 'Campo obrigatório');
  });
}
