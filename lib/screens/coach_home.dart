import 'package:above_the_bar/bloc/athlete_profile/athlete_profile_bloc.dart';
import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/models/athlete_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/bloc/athlete/athlete_bloc.dart';
import 'package:above_the_bar/bloc/program_list/program_list_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/cupertino_picker/dropdown_bloc.dart';

String _outlineTextButton = 'Assign Program';

class CoachHome extends StatefulWidget {
  final String userEmail;

  const CoachHome({super.key, required this.userEmail});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  Future<void> _deleteAthlete(AthleteModel athlete) async {
    // Delete the program from the database
    BlocProvider.of<AthleteBloc>(context)
        .add(DeleteAthlete(athlete, widget.userEmail));
  }

  @override
  Widget build(BuildContext context) {
    //loads in the coach's athletes
    context.read<ProgramListBloc>().add(LoadProgramList(widget.userEmail));
    DateTime _startDate = DateTime.now();

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
                      Navigator.pushNamed(context, '/coach/manage-programs',
                          arguments: widget.userEmail);
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
                  context
                      .read<AthleteBloc>()
                      .add(LoadAthlete(widget.userEmail));
                  if (state is AthleteLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AthleteLoaded) {
                    final List<AthleteModel> athleteList =
                        state.athletes.toList();
                    if (athleteList.isEmpty) {
                      context
                          .read<AthleteBloc>()
                          .add(LoadAthlete(widget.userEmail));
                    }
                    final blockList = athleteList
                        .map((athlete) => athlete.programId)
                        .toList();
                    return Flexible(
                      child: SizedBox(
                        height: 120.0,
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
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteAthlete(athleteList[index]);
                                      print(
                                          "Delete ${athleteList[index].name}");
                                    },
                                  ),
                                  BlocBuilder<ProgramListBloc,
                                      ProgramListState>(
                                    builder: (context, programState) {
                                      if (programState is ProgramListLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (programState is ProgramListLoaded) {
                                        final List<String> programsList =
                                            programState.programList.toList();
                                        programsList.insert(0, 'unassigned');
                                        final dropdownBloc =
                                            DropdownBloc<String>(programsList);
                                        String selectedItem = 'unassigned';
                                        if (programsList.contains(
                                            athleteList[index].programId)) {
                                          selectedItem =
                                              athleteList[index].programId;
                                        }
                                        return StreamBuilder<String>(
                                          stream:
                                              dropdownBloc.selectedItemStream,
                                          initialData: selectedItem,
                                          builder: (context, snapshot) {
                                            return DropdownButton<String>(
                                              value: snapshot.data,
                                              onChanged: (item) {
                                                context.read<AthleteBloc>().add(
                                                    CreateAthlete(
                                                        athleteList[index]
                                                            .copyWith(
                                                                programId:
                                                                    item!),
                                                        widget.userEmail));
                                                context
                                                    .read<AthleteProfileBloc>()
                                                    .add(
                                                      UpdateCreateAthleteProfile(
                                                        athleteList[index]
                                                            .email,
                                                        item,
                                                        _startDate,
                                                        1,
                                                        1,
                                                      ),
                                                    );
                                                setState(() {
                                                  selectedItem = item;
                                                });
                                                dropdownBloc
                                                    .setSelectedItem(item);
                                              },
                                              items: dropdownBloc.items.map<
                                                      DropdownMenuItem<String>>(
                                                  (item) {
                                                return DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item),
                                                );
                                              }).toList(),
                                            );
                                          },
                                        );
                                      }
                                      return Container();
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
                    arguments: widget.userEmail);
              },
              backgroundColor: Colors.blue,
              heroTag: null, //herotag is null
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
