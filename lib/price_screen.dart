import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/list_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String selectedCurrencyAmount;
  Map<String, String> cryptoMap = Map<String, String>();

  getDollarPrice() {
    cryptoList.forEach((currency) async {
      String value = await CoinData().getData(currency, selectedCurrency);
      setState(() {
        cryptoMap.update(currency, (old) => value, ifAbsent: () => value);
      });
    });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
          getDollarPrice();
        },
        children: currenciesList
            .map(
              (currency) => Text(
                currency,
                style: TextStyle(color: Colors.white),
              ),
            )
            .toList());
  }

  DropdownButton<String> androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map(
            (currency) => DropdownMenuItem(
              value: currency,
              child: Text(currency),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getDollarPrice();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cryptoList
                  .map((currency) => ListCard(
                        selectedCurrencyAmount: cryptoMap[currency],
                        cryptoCurrency: currency,
                        selectedCurrency: selectedCurrency,
                      ))
                  .toList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    getDollarPrice();
    super.initState();
  }
}
