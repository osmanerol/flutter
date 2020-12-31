import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main(){
  runApp(Game());
}

class Game extends StatefulWidget{
  const Game({ Key key }) : super(key: key);
  @override 
  _GameState createState()=> _GameState();
}

class _GameState extends State<Game>{
  String score="00:00:00";
  var boxes=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
  var number=1;
  var next=2;
  Random random=new Random();
  bool isStop=false;
  // for chronomoeter
  var swatch=Stopwatch();
  final duration=const Duration(milliseconds: 30);

  _GameState(){
    //  mix boxes array
    boxes.shuffle();
    _startChronometer();
  }

  void restartGame(){
    boxes.shuffle();
    setState(() {
      score="00:00:00";
      number=1;
      next=2;
      isStop=false;
    });
    swatch.reset();
    _startChronometer();
  }

  void _increment(){
    setState(() {
      number+=1;
    });
  }

  void _startTimer(){
    Timer(duration, _keepChronometer);
  }

  void _keepChronometer(){
    if(!isStop){
    _startTimer();
    }
    setState((){
      score= (swatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" + (swatch.elapsed.inSeconds%60).toString().padLeft(2, "0") + ":" + (swatch.elapsed.inMilliseconds%100).toString().padLeft(2, "0");
    });
  }

  void _startChronometer(){
    swatch.start();
    _startTimer();
  }

  void _stopChronometer(){
    swatch.stop();
    setState(() {
      isStop=true;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Schulte Game")
      ),
      body: Container(
        margin: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Next# : $next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )
                ),
                Text(
                  'Mode : React',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )
                ),
                Text(
                  'Time : $score',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  )
                ),
              ],
            ),
            Flexible(
              child: GridView.count(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                crossAxisCount: 5,
                children: List.generate(25, (index) {
                  return Container(
                    child: GestureDetector(
                      onTap: (){
                        if(boxes[index]==number){
                          setState(() {
                            next+=1;
                          });
                          _increment();
                        }
                        if(number==26){
                          _stopChronometer();
                          showDialog(
                            context: context,
                            builder: (_)=> CupertinoAlertDialog(
                              title: Text('Game Over'),
                              content: Text('Your score is: $score'),
                              actions: [
                                CupertinoDialogAction( 
                                  child: Text('Homepage'),
                                  onPressed: (){
                                    Navigator.popUntil(context,  ModalRoute.withName('/'));
                                  },
                                ),
                                CupertinoDialogAction( 
                                  child: Text('Yes'),
                                  onPressed: (){
                                    restartGame();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: boxes[index]==number ? Colors.red : ( boxes[index]<number ? Colors.white : Colors.grey )
                        ),
                        child: Center(
                          child: Visibility(
                            child: Text(
                              '${boxes[index]}',
                              style: TextStyle(
                                color: Colors.white 
                              )
                            ),
                            visible: boxes[index]==number,
                          )
                        )
                      )
                    )
                  );
                }),
              ) ,
            )
          ],
        )
      )
    );
  }
}

/*

var datas= Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Text(
      'Mode: React',
      style: TextStyle(
        fontWeight: FontWeight.bold
    ),
    Text(
        'Time: 10',
        style: TextStyle(
          fontWeight: FontWeight.bold
      ),
    )
  ],
)

var boxes=GridView.count(
  crossAxisCount: 5,
  children: List.generate(25, (index) {
    return Container(
      child: GestureDetector(
        onTap: (){
          print('asd');
        },
        child: Center(
          child: Text(
            '$index',
          ),
        ),
      )
    );
  }),
);


GridView.count(
        crossAxisCount: 5,
        children: List.generate(100, (index) {
          return Container(
            child: Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        }),
      )

*/