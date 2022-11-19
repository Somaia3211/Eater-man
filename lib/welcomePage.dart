import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pacman/homepage.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({Key? key}) : super(key: key);

  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'WELCOME\n         To\n EaterMan',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(100),
                    )),
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,

                ),
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: Text(
                    'P L A Y',
                    style: TextStyle(color: Colors.white,fontSize: 40),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
