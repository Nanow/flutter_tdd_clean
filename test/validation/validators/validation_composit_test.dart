import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_study/presentation/protocols/protocols.dart';
import 'package:flutter_clean_study/validation/protocols/protocols.dart';

import 'package:mockito/mockito.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> _validations;

  ValidationComposite(this._validations);

  @override
  String validate({String field, String value}) {
    return null;
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

  test('Should returns nulls if all validations returns null or empty', () {
    mockValidation2('');
    sut.validate(field: 'any_field', value: 'any_value');
  });
}
