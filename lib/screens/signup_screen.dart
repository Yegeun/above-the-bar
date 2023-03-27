import 'package:above_the_bar/auth_service.dart';
import 'package:above_the_bar/cubit/signup/signup_cubit.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:above_the_bar/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/user/user_bloc.dart';

const List<Widget> occupation = <Widget>[Text('coach'), Text('athlete')];
final List<bool> selectedOccupation = <bool>[true, false];

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (_) => SignupCubit(context.read<AuthService>()),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String _title = 'Occuaption';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Navigator.push(context, HomeScreen.route());
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ??
                      'Sign Up Failure because of ${state.errorMessage}'),
                ),
              );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              _EmailInput(),
              SizedBox(height: 10),
              _PasswordInput(),
              ToggleButtonsOccupation(title: _title),
              SizedBox(height: 10),
              _SignupButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleButtonsOccupation extends StatefulWidget {
  const ToggleButtonsOccupation({super.key, required this.title});

  final String title;

  @override
  State<ToggleButtonsOccupation> createState() => _ToggleButtonOccupation();
}

class _ToggleButtonOccupation extends State<ToggleButtonsOccupation> {
  List<bool> get getSelectedOccupation => selectedOccupation;

  List<bool> setOccupation(List<bool> selectedOccupation) {
    selectedOccupation[0] = selectedOccupation[0];
    selectedOccupation[1] = selectedOccupation[1];
    return selectedOccupation;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ToggleButtons with a single selection.
            Text('ROLE', style: theme.textTheme.titleSmall),
            const SizedBox(height: 5),
            ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < selectedOccupation.length; i++) {
                    selectedOccupation[i] = i == index;
                  }
                  (selectedOccupation);
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: selectedOccupation,
              children: occupation,
            )
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'Invalid Email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'Invalid Password' : null,
          ),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if (userState is UserLoaded || userState is UserLoading) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(210, 50),
                      ),
                      onPressed: state.status.isValidated
                          ? () {
                              context.read<SignupCubit>().signUpFormSubmitted();
                              if (_ToggleButtonOccupation()
                                  .getSelectedOccupation[0]) {
                                print('coach');
                                context.read<UserBloc>().add(
                                      CreateUser(
                                        UserPublicModel(
                                          email: state.email.value,
                                          occupation: 'coach',
                                        ),
                                      ),
                                    );
                              } else {
                                print('athlete');
                                context.read<UserBloc>().add(
                                      CreateUser(
                                        UserPublicModel(
                                          email: state.email.value,
                                          occupation: 'athlete',
                                        ),
                                      ),
                                    );
                              }
                            }
                          : null,
                      child: const Text('Sign Up'),
                    );
                  } else {
                    return Text('Error Occurred');
                  }
                },
              );
      },
    );
  }
}
