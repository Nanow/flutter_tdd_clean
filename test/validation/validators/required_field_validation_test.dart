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
    if (value == null) return null;
    if (value.isEmpty) return 'Campo obrigatório';
    return null;
  }
}

main() {
  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation(field: 'any field');
  });

  test('Should return null  if  value is not empity', () {
    expect(sut.validate('any_value'), null);
  });
  test('Should return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });
  test('Should return error if value is null', () {
    expect(sut.validate(null), null);
  });
}
