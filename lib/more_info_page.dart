import 'dart:convert';

import 'package:citys/data/countries_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class CitiyInfoPage extends StatefulWidget {
  final String? name;

  const CitiyInfoPage({this.name});

  @override
  _CitiyInfoPageState createState() => _CitiyInfoPageState(name);
}

class _CitiyInfoPageState extends State<CitiyInfoPage> {
  String? nameOfCitiy = '';
  _CitiyInfoPageState(this.nameOfCitiy);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      child: Image(
                        image: NetworkImage(
                            "https://source.unsplash.com/random/$index"),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  itemCount: 3,
                ),
                height: 250,
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                    color: Colors.black,
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
                    SizedBox(height: 20.0),
                    FutureBuilder(
                      future: getNameOfCapital(),
                      builder: (context, AsyncSnapshot<List<Countries>> snap) {
                        var data = snap.data;

                        if (snap.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.phone),
                                  Link(
                                    uri: Uri.parse(
                                      data![0].maps!.openStreetMaps.toString(),
                                    ),
                                    builder: (context, fllowLink) {
                                      return InkWell(
                                        onTap: fllowLink,
                                        child: Icon(Icons.location_on),
                                      );
                                    },
                                  ),
                                  Icon(Icons.forward_outlined),
                                  Icon(Icons.date_range_outlined),
                                  SizedBox(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(90, 40),
                                        primary: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        side: BorderSide(
                                            color: Colors.greenAccent)),
                                    onPressed: () {},
                                    child: Text(
                                      "Follow",
                                      style:
                                          TextStyle(color: Colors.greenAccent),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50.0),
                              Text(
                                "Information",
                                style: TextStyle(
                                    fontFamily: "Nanum",
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 30.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        data[0].timezones![0].toString(),
                                        style: TextStyle(
                                            fontFamily: "Nanum",
                                            color: Colors.black,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Time Zone",
                                        style: TextStyle(
                                          fontFamily: "Nanum",
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        data[0].population.toString(),
                                        style: TextStyle(
                                            fontFamily: "Nanum",
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Population",
                                        style: TextStyle(
                                          fontFamily: "Nanum",
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            data[0]
                                                .languages
                                                .toString()
                                                .replaceAll('{', '')
                                                .replaceAll('}', ''),
                                            style: TextStyle(
                                                fontFamily: "Nanum",
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Language",
                                        style: TextStyle(
                                          fontFamily: "Nanum",
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                "Japan has been inhabited since the Upper Paleolithic period (30,000 BC), though the first written mention of the archipelago appears in a Chinese chronicle finished in the 2nd century AD. Between the 4th and 9th centuries, the kingdoms of Japan became unified under an emperor and the imperial court based in Heian-kyō. Beginning in the 12th century, political power was held by a series of military dictators (shōgun) and feudal lords (daimyō), and enforced by a class of warrior nobility (samurai). After a century-long period of civil war, the country was reunified in 1603 under the Tokugawa shogunate, which enacted an isolationist foreign policy.",
                                style: TextStyle(
                                    color: Colors.grey, fontFamily: "Nanum"),
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                children: [
                                  Text("Show scorecard"),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  )
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: Size(155, 50),
                                        primary: Colors.transparent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        side: BorderSide(
                                            color: Colors.greenAccent)),
                                    onPressed: () {},
                                    child: Text(
                                      "Priview",
                                      style:
                                          TextStyle(color: Colors.greenAccent),
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(155, 50),
                                      primary: Colors.greenAccent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
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
