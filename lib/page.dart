import 'package:flutter/material.dart';
import 'package:udemy_couse2/login.dart';
import 'package:udemy_couse2/player.dart';
import 'package:udemy_couse2/stadium.dart';
import 'package:udemy_couse2/start_screen.dart';
import 'package:udemy_couse2/store.dart';
import 'package:udemy_couse2/tiket.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class page extends StatefulWidget {
  const page({super.key});

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  SampleItem? selectedMenu;

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
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 2, 90, 28)),
              accountName: Text(
                "Handi Achmad",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "handiachmad@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: Image.asset(
                './assets/images/bonek11.png',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => content()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 246, 248, 246),
              Color.fromARGB(218, 241, 241, 241)
            ],
          ),
          image: DecorationImage(
              image: AssetImage("./assets/images/bonek11.png"), opacity: 0.2),
        ),
        child: Column(
          children: <Widget>[
            _buildBackground(), // Bagian dekorasi (background gradient)
            SizedBox(height: 10),
            Expanded(
              child: _buildGridView(context), // Bagian GridView
            ),
          ],
        ), /* add child content here */
      ),
    );
  }

  Widget _buildBackground() {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 14, 7),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 235, 114),
                  Color.fromARGB(218, 17, 235, 126)
                ],
              ),
            ),
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"))),
            )));
  }

  Widget _buildGridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 14, 7),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(
                    title: "Persebaya Players",
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    "Player",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => stadium(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stadium_rounded,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    "Stadium",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Store(
                    title: "Persebaya Store",
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    "Store",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tiket()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.airplane_ticket,
                    size: 50,
                    color: Colors.black,
                  ),
                  Text(
                    "Tiket",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
