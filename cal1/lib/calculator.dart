

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var Num1;
  var Num2 = 0.0;
  var oper = " ";
  var output = "";
  var input = "";
  var hideValue = false;

  onClickButton(value) {
    if (value == "AC") {
      output = "";
      input = "";
    } else if (value == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var UserInput = input;
        UserInput = input.replaceAll("×", "*");
        Parser p = Parser();
        Expression expression = p.parse(UserInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
          // log("${output}");
        }
        input = output;
        hideValue = true;
      }
    } else {
      input = input + value;
      hideValue = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 3, 4),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 82, 113),
      title: Center(child: Text("CALCULATOR", style: TextStyle(fontStyle: FontStyle.italic))),
       ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(padding: EdgeInsets.all(80)),
                        Text(
                          hideValue ? output : input,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          hideValue ? "" : output,
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Color.fromARGB(60,40,30,159),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button(
                                text: "AC",
                                TextSize: 33.0,  ),
                            Button(text: "%",
                                TextSize: 35.0, ),
                            Button(
                                text: "⌫",
                                TextSize: 25.0,),
                            Button(
                                text: "/",
                                  TextSize: 35.0),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button(text: "7"),
                            Button(text: "8"),
                            Button(text: "9"),
                            Button(
                                text: "×",
                                TextSize: 35.0),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button(text: "4"),
                            Button(text: "5"),
                            Button(text: "6"),
                            Button(
                              text: "-",
                              TextSize: 35.0),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button(text: "1"),
                            Button(text: "2"),
                            Button(text: "3"),
                            Button(
                                text: "+",
                                TextSize: 35.0),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Button(text: "0"),
                            Button(text: "00", TextSize: 35.0),
                            Button(text: "."),
                            Button(
                              text: "=",
                              TextSize: 35.0,
                              BgColor: Color.fromARGB(255, 5, 82, 113),
                            ),
                          ],
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Button(
      {text,
        textColor = Colors.white,
        BgColor = Colors.black87,
        TextSize = 35.0}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(0),
        child: ElevatedButton(
          onPressed: () {
            onClickButton(text);
          },
          // ignore: sort_child_properties_last
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: TextSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),

          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: BgColor,
              padding: EdgeInsets.all(18)),
        ),
      ),
    );
  }
}