import 'package:flutter/material.dart';

class CreateProgram extends StatefulWidget {
  @override
  State<CreateProgram> createState() => _CreateProgramState();
}

class _CreateProgramState extends State<CreateProgram> {
  List<CreateExerciseWidget> listDynamic = [];
  List<String> data = [];

  int vExerciseNum = 1;

  Icon floatingIcon = Icon(Icons.add);

  addDynamic() {
    if (data.length != 0) {
      floatingIcon = Icon(Icons.add);

      data = [];
      listDynamic = [];
      print('if');
    }
    setState(() {});
    if (listDynamic.length >= 20) {
      return;
    }
    listDynamic.add(
      CreateExerciseWidget(
        week: 1,
        session: 1,
        exerciseNum: vExerciseNum++,
      ),
    );
  }

  submitData() {
    floatingIcon = Icon(Icons.arrow_back);
    data = [];
    listDynamic.forEach((widget) => data.add(widget.controller.text));
    setState(() {});
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Flexible(
      flex: 1,
      child: Card(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text("${index + 1} : ${data[index]}"),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );

    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(2.0),
        minScale: 0.1,
        maxScale: 1.6,
        child: Column(
          children: [
            data.isEmpty ? dynamicTextField : result,
            OutlinedButton(onPressed: addDynamic, child: floatingIcon),
          ],
        ),
      ),
    );
  }
}

class CreateExerciseWidget extends StatelessWidget {
  CreateExerciseWidget(
      {required this.week, required this.session, required this.exerciseNum});

  final int? week;
  final int? session;
  final int? exerciseNum;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Exercise' '$exerciseNum'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter Data '),
          ),
        ),
      ],
    );
  }
}
