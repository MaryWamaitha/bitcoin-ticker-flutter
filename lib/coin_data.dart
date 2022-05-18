import 'networking.dart';
const apiKey = '919BB7B7-E950-4E19-A290-954B55617DF0';
const coinApiUrl = 'https://rest.coinapi.io/v1/exchangerate';

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

class CoinData {
  Future<dynamic> getCurrencyValue(coin,currency) async {
    var url = '$coinApiUrl/$coin/$currency?apikey=$apiKey';
    NetworkHelper networkHelper = NetworkHelper('$url');
    var currencyData = await networkHelper.getData();
    return currencyData;
  }
}
