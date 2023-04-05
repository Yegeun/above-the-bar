import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/models/models.dart';
import 'package:intl/intl.dart';

class AthleteHistory extends StatefulWidget {
  final String athleteEmail;

  const AthleteHistory({super.key, required this.athleteEmail});

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Change the color here
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigate back to the previous screen
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[300]!, Colors.blue[700]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500]!,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 2.0),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "HISTORY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                      fontFamily: 'Helvetica Neue',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  if (state is AthleteDataLoading) {
                    _refreshScreen(context, widget.athleteEmail);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AthleteDataLoaded) {
                    final List<AthleteDataEntryModel> athleteData =
                        state.entries.toList();
                    if (athleteData.isEmpty) {
                      context
                          .read<AthleteDataBloc>()
                          .add(LoadAthleteData(widget.athleteEmail));
                    }
                    return Flexible(
                      child: SizedBox(
                        height: 300,
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
                                  _deleteAthleteData(athleteData[index]);
                                  // setState(() {
                                  //   athleteData.removeAt(index);
                                  // });
                                  UpdateAthleteData(athleteData);
                                  _refreshScreen(context, widget.athleteEmail);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
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
void _refreshScreen(BuildContext context, String athleteEmailString) {
  // context.read<AthleteDataBloc>().close();

  // Push a new instance of the same screen onto the navigation stack
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) =>
          AthleteHistory(athleteEmail: athleteEmailString),
    ),
  );
}
