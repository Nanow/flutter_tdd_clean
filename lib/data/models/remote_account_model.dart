import 'package:flutter/foundation.dart';

import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccouontModel {
  final String accessToken;

  RemoteAccouontModel({@required this.accessToken});

  factory RemoteAccouontModel.fromJson(Map<String, dynamic> map) {
    if (!map.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }
    return RemoteAccouontModel(accessToken: map['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(token: this.accessToken);
}
