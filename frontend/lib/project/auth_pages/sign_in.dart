import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home.dart';
import '../classes/constants.dart';

class SignIn extends StatelessWidget {
  Future<String?>? _authenticateUsers(dynamic data) {
    print('authenticate users');
    return Future.delayed(Duration(seconds: 1)).then((_) => null);
  }

  Future<String?>? _onRecoverPassword(String name) {
    print('onRecoverPassword');
    return Future.delayed(Duration(seconds: 1)).then((_) => null);
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.circular(12.0);
    return FlutterLogin(
      title: 'MMAS',
      logo: '💰',
      onSignup: _authenticateUsers,
      onLogin: _authenticateUsers,
      onRecoverPassword: _onRecoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      messages: LoginMessages(
        userHint: 'Username',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOGIN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot Password?',
        recoverPasswordButton: 'RESET',
        goBackButton: 'BACK',
        confirmPasswordError: 'Passwords do not match',
        recoverPasswordDescription: 'Enter your username to recover password',
        recoverPasswordSuccess: 'Password recovered successfully',
      ),
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            print('start google sign in');
            await Future.delayed(Duration(seconds: 1));
            print('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            print('start facebook sign in');
            await Future.delayed(Duration(seconds: 1));
            print('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.linkedinIn,
          callback: () async {
            print('start linkdin sign in');
            await Future.delayed(Duration(seconds: 1));
            print('stop linkdin sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.githubAlt,
          callback: () async {
            print('start github sign in');
            await Future.delayed(Duration(seconds: 1));
            print('stop github sign in');
            return null;
          },
        ),
      ],
      theme: LoginTheme(
        primaryColor: primaryColor,
        accentColor: accentColor,
        errorColor: red,
        titleStyle: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryColor,
          letterSpacing: 2,
        ),
        bodyStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
        textFieldStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        buttonStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: white,
        ),
        cardTheme: CardTheme(
          color: cardBackground,
          elevation: 8,
          shadowColor: shadowColor,
          margin: EdgeInsets.only(top: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: backgroundColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          errorStyle: GoogleFonts.inter(
            fontSize: 12,
            color: red,
          ),
          labelStyle: GoogleFonts.inter(
            fontSize: 14,
            color: textSecondary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dividerColor, width: 1.5),
            borderRadius: inputBorder,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2),
            borderRadius: inputBorder,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: red, width: 1.5),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: red, width: 2),
            borderRadius: inputBorder,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: dividerColor, width: 1),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: primaryLight,
          backgroundColor: primaryColor,
          highlightColor: primaryDark,
          elevation: 4.0,
          highlightElevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../classes/textinput_decoration.dart';
// import 'loading_page.dart';
//
// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = '';
//   bool loading = false;
//
//   // text field state
//   String email = '';
//   String password = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             backgroundColor: Colors.brown[100],
//             appBar: AppBar(
//               backgroundColor: Colors.brown[400],
//               elevation: 0.0,
//               title: Text('Sign in to Brew Crew'),
//               actions: <Widget>[
//                 FlatButton.icon(
//                   icon: Icon(Icons.person),
//                   label: Text('Register'),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             body: Container(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(height: 20.0),
//                     TextFormField(
//                       decoration:
//                           textInputDecoration.copyWith(hintText: 'email'),
//                       validator: (val) => val.isEmpty ? 'Enter an email' : null,
//                       onChanged: (val) {
//                         setState(() => email = val);
//                       },
//                     ),
//                     SizedBox(height: 20.0),
//                     TextFormField(
//                       obscureText: true,
//                       decoration:
//                           textInputDecoration.copyWith(hintText: 'password'),
//                       validator: (val) => val.length < 6
//                           ? 'Enter a password 6+ chars long'
//                           : null,
//                       onChanged: (val) {
//                         setState(() => password = val);
//                       },
//                     ),
//                     SizedBox(height: 20.0),
//                     RaisedButton(
//                         color: Colors.pink[400],
//                         child: Text(
//                           'Sign In',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
//                           if (_formKey.currentState.validate()) {
//                             setState(() => loading = true);
//                             dynamic result = await _auth
//                                 .signInWithEmailAndPassword(email, password);
//                             if (result == null) {
//                               setState(() {
//                                 loading = false;
//                                 error =
//                                     'Could not sign in with those credentials';
//                               });
//                             } else {
//                               Navigator.pop(context);
//                             }
//                           }
//                         }),
//                     SizedBox(height: 12.0),
//                     Text(
//                       error,
//                       style: TextStyle(color: Colors.red, fontSize: 14.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }
// }
