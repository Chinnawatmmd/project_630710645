
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  var cardCorrect;
  var cardWrong;

  ReviewPage({Key? key, this.cardCorrect, this.cardWrong}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  var isShowWrong = true;
  var isShowCorrect = false;
  @override
  void initState() {
    super.initState();
    if(widget.cardWrong.length==0){
      isShowWrong = false;
      isShowCorrect = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF3d4035),
      appBar: AppBar(
        backgroundColor: Color(0XFF555555),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.cardWrong.length > 0)
                createButton('WRONG : ${widget.cardWrong.length}', isShowWrong),
              if (widget.cardCorrect.length > 0)
                createButton(
                    'CORRECT: ${widget.cardCorrect.length}', isShowCorrect),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: buildListItem,
              itemCount: isShowWrong
                  ? widget.cardWrong.length
                  : widget.cardCorrect.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget createButton(String text, bool isShow) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            if (isShow == isShowWrong) {
              isShowWrong = true;
              isShowCorrect = false;
            } else {
              isShowWrong = false;
              isShowCorrect = true;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0XFF696969),
            border: isShow
                ? Border(
                    bottom: BorderSide(color: Colors.white, width: 4.0),
                  )
                : Border(
                    bottom: BorderSide(color: Color(0XFF696969), width: 4.0),
                  ),
          ),
          child: Text(
            text,
            style: isShow
                ? TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
      ),
    );
  }

  Widget showListItemData(String text, int index) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              height: 1.5,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListItem(BuildContext context, int index) {
    return Card(
      color: Color(0XFF696969),
      margin: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            showListItemData(
                isShowWrong
                    ? widget.cardWrong[index].term
                    : widget.cardCorrect[index].term,
                index),
            showListItemData(
                isShowWrong
                    ? widget.cardWrong[index].definition
                    : widget.cardCorrect[index].definition,
                index),
          ],
        ),
      ),
    );
  }
}
