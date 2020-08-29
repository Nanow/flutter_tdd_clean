import 'package:flutter/material.dart';
import 'package:flutter_clean_study/ui/comoponents/spinner_dialog.dart';
import 'package:provider/provider.dart';
import '../../comoponents/components.dart';

import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingController.listen(
            (bool isLoading) {
              if (isLoading) {
                showLoading(context);
              } else {
                hideLoading(context);
              }
            },
          );

          widget.presenter.mainErrorController.listen((error) {
            if (error != null) {
              showErrorMessage(context, error);
            }
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                HeadLine1(text: 'Login'),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Provider(
                    create: (context) => widget.presenter,
                    child: Form(
                      child: Column(
                        children: [
                          EmailImput(),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 32),
                            child: StreamBuilder<String>(
                              stream: widget.presenter.passwordErrorController,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Senha',
                                    icon: Icon(
                                      Icons.vpn_key,
                                    ),
                                    errorText: snapshot.data?.isEmpty == true
                                        ? null
                                        : snapshot.data,
                                  ),
                                  obscureText: true,
                                  onChanged: widget.presenter.validatePassword,
                                );
                              },
                            ),
                          ),
                          StreamBuilder<bool>(
                              stream: widget.presenter.isFormValidController,
                              builder: (context, snapshot) {
                                return RaisedButton(
                                  onPressed:
                                      snapshot.data != null && snapshot.data
                                          ? widget.presenter.auth
                                          : null,
                                  child: Text('Entrar'.toUpperCase()),
                                );
                              }),
                          FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.person),
                            label: Text('Criar conta'),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
