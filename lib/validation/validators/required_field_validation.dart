import '../protocols/protocols.dart';

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
