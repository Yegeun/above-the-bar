import 'package:above_the_bar/models/athlete_data_entry_model.dart';
import 'package:above_the_bar/widgets/athlete_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/athlete_data/athlete_data_bloc.dart';

class AthleteHome extends StatefulWidget {
  late DateTime date = DateTime.now();

  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  List<AthleteInputWidget> listDynamic = [];
  List<AthleteInputWidget> listCreateData = [];
  List<String> data = [];

  late DateTime date = DateTime.now();
  //initiate AthleteInput
  AthleteInputWidget ex1 = AthleteInputWidget(exerciseNum: 1);
  AthleteInputWidget ex2 = AthleteInputWidget(exerciseNum: 2);

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Programming App"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/history');
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
                      Navigator.pushNamed(context, '/athlete/history');
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
            ],
          ),//Date
          ex1,
          ex2,
          Row(
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(builder: (context,state){
                if(state is AthleteDataLoading || state is AthleteDataLoaded){
                  return OutlinedButton(
                      onPressed: () {
                        // Input validation for the Exercises
                        if(ex1.controllerGetExText == "" || ex2.controllerGetExText == ""){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please enter an a valid exercise")));
                          return;
                        }

                        listCreateData.add(ex1);
                        listCreateData.add(ex2);

                        for(int i = 0; i < listCreateData.length; i++) {
                          context.read<AthleteDataBloc>().add(
                              CreateAthleteData(
                                  AthleteDataEntryModel(
                                    email: "yegeunator@gmail.com",
                                    date: DateTime.parse(text),
                                    bw: 61,
                                    exercise: listCreateData[i].controllerGetExText,
                                    sets: int.parse(listCreateData[i].controllerGetSetsText),
                                    reps: int.parse(listCreateData[i].controllerGetRepsText),
                                    load: int.parse(listCreateData[i].controllerGetIntText),
                                  )
                              )
                          );
                        }
                        Navigator.pushNamed(context, '/athlete/home');
                      },
                      child: Text("Submit Data"));
                }
                return Text(
                'Something went wrong ',
                style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600),
                );
              }
              ),
            ],
          ),

        ],
      ),
    );
  }
}
