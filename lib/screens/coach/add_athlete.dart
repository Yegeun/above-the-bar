import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/screens/coach_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:above_the_bar/models/athlete_model.dart';

final List<String> athleteList = [];
String addAthleteEmail = '';

class AddAthlete extends StatefulWidget {
  final String coachEmail;

  const AddAthlete({super.key, required this.coachEmail});

  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBlock = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

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

  //TODO need to check if there's duplicate email already added to the coaches list
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
              BlocBuilder<AthleteListBloc, AthleteListState>(
                builder: (context, state) {
                  if (state is AthleteListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AthleteListLoaded) {
                    athleteList.clear();
                    athleteList.addAll(state.athleteList.toList());
                    return Container(
                      width: 150,
                      child: RawAutocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          } else {
                            List<String> matches = <String>[];
                            matches.addAll(athleteList);
                            matches.retainWhere((s) {
                              return s.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (String selection) {
                          if (kDebugMode) {
                            print('You just selected $selection');
                          }
                          _controllerEmail.text = selection;
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                            controller: textEditingController,
                            focusNode: focusNode,
                            //
                            onSubmitted: (String value) {
                              _controllerEmail.text = value;
                              addAthleteEmail = value;
                            },
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            void Function(String) onSelected,
                            Iterable<String> options) {
                          return Material(
                            child: SizedBox(
                              height: 200,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: options.map((opt) {
                                    return InkWell(
                                        onTap: () {
                                          onSelected(opt);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(right: 60),
                                            child: Card(
                                                child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              child: Text(opt),
                                            ))));
                                  }).toList(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),

              // Container(
              //   width: 200,
              //   margin: EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: _controllerEmail,
              //     decoration: InputDecoration(hintText: 'Email'),
              //   ),
              // ),
              BlocBuilder<ProgramListBloc, ProgramListState>(
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
              // BlocBuilder<AthleteData>()
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
              BlocBuilder<AthleteBloc, AthleteState>(
                builder: (context, state) {
                  if (state is AthleteLoading || state is AthleteLoaded) {
                    return ElevatedButton(
                      onPressed: () {
                        print(controllerGetEmailText.toLowerCase());
                        if (athleteList
                            .contains(controllerGetEmailText.toLowerCase())) {
                          context.read<AthleteBloc>().add(
                                CreateAthlete(
                                  AthleteModel(
                                    name: controllerGetNameText.toLowerCase(),
                                    email: controllerGetEmailText.toLowerCase(),
                                    //TODO email vaildation for the Sign up form
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
                              builder: (context) =>
                                  CoachHome(coachEmail: widget.coachEmail),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Athlete does not exist'),
                            ),
                          );
                        }
                      },
                      child: const Text('Add Athlete'),
                    );
                  }
                  return const Text('Error');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
