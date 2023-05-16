import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  List<String> buttonList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '6',
    '7',
    '8',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];
  String UserINPUT = '';
  String result = '0';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              child: resultWidget(),
              flex: 1,
            ),
            Flexible(
              child: buttonWidget(),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            UserINPUT,
            style: const TextStyle(fontSize: 30),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget() {
    return GridView.builder(
      itemCount: buttonList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
        return button(buttonList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
        shape: const CircleBorder(),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == 'AC') {
      UserINPUT = '';
      result = '0';
      return;
    }
    if (text == 'C') {
      UserINPUT = UserINPUT.substring(0, UserINPUT.length - 1);
      return;
    }
    if (text == '=') {
      result = calculate();
      if (result.endsWith('.0')) result = result.replaceAll('.0', '');
      return;
    }
    UserINPUT = UserINPUT + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(UserINPUT);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return 'error ';
    }
  }

  getColor(String text) {
    if (text == '*' || text == '+' || text == '/' || text == '-') {
      return Colors.orangeAccent;
    }
    if (text == '(' || text == ')') {
      return Colors.blueGrey;
    }
    if (text == 'AC' || text == 'C') {
      return Colors.red;
    }
    return Colors.lightBlue;
  }
}
