import 'package:above_the_bar/bloc/blocs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagePrograms extends StatefulWidget {
  @override
  State<ManagePrograms> createState() => _ManageProgramsState();
}

class _ManageProgramsState extends State<ManagePrograms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Programs"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/create-program');
                    },
                    child: Text(
                      'Create Program',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/create-exercise');
                    },
                    child: Text(
                      "Create Exercise",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<ProgramListBloc, ProgramListState>(
                builder: (context, state) {
                  if (state is ProgramListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProgramListLoaded) {
                    final List<String> programsList =
                        state.programList.toList();
                    print(programsList);
                    // if (programsList.isEmpty) {
                    //   context.read<ProgramListBloc>().add(LoadProgramList());
                    // }
                    return Flexible(
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: programsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(programsList[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (kDebugMode) {
                                        print('Delete');
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (kDebugMode) {
                                        print('Copy');
                                      }
                                    },
                                    icon: Icon(Icons.copy),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/coach/edit-program');
                                    },
                                    icon: Icon(Icons.edit),
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
                      child: Text('No Programs Found'),
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
