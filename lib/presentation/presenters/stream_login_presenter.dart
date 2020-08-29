import 'dart:async';
import 'package:meta/meta.dart';

import '../protocols/protocols.dart';

class LoginState {
  String emailError;
  String passwordError;
  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;

  final _controller = StreamController<LoginState>.broadcast();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  Stream<bool> get isFormValidController =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  var _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  void _update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  dispose() {
    _controller.close();
  }
}
