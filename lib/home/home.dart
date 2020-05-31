import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List todo = List();
  String input = '';

 createTodo(){
  DocumentReference documentReference =
      Firestore.instance.collection("mytodos").document(input);
  Map<String , String> todo = {"todotitle" : input
  } ;
 documentReference.setData(todo).whenComplete((){ print("$input created");

 });
}
 deleteTodo(item) {
   DocumentReference documentReference =
   Firestore.instance.collection("mytodos").document(item);

   documentReference.delete().whenComplete((){ print("deleted");

 });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add your todos'),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton( child: Text('add'),
                      onPressed: (){
                       createTodo();
                        Navigator.of(context).pop();

                      },
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.orangeAccent,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Todo list',
          style: TextStyle(color: Colors.orangeAccent),
        ),
      ),
     
      body: StreamBuilder(
        stream: Firestore.instance.collection("mytodos").snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {

                DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      child: ListTile(
                        trailing:IconButton(
                          icon: Icon( Icons.delete),
                          onPressed: () { deleteTodo(documentSnapshot ["todotitle"]);
                          },
                        ),
                        title: Text(documentSnapshot["todotitle"]),
                      ),
                    ));
              });
        }
      ),
    );
  }
}


