import 'dart:convert';

import 'package:citys/countries_class.dart';
import 'package:citys/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Citiy_Ui extends StatefulWidget {
  const Citiy_Ui({Key? key}) : super(key: key);

  @override
  _Citiy_UiState createState() => _Citiy_UiState();
}

class _Citiy_UiState extends State<Citiy_Ui> {
  TextEditingController _controller = TextEditingController();
  String nameOfCapital = 'Beijing';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25.0),
                Text(
                  "Countries",
                  style: TextStyle(
                    fontFamily: "Nanum",
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Find a place to play golf",
                  style: TextStyle(
                      fontFamily: "Nanum", fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 15.0),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type to search...",
                    hintStyle: TextStyle(color: Colors.grey),
                    // fillColor: Colors.black.withOpacity(0.1),
                    // filled: true,
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          nameOfCapital = _controller.text;
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 18.0,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Top Countries",
                          style: TextStyle(
                            fontFamily: "Nanum",
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Near from Tashkent Countries, PA 1501",
                          style: TextStyle(
                            fontFamily: "Nanum",
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                        fontFamily: "Nanum",
                        fontSize: 17.5,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                FutureBuilder(
                  future: countriesApi(),
                  builder: (context, AsyncSnapshot<List<Countries>> snap) {
                    var data = snap.data;
                    if (snap.hasData) {
                      return Container(
                        height: 212,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        data![index + 22].flags!.png.toString(),
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(15)),
                              margin: EdgeInsets.all(5),
                              height: 210,
                              width: 155,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${data[index + 22].capital.toString().replaceAll('[', '').replaceAll(']', '')}, ${data[index + 22].flag!.toString()}",
                                            style: TextStyle(
                                              fontFamily: "Nanum",
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "⭐️ ${data[index + 22].name!.official.toString()}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                SizedBox(height: 18.0),
                Row(
                  children: [
                    Text(
                      "Top Rated",
                      style: TextStyle(
                        fontFamily: "Nanum",
                        fontSize: 17.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                        fontFamily: "Nanum",
                        fontSize: 17.5,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeatherPage(
                                  name: nameOfCapital,
                                )));
                  },
                  child: FutureBuilder(
                    future: getNameOfCapital(),
                    builder: (context, AsyncSnapshot<List<Countries>> snap) {
                      var data = snap.data;
                      if (snap.hasData) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      data![0].flags!.png.toString(),
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.all(5),
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(
                                    "${data[0].capital.toString().replaceAll('[', '').replaceAll(']', '')}, ${data[0].flag.toString()}",
                                    style: TextStyle(
                                      fontFamily: "Nanum",
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        " ${data[0].continents.toString().replaceAll('[', '').replaceAll(']', '')} ,  ${data[0].name!.official.toString().replaceAll('[', '').replaceAll(']', '')}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Icon(
                                        Icons.info,
                                        size: 35,
                                        color: Colors.greenAccent,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.golf_course_sharp),
            title: Text(""),
          )
        ],
      ),
    );
  }

  Future<List<Countries>> countriesApi() async {
    Uri url = Uri.parse("https://restcountries.com/v3.1/all");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => Countries.fromJson(e))
          .toList();
    } else {
      throw Exception("Xato Bor ${res.statusCode}");
    }
  }

  Future<List<Countries>> getNameOfCapital() async {
    Uri url =
        Uri.parse("https://restcountries.com/v3.1/capital/${nameOfCapital}");
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
