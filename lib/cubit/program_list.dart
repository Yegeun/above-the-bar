import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramListCubit extends Cubit<List<String>> {
  ProgramListCubit(super.initialState);

  void addToList(String programName) {
    List<String> list = state;
    list.add(programName);
    emit(list);
  }
}
