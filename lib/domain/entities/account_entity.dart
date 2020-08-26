import 'package:flutter/foundation.dart';

class AccountEntity {
  final String token;

  AccountEntity({@required this.token});

  factory AccountEntity.fromJson(Map<String, dynamic> map) =>
      AccountEntity(token: map['accessToken']);
}
