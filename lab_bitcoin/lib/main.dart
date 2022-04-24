import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_bitcoin/bitcoin.dart';
import 'package:ndialog/ndialog.dart';


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
            title: const Text('BITCOIN CRYPTOCURRENCY CONVERTER'),
          ),
          body: SingleChildScrollView(
              child: Column(children: [
            Container(
                child: Center(
                    child: Image.asset("assets/images/logo_bitcoin.jpg",
                        scale: 1.0))),
            Container(height: 700, child: const MyHomePage()),
          ]))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selecRates = "btc";
  List<String> ratesList = [
    "btc","eth","ltc","bch","bnb","eos","xrp","xlm","link",
    "dot","yfi","usd","aed","ars","aud","bdt","bhd","bmd",
    "brl","cad","chf","clp","cny","czk","dkk","eur","gbp",
    "hkd","huf","idr","ils","inr","jpy","krw","kwd","lkr",
    "mmk","mxn","myr","ngn","nok","nzd","php","pkr","pln",
    "rub","sar","sek","sgd","thb","try","twd","uah","vef",
    "vnd","zar","xdr","xag","xau","bits","sats"];

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
          const SizedBox(height: 10.0),
          const Text(
            "Bitcoin Cryptocurrency",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            itemHeight: 50,
            value: selecRates,
            onChanged: (newValue) {
              setState(() {
                selecRates = newValue.toString();
              });
            },
            items: ratesList.map((selecRates) {
              return DropdownMenuItem(
                child: Text(
                  selecRates,
                ),
                value: selecRates,
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: _exchange,
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 190, 136, 199)),
              child: const Text("EXCHANGE",
                  style: TextStyle(fontSize: 15, color: Colors.white))),
          const SizedBox(height: 10.0),
          Text(
            'BitCoin cryptocurrency value already exchange to ' +
                selecRates +
                ".",
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: BitcoinGrid(curbitcoin: curbitcoin),
          ),
        ],
      ),
    );
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

      name = parsedJson['rates'][selecRates]['name'];
      unit = parsedJson['rates'][selecRates]['unit'];
      value = parsedJson['rates'][selecRates]['value'];
      type = parsedJson['rates'][selecRates]['type'];

      curbitcoin = Bitcoin(selecRates, name, unit, value, type);

      setState(() {
        description =
            "Select Rates = $selecRates name = $name Unit = $unit Value = $value Type = $type";
      });
    } else {
      print("Failed");
    }
    progressDialog.dismiss();
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
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          GestureDetector(
            onTap: _pressMe,
            child: InkWell(
              child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("RATES"),
                      const Icon(
                        Icons.motion_photos_auto_outlined,
                        size: 70,
                      ),
                      Text(widget.curbitcoin.rates)
                    ],
                  ),
                  color: const Color.fromARGB(255, 242, 124, 116)),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("NAME"),
                  const Icon(
                    Icons.paid_outlined,
                    size: 70,
                  ),
                  Text(widget.curbitcoin.name)
                ],
              ),
              color: const Color.fromARGB(255, 246, 190, 107)),
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("UNIT"),
                  const Icon(
                    Icons.attach_money,
                    size: 70,
                  ),
                  Text(widget.curbitcoin.unit)
                ],
              ),
              color: const Color.fromARGB(255, 231, 218, 98)),
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("VALUE"),
                  const Icon(
                    Icons.moving,
                    size: 70,
                  ),
                  Text(widget.curbitcoin.value.toString())
                ],
              ),
              color: const Color.fromARGB(255, 152, 210, 86)),
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("TYPE"),
                  const Icon(
                    Icons.pageview_outlined,
                    size: 70,
                  ),
                  Text(widget.curbitcoin.type)
                ],
              ),
              color: const Color.fromARGB(255, 145, 198, 241)),
        ]);
  }

  void _pressMe() {
    print("Hello");
  }
}
