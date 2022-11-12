import 'package:flutter/material.dart';
import 'package:project_630710645/pages/thirdHome.dart';

import '../model/set.dart';
import 'alert.dart';

class AddCardPage extends StatefulWidget {
  List<dynamic> tempData;
  int indexSet;
  int editNum = -1;

  AddCardPage({Key? key, required this.tempData, required this.indexSet})
      : super(key: key);

  AddCardPage.edit(
      {Key? key,
      required this.tempData,
      required this.indexSet,
      required this.editNum});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final termController = TextEditingController();
  final definitionController = TextEditingController();

  void addData() {
    widget.tempData[widget.indexSet].addItem(
        Item(term: termController.text, definition: definitionController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF696969),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThirdHomePage(
                              tempData: widget.tempData,
                              indexSet: widget.indexSet)),
                    );
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    var isEdit = false;
                    if (widget.editNum < 0) {
                      if (termController.text.length > 0 &&
                          definitionController.text.length > 0) {
                        addData();
                      }
                    } else {
                      if (termController.text.length > 0)
                        widget.tempData[widget.indexSet].card[widget.editNum]
                            .term = termController.text;
                      if (definitionController.text.length > 0)
                        widget.tempData[widget.indexSet].card[widget.editNum]
                            .definition = definitionController.text;
                      isEdit = true;
                    }
                    if (termController.text.length > 0 &&
                            definitionController.text.length > 0 ||
                        isEdit) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdHomePage(
                                tempData: widget.tempData,
                                indexSet: widget.indexSet)),
                      );
                    } else
                      showMyDialog(context, 'Sorry',
                          'Term and definition cannot be empty.');
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0XFFd3d3d3), width: 2.0),
                  ),
                  labelText: widget.editNum < 0
                      ? 'Term(front side)'
                      : widget
                          .tempData[widget.indexSet].card[widget.editNum].term,
                  hintText: 'Term(front side)',
                  hintStyle: TextStyle(
                    color: Color(0XFFd3d3d3),
                  ),
                ),
                controller: termController,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.indigoAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0XFFd3d3d3), width: 2.0),
                  ),
                  labelText: widget.editNum < 0
                      ? 'Definition(back side)'
                      : widget.tempData[widget.indexSet].card[widget.editNum]
                          .definition,
                  hintText: 'Definition(back side)',
                  hintStyle: TextStyle(
                    color: Color(0XFFd3d3d3),
                  ),
                ),
                controller: definitionController,
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (widget.editNum < 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    if (termController.text.length > 0 &&
                        definitionController.text.length > 0) {
                      addData();
                      termController.clear();
                      definitionController.clear();
                    } else
                      showMyDialog(context, 'Sorry',
                          'Term and definition cannot be empty.');
                  },
                  child: Text(
                    'ADD ANOTHER CARD',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.indigoAccent),
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
