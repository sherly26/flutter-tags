import 'package:flutter/material.dart';
import 'package:flutter_tags/models/tag.model.dart';

class SelectDialog extends StatefulWidget {
  final List<TagModel> selectablesItems;

  const SelectDialog({Key? key, required this.selectablesItems})
      : super(key: key);

  @override
  _SelectDialogState createState() => _SelectDialogState();
}

class _SelectDialogState extends State<SelectDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(children: [
        ...widget.selectablesItems
            .map((e) => CheckboxListTile(
                activeColor: Colors.blueAccent,
                value: e.tagIsActive,
                onChanged: (value) => setState(() {
                      e.tagIsActive = value!;
                    }),
                subtitle: Text(e.tagName)))
            .toList(),
      ])),
    );
  }
}
