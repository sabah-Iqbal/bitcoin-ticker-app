import 'package:http/http.dart' as http;
import 'dart:convert';

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
//const baseurl = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD';
//const baseurl = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
const baseurl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'CABCBA8F-4219-4C8A-AD76-2E85BFC8D462';

class CoinData {
  Future getCoinData(String currency) async {
    List<double> rateList = [];
    for (String list in cryptoList) {
      String url = '$baseurl/$list/$currency?apiKey=$apiKey';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        rateList.add(data['rate']);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return rateList;
  }
}
