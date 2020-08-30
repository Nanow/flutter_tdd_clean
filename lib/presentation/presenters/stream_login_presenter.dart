import 'dart:async';
import 'package:flutter_clean_study/domain/helpers/helpers.dart';
import 'package:meta/meta.dart';

import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';

class LoginState {
  String email;
  String password;
  String mainError;
  String emailError;
  String passwordError;
  bool isLoading = false;
  bool get isFormValid =>
      email != null &&
      password != null &&
      emailError == null &&
      passwordError == null;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;

  final _controller = StreamController<LoginState>.broadcast();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  var _state = LoginState();

  StreamLoginPresenter(
      {@required this.validation, @required this.authentication});

  void _update() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(
        AuthenticationParams(username: _state.email, secret: _state.password),
      );
    } on DomainError catch (error) {
      _state.mainError = error.description;
    } finally {
      _state.isLoading = false;
      _update();
    }
  }

  dispose() {
    _controller.close();
  }
}
