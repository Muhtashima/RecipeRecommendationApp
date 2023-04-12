import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project470/Home/SignInPage.dart';
import 'package:project470/Services/Authentication.dart';
import 'package:provider/provider.dart';
import 'Home/Home.dart';
import 'Models/MyUser.dart';
import 'Services/Database.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Chefbot());
}

class Chefbot extends StatelessWidget {
  const Chefbot({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value:Authenticator().user_stream,
      catchError: (_,__){},
       initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //This Wrapper shows HOME widget if user exists(signed in) or SIGNINPAGE widget is user is null(signed out)
        home: Wrapper(),
      ),
     );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user_auth_state = Provider.of<MyUser?>(context);
    if (user_auth_state == null){
      return SignInPage();
    }else{
      return Home();
    };
  }
}







