import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/models/models.dart';
import 'package:above_the_bar/bloc/blocs.dart';

class AthleteHistory extends StatefulWidget {
  @override
  State<AthleteHistory> createState() => _AthleteHistoryState();
}

class _AthleteHistoryState extends State<AthleteHistory> {
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
              Expanded(
                flex: 1,
                child: Text(
                    "Yegeunator History You can view and delete your entires here"),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  if (state is AthleteDataLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AthleteDataLoaded) {
                    final List<AthleteDataEntryModel> athleteData =
                        state.entries.toList();
                    print(athleteData.length);
                    return Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: athleteData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(athleteData[index].exercise),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text(
                      'Something went wrong ',
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
