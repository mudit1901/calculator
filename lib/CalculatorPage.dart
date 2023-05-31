import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPage();
}

class _CalculatorPage extends State<CalculatorPage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '.',
    '0',
    '00',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //Input Box
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(fontSize: 35, color: Colors.white),
                  ),
                )
              ],
            ),
          )),
          //Keys
          Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                // For the Button Clear
                if (index == 0) {
                  return Button(
                    buttonTaped: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textcolor: Colors.white,
                  );
                  //  This is Delete Button
                } else if (index == 1) {
                  return Button(
                    buttonTaped: () {
                      setState(() {
                        if (userQuestion.length > 0) {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                          userAnswer = '';
                        }
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red.shade300,
                    textcolor: Colors.white,
                  );
                }
                //Equal to Button
                else if (index == buttons.length - 1) {
                  return Button(
                    buttonTaped: () {
                      setState(() {
                        equaltoPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red.shade300,
                    textcolor: Colors.white,
                  );
                } else {
                  return Button(
                      buttonTaped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      color: isOperator(buttons[index])
                          ? Colors.blue
                          : const Color.fromARGB(255, 77, 74, 74),
                      textcolor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.blue,
                      buttonText: buttons[index]);
                }
              },
            )),
          )
        ],
      ),
    );
  }

// For Giving Different Color of Operator
  bool isOperator(String s) {
    if (s == '%' || s == '/' || s == 'x' || s == '-' || s == '+' || s == '=') {
      return true;
    }
    return false;
  }

  void equaltoPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double finalequ = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = finalequ.toStringAsFixed(5);
  }
}
