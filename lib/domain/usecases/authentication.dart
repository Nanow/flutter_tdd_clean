import 'package:meta/meta.dart';

import '../entities/entities.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    @required String username,
    @required String password,
  });
}
