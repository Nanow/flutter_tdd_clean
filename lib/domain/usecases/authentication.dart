import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({AuthenticationParams params});
}

class AuthenticationParams {
  final String username;

  /// Sema thing as password
  final String secret;

  AuthenticationParams({
    @required this.username,
    @required this.secret,
  });
}
