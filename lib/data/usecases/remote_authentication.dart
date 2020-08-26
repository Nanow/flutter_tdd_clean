import 'package:meta/meta.dart';

import '../../domain/usecases/authentication.dart';
import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';

import '../http/http.dart';
import '../models/models.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    @required this.httpClient,
    @required this.url,
  });

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );
      return RemoteAccouontModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      error == HttpError.unauthorized
          ? throw DomainError.invalidCredentails
          : throw DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String username;

  final String password;

  RemoteAuthenticationParams({
    @required this.username,
    @required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams entity) =>
      RemoteAuthenticationParams(
        password: entity.secret,
        username: entity.username,
      );
  Map<String, dynamic> toJson() => {
        'email': this.username,
        'password': this.password,
      };
}
