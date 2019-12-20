import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/";

class CoinData {
  Future<String> getData(String cryptoCurrency, String currency) async {
    http.Response response = await http.get("$baseURL$cryptoCurrency$currency");
    if (response.statusCode == 200) {
      double value = jsonDecode(response.body)["last"];
      return value.toStringAsFixed(2);
    } else {
      print(response.statusCode);
      return "";
    }
  }
}
