import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String bitcoinValue = '?';
  String ethValue = '?';
  String ltcValue = '?';
  DropdownButton getAndroidDropDown() {
    List<DropdownMenuItem<String>> dropdownMenuItem = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenuItem.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  CupertinoPicker getIosPicker() {
    List<Text> listItem = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      listItem.add(item);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: listItem,
    );
  } //end of getIosPicker

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getData();
  }

  void getData() async {
    CoinData coinData = CoinData();
    try {
      //double data = await coinData.getCoinData(currency);
      List<double> rateList = await coinData.getCoinData(selectedCurrency);
      setState(() {
        for (int i = 0; i < rateList.length; i++) {
          if (i == 0) {
            bitcoinValue = rateList[i].toStringAsFixed(0);
          } else if (i == 1) {
            ethValue = rateList[i].toStringAsFixed(0);
          } else if (i == 2) {
            ltcValue = rateList[i].toStringAsFixed(0);
          }
        }
        //bitcoinValue = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  "1 BTC = $bitcoinValue $selectedCurrency",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  "1 ETH = $ethValue $selectedCurrency",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  "1 LTC = $ltcValue $selectedCurrency",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getIosPicker() : getAndroidDropDown(),
          ),
        ],
      ),
    );
  }
}
/*
DropdownButton<String>(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                });
              },
            ),
 */
/*
CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex) {
                print(selectedIndex);
              },
              children: getListItem(),
            ),
 */
