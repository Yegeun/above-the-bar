import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/screens/coach_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:above_the_bar/models/athlete_model.dart';

class AddAthlete extends StatefulWidget {
  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerBlock = TextEditingController();

  String get controllerGetNameText => _controllerName.text;

  String get controllerGetEmailText => _controllerEmail.text;

  String get controllerGetBlock => _controllerBlock.text;

  late DateTime date = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Set an initial value for _selectedItem
  }

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Athlete"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                width: 200,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerName,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Container(
                width: 200,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
              ),
              BlocBuilder<ProgramListBloc, ProgramListState>(
                //TODO this shoudl adpat for uassign and assign
                builder: (context, state) {
                  if (state is ProgramListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProgramListLoaded) {
                    final List<String> programsList =
                        state.programList.toList();
                    programsList.insert(0, 'unassigned');

                    final dropdownBloc = DropdownBloc<String>(programsList);
                    late String selectedItem = dropdownBloc.items[0];
                    return StreamBuilder<String>(
                      stream: dropdownBloc.selectedItemStream,
                      initialData: selectedItem,
                      builder: (context, snapshot) {
                        return DropdownButton<String>(
                          value: snapshot.data,
                          onChanged: (item) {
                            setState(() {
                              selectedItem = item!;
                              _controllerBlock.text = item;
                            });
                            dropdownBloc.setSelectedItem(item!);
                          },
                          items: dropdownBloc.items
                              .map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No Programs'),
                    );
                  }
                },
              ),
              Container(
                width: 200,
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
              SizedBox(height: 10.0),
            ],
          ),
          BlocBuilder<AthleteBloc, AthleteState>(
            builder: (context, state) {
              if (state is AthleteLoading || state is AthleteLoaded) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AthleteBloc>().add(
                          CreateAthlete(
                            AthleteModel(
                              name: controllerGetNameText.toLowerCase(),
                              email: controllerGetEmailText.toLowerCase(),
                              block: controllerGetBlock.toLowerCase(),
                              startDate: DateTime.parse(text),
                            ),
                          ),
                        );
                    dispose();
                    // Navigation.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoachHome(),
                      ),
                    );
                  },
                  child: const Text('Add Athlete'),
                );
              }
              return const Text('Error');
            },
          )
        ],
      ),
    );
  }
}
