import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Dishes.dart';
class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference collection1 = FirebaseFirestore.instance.collection('Dishes');

  //Add firestore data
  Future addDocument(String name, String ingredient, String image)async{
    String recipe = 'Unable to view recipe';
    DocumentReference documentReference = await collection1.add({'name':name, 'ingredient':ingredient, 'image':image, 'recipe': recipe}) as DocumentReference<Object?>;
    uid = documentReference.id;

  }

  //Update firestore document
  Future updateDocument(String? documentId, String name, String ingredient, String image) async {
    final document = collection1.doc(documentId);

    final documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print('This Document DOES NOT EXIST');
      return null;
    }

    await document.update({
      'name':name,
      'ingredient':ingredient,
      'image':image,
    });
  }

  //Delete firestore data
  Future deleteDocument(String? documentId) async {
    final document = collection1.doc(documentId);

    final documentSnapshot = await document.get();

    if (!documentSnapshot.exists) {
      print('Document does not exist');
      return null;
    }
    await document.delete();
  }

  Stream<QuerySnapshot> get foodlist => collection1.snapshots();

  Stream<DocumentSnapshot> get foodListDocs => collection1.doc(uid).snapshots();

  Dishes _dishesfromSnapshots(DocumentSnapshot snapshot) =>
      Dishes(
          id: snapshot.id,
          name: snapshot.get('name'),
          ingredient: snapshot.get('ingredient'),
          image: snapshot.get('image'),
          recipe: snapshot.get('recipe'),
      );

  Stream<Dishes> get dishes => foodListDocs.map(_dishesfromSnapshots);

  List<Dishes> _ListofDishesfromSnapshots(QuerySnapshot snapshot) =>
      snapshot.docs.map((e) => Dishes(
          id: e.id,
          name: e.get('name'),
          ingredient: e.get('ingredient'),
          image: e.get('image'),
        recipe: e.get('recipe'),
      )
      ).toList();
  Stream<List<Dishes>> get List_of_Dishes => foodlist.map(_ListofDishesfromSnapshots);

}



