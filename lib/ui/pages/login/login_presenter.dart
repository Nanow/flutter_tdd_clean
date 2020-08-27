abstract class LoginPresenter {
  Stream get emailErrorController;
  Stream get passwordErrorController;

  void validateEmail(String email);
  void validatePassword(String password);
}
