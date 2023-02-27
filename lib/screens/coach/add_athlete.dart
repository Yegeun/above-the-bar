import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAthlete extends StatefulWidget {
  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  String time = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Athlete"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CreateAthleteWidget(),
          //   BlocBuilder<ProgramBloc, ProgramState>(
          //   builder: (context, state) {
          // if (state is ProgramLoading) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (state is ProgramLoaded) {
          //   return ElevatedButton(
          //       onPressed: () {
          //     listCreateExercise.add(one);
          //     listCreateExercise.add(two);
          //     // make a list of each exercise populated
          //     // then add each list inside the exercise using []
          //     for (int i = 0;
          //     i < listCreateExercise.length;
          //     i++) {
          //       context.read<ProgramBloc>().add(
          //         CreateProgram(
          //           Program(
          //           ),
          //         ),
          //       );
          //       listCreateExercise[i].dispose();
          //     }
        ],
      ),
    );
  }
}

class CreateAthleteWidget extends StatefulWidget {
  CreateAthleteWidget({Key? key}) : super(key: key);

  final TextEditingController _controllerName = TextEditingController();
  String get controllerGetNameText => _controllerName.text;
  final TextEditingController controllerEmail = TextEditingController();
  String get controllerGetEmailText => controllerEmail.text;
  final TextEditingController _controllerBlock = TextEditingController();
  String get controllerGetBlock => _controllerBlock.text;
  final TextEditingController _controllerStart = TextEditingController();
  String get controllerGetStart => _controllerStart.text;

  @override
  _CreateAthleteWidgetState createState() => _CreateAthleteWidgetState();
}

class _CreateAthleteWidgetState extends State<CreateAthleteWidget> {
  late DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(_date);
    return Column(
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: widget._controllerName,
            decoration: InputDecoration(hintText: 'Name'),
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: widget.controllerEmail,
            decoration: InputDecoration(hintText: 'Email'),
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: widget._controllerBlock,
            decoration: InputDecoration(hintText: 'Block'),
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () async {
              _date = (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2024)))!;
              print(_date);
              setState(() {
                text = DateFormat('yyyy-MM-dd').format(_date);
              });
            },
            child: Text(text),
          ),
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {},
          child: Text("Add Athlete"),
        ),
      ],
    );
  }
}
