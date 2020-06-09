import 'package:flutter/material.dart';
import 'package:e2517/bloc/login_bloc.dart';
import 'package:e2517/bloc/provider_bloc.dart';
import 'package:e2517/providers/superheroes_login_register_provider.dart';
import 'package:e2517/utils/background_image_utils.dart' as background;
import 'package:e2517/utils/alert_utils.dart' as utils;
import 'package:e2517/utils/change_padding_keyboard_utils.dart' as keyboard;

class LoginPage extends StatelessWidget {
  final userProvider = new UserProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        background.backgroundImage(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: AnimatedPadding(
        padding: EdgeInsets.only(top: keyboard.changePaddingKeyBoard(context)),
        duration: Duration(seconds: 1),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 25.0)),
                SizedBox(height: 15.0),
                _createEmail(bloc),
                SizedBox(height: 30.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(bloc),
              ],
            ),
            FlatButton(
              child: Text('New user Sign Up?',
                  style: TextStyle(color: Colors.red)),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'registration'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Enter your Email',
                hintText: 'Email',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changeEmail(value),
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: 'Enter your Password',
                hintText: 'Password',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Enter', style: TextStyle(fontSize: 20.0)),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 2.0,
            color: Colors.white,
            textColor: Colors.black,
            onPressed: snapshot.hasData ? () => _login(context, bloc) : null);
      },
    );
  }

  _login(BuildContext context, LoginBloc bloc) async {
    Map info =
        await userProvider.login(bloc.email.trim(), bloc.password.trim());

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'user');
    } else {
      utils.showAlert(context, 'INVALID USER');
    }
  }
}
