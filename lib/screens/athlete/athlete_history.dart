import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/models/models.dart';
import 'package:intl/intl.dart';

class AthleteHistory extends StatefulWidget {
  @override
  State<AthleteHistory> createState() => _AthleteHistoryState();
}

class _AthleteHistoryState extends State<AthleteHistory> {
  Future<void> _deleteAthleteData(AthleteDataEntryModel athleteData) async {
    // Delete the athlete data from the database
    BlocProvider.of<AthleteDataBloc>(context)
        .add(DeleteAthleteData(athleteData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete History"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("History"),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  print(state);
                  if (state is AthleteDataLoading) {
                    _refreshScreen(context);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AthleteDataLoaded) {
                    final List<AthleteDataEntryModel> athleteData =
                        state.entries.toList();
                    if (athleteData.isEmpty) {
                      context.read<AthleteDataBloc>().add(LoadAthleteData());
                    }
                    return Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: athleteData.length,
                        itemBuilder: (context, index) {
                          // print(athleteData[index].document)
                          return ListTile(
                            title: Text(
                                '${DateFormat('yyyy-MM-dd').format(athleteData[index].date)} ${athleteData[index].exercise} ${athleteData[index].load} ${athleteData[index].reps}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                print(athleteData[index].id);
                                _deleteAthleteData(athleteData[index]);
                                // setState(() {
                                //   athleteData.removeAt(index);
                                // });
                                UpdateAthleteData(athleteData);
                                _refreshScreen(context);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    print("Error");
                    return Center(
                      child: Text("Error"),
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

// Define a function to refresh the screen
void _refreshScreen(BuildContext context) {
  // Close any blocs
  // context.read<AthleteDataBloc>().close();

  // Push a new instance of the same screen onto the navigation stack
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => AthleteHistory(),
    ),
  );
}
