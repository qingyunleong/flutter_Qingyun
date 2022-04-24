import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BITCOIN CRYPTOCURRENCY',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BITCOIN CRYPTOCURRENCY'),
          ),
          body: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String rates = "btc";
  List<String> ratesList = [
    "btc","eth","ltc","bch","bnb","eos","xrp","xlm","link",
    "dot","yfi","usd","aed","ars","aud","bdt","bhd","bmd",
    "brl","cad","chf","clp","cny","czk","dkk","eur","gbp",
    "hkd","huf","idr","ils","inr","jpy","krw","kwd","lkr",
    "mmk","mxn","myr","ngn","nok","nzd","php","pkr","pln",
    "rub","sar","sek","sgd","thb","try","twd","uah","vef",
    "vnd","zar","xdr","xag","xau","bits","sats"];

  String description = "No record";
  String name = "No Record";
  String unit = "No Record";
  String type = "No Record";
  var value = 0.000;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Bitcoin Cryptocurrency App",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        DropdownButton(
          itemHeight: 50,
          value: rates,
          onChanged: (newValue) {
            setState(() {
              rates = newValue.toString();
            });
          },
          items: ratesList.map((rates) {
            return DropdownMenuItem(
              child: Text(
                rates,
              ),
              value: rates,
            );
          }).toList(),
        ),
        ElevatedButton(onPressed: _exchange, child: const Text("Exchange")),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ));
  }

  Future<void> _exchange() async {
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

      setState(() {
        description = "Name = $name Unit = $unit Value = $value Type = $type";
      });
      progressDialog.dismiss();
    }
  }

  
}
