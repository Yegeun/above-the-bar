import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AthleteProfileRow extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  AthleteProfileRow({required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 20.0),
          ),
          Container(
            width: 150.0,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: labelText,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
