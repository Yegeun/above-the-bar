import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoachHome extends StatefulWidget {
  @override
  _CoachHomeState createState() => _CoachHomeState();
}

class _CoachHomeState extends State<CoachHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coach Programming App"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/manage-programs');
                    },
                    child: Text("Manage Programs"),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  // alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/athlete-overview');
                    },
                    child: Text("Overview"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  // alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/edit');
                    },
                    child: Text("Program"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, left: 40.0),
                  // alignment: Alignment.topCenter,
                  child: Text("Week/s"),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  // alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("Unassigned");
                      }
                    },
                    child: Text("Unassigned"),
                  ),
                ),
              ),
            ],
          ),
          Container(
            //bottom right
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(50),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/coach/add-athlete');
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
