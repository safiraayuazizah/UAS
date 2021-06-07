import 'package:flutter/material.dart';
import 'package:uas_safira/sign_in.dart';
import 'package:uas_safira/first.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade400,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/my.png'),
                  //fit: BoxFit.contain,
                )),
                child: const Text('Admin My Shoebett',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
              ),
              _formLogin(),
              _signInButton(),

              // FlutterLogo(size: 150),
              // SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formLogin() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text('Admin My Shoebett',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
          ),
          Container(
            child: const Text('Sign in with email and password'),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
          ),
          Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                labelText: 'Email',
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.vpn_key),
                labelText: 'Password',
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            alignment: Alignment.center,
            child: OutlineButton(
              splashColor: Colors.black,
              color: Colors.blueGrey,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  signInWithEmailAndPassword(
                          emailController.text, passwordController.text)
                      .then((result) {
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return First();
                          },
                        ),
                      );
                    }
                  });
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return First();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
