import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'dart:async';


class GamePlay extends StatefulWidget {
  @override
  _GamePlay createState() => _GamePlay();
  static String tag = 'homepage';
}


var _operation;
var _dataPassed;
var _userAnswer;
var _sign;
var _score;
bool _win;
int _rand1,_rand2,_randOperator,_ans1,_ans2,_ans3,_total;

class _GamePlay extends State<GamePlay>
    with SingleTickerProviderStateMixin {
 GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

Timer _timer;
var _start = 20;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (_start < 1) {
          timer.cancel();
            showScore();
            setState(() { 
              _dataPassed = null; 
               setRandomNumbers();
            });
           
        } else {
          _start = _start - 1;
        }
      },
    ),
  );
}

@override
void dispose() {
  _timer.cancel();
  super.dispose();
}

 @override
  void initState() {
    super.initState();
     //_audio.loadAll(kSoundFiles);
      setRandomNumbers();
      //_entranceDialog();
      startTimer();
      setState(() { 
        _dataPassed = null;
        _operation = null;
        _sign = null;
        _score= 0;
        _start= 30;
       });
      
     
  }

//CUSTOM WIDGET FOR NUMBERS

  Widget _buildContainer(int value) {
   
    return Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.green,
              );
  }



  Widget _buildOperator(int info,String label) {
    return Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    label.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.orange,
              );
  }


//CUSTOM WIDGET FOR DRAGGABLE NUMBERS

  Widget _buildDraggable(int value) {
   
    return Padding(
    padding: EdgeInsets.all(5.0),
    child: Draggable(
              data: value,
              child: Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.blue,
              ),
              feedback: Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.red,
              ),
            childWhenDragging:Container(),
           ));
  }


  @override
  Widget build(BuildContext context) {

  Size size = MediaQuery.of(context).size;

return WillPopScope(
      onWillPop: () async {
    MoveToBackground.moveTaskToBack();
         return false;
      },
    child:Scaffold(
       key: scaffoldKey,
        appBar: new AppBar(
          automaticallyImplyLeading: true,
        title: Text('Back'),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.of(context).pop(),
        )
         
          ),

      backgroundColor: Colors.white,
      body: 

     Stack(
        children: <Widget>[
           Center(
            child: new Image.asset(
              'assets/images/menu_bg.jpg',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
          ),

      Center( 
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          children: <Widget>[
            Text("Timer: "+"$_start"+" secs                  Score:"+"$_score", style: TextStyle(color: Colors.white, fontSize: 20.0)),
            //Text("$_start"),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContainer(_rand1),
                _buildContainer(_randOperator),
                _buildContainer(_rand2),
              ],
            ),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               _buildDraggable(_ans1),
               _buildDraggable(_ans2),
               _buildDraggable(_ans3),
              ],
            ),

           SizedBox(height: 5.0),

             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      print(candidateData);
                       var answerlabel;
                          if(_userAnswer==null)
                          {
                           answerlabel="Answer";
                          }
                          else{
                           answerlabel=_userAnswer.toString();
                          }
                      return Center(child: Text(answerlabel, style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (_dataPassed) {
                      return true;
                    },
                    onAccept: (_dataPassed) {
                       setState(() { _userAnswer=_dataPassed; });
                      if(_total==_dataPassed)
                      {
                          scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct !!!")));
                         setState(() {
                            _dataPassed = null; 
                             setRandomNumbers();
                            _start=_start+5;
                            _score=_score+1;
                        });
                      }
                      else{
                         scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Thats wrong !!!")));
                      }
                      
                    },
                  ),
                ),

              ],
            )
          
          ],
        ),
      ),
      ]
     ),
    ));
  }



void setRandomNumbers()
{

int temp;

 temp=getNumber();

  setState((){ 
    _rand1=getNumber(); 
    _rand2=getNumber(); 
    _randOperator=getNumber(); 

    if(_randOperator==10)
    {
     _total=_rand1+_rand2;
     _sign="+";
    }
    if(_randOperator==11)
    {
     _total=_rand1-_rand2;
     _sign="-";
    }
    if(_randOperator==12)
    {
     _total=_rand1*_rand2;
     _sign="x";
    }
    
   
  
   /* if(temp==1)
    {
     
    }
    if(temp==2)
    {
     
    }
    if(temp==3)
    {
     _ans1=getNumber(); 
    }
     
     _ans2=getNumber(); 
     _ans3=getNumber();  */
  });

}


void results(bool win,int answer)
{

  if(win)
  {

   scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Correct !!!")));
   setState(() {
      _dataPassed = null; 
       setRandomNumbers();
      _start=_start+5;
      _score=_score+1;
   });
 
  }
  else
  {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Thats wrong !!!"))); 
  }
  
}

Future showScore()async
{
  String message;

   final prefs = await SharedPreferences.getInstance();
   int highScore=prefs.getInt("highscore");
   
if(highScore!=null)
{
  if(highScore > _score)
  {
    message="Your score is "+"$_score";
  }
  else{
    message="Congrats !!!. New high score.Your score is "+"$_score";
    prefs.setInt("highscore",_score);
    prefs.setInt("date",_score);
  }
}
else{
    message="Congrats !!!. New high score.Your score is "+"$_score";
    prefs.setInt("highscore",_score);
    prefs.setInt("date",_score);
}
  

  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Game over"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("try again"),
              onPressed: () {
                setState(() { _start= 30; });
                startTimer();
              Navigator.of(context).pop();

              },
            ),
            new FlatButton(
              child: new Text("Back"),
              onPressed: () {
              Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    setState(() { _score=0; });
}


}


int getNumber()
{
  Random random = new Random();
  int randomNumber = random.nextInt(15) + 0;
  return randomNumber;
}


void main() {
   runApp(new GamePlay());
 
}