import 'package:flutter/material.dart';
import 'package:project470/shared/Loading.dart';
import 'package:project470/shared/textInputDecoration.dart';
import 'package:provider/provider.dart';
import '../Models/Dishes.dart';
import '../Models/MyUser.dart';
import '../Services/Database.dart';
class UpdateDish extends StatefulWidget {
  String? documentID;
  Dishes dish;
  UpdateDish({this.documentID, required this.dish});
  @override
  State<UpdateDish> createState() => _UpdateDishState();
}

class _UpdateDishState extends State<UpdateDish> {
  //final _formKey = GlobalKey<FormState>();

  String? _currentName;

  String? _currentRecipe;

  String? _currentImage;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Update Dish Settings', style: TextStyle(fontSize: 20),)),
      body: Form(

          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dish Name',
                      style: TextStyle(fontWeight: FontWeight.bold, color:Colors.green[900],),
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                        initialValue: widget.dish?.name,
                        decoration: textInputDecoration,
                        validator: (val)=> val!.isEmpty ? 'Please enter a valid Dish name': null,
                        onChanged: (val)=>setState(() {
                          _currentName = val;
                        })
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dish recipe',
                    style: TextStyle(fontWeight: FontWeight.bold, color:Colors.green[900]),
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                        initialValue: widget.dish?.ingredient,
                        decoration: textInputDecoration,
                        validator: (val)=> val!.isEmpty ? 'No recipe': null,
                        onChanged: (val)=>setState(() {
                          _currentRecipe = val;
                        })
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Image file name in png',
                      style: TextStyle(fontWeight: FontWeight.bold, color:Colors.green[900],),
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                      initialValue: widget.dish?.image,
                      decoration: textInputDecoration,
                      validator: (val)=> val!.isEmpty ? 'Please enter a valid image: example, \'image.png\'': null,
                      onChanged: (val)=>setState(() {
                        _currentImage = val;
                      }),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
              ElevatedButton(
                onPressed: () async{
                  await Database().updateDocument(
                    widget.documentID!,
                    _currentName ?? widget.dish.name!,
                    _currentRecipe ?? widget.dish.ingredient!,
                    _currentImage ?? widget.dish.image! ,
                  );
                  print('UPDATE SUCCESSFUL');
                  Navigator.pop(context);

                },
                child: Text('Confirm Update'),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),
              ),
            ],
          )
      ),
    );


  }
}
