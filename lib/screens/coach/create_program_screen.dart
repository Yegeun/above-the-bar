import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/blocs.dart';
import 'package:above_the_bar/widgets/create_exercise_widget.dart';

class CreateProgramScreen extends StatefulWidget {
  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  List<CreateExerciseWidget> listDynamic = [];
  List<CreateExerciseWidget> listCreateExercise = [];
  List<String> data = [];

  int vExerciseNum = 1;
  int vSessionNum = 1;
  int vWeekNum = 1;

  Icon floatingIcon = Icon(Icons.add);

  TextEditingController controllerProgName = TextEditingController();

  CreateExerciseWidget one =
      CreateExerciseWidget(week: 1, session: 1, exerciseNum: 1);
  CreateExerciseWidget two =
      CreateExerciseWidget(week: 1, session: 1, exerciseNum: 2);

  // addDynamic(int dynamicWeek, int dynamicSession, int dynamicExerciseNum) {
  //   if (data.length != 0) {
  //     floatingIcon = Icon(Icons.add);
  //
  //     data = [];
  //     listDynamic = [];
  //     print('if');
  //   }
  //   setState(() {});
  //   if (listDynamic.length >= 20) {
  //     return;
  //   }
  //   listDynamic.add(
  //     CreateExerciseWidget(
  //       week: dynamicWeek,
  //       session: dynamicSession,
  //       exerciseNum: dynamicExerciseNum,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Widget result = Flexible(
      flex: 1,
      child: Card(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text("${index + 1} : ${data[index]}"),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );

    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(2.0),
        minScale: 0.1,
        maxScale: 2.0,
        constrained: false,
        child: Row(
          children: [
            Column(
              children: [
                Center(
                  child: BlocBuilder<ProgramBloc, ProgramState>(
                    builder: (context, state) {
                      if (state is ProgramLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ProgramLoaded) {
                        return ElevatedButton(
                          onPressed: () {
                            listCreateExercise.add(one);
                            listCreateExercise.add(two);
                            // make a list of each exeercise populated
                            // then add each list inisde the exercise using []
                            for (int i = 0;
                                i < listCreateExercise.length;
                                i++) {
                              context.read<ProgramBloc>().add(
                                    CreateProgram(
                                      Program(
                                        programName: controllerProgName.text,
                                        name: listCreateExercise[i]
                                            .controllerGetExText,
                                        week: listCreateExercise[i].week,
                                        session: listCreateExercise[i].session,
                                        exerciseNum:
                                            listCreateExercise[i].exerciseNum,
                                        exercise: listCreateExercise[i]
                                            .controllerGetExText,
                                        sets: int.parse(listCreateExercise[i]
                                            .controllerGetSetsText),
                                        reps: int.parse(listCreateExercise[i]
                                            .controllerGetRepsText),
                                        intensity: int.parse(
                                            listCreateExercise[i]
                                                .controllerGetIntText),
                                        comments: listCreateExercise[i]
                                            .controllerGetCommentsText,
                                      ),
                                    ),
                                  );
                              listCreateExercise[i].dispose();
                            }

                            Navigator.pop(context);
                          },
                          child: Text('Submit'),
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
                Container(
                  width: 150,
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllerProgName,
                    decoration: InputDecoration(hintText: 'Name of Program'),
                  ),
                ),
                Text('W1 Session 1'),
                one,
                two,
                // Column(
                //   children: [
                //     Text('W2 Session 1'),
                //     CreateExerciseWidget(week: 2, session: 1, exerciseNum: 1),
                //     CreateExerciseWidget(week: 2, session: 1, exerciseNum: 2),
                //     Text('Session 2'),
                //     CreateExerciseWidget(week: 2, session: 2, exerciseNum: 1),
                //     CreateExerciseWidget(week: 2, session: 2, exerciseNum: 2),
                //   ],
                // )

                // data.isEmpty ? dynamicTextField : result,
                // OutlinedButton(
                //   onPressed: addDynamic(vSessionNum, vWeekNum, vExerciseNum++),
                //   child: Text('Add Exercise'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
