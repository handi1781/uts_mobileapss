import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Container(
//               child: Image.asset(
//             "assets/images/players-b.jpg",
//             width: 150,
//           )),
//         ),
//         backgroundColor: Color.fromARGB(255, 4, 110, 8),
//       ),
//       body: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               //print(nama[index]);
//             },
//             child: Card(
//               child: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 100,
//                     height: 100,
//                     //child: datajson["data"][index]["attributes"][foto]
//                     child: Image.asset(foto[index]),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           data[index]['nama'],
//                           // nama[index],
//                           style: const TextStyle(
//                             fontSize: 25,
//                             color: Colors.black87,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: 100,
//                           child: Text(
//                             data[index]['posisi'],
//                             //posisi[index],
//                             maxLines: 3,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 color: Color.fromARGB(255, 5, 83, 2)),
//                           ),
//                         ),
//                         // Container(
//                         //   width: 100,
//                         //   // child: datajson["data"][index]["attributes"]
//                         //   //   ["umur"],
//                         //   //umur[index],
//                         // )
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );

//   // var datajson;
//   // int totalData = 0;
//   // Future _getapi() async {
//   //   Map<String, String> headers = {
//   //     'Content-Type': 'application/json',
//   //     'Accept': 'application/json'
//   //   };

//   //   var response = await http
//   //       .get(Uri.parse('http://localhost:1337/api/players'), headers: headers);

//   //   datajson = jsonDecode(response.body);
//   //   print(datajson["data"][0]["attributes"][0]);
//   //   setState(() {
//   //     totalData = datajson["meta"]["pagination"]["total"];
//   //   });
//   // }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final apiUrl = 'http://localhost:5000/player';

  List<dynamic> data = [];
  bool isLoading = true;

  final idController = TextEditingController();
  final namaController = TextEditingController();
  final posisiController = TextEditingController();
  final fotoController = TextEditingController();
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

  Future<void> addData() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': namaController.text,
        'posisi': posisiController.text,
        'foto': fotoController.text,
      }),
    );

    if (response.statusCode == 201) {
      fetchData();
      namaController.clear();
      posisiController.clear();
      fotoController.clear();
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<void> updateData(String id) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': namaController.text,
        'posisi': posisiController.text,
        'foto': fotoController.text,
      }),
    );

    if (response.statusCode == 200) {
      fetchData();
      idController.clear();
      namaController.clear();
      posisiController.clear();
      fotoController.clear();
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<void> deleteData(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception('Failed to delete data');
    }
  }

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
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   backgroundColor: Color.fromARGB(255, 2, 80, 21),
      // ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("./assets/images/title.png"),
                      opacity: 0.2,
                      fit: BoxFit.contain),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 14, 7),
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Update Data'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: namaController,
                                      decoration: InputDecoration(
                                        labelText: 'Nama',
                                      ),
                                    ),
                                    TextField(
                                      controller: posisiController,
                                      decoration: InputDecoration(
                                        labelText: 'Posisi',
                                      ),
                                    ),
                                    TextField(
                                      controller: fotoController,
                                      decoration: InputDecoration(
                                        labelText: 'Link Foto',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Icon(Icons.cancel),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Icon(Icons.change_circle),
                                    onPressed: () {
                                      updateData(data[index]['id'].toString());
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MyHomePage(title: "Persebaya Players"),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                data[index]['foto'],
                                width: 59,
                                height: 59,
                              ),
                              Text(
                                data[index]['nama'],
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Text(data[index]['posisi']),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  updateData(data[index]['id'].toString());
                                  Navigator.of(context).pop();
                                  // Tambahkan fungsi untuk menghapus data dari GridView
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
      // ListView.builder(
      //     itemCount: data.length,
      //     itemBuilder: (context, index) {
      //       return ListTile(
      //         title: Text(data[index]['nama']),
      //         subtitle: Text(data[index]['posisi']),
      //         trailing: Row(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             IconButton(
      //               icon: Icon(Icons.edit),
      //               onPressed: () {
      //                 showDialog(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return AlertDialog(
      //                       title: Text('Update Data'),
      //                       content: Column(
      //                         mainAxisSize: MainAxisSize.min,
      //                         children: [
      //                           TextField(
      //                             controller: namaController,
      //                             decoration: InputDecoration(
      //                               labelText: 'Nama',
      //                             ),
      //                           ),
      //                           TextField(
      //                             controller: posisiController,
      //                             decoration: InputDecoration(
      //                               labelText: 'Posisi',
      //                             ),
      //                           ),
      //                           TextField(
      //                             controller: fotoController,
      //                             decoration: InputDecoration(
      //                               labelText: 'Link Foto',
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       actions: [
      //                         TextButton(
      //                           child: Text('Cancel'),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                         TextButton(
      //                           child: Text('Update'),
      //                           onPressed: () {
      //                             updateData(data[index]['id'].toString());
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                       ],
      //                     );
      //                   },
      //                 );
      //               },
      //             ),
      //             IconButton(
      //               icon: Icon(Icons.delete),
      //               onPressed: () {
      //                 showDialog(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return AlertDialog(
      //                       title: Text('Delete Data'),
      //                       content: Text(
      //                           'Are you sure you want to delete this data?'),
      //                       actions: [
      //                         TextButton(
      //                           child: Text('Cancel'),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                         TextButton(
      //                           child: Text('Delete'),
      //                           onPressed: () {
      //                             deleteData(data[index]['id'].toString());
      //                             Navigator.of(context).pop();
      //                           },
      //                         ),
      //                       ],
      //                     );
      //                   },
      //                 );
      //               },
      //             ),
      //             Image.network(
      //               data[index]['foto'],
      //               width: 50,
      //               height: 50,
      //             )
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Color.fromARGB(255, 6, 116, 10),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Data'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: 'Nama',
                      ),
                    ),
                    TextField(
                      controller: posisiController,
                      decoration: InputDecoration(
                        labelText: 'Posisi',
                      ),
                    ),
                    TextField(
                      controller: fotoController,
                      decoration: InputDecoration(
                        labelText: 'Link Foto',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addData();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
