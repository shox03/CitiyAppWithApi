import 'dart:convert';

import 'package:citys/capitals_img.dart';
import 'package:citys/countries_class.dart';
import 'package:citys/more_info_page.dart';
import 'package:citys/pagoda_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  final String? name;

  const WeatherPage({this.name});

  @override
  _WeatherPageState createState() => _WeatherPageState(name);
}

class _WeatherPageState extends State<WeatherPage> {
  String? nameOfCitiy = '';
  _WeatherPageState(this.nameOfCitiy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://d31atr86jnqrq2.cloudfront.net/images/adelaide-parklands-walking.jpg?mtime=20200831125552&focal=69.1%25+65.74%25"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
                Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      size: 45,
                      color: Colors.yellow,
                    ),
                    FutureBuilder(
                      future: _getPostFromAPi(nameOfCitiy.toString()),
                      builder: (context, AsyncSnapshot<Pagoda> snap) {
                        var data = snap.data;
                        debugPrint("$data  eeeeeeeeeeeeeeeeeeeeee");
                        if (snap.hasData) {
                          var weather;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    data!.weather![0].main.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                        fontFamily: "Nanum"),
                                  ),
                                  // Text(
                                  //   "○",
                                  //   // textAlign: TextAlign.end,
                                  //   style: TextStyle(
                                  //       fontSize: 10, color: Colors.white),
                                  // ),
                                  // Text(
                                  //   "C",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.white),
                                  // )
                                ],
                              ),
                              Text(
                                "${data.wind!.speed.toString()} m/s NNE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
                FutureBuilder(
                  future: getNameOfCapital(),
                  builder: (context, AsyncSnapshot<List<Countries>> snap) {
                    var data = snap.data;
                    if (snap.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data![0].capital.toString().replaceAll('[', '').replaceAll(']', '')}, ${data[0].flag.toString()}",
                            style: TextStyle(
                                fontFamily: "Nanum",
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Region: ${data[0].continents.toString().replaceAll('[', '').replaceAll(']', '')} ,  ${data[0].name!.official.toString().replaceAll('[', '').replaceAll(']', '')}",
                            style: TextStyle(
                                fontFamily: "Nanum",
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(155, 50),
                          primary: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: BorderSide(color: Colors.white70)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CitiyInfoPage(
                              name: nameOfCitiy,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Priview",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(155, 50),
                        primary: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        // side: BorderSide(color: Colors.white70),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Start Round",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Pagoda> _getPostFromAPi(String data) async {
    var _res = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$data&appid=8b6e346c880a98e44a35e675ff4c74ad"));
    if (_res.statusCode == 200) {
      return Pagoda.fromJson(jsonDecode(_res.body));
    } else {
      throw Exception("Error");
    }
  }


  Future<List<Countries>> getNameOfCapital() async {
    Uri url =
        Uri.parse("https://restcountries.com/v3.1/capital/${nameOfCitiy}");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Countries.fromJson(e))
          .toList();
    } else {
      throw Exception("Xato Bor ${res.statusCode}");
    }
  }
}
