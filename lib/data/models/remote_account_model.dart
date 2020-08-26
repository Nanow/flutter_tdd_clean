import 'package:flutter/foundation.dart';
import 'package:flutter_clean_study/domain/entities/account_entity.dart';

class RemoteAccouontModel {
  final String accessToken;

  RemoteAccouontModel({@required this.accessToken});

  factory RemoteAccouontModel.fromJson(Map<String, dynamic> map) =>
      RemoteAccouontModel(accessToken: map['accessToken']);

  AccountEntity toEntity() => AccountEntity(token: this.accessToken);
}
