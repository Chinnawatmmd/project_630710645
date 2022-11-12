import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_630710645/pages/practice.dart';
import 'package:project_630710645/pages/secondHome.dart';
import 'package:project_630710645/pages/thirdHome.dart';

import '../model/set.dart';
import 'addCardPage.dart';

class HomePage extends StatefulWidget {
  List<dynamic> tempData = [
    Set(
      name: 'Words starting with a',
    ),
    Set.withDesc(name: 'b', description: 'Just word with b')
  ];

  HomePage({Key? key}) : super(key: key);

  HomePage.New({Key? key, required this.tempData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget createSearchBarButton(String text) {
    return OutlinedButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          color: Colors.indigoAccent,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.indigoAccent),
      ),
    );
  }

  /*void initState() {
    super.initState();
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF555555),
        automaticallyImplyLeading: false,
        title: Text('FLASHCARD MAKER'),
      ),
      backgroundColor: Color(0XFF3d4035),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: _buildListItem,
              itemCount: widget.tempData.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondHome(tempData: widget.tempData)),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('CREATE SET'),
        backgroundColor: Colors.indigoAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      color: Color(0XFF696969),
      margin: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThirdHomePage(
                tempData: widget.tempData,
                indexSet: index,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.tempData[index].name!,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondHome.edit(
                                      tempData: widget.tempData,
                                      editNum: index,
                                    )),
                          );
                        },
                        icon: Icon(Icons.edit, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.tempData[index].description != null
                            ? widget.tempData[index].description!
                            : '',
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.tempData.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "${widget.tempData[index].card.length.toString()} Card",
                      style: TextStyle(
                        color: Colors.white38,
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
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
                    if (widget.tempData[index].card.length > 0)
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PracticePage(
                                  card: widget.tempData[index].card),
                            ),
                          );
                        },
                        child: Text(
                          'PRACTICE',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.indigoAccent),
                          backgroundColor: Colors.indigoAccent,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
