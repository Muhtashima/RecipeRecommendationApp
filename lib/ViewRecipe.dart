import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'Models/Dishes.dart';

class viewRecipe extends StatefulWidget {
  final Dishes dish;

  viewRecipe({required this.dish});

  @override
  State<viewRecipe> createState() => _viewRecipeState();
}

class _viewRecipeState extends State<viewRecipe> {



  @override
  Widget build(BuildContext context) {
    List<String> ingredients = widget.dish.ingredient!.split(',');
    List<Text> textOfIngredients = ingredients.map((e){return Text(e);}).toList();
    String image = widget.dish.image!;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey[300],
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.dish.name!),
              background: Image.asset(
                'assets/${image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green[70],
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  //ListTile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredients.asMap().entries.map((entry) => Container(padding: EdgeInsets.all(10.0), child: Text('${entry.key}. ${entry.value}'))).toList(),
                    ),


                  SizedBox(height: 20.0),
                  Text(
                    'Instructions:',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(widget.dish.recipe!,
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
                  ),

                  // add more instructions as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
