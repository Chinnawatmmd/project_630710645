import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_630710645/pages/review.dart';

import '../model/set.dart';

class PracticePage extends StatefulWidget {
  var listCard;

  PracticePage({Key? key, required List<Item> card}) {
    listCard = card.toList();
    swap();
  }

  void swap() {
    for (int i = 0; i < listCard.length / 2; i++) {
      int temp1 = Random().nextInt(listCard.length);
      int temp2 = Random().nextInt(listCard.length);
      Item item = listCard[temp1].copyWith(
          term: listCard[temp1].term.toString(),
          definition: listCard[temp1].definition.toString());
      listCard[temp1] = listCard[temp2].copyWith(
          term: listCard[temp2].term.toString(),
          definition: listCard[temp2].definition.toString());
      listCard[temp2] = item.copyWith(
          term: item.term.toString(), definition: item.definition.toString());
    }
  }

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  var index = 0;
  final answerController = TextEditingController();
  var isShowAnswer = false;
  var isSubmit = false;
  var cardCorrect = [];
  var cardWrong = [];
  var isCorrect = false;

  Widget showResult() {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Color(0XFF3d4035),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showText('Summary', 0),
            showText('Correct answer: ${cardCorrect.length}', 1),
            showText('Incorrect answer: ${cardWrong.length}', -1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(cardCorrect: cardCorrect,cardWrong: cardWrong,),
                    ),
                  );
                },
                child: Text('VIEW RESULT'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.indigoAccent,
                  side: BorderSide(color: Colors.indigoAccent, width: 2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }, child: Text('DONE')),
            ),
          ],
        ),
      ),
    );
  }

  Widget showData(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showText(text, 0),
        ],
      ),
    );
  }

  Widget showText(String text, int type) {
    return Text(
      text,
      style: TextStyle(
        color: type == 0
            ? Colors.white
            : type < 0
                ? Colors.red
                : Colors.green,
        height: 1.5,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF696969),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                showData(widget.listCard[index].term),
                if (isShowAnswer) showData(widget.listCard[index].definition),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigoAccent, width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Enter a your answer here',
                      contentPadding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 40, bottom: 40),
                    ),
                    style: TextStyle(
                        fontSize: 20.0, color: Colors.white, height: 1.25),
                    controller: answerController,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          if (!isSubmit)
            InkWell(
              onTap: () {
                setState(() {
                  isShowAnswer = !isShowAnswer;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                width: double.infinity,
                color: Colors.lightBlueAccent,
                child: Text(isShowAnswer ? 'HIDE ANSWER' : 'SHOW ANSWER',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          InkWell(
            onTap: () {
              setState(() {
                if (isSubmit) {
                  if (index < widget.listCard.length - 1) {
                    isShowAnswer = false;
                    isSubmit = false;
                    isCorrect = false;
                    index++;
                    answerController.clear();
                  } else {
                    //เปลี่ยนหน้า, show dialog
                    showDialog(
                      context: context,
                      builder: (context) => showResult(),
                    );
                  }
                } else {
                  isShowAnswer = true;
                  isSubmit = true;
                  if (widget.listCard[index].definition ==
                      answerController.text) {
                    isCorrect = true;
                  }
                  if (isCorrect)
                    cardCorrect.add(widget.listCard[index]);
                  else
                    cardWrong.add(widget.listCard[index]);
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              color: (isCorrect && isSubmit)
                  ? Colors.green
                  : isSubmit
                      ? Colors.red
                      : Colors.blueAccent,
              child: Text(
                isSubmit ? 'NEXT CARD' : 'SUBMIT',
                style: TextStyle(
                  color: Colors.white,
                  height: 1.5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
