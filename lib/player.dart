import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class player extends StatefulWidget {
  const player({super.key});

  @override
  State<player> createState() => _playerState();
}

class _playerState extends State<player> {
  var datajson;
  int totalData = 0;
  void _getapi() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var response = await http
        .get(Uri.parse('http://localhost:1337/api/players'), headers: headers);

    datajson = jsonDecode(response.body);
    print(datajson["data"][1]["attributes"][1]);
    setState(() {
      totalData = datajson["meta"]["pagination"]["total"];
    });
  }
  // final List<String> nama = [
  //   "Ilham",
  //   "Handi",
  //   "Angger",
  //   "Asif",
  //   "Ilhan",
  //   "Arip",
  //   "Jabran"
  // ];

  // final List<String> posisi = [
  //   "Posisi : Kiper",
  //   "Posisi : CB",
  //   "Posisi : LB",
  //   "Posisi : RB",
  //   "Posisi : CM",
  //   "Posisi : LW",
  //   "Posisi : ST"
  // ];
  // final List<String> umur = ["20", "30", "18", "19", "16", "17", "19"];
  final List<String> foto = [
    "assets/images/bg.png",
    "assets/images/bg.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
                child: Image.asset(
              "assets/images/players-b.jpg",
              width: 150,
            )),
          ),
          backgroundColor: Color.fromARGB(255, 4, 110, 8),
        ),
        body: ListView.builder(
          itemCount: totalData,
          itemBuilder: (data, index) {
            return GestureDetector(
              onTap: () {
                //print(nama[index]);
              },
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      // child: Image.asset(foto[index]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            datajson["data"][index]["attributes"]["nama"],
                            // nama[index],
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              datajson["data"][index]["attributes"]["posisi"],
                              //posisi[index],
                              maxLines: 3,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 5, 83, 2)),
                            ),
                          ),
                          Container(
                              width: 100,
                              child: Text(
                                "20",
                                //umur[index],
                                style: TextStyle(
                                    fontSize: 15, color: Colors.green),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: _getapi));
  }
}
