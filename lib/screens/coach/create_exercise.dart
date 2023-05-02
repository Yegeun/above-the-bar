import 'package:above_the_bar/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:above_the_bar/bloc/blocs.dart';

class CreateExercise extends StatefulWidget {
  final String coachEmail;

  const CreateExercise({super.key, required this.coachEmail});

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        context.read<ExerciseBloc>().add(LoadExercises(widget.coachEmail)));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Exercise"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Exercises',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                      return Flexible(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: exercisetemp.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title:
                                Text('Name: ${exercisetemp[index].name}'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    context.read<CreateNewExerciseBloc>().add(
                                      DeleteExercise(
                                        exercisetemp[index],
                                        widget.coachEmail,
                                      ),
                                    );
                                  },
                                ));
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
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      child: Text("Exercise Name",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<CreateNewExerciseBloc,
                      CreateNewExerciseState>(
                    builder: (context, state) {
                      if (state is CreateNewExerciseLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CreateNewExerciseLoaded) {
                        return Container(
                          padding: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.add),
                              hintText: 'What is the exercise called',
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        );
                      }
                      return Text(
                        'Something went wrong ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: BlocBuilder<CreateNewExerciseBloc, CreateNewExerciseState>(
                builder: (context, state) {
                  if (state is CreateNewExerciseLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CreateNewExerciseLoaded) {
                    return ElevatedButton(
                      onPressed: () {
                        nameController.text
                            .trim()
                            .isNotEmpty
                            ? context.read<CreateNewExerciseBloc>().add(
                          CreateNewExercise(
                            Exercise(
                              name: nameController.text,
                            ),
                            widget.coachEmail,
                          ),
                        )
                            : SnackBar(content: Text('Please enter a name'));
                        //refresh
                        Future.microtask(() =>
                            context
                                .read<ExerciseBloc>()
                                .add(LoadExercises(widget.coachEmail)));
                      },
                      child: Text('Submit'),
                    );
                  }
                  return Text(
                    'Something went wrong ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
