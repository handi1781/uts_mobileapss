import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class stadium extends StatefulWidget {
  const stadium({super.key});

  @override
  State<stadium> createState() => _stadiumState();
}

class _stadiumState extends State<stadium> {
  final apiUrl = 'http://localhost:5000/stadium';

  List<dynamic> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            child: Image.asset(
              './assets/images/title.png',
              width: 50,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 2, 90, 46),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F3FF),
                  ),
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['foto']))),
                        )),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  data[index]['nama'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  data[index]['lokasi'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  data[index]['kapasitas'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
