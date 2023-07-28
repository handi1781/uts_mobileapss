import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class tiket extends StatefulWidget {
  const tiket({super.key});

  @override
  State<tiket> createState() => _tiketState();
}

class _tiketState extends State<tiket> {
  final apiUrl = 'http://localhost:5000/tiket';
  final apiUrl2 = 'http://localhost:5000/pesan';

  List<dynamic> data = [];
  bool isLoading = true;

  final idController = TextEditingController();
  final pertandinganController = TextEditingController();
  final jadwalController = TextEditingController();
  final hargaController = TextEditingController();
  final lokasiController = TextEditingController();

  final jumlahpesanController = TextEditingController();
  final keteranganController = TextEditingController();

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
        'pertandingan': pertandinganController.text,
        'jadwal': jadwalController.text,
        'harga': int.parse(hargaController.text),
        'lokasi': lokasiController.text,
      }),
    );

    if (response.statusCode == 201) {
      fetchData();
      idController.clear();
      pertandinganController.clear();
      jadwalController.clear();
      hargaController.clear();
      lokasiController.clear();
    } else {
      throw Exception('Failed to add data');
    }
  }

  Future<void> deleteData(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception('Failed to delete data');
    }
  }

  Future<void> order() async {
    final response = await http.post(
      Uri.parse(apiUrl2),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'jumlahpesan': int.parse(jumlahpesanController.text),
        'keterangan': keteranganController.text,
      }),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pembelian Suksess'),
          content: Text('Terima Kasih'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Persebaya Tiket"),
        backgroundColor: Color.fromARGB(255, 4, 121, 8),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("./assets/images/title.png"),
                    opacity: 0.2,
                    fit: BoxFit.contain),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 14, 7),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    {}
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(
                              "./assets/images/logobri.png",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            data[index]['pertandingan'],
                            style: TextStyle(fontSize: 15),
                          ),
                          Text('\Rp${data[index]['harga']}'),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteData(data[index]['id']);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.money_rounded),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('\Rp${data[index]['harga']}'),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "./assets/images/logibri.png",
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(height: 10),
                                        Text(data[index]['pertandingan']),
                                        Text(data[index]['jadwal']),
                                        TextField(
                                          controller: jumlahpesanController,
                                          decoration: InputDecoration(
                                            labelText: 'Jumlah Order',
                                          ),
                                        ),
                                        TextField(
                                          controller: keteranganController,
                                          decoration: InputDecoration(
                                            labelText: 'Keterangan',
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            order();
                                            showSuccessDialog(context);
                                          },
                                          child: Text("Beli"),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
                      controller: pertandinganController,
                      decoration: InputDecoration(
                        labelText: 'Pertandingan',
                      ),
                    ),
                    TextField(
                      controller: jadwalController,
                      decoration: InputDecoration(
                        labelText: 'Jadwal',
                      ),
                    ),
                    TextField(
                      controller: hargaController,
                      decoration: InputDecoration(
                        labelText: 'Harga',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: lokasiController,
                      decoration: InputDecoration(
                        labelText: 'LOkasi',
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
