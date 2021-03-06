import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../widgets/textInput.dart';

class AddToiletTitle extends StatelessWidget {
  const AddToiletTitle(this.title, this.onTitleChanged);
  final String title;
  final Function(String) onTitleChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 45, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "toiletName"),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextInput(
              title,
              FlutterI18n.translate(context, "name"),
              onTextChanged: onTitleChanged,
            ),
          )
        ],
      ),
    );
  }
}
