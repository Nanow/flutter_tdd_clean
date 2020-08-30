import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_study/validation/validators/validators.dart';

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
}
