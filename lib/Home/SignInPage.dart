import 'package:flutter/material.dart';
import 'package:project470/Services/Authentication.dart';
import 'package:project470/shared/textInputDecoration.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Authenticator _auth = Authenticator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      // appBar:
      // AppBar(
      //   centerTitle: true,
      //   title: Text('Chefbot'),
      //   elevation: 0.0,
      // ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 168),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                color: Colors.green,
              ),
              child: Text('Chefbot', style: TextStyle(fontSize: 40.0, fontFamily: 'Anuphan', color: Colors.white),),
            ),
            TextButton(
              onPressed: () async{
                dynamic result = await _auth.signInAnon();
                print(result);
              },
              child: Decorate(width: 160.0, height: 60.0, radius: 15.0, boxColor: Colors.lightGreen).withBox('Register'),
              // Container(
              //     padding: EdgeInsets.all(20.0),
              //     color: Colors.red,
              //     child: Text('login', style: TextStyle(color: Colors.white),),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
