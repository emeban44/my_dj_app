import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
  ) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _userFormKey = GlobalKey<FormState>();
  var _isLogin = true;
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  var _userEmail = '';
  var _userPass = '';
  var _userName = '';

  void _trySubmit() {
    var isValid = false;
    //  if (!_isLogin)
    isValid = _userFormKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (isValid) {
      _userFormKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPass.trim(),
        _userName.trim(),
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.teal,
        margin: const EdgeInsets.all(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _userFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      controller: _emailController,
                      validator: (value) {
                        if (value.isEmpty ||
                            !value.contains('.com') ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        validator: (value) {
                          if (value.length < 4 || value.isEmpty)
                            return "Username should be at least 4 characters long";
                          return null;
                        },
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      obscureText: true,
                      controller: _passController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length <= 7) {
                          return "Password should be at least 8 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPass = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('confirm'),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        validator: (value) {
                          if (value != _passController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                    Container(
                      width: 120,
                      height: 40,
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          side: BorderSide(width: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                          _userFormKey.currentState.reset();
                          _passController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        child: Text(
                          _isLogin
                              ? 'Click to sign up first'
                              : 'I already have an account',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
