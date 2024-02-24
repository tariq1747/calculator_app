import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = '0';
  void _valueOnChange(String val) {
    setState(() {
      if ('AC' == val) {
        text = '0';
      } else if ('=' == val) {
        Parser parser = Parser();
        Expression exp = parser.parse(text);
        ContextModel cm = ContextModel();
        cm.bindVariableName('x', Number(4)); // Bind value to variable x
        double result = exp.evaluate(EvaluationType.REAL, cm);

        text = result.toString();
      } else {
        text = text + val;
      }
    });
  }

  List<String> numOprationsList = [
    'AC',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              alignment: Alignment.centerRight,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 100),
              ),
            ),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ...List.generate(
                  numOprationsList.length,
                  (index) {
                    return Button(
                      onTap: () => _valueOnChange(numOprationsList[index]),
                      lable: numOprationsList[index],
                      radius: 50,
                      color: RegExp(r'\d|\.').hasMatch(numOprationsList[index])
                          ? null
                          : RegExp(r'(AC|\+\/-|%)')
                                  .hasMatch(numOprationsList[index])
                              ? Colors.grey
                              : Colors.amber,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.color,
    required this.lable,
    this.lableColor,
    this.radius,
    this.onTap,
  });
  final Color? color;
  final String lable;
  final Color? lableColor;
  final double? radius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          width: lable == '0' ? 150 : 70,
          decoration: BoxDecoration(
            color: color ?? Colors.grey[800],
            borderRadius:
                radius != null ? BorderRadius.circular(radius!) : null,
          ),
          child: Center(
            child: Text(
              lable,
              style: TextStyle(
                color: lableColor ?? Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
