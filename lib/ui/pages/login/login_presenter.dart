abstract class LoginPresenter {
  Stream<String> get emailErrorController;
  Stream<String> get passwordErrorController;
  Stream<bool> get isFormValidController;
  Stream<bool> get isLoadingController;
  Stream<String> get mainErrorController;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
  void dispose();
}
