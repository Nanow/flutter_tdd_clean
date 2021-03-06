import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<bool>(
        stream: presenter.isFormValidController,
        builder: (context, snapshot) {
          return RaisedButton(
            onPressed:
                snapshot.data != null && snapshot.data ? presenter.auth : null,
            child: Text('Entrar'.toUpperCase()),
          );
        });
  }
}
