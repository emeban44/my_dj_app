import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    bool isAdmin,
  ) submitFn;
  final bool isLoading;

  AuthForm(this.submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _userFormKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _isAdmin = false;
  var _isActuallyAdmin = false;
  var _adminCode = '';
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _adminCodeController = TextEditingController();
  var _userEmail = '';
  var _userPass = '';
  var _userName = '';

  void _trySubmit() async {
    var isValid = false;
    //  if (!_isLogin)
    isValid = _userFormKey.currentState.validate();

    FocusScope.of(context).unfocus();

    if (_isAdmin) {
      final adminCodes =
          await FirebaseFirestore.instance.collection('adminCodes').get();
      adminCodes.docs.forEach((doc) {
        if (doc['code'] == _adminCodeController.text) {
          _isActuallyAdmin = true;
        }
      });
    }

    if (_isActuallyAdmin == false && _isAdmin == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Your Admin Code is invalid!", textAlign: TextAlign.center),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (isValid) {
      _userFormKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPass.trim(),
        _userName.trim(),
        _isLogin,
        _isActuallyAdmin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade100, Colors.pink.shade100],
            ),
          ),
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
                        autocorrect: false,
                        validator: (value) {
                          if (value.isEmpty ||
                              !value.contains('.com') ||
                              !value.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        style: TextStyle(fontFamily: 'Lexend'),
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontFamily: 'Raleway')),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      if (!_isLogin)
                        TextFormField(
                          autocorrect: false,
                          style: TextStyle(fontFamily: 'Lexend'),
                          validator: (value) {
                            if (value.length < 4 || value.isEmpty)
                              return "Username should be at least 4 characters long";
                            return null;
                          },
                          key: ValueKey('username'),
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(fontFamily: 'Raleway')),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        obscureText: true,
                        autocorrect: false,
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
                      if (_isLogin && _isAdmin)
                        TextFormField(
                          autocorrect: false,
                          style: TextStyle(fontFamily: 'Lexend'),
                          decoration: InputDecoration(
                            labelText: 'Admin Code',
                            labelStyle: TextStyle(fontFamily: 'Raleway'),
                          ),
                          controller: _adminCodeController,
                          onSaved: (value) {
                            _adminCode = value;
                          },
                        ),
                      if (!_isLogin)
                        TextFormField(
                          autocorrect: false,
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
                        margin: EdgeInsets.only(top: 30, bottom: 1),
                        child: widget.isLoading
                            ? CircularProgressIndicator.adaptive()
                            : ElevatedButton(
                                onPressed: _trySubmit,
                                child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  primary: Color.fromRGBO(59, 3, 97, 0.9),
                                  side: BorderSide(width: 0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        child: widget.isLoading
                            ? Text('Loading...')
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                  _userFormKey.currentState.reset();
                                  _passController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                style: TextButton.styleFrom(
                                  primary: Color.fromRGBO(59, 3, 97, 0.9),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
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
        if (_isLogin)
          Container(
            height: 40,
            width: 185,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _isAdmin = !_isAdmin;
                });
              },
              child: Text(_isAdmin ? 'SIGN IN AS USER' : 'SIGN IN AS ADMIN'),
              style: ElevatedButton.styleFrom(
                elevation: 3,
                primary: Colors.white70,
                onPrimary: Colors.black87,
                side: BorderSide(width: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
