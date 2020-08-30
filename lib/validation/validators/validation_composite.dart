import 'package:meta/meta.dart';

import '../../presentation/protocols/protocols.dart';

import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> _validations;

  ValidationComposite(this._validations);

  @override
  String validate({@required String field, @required String value}) {
    String error;
    for (final validation in _validations.where((v) => field == v.field)) {
      error = validation.validate(value);
      if (error != null && error.isNotEmpty) {
        return error;
      }
    }
    return error;
  }
}
