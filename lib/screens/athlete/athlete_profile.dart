import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:above_the_bar/bloc/athlete_profile/athlete_profile_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteProfile extends StatefulWidget {
  final String athleteEmail;

  const AthleteProfile({super.key, required this.athleteEmail});

  @override
  State<AthleteProfile> createState() => _AthleteProfileState();
}

class _AthleteProfileState extends State<AthleteProfile> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _coachEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.athleteEmail);
    context
        .read<AthleteProfileBloc>()
        .add(LoadAthleteProfile(widget.athleteEmail));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Profile"),
      ),
      body: BlocBuilder<AthleteProfileBloc, AthleteProfileState>(
        builder: (context, state) {
          if (state is AthleteProfileLoading) {
            return const CircularProgressIndicator();
          }
          if (state is AthleteProfileLoaded) {
            AthleteProfileModel athleteProfile = state.athleteProfile;
            _weightController.text = athleteProfile.weightClass.toString();
            _coachEmailController.text = athleteProfile.coachEmail;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    "Profile Page",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        athleteProfile.email,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Weight Class:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Container(
                        width: 150.0,
                        child: TextFormField(
                          controller: _weightController,
                          decoration: InputDecoration(
                            hintText: 'Weight Class',
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Coach Email:",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        athleteProfile.coachEmail,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            context
                                .read<AthleteProfileBloc>()
                                .add(CreateAthleteProfile(
                                  AthleteProfileModel(
                                      email: athleteProfile.email,
                                      weightClass:
                                          double.parse(_weightController.text),
                                      coachEmail: _coachEmailController.text,
                                      programId: state.athleteProfile.programId,
                                      startDate:
                                          state.athleteProfile.startDate),
                                ));

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Profile Updated Successfully'),
                            ));
                          },
                          child: Text('Update Profile')),
                    ],
                  ),
                ],
              ),
            );
          }
          return Text('Data has not been loaded');
        },
      ),
    );
  }
}
