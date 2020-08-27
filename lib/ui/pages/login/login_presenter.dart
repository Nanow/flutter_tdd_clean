abstract class LoginPresenter {
  Stream get emailErrorController;
  Stream get passwordErrorController;
  Stream<bool> get isFormValidController;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
