import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData exchange = CoinData();
  String selectedCurrency = 'USD';
  String btcCoin ='';
  String ethCoin ='';
  String ltcCoin ='';
  String btcCurrencyValue = '?';
  String ethCurrencyValue = '?';
  String ltcCurrencyValue = '?';

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
      for (int i = 0; i < currenciesList.length; i++) {
        String currency = currenciesList[i];
         var newItem = DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
         dropdownItems.add(newItem);
      }
      return dropdownItems;
  }

  void getBTCData() async{
    btcCoin = 'BTC';
    try {
      var data = await exchange.getCurrencyValue(btcCoin,selectedCurrency);
      double rate = data['rate'];
      setState(() {
        btcCurrencyValue= rate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }
  void getETHData() async{
    ethCoin = 'ETH';
    try {
      var data = await exchange.getCurrencyValue(ethCoin,selectedCurrency);
      double rate = data['rate'];
      setState(() {
        ethCurrencyValue= rate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }
  void getLTCData() async{
    ltcCoin ='LTC';
    try {
      var data = await exchange.getCurrencyValue(ltcCoin,selectedCurrency);
      double rate = data['rate'];
      setState(() {
        ltcCurrencyValue= rate.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getBTCData();
    getETHData();
    getLTCData();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CurrencyBox(bitText: 'BTC', currencyValue: btcCurrencyValue, selectedCurrency: selectedCurrency),
              CurrencyBox(bitText: 'ETH', currencyValue: ethCurrencyValue, selectedCurrency: selectedCurrency),
              CurrencyBox(bitText: 'LTC', currencyValue: ltcCurrencyValue, selectedCurrency: selectedCurrency),
            ],
          ),


          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              //VALUE is the default value that the onChanged starts with
              value: selectedCurrency,
              items: getDropdownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                  getBTCData();
                  getETHData();
                  getLTCData();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyBox extends StatelessWidget {
  const CurrencyBox({
    @required this.bitText,
    @required this.currencyValue,
    @required this.selectedCurrency,
  });

  final String currencyValue;
  final String selectedCurrency;
  final String bitText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '$bitText = $currencyValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


