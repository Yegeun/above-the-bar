import 'package:above_the_bar/models/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:above_the_bar/bloc/exercise/exercise_bloc.dart';
import '/bloc/blocs.dart';

class CreateExercise extends StatefulWidget {
  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final _formKey = GlobalKey<FormState>();

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
            SizedBox(height: 20),
            Row(
              children: [
                BlocBuilder<ExerciseBloc, ExerciseState>(
                  builder: (context, state) {
                    if (state is ExerciseLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ExerciseLoaded) {
                      final List<Exercise> exercisetemp =
                          state.exercises.toList();
                      print(exercisetemp.length);
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: exercisetemp.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(exercisetemp[index].name),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text(
                        'Something went wrong ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      );
                    }
                  },
                ),
              ],
            ),
            Container(
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 20.0),
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
