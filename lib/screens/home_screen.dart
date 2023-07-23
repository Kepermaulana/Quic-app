import 'package:flutter/material.dart';
import 'package:quiz_app/core/models/question_model.dart';
import 'package:quiz_app/core/style/constants.dart';
import 'package:quiz_app/widgets/WNextButton.dart';
import 'package:quiz_app/widgets/WOptionCard.dart';
import 'package:quiz_app/widgets/WQuestion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question> _questions = [
    Question(
        id: '10',
        title: 'What is 2 + 2 ?',
        options: {'5': false, '30': false, '4': true, '10': false}),
    Question(
        id: '11',
        title: 'What is 10 + 20',
        options: {'50': false, '30': true, '40': false, '10': false})
  ];
  int index = 0;

  bool isPressed = false;

  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          print(_questions.length);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsetsDirectional.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void changeColor() {
    setState(() {
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            WQuestion(
                indexAction: index,
                question: _questions[index].title,
                totalQuestions: _questions.length),
            Divider(
              color: neutral,
            ),
            SizedBox(
              height: 25,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              WOptionCard(
                option: _questions[index].options.keys.toList()[i],
                color: isPressed
                    ? _questions[index].options.values.toList()[i] == true
                        ? correct
                        : incorrect
                    : neutral,
                onTap: changeColor,
              )
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: WNextButton(
            nextQuestion: nextQuestion,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
