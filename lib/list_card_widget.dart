import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final cryptoCurrency;
  final selectedCurrencyAmount;
  final selectedCurrency;

  const ListCard(
      {Key key,
      this.cryptoCurrency,
      this.selectedCurrencyAmount,
      this.selectedCurrency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrency = $selectedCurrencyAmount $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
