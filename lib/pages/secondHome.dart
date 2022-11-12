import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project_630710645/pages/addCardPage.dart';
import 'package:project_630710645/pages/home.dart';
import '../model/set.dart';
import 'alert.dart';

class SecondHome extends StatefulWidget {
  List<dynamic> tempData;
  int editNum = -1;

  SecondHome({Key? key, required this.tempData}) : super(key: key);

  SecondHome.edit({Key? key, required this.tempData, required this.editNum});

  @override
  State<SecondHome> createState() => _SecondHomeState();
}

class _SecondHomeState extends State<SecondHome> {
  @override
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  void addData() {
    if (nameController.text.length > 0) {
      if (descriptionController.text.length > 0)
        widget.tempData.add(Set.withDesc(
            name: nameController.text,
            description: descriptionController.text));
      else
        widget.tempData.add(Set(name: nameController.text));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF3d4035),
      body: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(16.0),
        color: Color(0XFF696969),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    var isEdit = false;
                    if (widget.editNum >= 0) {
                      if (nameController.text.length > 0)
                        widget.tempData[widget.editNum].name =
                            nameController.text;
                      if (descriptionController.text.length > 0)
                        widget.tempData[widget.editNum]
                            .addDesc(descriptionController.text);
                      isEdit = true;
                    } else {
                      addData();
                    }
                    if (nameController.text.length > 0 || isEdit)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage.New(tempData: widget.tempData)),
                      );
                    else
                      showMyDialog(context, 'Sorry', 'Name cannot be empty.');
                    //print(widget.tempData.length);
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
                      ? 'Name'
                      : widget.tempData[widget.editNum].name,
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Color(0XFFd3d3d3),
                  ),
                ),
                controller: nameController,
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
                  labelText: widget.editNum >= 0 &&
                          widget.tempData[widget.editNum].description != null
                      ? widget.tempData[widget.editNum].description
                      : 'Description-optional',
                  hintText: 'Description-optional',
                  hintStyle: TextStyle(
                    color: Color(0XFFd3d3d3),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                controller: descriptionController,
              ),
            ),
            if (widget.editNum < 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () {
                    addData();
                    if (nameController.text.length > 0)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCardPage(
                              tempData: widget.tempData,
                              indexSet: widget.tempData.length - 1),
                        ),
                      );
                  },
                  child: Text(
                    '+ ADD CARDS',
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
