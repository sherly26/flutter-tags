import 'package:flutter/material.dart';
import 'package:flutter_tags/models/tag.model.dart';
import 'package:flutter_tags/widgets/select_dialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TagModel> tags = [];
  final List<String> tagsNames = [
    'Apple',
    'Banana',
    'Orange',
    'Grape',
    'Pineapple',
    'Tangerine',
    'Kiwi',
    'Passionfruit',
    'Mango'
  ];

  @override
  void initState() {
    _buildTagModels();
    super.initState();
  }

  void _buildTagModels() {
    for (String tagName in tagsNames) {
      tags.add(TagModel(tagName, false));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: _openDialog,
              child:
                  Text('Select Tags', style: TextStyle(color: Colors.white))),
          _buildTags()
        ]);
  }

  _openDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Tags'),
          content: SelectDialog(selectablesItems: tags),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTags() {
    final TextStyle textStyle = TextStyle(color: Colors.white);
    return Wrap(children: [
      ...tags.map((tag) {
        final Size size = (TextPainter(
                text: TextSpan(text: tag.tagName, style: textStyle),
                maxLines: 1,
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                textDirection: TextDirection.ltr)
              ..layout())
            .size;

        if (tag.tagIsActive) {
          return Wrap(children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: size.width + 55,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(child: Text(tag.tagName, style: textStyle)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      child: Icon(Icons.close, size: 20, color: Colors.white),
                      onTap: () {
                        final foundItem = tags
                            .where((element) => element.tagName == tag.tagName)
                            .first;
                        setState(() {
                          foundItem.tagIsActive = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ]);
        } else {
          return Container();
        }
      })
    ]);
  }
}
