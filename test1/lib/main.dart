import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

import 'bitcoin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BITCOIN CRYPTOCURRENCY',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BITCOIN CRYPTOCURRENCY APP'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const Text("", style: TextStyle(height: 1)),
          Container(
              child: Center(child: Image.asset("assets/images/bitcoin.jpg"))),
          Container(child: const BitcoinPage()),
        ])),
      ),
    );
  }
}

class BitcoinPage extends StatefulWidget {
  const BitcoinPage({Key? key}) : super(key: key);

  @override
  _BitcoinPageState createState() => _BitcoinPageState();
}

class _BitcoinPageState extends State<BitcoinPage> {
  String rates = "btc";
  List<String> ratesList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats"
  ];

  String description = "Not Available";
  String name = "Not Available";
  String unit = "Not Available";
  String type = "Not Available";
  var value = 0.000;

  Bitcoin curbitcoin = Bitcoin("Not Available", "Not Available",
      "Not Available", 0.000, "Not Available");

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "BITCOIN CRYPTOCURRENCY",
          style: TextStyle(
              height: 2,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 253, 224, 136)),
        ),
        DropdownButton(
          itemHeight: 60,
          value: rates,
          onChanged: (newValue) {
            setState(() {
              rates = newValue.toString();
            });
          },
          items: ratesList.map((rates) {
            return DropdownMenuItem(
              child: Text(rates,
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
              value: rates,
            );
          }).toList(),
        ),
        ElevatedButton(
            onPressed: _loadExchange,
            style: ElevatedButton.styleFrom(primary: Colors.yellow),
            child: const Text("EXCHANGE",
                style: TextStyle(fontSize: 15, color: Colors.white))),

        /*const SizedBox(height: 15),
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),*/

        Expanded(
          child: BitcoinGrid(
            curbitcoin: curbitcoin,
          ),
        ),
      ],
    ));
  }

  Future<void> _loadExchange() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));

    progressDialog.show();

    var url = Uri.parse("https://api.coingecko.com/api/v3/exchange_rates");

    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);

      name = parsedJson['rates'][rates]['name'];
      unit = parsedJson['rates'][rates]['unit'];
      value = parsedJson['rates'][rates]['value'];
      type = parsedJson['rates'][rates]['type'];

      curbitcoin = Bitcoin(rates, name, unit, value, type);

      /*setState(() {
        description = "Name = $name Unit = $unit Value = $value Type = $type";
      });*/

      progressDialog.dismiss();
    }
  }
}

class BitcoinGrid extends StatefulWidget {
  final Bitcoin curbitcoin;
  const BitcoinGrid({Key? key, required this.curbitcoin}) : super(key: key);

  @override
  State<BitcoinGrid> createState() => _BitcoinGridState();
}

class _BitcoinGridState extends State<BitcoinGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Location"),
              Icon(
                Icons.location_city,
                size: 64,
              ),
              //Text(widget.curweather.loc)
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Weather"),
              Icon(
                Icons.cloud,
                size: 64,
              ),
              //Text(widget.curweather.weather)
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Temp"),
              Icon(
                Icons.thermostat,
                size: 64,
              ),
              //Text(widget.curweather.temp.toString() + " Celcius")
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Humidity"),
              Icon(
                Icons.hot_tub,
                size: 64,
              ),
              //Text(widget.curweather.hum.toString() + "%")
            ],
          ),
          color: Colors.blue[100],
        ),
      ],
    );
  }
}
