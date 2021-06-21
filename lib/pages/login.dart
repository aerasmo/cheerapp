import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:google_sign_in/google_sign_in.dart';

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
class BuildLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        child:
        Column(children: [
          Transform.scale(
            child: Image(image: AssetImage('icons/logo.png')),
            scale: 1.25,
          ),
          SizedBox(height: 15),
          Text(
            'Cheer APP', style: TextStyle(fontSize: 20),
            ),  
        ],) 
      );
  }
}
class Input extends StatelessWidget {
  final inputLabel;

  Input(this.inputLabel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: inputLabel
        ),
      ),
    );
  }
}

class InputPassword extends StatefulWidget {
  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              )
    
      );
  }
}

class LoginButton extends StatelessWidget {
  // String name;
  // LoginButton(this.name);

  final widt;
  LoginButton(this.widt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widt,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColor))
        ),
        child: Text("Log In",
          style: TextStyle(
            color: Colors.black87,
          )
        ), 
        onPressed: () => Navigator.pushNamed(context, '/home')
      )
    );
  }
}

class SignUpButton extends StatelessWidget {
  final widt;
  void signup() {
    print("onPressed: Sign Up button");
  }
  SignUpButton(this.widt);
  @override
  Widget build(BuildContext context) {

    return Container(
      width: widt, 
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColor))
        ),
        child: Text("Sign Up",
          style: TextStyle(
            color: Colors.black87,
          )
        ), 
        onPressed: signup
      )
    );
  }
}
class GoogleSignInButton extends StatelessWidget {
  final widt;

  GoogleSignInButton(this.widt);
  _default(context) {
    return Container(
      width: widt,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(secondaryColor))
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.google, size: 15),
            SizedBox(width: 10),
            Text('Sign-in using Google',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ), 
        onPressed: () => Navigator.of(context).pushNamed('/home')

      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return _default(context);
  }
  // _signInWithGoogle() {
  // }
}
class Login extends StatelessWidget {
  double widt = 250;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(loginColor),
    // backgroundColor: Colors.grey[400],
    // backgroundColor: Colors.white,
    // backgroundColor: Colors.lightBlue[00],
    appBar: 
    AppBar(
      title: Text("CheerAPP",
        style: TextStyle(
        color: Colors.black54,
        fontSize: 23.0
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(primaryColor),
            
    ),
    body: _login(),
    );
  }
  _login() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Center(
        heightFactor: 1.5,
        child: SingleChildScrollView(
          child:
            Container(
              width: widt,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BuildLogo(),
                  Input('Username'),
                  InputPassword(),

                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(children: [
                        Spacer(flex:2),
                        SignUpButton(widt/2 - 5),
                        LoginButton(widt/2 - 5),
                        Spacer(flex:2)
                      ]),
                  ),
                  GoogleSignInButton(widt)
                ],
              ),
            )
        )
      )
    );
    
  }
}