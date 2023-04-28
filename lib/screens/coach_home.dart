import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/models/athlete_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String _outlineTextButton = 'Assign Program';

class CoachHome extends StatefulWidget {
  final String userEmail;

  const CoachHome({super.key, required this.userEmail});

  @override
  State<CoachHome> createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  List<String> athleteAssigned = [];

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
          SizedBox(
            height: 10.0,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Welcome: ${widget.userEmail}',
                      style: TextStyle(
                        fontFamily: 'Arial',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      List<String> _manageList = [];
                      _manageList.add(widget.userEmail);
                      _manageList.addAll(athleteAssigned);
                      Navigator.pushNamed(context, '/coach/manage-programs',
                          arguments: _manageList);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey[900],
                      // text color
                      side: BorderSide(color: Colors.blue, width: 2),
                      // border color and width
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // rounded corners
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0), // button padding
                    ),
                    icon: Icon(Icons.manage_search_rounded), // manage icon
                    label: Text("Manage Programs"), // button text
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
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey[50]!),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(
                                        color: Colors.blue[700]!,
                                        // Border color
                                        width: 2.0, // Border width
                                      ),
                                    ),
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return 4; // Elevation when hovering
                                    } else {
                                      return 0; // Default elevation
                                    }
                                  }),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/coach/athlete-overview',
                                    arguments: athleteList[index],
                                  );
                                },
                                child: Text(
                                  '${athleteList[index].name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.blue, // Text color
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
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
                                        athleteAssigned
                                            .add(athleteList[index].programId);
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
              heroTag: null,
              tooltip: 'Add Athlete',
              child: Row(
                children: [
                  const Icon(Icons.add, size: 28),
                  // Add a small space between the icon and text
                  const Icon(Icons.person, size: 28),
                  // Add the text next to the icon
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                // set the text color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // set the rounded corners
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0), // set the button padding
              ),
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
