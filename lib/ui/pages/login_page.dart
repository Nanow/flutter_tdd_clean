import 'package:flutter/material.dart';
import '../comoponents/components.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            HeadLine1(text: 'Login'),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.email,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.vpn_key,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Entrar'.toUpperCase()),
                    ),
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                        label: Text('Criar conta'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
