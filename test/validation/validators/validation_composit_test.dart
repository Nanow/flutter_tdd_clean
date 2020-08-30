import 'package:meta/meta.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_study/presentation/protocols/protocols.dart';
import 'package:flutter_clean_study/validation/protocols/protocols.dart';

import 'package:mockito/mockito.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> _validations;

  ValidationComposite(this._validations);

  @override
  String validate({@required String field, @required String value}) {
    String error;
    for (final validation in _validations) {
      error = validation.validate(value);
      if (error != null && error.isNotEmpty) {
        return error;
      }
    }
    return error;
  }
}

class FieldValidationSpy extends Mock implements FieldValidation {}

main() {
  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void mockValidation1(String error) {
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String error) {
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String error) {
    when(validation3.validate(any)).thenReturn(error);
  }

  setUp(() {
    validation1 = FieldValidationSpy();
    when(validation1.field).thenReturn('any_field');
    mockValidation1(null);
    validation2 = FieldValidationSpy();
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    validation3 = FieldValidationSpy();
    when(validation3.field).thenReturn('other_field');
    mockValidation3(null);
    sut = ValidationComposite([validation1, validation2, validation3]);
  });
  test('Should return null if all validations return null or empty', () {
    mockValidation2('');
    final error = sut.validate(field: 'any_field', value: 'any_value');
    expect(error, null);
  });
  test('Should the first error found', () {
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_1');
  });
}
