enum DomainError { unexpected, invalidCredentails }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentails:
        return "Credenciais inválidas";
      default:
        return '';
    }
  }
}
