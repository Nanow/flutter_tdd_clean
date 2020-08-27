abstract class LoginPresenter {
  Stream get emailErrorController;

  void validateEmail(String email);
  void validatePassword(String password);
}
