import 'package:above_the_bar/bloc/athlete/athlete_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/athlete_model.dart';

class AddAthlete extends StatefulWidget {
  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  String time = '';

  final TextEditingController _controllerName = TextEditingController();
  String get controllerGetNameText => _controllerName.text;
  final TextEditingController _controllerEmail = TextEditingController();
  String get controllerGetEmailText => _controllerEmail.text;
  final TextEditingController _controllerBlock = TextEditingController();
  String get controllerGetBlock => _controllerBlock.text;
  late DateTime date = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerBlock.dispose();
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
              Container(
                width: 200,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerBlock,
                  decoration: InputDecoration(hintText: 'Block'),
                ),
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
                    print(date);
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
                            Athlete(
                              name: controllerGetNameText.toLowerCase(),
                              email: controllerGetEmailText.toLowerCase(),
                              block: controllerGetBlock.toLowerCase(),
                              startDate: DateTime.parse(text),
                            ),
                          ),
                        );
                    print(controllerGetNameText);
                    print(controllerGetEmailText);
                    print(controllerGetBlock);
                    print(text);
                    dispose();
                    Navigator.pop(context);
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
