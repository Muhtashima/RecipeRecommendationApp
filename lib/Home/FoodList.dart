import 'package:flutter/material.dart';
import 'package:project470/Home/updateDish.dart';
import 'package:project470/Services/Database.dart';
import 'package:provider/provider.dart';
import 'package:project470/ViewRecipe.dart';
import '../Models/Dishes.dart';
import 'package:project470/shared/TextSpan.dart';


class foodlist extends StatefulWidget {
  String? dishname;
  String? ingredients;
  foodlist({this.dishname, this.ingredients});
  @override
  State<foodlist> createState() => _foodlistState();
}

class _foodlistState extends State<foodlist> {
  late Dishes dishes;
  //late int _selectedIndex;
  @override
  Widget build(BuildContext context) {


    String selectedFunction;
    //selectedFunction = options.first;

    //Initialise dishlist from Provider and searchedDishes and SearchedIngredients
    final dishlist = Provider.of<List<Dishes>>(context) ?? [];
    List<Dishes?> filteredDishes = [];
    String searchedDish = widget.dishname!.toLowerCase();
    String searchedIngredients = widget.ingredients!.toLowerCase();


    //Use RegExp and where clause and .contains() to filter dishes
    RegExp pattern1 = RegExp(r'[a-zA-Z]+');
    List<String?> ingredients_list = [for (Match match in pattern1.allMatches(searchedIngredients)) match.group(0)];
    String substring = ingredients_list.join('|');
    RegExp pattern2 = RegExp(substring);
    filteredDishes = dishlist.where((dish)=>dish.name!.toLowerCase().contains(searchedDish)| dish.ingredient!.toLowerCase().contains(pattern2)).toList();

    return ListView.builder(
        itemCount: filteredDishes.length,
        itemBuilder: (context, index){
          dishes = filteredDishes[index]!;
          return Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
                  margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  elevation: 2.0,
                  child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/${dishes.image}'),
                        ),
                        title: Text('${dishes.name}',style: TextStyle(color:Colors.green[900])),
                        subtitle: StyleText(text: '${dishes.ingredient}', keywords: ingredients_list).highlight(),//Text('${dishes.ingredient}'),
                        onTap: () {


                          showModalBottomSheet(
                             context: context,
                             builder: (context){
                               return Scaffold(
                                 backgroundColor: Colors.green[100],
                                 appBar: AppBar(
                                   backgroundColor: Colors.green[800],
                                   centerTitle: true,
                                   title: Text('Customize Your List'),
                                 ),
                                 body: Column(
                                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                   children: [
                                     Expanded(
                                       flex: 1,
                                       child: Container(
                                         margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                         child: ElevatedButton.icon(
                                             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                             onPressed: () async{
                                               await Database().addDocument('New Dish', 'None', 'blank.png');
                                               Navigator.pop(context);
                                             }, icon: Icon(Icons.add),
                                             label: Text('Add dish item')
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       flex: 1,
                                       child: Container(
                                         margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                         child: ElevatedButton.icon(
                                             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                             onPressed: () async{
                                               await Database().deleteDocument(filteredDishes[index]?.id);
                                               //Navigator.pop(context);
                                             }, icon: Icon(Icons.remove),
                                             label: Text('Delete dish item')
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       flex: 1 ,
                                       child: Container(
                                         margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                         child: ElevatedButton.icon(
                                             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                             onPressed: () async{
                                               await Navigator.push(context,
                                                   MaterialPageRoute(
                                                       builder: (context)=>UpdateDish(documentID: filteredDishes[index]?.id!,dish:filteredDishes[index]!)
                                                   )
                                               );
                                               //Navigator.pop(context);

                                             },
                                             icon: Icon(Icons.update),
                                             label: Text('Update')
                                         ),
                                       ),
                                     ),
                                     Expanded(
                                       flex: 1 ,
                                       child: Container(
                                         margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                                         child: ElevatedButton.icon(
                                             style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                             onPressed: () async{
                                               await Navigator.push(context,
                                                   MaterialPageRoute(
                                                       builder: (context)=>viewRecipe(dish: filteredDishes[index]!),
                                                   )
                                               );
                                               //Navigator.pop(context);

                                             },
                                             icon: Icon(Icons.details),
                                             label: Text('View Full Recipe')
                                         ),
                                       ),
                                     ),
                                   ],
                             ),
                               );
                             }
                          );
                        },
                      ),

                ),


          );
        });
  }
}



