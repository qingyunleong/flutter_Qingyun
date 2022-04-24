import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:ndialog/ndialog.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyWeatherPage(),
    );
  }
}

class MyWeatherPage extends StatefulWidget {
  const MyWeatherPage({Key? key}) : super(key: key);

  @override
  State<MyWeatherPage> createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  String selectLoc = "Changlun";
  String description = "No weather information";
  String weather = "";

  var temperature, humidity, feelslike;
  
  //double temperature = 0.0;
  //int  humidity = 0;
  //double feelslike = 0.00;

  List<String> locList = ["Changlun", "Jitra", "Alor Setar", "Baling"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather APP")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Simple Weather APP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            DropdownButton(
              itemHeight: 60,
              value: selectLoc,
              onChanged: (newValue) {
                setState(() {
                  selectLoc = newValue.toString();
                });
              },
              items: locList.map((selectLoc) {
                return DropdownMenuItem(
                  child: Text(
                    selectLoc,
                  ),
                  value: selectLoc,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadWeather, child: const Text("Load Weather")),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ],
        )));
  }

  Future<void> _loadWeather() async {
    var apiid = "15de80e1abffb64ec7d59b4432709513";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectLoc&appid=$apiid&units=metric');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);

      temperature = parsedData['main']['temp'];
      humidity = parsedData['main']['humidity'];
      weather = parsedData['weather'][0]['main'];
      feelslike = parsedData['main']['feels_like'];

      setState(() {
        description =
            "The current weather in $selectLoc is $weather. It feels like $feelslike. The current temperature is $temperature Celcius and humidity is $humidity percent. ";
      });

      //progressDialog.dismiss();
    }
  }
}
