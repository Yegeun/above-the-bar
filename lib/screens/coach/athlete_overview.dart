import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteOverview extends StatefulWidget {
  @override
  State<AthleteOverview> createState() => _AthleteOverviewState();
}

class _AthleteOverviewState extends State<AthleteOverview> {
  @override
  Widget build(BuildContext context) {
    //gets data from previous page
    final athlete = ModalRoute.of(context)!.settings.arguments as AthleteModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Overview"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                      "Overview of ${athlete.name} email: ${athlete.email}"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20.0, top: 30.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'Athlete Current Best \n'
                        'Snatch 80 \n',
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  print(athlete.email);
                  context
                      .read<AthleteDataBloc>()
                      .add(LoadAthleteData("ukm0613@gmail.com"));

                  if (state is AthleteDataLoading) {
                    // _refreshScreen(context);
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
                          .add(LoadAthleteData("ukm0613@gmail.com"));
                    }

                    print(
                        'AthleteData ${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Clean and Jerk")}');
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
                                  '${athleteData[index].exercise} ${athleteData[index].load} ${athleteData[index].reps}'),
                            );
                          },
                        ),
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
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Athlete Graphs'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
