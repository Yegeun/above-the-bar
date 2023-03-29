import 'package:above_the_bar/models/athlete_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/bloc/athlete/athlete_bloc.dart';
import 'package:above_the_bar/bloc/program_list/program_list_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

class CoachHome extends StatefulWidget {
  final String coachEmail;

  const CoachHome({super.key, required this.coachEmail});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  Future<void> _deleteAthlete(AthleteModel athlete) async {
    // Delete the program from the database
    BlocProvider.of<AthleteBloc>(context).add(DeleteAthlete(athlete));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coach Programming App"),
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
                      Navigator.pushNamed(context, '/coach/manage-programs');
                    },
                    child: Text("Manage Programs"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<AthleteBloc, AthleteState>(
                builder: (context, state) {
                  if (state is AthleteLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AthleteLoaded) {
                    final List<AthleteModel> athleteList =
                        state.athletes.toList();
                    if (athleteList.isEmpty) {
                      context.read<AthleteBloc>().add(LoadAthlete());
                    }
                    final blockList =
                        athleteList.map((athlete) => athlete.block).toList();
                    return Flexible(
                      child: SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: athleteList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: TextButton(
                                  child: Text(athleteList[index].name),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/coach/athlete-overview',
                                      arguments: athleteList[index],
                                    );
                                  }),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/coach/edit',
                                        arguments: athleteList[index],
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteAthlete(athleteList[index]);
                                      print(
                                          "Delete ${athleteList[index].name}");
                                    },
                                  ),
                                  Text(
                                    "GPP1 Week 1 Session 1",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  BlocBuilder<ProgramListBloc,
                                      ProgramListState>(
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
                                        if (athleteList[index].block == '') {
                                          return TextButton(
                                              onPressed: () {
                                                Placeholder();
                                              },
                                              child: Text('Assign Program'));
                                        } else {
                                          return Text(athleteList[index].block);
                                        }
                                      } else {
                                        return Center(
                                          child: Text('Error'),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("No Athletes"),
                    );
                  }
                },
              ),
            ],
          ),
          Container(
            //bottom right
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(50),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coach/add-athlete',
                    arguments: widget.coachEmail);
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
