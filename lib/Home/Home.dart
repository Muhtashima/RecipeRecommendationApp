import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project470/Services/Authentication.dart';
import 'package:provider/provider.dart';
import '../Models/Dishes.dart';
import '../Models/MyUser.dart';
import '../Services/Database.dart';
import 'FoodList.dart';
import 'updateDish.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //const Home({Key? key}) : super(key: key);
  final Authenticator _auth = Authenticator();

  String? name;

  String? recipe;

  String dishname = '';
  String ingredients = '';

  TextEditingController searchController = TextEditingController();

  // void filterBooks(String searchText) {
  @override
  Widget build(BuildContext context) {
    final Database dB = Database();
    dynamic dishlist = dB.List_of_Dishes;
    return StreamProvider<List<Dishes>>.value(
      value: dishlist,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          actions: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Icon(Icons.search, color: Colors.black,),
            ),
            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              color: Colors.white,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter name of Dishes/Ingredients',
                ),
               onChanged: (val){
                  setState(() {dishname=val;ingredients=val;});
                  },
              ),
            ),
            SizedBox(width: 30.0,),
            TextButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('Deregister', style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: foodlist(dishname: dishname,ingredients: ingredients,),
      ),
    );
  }
}