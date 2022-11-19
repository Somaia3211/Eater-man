import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/pacman.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'barriers.dart';
import 'ghost.dart';
import 'pixel.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future showMessage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Text("       Gave Over!",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            content: Container(

              height: 150,
              child: Column(
                children: [
                  Text("Your Score  : $score",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),

                  SizedBox(height: 30,),
                  Text(" Would You like to play again? ",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white70,fontSize: 20),)
                ],
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                  onPressed: () {

                    Navigator.of(context).pop();
                    setState(() {
                      gameStarted = false;
                      player = 166;
                      ghost = 20;
                      score = 0;

                    });


                  },
                  child: Text("Yes",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),)),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,

                ),
                  onPressed: () {
                  SystemNavigator.pop();
                  },
                  child: Text("No",style: TextStyle(color:Colors.green,fontWeight: FontWeight.bold,fontSize: 20),))
            ],
          );
        });
  }
  static int numberOfSquares = numberInRow * 17;
  static int numberInRow = 11;
  int player = 166;
  int ghost = 20;
  bool mouthClosed = true;
  int score = 0;


  static List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160
  ];

  List<int> food = [];

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  String direction = "";
  bool gameStarted = false;

  void startGame() {
    //print(MediaQuery.of(context).size.width);
    score = 0;
    moveGhost();
    gameStarted = true;
    getFood();
    Duration duration = Duration(milliseconds: 500);
    Timer.periodic(duration, (timer) {
      setState(() {
        mouthClosed = !mouthClosed;
      });
      if (food.contains(player)) {
        food.remove(player);
        score++;
      } else if (player == ghost) {
        showMessage(context);

      }

      switch (direction) {
        case "right":
          moveRight();
          break;

        case "up":
          moveUp();

          break;

        case "left":
          moveLeft();

          break;

        case "down":
          moveDown();

          break;
      }
    });
  }

  String ghostDirection = "left"; // initial
  void moveGhost() {
    Duration ghostSpeed = Duration(milliseconds: 500);
    Timer.periodic(ghostSpeed, (timer) {
      if (!barriers.contains(ghost - 1) && ghostDirection != "right") {
        ghostDirection = "left";
      } else if (!barriers.contains(ghost - numberInRow) &&
          ghostDirection != "down") {
        ghostDirection = "up";
      } else if (!barriers.contains(ghost + numberInRow) &&
          ghostDirection != "up") {
        ghostDirection = "down";
      } else if (!barriers.contains(ghost + 1) && ghostDirection != "left") {
        ghostDirection = "right";
      }

      switch (ghostDirection) {
        case "right":
          setState(() {
            ghost++;
          });
          break;

        case "up":
          setState(() {
            ghost -= numberInRow;
          });
          break;

        case "left":
          setState(() {
            ghost--;
          });
          break;

        case "down":
          setState(() {
            ghost += numberInRow;
          });
          break;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!barriers.contains(player + 1)) {
        player += 1;
      }
    });
  }

  void moveUp() {
    setState(() {
      if (!barriers.contains(player - numberInRow)) {
        player -= numberInRow;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!barriers.contains(player - 1)) {
        player -= 1;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (!barriers.contains(player + numberInRow)) {
        player += numberInRow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    showAlert() {
      Alert(
          context: context,
          content: Icon(
            Icons.check_circle,
            size: 100,
            color: Colors.green,
          ),
          title: "You are fial",
          closeIcon: Icon(Icons.ac_unit_outlined),
          desc: "your score is $score",
          buttons: [
            DialogButton(
                child: Text(
                  'reset',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {}),
          ]).show();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.delta.dy > 0) {
                          direction = "down";
                        } else if (details.delta.dy < 0) {
                          direction = "up";
                        }
                      },
                      onHorizontalDragUpdate: (details) {
                        if (details.delta.dx > 0) {
                          direction = "right";
                        } else if (details.delta.dx < 0) {
                          direction = "left";
                        }
                      },
                      child: Container(
                        child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: numberOfSquares,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: numberInRow),
                            itemBuilder: (BuildContext context, int index) {
                              if (player == index) {
                                if (mouthClosed) {
                                  return Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Container(
                                        decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.yellow,
                                    )),
                                  );
                                } else {
                                  if (direction == "right") {
                                    return PacmanDude();
                                  } else if (direction == "up") {
                                    return Transform.rotate(
                                        angle: 3 * pi / 2, child: PacmanDude());
                                  } else if (direction == "left") {
                                    return Transform.rotate(
                                        angle: pi, child: PacmanDude());
                                  } else if (direction == "down") {
                                    return Transform.rotate(
                                        angle: pi / 2, child: PacmanDude());
                                  }
                                }
                              } else if (ghost == index) {
                                return Ghost();
                              } else if (barriers.contains(index)) {
                                return MyBarrier(
                                  innerColor: Colors.green[800],
                                  outerColor: Colors.green[900],
                                  //child: Center(child: Text(index.toString(), style: TextStyle(fontSize: 10,color: Colors.white),)),
                                );
                              } else if (food.contains(index) || !gameStarted) {
                                return MyPixel(
                                  innerColor: Colors.white,
                                  outerColor: Colors.black,
                                  //child: Center(child: Text(index.toString(), style: TextStyle(fontSize: 10,color: Colors.white),)),
                                );
                              }
                              //else if(player == ghost){
                              //      player=166;
                              //   ghost=20;
                              //    Navigator.push(context,MaterialPageRoute(builder: (context)=>SecondPage()));

                              //     print(score);

                              // }
                              else {
                                return MyPixel(
                                  innerColor: Colors.black,
                                  outerColor: Colors.black,
                                  //child: Center(child: Text(index.toString(), style: TextStyle(fontSize: 10,color: Colors.white),)),
                                );
                              }

                              return MyPixel(
                                innerColor: Colors.black,
                                outerColor: Colors.black,
                                //child: Center(child: Text(index.toString(), style: TextStyle    (fontSize: 10,color: Colors.white),)),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                //color: Colors.green,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Score: ' + score.toString(),
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: startGame,
                        child: Text('P L A Y',
                            style:
                                TextStyle(fontSize: 40, color: Colors.white)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
