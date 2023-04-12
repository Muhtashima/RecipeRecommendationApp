import 'package:firebase_auth/firebase_auth.dart';
import 'package:project470/Services/Database.dart';

import '../Models/MyUser.dart';


class Authenticator{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String? userID;

  //Create MyUser obj based on User
  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(token: user.uid) : null;
  }
  //auth change user stream
  Stream<MyUser?> get user_stream{
    return _auth.authStateChanges()
        .map((User? user)=>_userfromFirebase(user!));
  }

  //sign in anonymously
  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      userID = user?.uid;
      print(userID);
      await Database(uid: userID).addDocument('Food0', 'Not fixed Yet', 'blank.png');
      return  user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign out

  Future signOut() async{
    try {
      return  await _auth.signOut();

    }catch(e){
      print(e.toString());
      return null;
    }
  }



}
