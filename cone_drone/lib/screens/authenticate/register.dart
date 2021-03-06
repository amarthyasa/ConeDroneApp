import 'package:flutter/material.dart';
import 'package:cone_drone/components/rounded_botton.dart';
import 'package:cone_drone/screens/loading_screen.dart';
import 'package:cone_drone/models/user.dart';
import 'package:cone_drone/services/auth.dart';
import 'package:cone_drone/constants.dart';

class Register extends StatefulWidget {
  final Function toggleScreen;
  Register({this.toggleScreen});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String email = '';
  String pass = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.blueGrey.shade900,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            child: Image.asset('images/drone.png'),
                            height: 200.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value.isEmpty ? 'Enter an Email' : null,
                        style: kTextFieldStyle,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Email'),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        obscureText: true,
                        validator: (value) => value.length < 6
                            ? 'Enter a password of 6+ characters'
                            : null,
                        style: kTextFieldStyle,
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: 'Password'),
                        onChanged: (value) {
                          setState(() {
                            pass = value;
                          });
                        },
                      ),
                      RoundedButton(
                        title: 'Register',
                        backgroundColor: Colors.blueAccent,
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => _loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, pass);
                            if (result.runtimeType != MyUser) {
                              setState(() {
                                error = result;
                                _loading = false;
                              });
                            }
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white70)),
                          FlatButton(
                            onPressed: () => widget.toggleScreen(),
                            child: Text(
                              'Already have an account?',
                              style: kTextFieldStyle,
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white70)),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(error, style: TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
