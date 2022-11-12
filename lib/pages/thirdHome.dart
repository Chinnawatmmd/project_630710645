import 'package:flutter/material.dart';
import 'package:project_630710645/pages/home.dart';
import 'package:project_630710645/pages/practice.dart';

import 'addCardPage.dart';

class ThirdHomePage extends StatefulWidget {
  List<dynamic> tempData;
  int indexSet;

  ThirdHomePage({Key? key, required this.tempData, required this.indexSet})
      : super(key: key);

  @override
  State<ThirdHomePage> createState() => _ThirdHomePageState();
}

class _ThirdHomePageState extends State<ThirdHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF696969),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage.New(
                      tempData: widget.tempData,
                    )),
          ),
        ),
      ),
      backgroundColor: Color(0XFF3d4035),
      body: Column(
        children: [
          if (widget.tempData[widget.indexSet].card != null)
            Expanded(
              child: ListView.builder(
                itemBuilder: _buildListItem,
                itemCount: widget.tempData[widget.indexSet].card.length,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: OutlinedButton(
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '+ ADD CARDS',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 1.25),
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              ),
              if (widget.tempData[widget.indexSet].card.length > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PracticePage(card: widget.tempData[widget.indexSet].card),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'PRACTICE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white,width: 1.25),
                      backgroundColor: Colors.indigoAccent,
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      color: Color(0XFF696969),
      margin: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.tempData[widget.indexSet].card[index].term,
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
                              builder: (context) => AddCardPage.edit(
                                    tempData: widget.tempData,
                                    indexSet: widget.indexSet,
                                    editNum: index,
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.tempData[widget.indexSet].card[index].definition,
                      style: TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      widget.tempData[widget.indexSet].card.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
