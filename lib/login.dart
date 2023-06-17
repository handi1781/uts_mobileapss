import 'package:flutter/material.dart';
import 'package:udemy_couse2/page.dart';

class content extends StatefulWidget {
  const content({super.key});

  @override
  State<content> createState() {
    return _contentState();
  }
}

class _contentState extends State<content> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 240, 243, 240),
            Color.fromARGB(218, 17, 235, 126)
          ])),
          height: 200,
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/wani-1.png"))),
              ))
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Hello There",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 85, 7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(0, 2, 104, 24),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 4, 92, 19),
                        ),
                      )),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Username/ID",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 3, 97, 18)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 6, 100, 3),
                          ),
                        ),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 2, 88, 2)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const page(),
                        ));
                      },
                      child: const Text(
                        "Log In",
                        style:
                            TextStyle(color: Color.fromARGB(255, 13, 129, 3)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
