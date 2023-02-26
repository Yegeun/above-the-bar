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
  List<String> data = [];

  int vExerciseNum = 1;
  int vSessionNum = 1;
  int vWeekNum = 1;

  Icon floatingIcon = Icon(Icons.add);

  CreateExerciseWidget one =
      CreateExerciseWidget(week: 1, session: 1, exerciseNum: 1);

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
                            // make a list of each exeercise populated
                            // then add each list inisde the exercise using []
                            context.read<ProgramBloc>().add(
                                  CreateProgram(
                                    Program(
                                      name: 'Test',
                                      week: 1,
                                      session: 1,
                                      exerciseNum: 2,
                                      exercise: one.controllerGetExText,
                                      sets:
                                          int.parse(one.controllerGetSetsText),
                                      reps:
                                          int.parse(one.controllerGetRepsText),
                                      intensity:
                                          int.parse(one.controllerGetIntText),
                                      comments: one.controllerGetCommentsText,
                                    ),
                                  ),
                                );
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
                Text('W1 Session 1'),
                one,
                CreateExerciseWidget(week: 1, session: 1, exerciseNum: 2),
                // Text('Session 2'),
                // CreateExerciseWidget(week: 1, session: 2, exerciseNum: 1),
                // CreateExerciseWidget(week: 1, session: 2, exerciseNum: 2),
              ],
            ),
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
      ),
    );
  }
}
