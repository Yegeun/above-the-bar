import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateExercise extends StatefulWidget {
  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  //this can be implemented somewhere else
  final _formKey = GlobalKey<FormState>();

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Exercise"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text("Create Exercise")),
                ),
              ],
            ),
            Text(
              'Read data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 20.0),

              //                 final messages = snapshot.data!.docs;
              //                 List<Text> messageWidgets = [];
              //
              //                 for (var element in messages) {
              //                   final messageText = element['text'];
              //                   final messageSender = element['sender'];
              //
              //                   final messageWidget =
              //                       Text('$messageText from $messageSender');
              //                   messageWidgets.add(messageWidget);
              //                 }
              //                 return Column(
              //                   children: messageWidgets,
              //                 );
              //               }
              //               return const Text('Error');
              //             },
              //             stream:collectionStream),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      child: Text("Exercise Name")),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add),
                        hintText: 'What is the exercise called',
                        labelText: 'Name',
                      ),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Sending Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
