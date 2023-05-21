import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../fire_auth.dart';
import '../validator.dart';
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget{
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Firebase Authentication'),
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) =>
                            Validator.validateEmail(email: value),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        validator: (value) =>
                            Validator.validatePassword(password: value),
                      ),
                    ],
                  ),
                )
              ],
            );
          Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            User? user = await FireAuth.signInUsingEmailPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text,
            );
            if (user != null) {
              Navigator.of(context)
                  .pushReplacement(
                MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
              );
            }
          }
        },
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
)}
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
