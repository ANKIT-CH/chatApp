import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(
    String username,
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitInfo;
  bool isLoading;

  AuthForm(this.submitInfo, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _email = '';
  var _userName = '';
  var _password = '';

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState.save();
      print(_userName);
      print(_email);
      print(_password);

      widget.submitInfo(
        _userName.trim(),
        _email.trim(),
        _password.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    // keyboardType: TextInputType.text,
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value == null || value.length <= 5) {
                        return 'please enter a user name with length greater than 5';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'user name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'email address',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    // keyboardType: TextInputType.text,
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value == null || value.length <= 6) {
                        return 'please password with lenth greater than 6 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'password',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 10),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(
                        _isLogin ? 'login' : 'sign Up',
                      ),
                      onPressed: _trySubmit,
                    ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    FlatButton(
                      child: Text(_isLogin
                          ? 'create a new account'
                          : 'already have account? Login'),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
