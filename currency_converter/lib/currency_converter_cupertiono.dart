import 'package:flutter/cupertino.dart';

class CurrencyConverterCupertinoPage extends StatefulWidget {
  const CurrencyConverterCupertinoPage({super.key});

  @override
  State<CurrencyConverterCupertinoPage> createState() =>
      _CurrencyConverterCupertinoPageState();
}

class _CurrencyConverterCupertinoPageState
    extends State<CurrencyConverterCupertinoPage> {
  late double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  void convert() {
    setState(() {
      result = double.parse(textEditingController.text) * 81;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.activeBlue,
        navigationBar: const CupertinoNavigationBar(
          middle: Text(
            'CurrencyConverter',
            style:
                TextStyle(fontSize: 30, color: Color.fromARGB(255, 11, 12, 12)),
          ),
          automaticallyImplyMiddle: true,
          backgroundColor: CupertinoColors.activeBlue,
        ),
        child: Center(
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
              child: CupertinoTextField(
                controller: textEditingController,
                style: const TextStyle(color: CupertinoColors.black),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: 'Please enter amount in USD:',
                prefix: const Icon(CupertinoIcons.money_dollar),
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
              child: CupertinoButton(
                  onPressed:
                      convert, //calls this function when button is pressed
                  color: CupertinoColors.black,
                  child: const Text('Convert')),
            ),
          ]),
        ));
  }
}
