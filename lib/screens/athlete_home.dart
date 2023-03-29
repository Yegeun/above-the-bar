import 'package:above_the_bar/models/athlete_data_entry_model.dart';
import 'package:above_the_bar/widgets/athlete_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/athlete_data/athlete_data_bloc.dart';

//initiate AthleteInput
AthleteInputWidget ex1 = AthleteInputWidget(exerciseNum: 1);
AthleteInputWidget ex2 = AthleteInputWidget(exerciseNum: 2);

class AthleteHome extends StatefulWidget {
  final String userEmail;

  const AthleteHome({super.key, required this.userEmail});

  static const routeName = '/athlete/home';

  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  late DateTime date = DateTime.now();
  TextEditingController _controller = TextEditingController();

  List<AthleteInputWidget> listDynamic = [];
  List<AthleteInputWidget> listCreateData = [];
  List<String> data = [];

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);
    _controller.text = '61';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Programming App"),
      ),
      body: Column(
        children: [
          Row(
            // Button
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/profile',
                          arguments: widget.userEmail);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/history',
                          arguments: widget.userEmail);
                    },
                    child: Text("History"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/program-viewer',
                          arguments: widget.userEmail);
                    },
                    child: Text("View Program"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: Text("Program"),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          // Add some space between the button and the text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Date:'),
              Container(
                width: 180,
                margin: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () async {
                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2024)))!;
                    setState(() {
                      text = DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                  child: Text(text),
                ),
              ),
              Container(
                width: 90,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BW KG',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(?:[1-4]?\d{1,2}|200|[0-9])$')),
                  ],
                ),
              ),
            ],
          ), //Date
          ex1,
          ex2,
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  if (state is AthleteDataLoading ||
                      state is AthleteDataLoaded) {
                    return OutlinedButton(
                        onPressed: () {
                          // Input validation for the Exercises
                          if (ex1.controllerGetExText == "" ||
                              ex2.controllerGetExText == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Please enter an a valid exercise")));
                            return;
                          }

                          listCreateData.add(ex1);
                          listCreateData.add(ex2);
                          for (int i = 0; i < listCreateData.length; i++) {
                            context.read<AthleteDataBloc>().add(
                                  CreateAthleteData(
                                    AthleteDataEntryModel(
                                      email: widget.userEmail,
                                      date: DateTime.parse(text),
                                      bw: int.parse(_controller.text),
                                      exercise:
                                          listCreateData[i].controllerGetExText,
                                      sets: int.parse(listCreateData[i]
                                          .controllerGetSetsText),
                                      reps: int.parse(listCreateData[i]
                                          .controllerGetRepsText),
                                      load: int.parse(listCreateData[i]
                                          .controllerGetLoadText),
                                    ),
                                  ),
                                );
                          }
                          _refreshScreen(context, widget.userEmail);
                        },
                        child: Text("Submit Data"));
                  }
                  return Text(
                    'Something went wrong ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Define a function to refresh the screen
void _refreshScreen(BuildContext context, String athleteEmailString) {
  // reset bloc to loading state
  context.read<AthleteDataBloc>().add(LoadAthleteData(athleteEmailString));

  // Clear any text fields
  ex1.clear();
  ex2.clear();

  // Push a new instance of the same screen onto the navigation stack
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => AthleteHome(
        userEmail: athleteEmailString,
      ),
    ),
  );
}
