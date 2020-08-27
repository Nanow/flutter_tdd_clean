abstract class LoginPresenter {
  Stream<String> get emailErrorController;
  Stream<String> get passwordErrorController;
  Stream<bool> get isFormValidController;
  Stream<bool> get isLoadingController;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
}
