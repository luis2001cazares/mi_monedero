import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimonedero/main.dart';


class LoginWidget extends StatefulWidget {
  //const LoginWidget({super.key});

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
 final emailController = TextEditingController();
 final passwordController = TextEditingController();

@override
void dispose(){
 emailController.dispose();
 passwordController.dispose();

 super.dispose();
}
  @override
  Widget build(BuildContext context) => SingleChildScrollView (
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText:'Email' ),
        ),
        SizedBox(height: 4),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText:'Password' ),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          style:  ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
          ),
          icon: Icon(Icons.lock_open, size: 32),
          label: Text(
            'Sign In',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signIn,
          ),
      ],
    ),
  );

  Future signIn() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email : emailController.text.trim(),
    password : passwordController.text.trim(),
  );
} on FirebaseAuthException catch (e) {
  print(e);
}

  // Navigator.of(context) not working!
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}