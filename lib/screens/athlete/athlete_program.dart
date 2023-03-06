import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/bloc/program/program_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteProgram extends StatefulWidget {
  @override
  State<AthleteProgram> createState() => _AthleteProgramState();
}

class _AthleteProgramState extends State<AthleteProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Program"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("Program"),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<ProgramBloc, ProgramState>(
                builder: (context, state) {
                  if (state is ProgramLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProgramLoaded) {
                    final List<ProgramModel> programData =
                        state.program.toList();
                    print(programData);
                    return Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: programData.length,
                        itemBuilder: (context, index) {
                          // print(athleteData[index].document)
                          return ListTile(
                            title: Text(
                                '${programData[index].exercise} ${programData[index].sets} hell '
                                '${programData[index].intensity} ${programData[index].comments}'),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text(
                      'State: $state',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
