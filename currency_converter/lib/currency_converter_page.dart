import 'package:flutter/material.dart';

// ignore: camel_case_types
class matrialHomePage extends StatefulWidget {
  const matrialHomePage({super.key});

  @override
  State<matrialHomePage> createState() => _currencyConverterState();
}

class _currencyConverterState extends State<matrialHomePage> {
  late double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void convert() {
    setState(() {
      result = double.parse(textEditingController.text) * 81;
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 5.0,
        style: BorderStyle.solid,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(25),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text(
            'CurrencyConverter',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 0,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'INR ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(3, 4, 3, 0.988),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10), //or can use all edgeInsets.all(10)
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Enter the amount in USD:',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: Icon(Icons.monetization_on),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
              ),
            ),
            //Button->textButton and raised(regular button)
            //1.Text Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                  onPressed:
                      convert, //calls this function when button is pressed

                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder()),
                  child: const Text('Convert')),
            ),
          ]),
        ));
  }
}
