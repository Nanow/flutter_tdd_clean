import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String username;

  /// Sema thing as password
  final String secret;

  AuthenticationParams({
    @required this.username,
    @required this.secret,
  });

  @override
  List get props => [username, secret];
}
