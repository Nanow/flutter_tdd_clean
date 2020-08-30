enum DomainError { unexpected, invalidCredentails }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentails:
        return "Credenciais inválidas.";
      case DomainError.unexpected:
        return "Algo errado aconteceu. Tente novamente em breve.";
      default:
        return '';
    }
  }
}
