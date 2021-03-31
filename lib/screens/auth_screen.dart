import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
  ) async {
    UserCredential authResult;
    print(isLogin);
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
/*
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg'); 

        await ref.putFile(image); 

        final url = await ref.getDownloadURL(); */

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set(
          {
            'username': username,
            'email': email,
            //         'image_url': url,
          },
        );
      }
    } on PlatformException catch (error) {
      var message = 'An error ocurred, please check your credentials!';
      if (error.message != null) {
        message = error.message;
      }
      print('errrrrrrrrrrrrrrrrror');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      var message = 'An error ocurred, please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      print('errrrrrrrrrrrrrrrrror');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red.shade700,
        ),
      );
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurple, Colors.black12],
      )),
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                //         margin: EdgeInsets.only(top: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME',
                      style: TextStyle(
                        color: Colors.pink.shade100,
                        fontSize: 35,
                        fontFamily: 'Doctor',
                      ),
                    ),
                    Center(child: AuthForm(_submitAuthForm)),
                    Container(
                      height: 45,
                      width: 185,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('SIGN IN AS ADMIN'),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
