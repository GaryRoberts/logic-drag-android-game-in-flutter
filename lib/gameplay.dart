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
var _number1;
var _number2;
var _sign;
var _score;
bool _win;
int _rand1,_rand2,_rand3,_rand4,_rand5,_rand6,_rand7,_rand8,_rand9;

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
              _operation = null;
              _number1 = null; 
              _number2 = null; 
              _sign = null;
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
                color: Colors.green,
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



Widget _draggingMode(int number)
{
  //setState(() { _dataPassed = number; });

}

  Widget _buildOperator(int info,String label) {
    return Padding(
    padding: EdgeInsets.all(5.0),
    child: Draggable(
              data: info,
              child: Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    label.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.orange,
              ),
              feedback: Container(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Text(
                    label.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                ),
                color: Colors.red,
              ),
            //childWhenDragging:_draggingModeOperator(info),
           ));
  }

Widget _draggingModeOperator(int getData)
{
 //setState(() { _operation = getData; });
}


Widget _entranceDialog() {
    return new AlertDialog(
      title: new Text(
        "Logout",
        style: new TextStyle(color: Colors.blue[400], fontSize: 20.0),
      ),
      content: new Text(
        "Are you ready to race against time to make expressions?",
        style: new TextStyle(color: Colors.grey, fontSize: 20.0),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Start",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
             //startTimer();
             Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text("Cancel",
              style: new TextStyle(color: Colors.blue[400], fontSize: 20.0)),
          onPressed: () {
              Navigator.of(context).pop();
          },
        ), 
      ],
    );
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
                _buildDraggable(_rand1),
                _buildDraggable(_rand2),
                _buildDraggable(_rand3),
              ],
            ),

              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDraggable(_rand4),
                _buildDraggable(_rand5),
                _buildDraggable(_rand6),
              ],
            ),

              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDraggable(_rand7),
                _buildDraggable(_rand8),
                _buildDraggable(_rand9),
              ],
            ),
            
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOperator(10,"+"),
                _buildOperator(11,"-"),
                _buildOperator(12,"x"),
              ],
            ),
          

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
                      var label1;
                          if(_number1==null)
                          {
                           label1="Num 1";
                          }
                          else{
                           label1=_number1.toString();
                          }
                      return Center(child: Text(label1, style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (_dataPassed) {
                      return true;
                    },
                    onAccept: (_dataPassed) {
                      if(_dataPassed>9) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Not a number.Operator found")));
                      }
                     else{
                        //scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_dataPassed.toString())));
                        setState(() {
                           _number1=_dataPassed; 
                           _dataPassed = null;
                        });
                        
                     }
                   
                     
                    },
                  ),
                ),

                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                      print(candidateData);
                       var operatorLabel;
                          if(_sign==null)
                          {
                           operatorLabel="(+/-/x)";
                          }
                          else{

                            if(_sign==10)
                            {
                             operatorLabel="+";
                            }
                            if(_sign==11)
                            {
                             operatorLabel="-";
                            }
                            if(_sign==12)
                            {
                             operatorLabel="x";
                            }
                          
                          }
                      return Center(child: Text(operatorLabel, style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (_operation) {
                      return true;
                    },
                    onAccept: (_operation) {
                      if(_operation<10) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Not an operator")));
                      }
                      else{
                
                      //scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_operation.toString())));
                      setState(() { _sign=_operation; });
                     } 
                    },
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.deepPurple,
                  child: DragTarget(
                    builder:
                        (context, List<int> candidateData, rejectedData) {
                          var label2;
                          if(_number2==null)
                          {
                           label2="Num 2";
                          }
                          else{
                           label2=_number2.toString();
                          }
                      return Center(child: Text(label2, style: TextStyle(color: Colors.white, fontSize: 22.0),));
                    },
                    onWillAccept: (_dataPassed) {
                      return true;
                    },
                    onAccept: (_dataPassed) {
                      if(_dataPassed>9) {
                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Not a number.Operator found")));
                      }
                     else{
                      // number2=_dataPassed;
                       //scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_dataPassed.toString())));
                       setState(() { 
                         _number2=_dataPassed; 
                         _dataPassed = null;
                        });
                      
                     }
                    },
                  ),
                ),
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
                       // scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(_userAnswer.toString())));
                       if(_sign==null || _number1==null || _number2==null) {
                         scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("2 numbers and operator required")));
                       }
                      
                      if(_number1!=null && _number2!=null && _sign!=null) {
                        var result;
                       
                      if(_sign==10)
                      {
                         setRandomNumbers();
                         result=_number1+_number2;
                      
                         if(result==_userAnswer)
                         {
                           setState(() { _win=true; });   
                         }
                         else{
                           setState(() { _win=false; });
                         }

                         results(_win,_number1,_number2,_sign,result);
                          _userAnswer=null;
                      }

                      if(_sign==11)
                      {
                         setRandomNumbers();
                         result=_number1-_number2;
                         if(result==_userAnswer)
                         {
                          setState(() { _win=true; });
                         }
                         else{
                           setState(() { _win=false; });
                         }

                         results(_win,_number1,_number2,_sign,result);
                          _userAnswer=null;
                      }
                      if(_sign==12)
                      {
                        setRandomNumbers();
                         result=_number1*_number2;
                         if(result==_userAnswer)
                         {
                          setState(() { _win=true; });
                         }
                         else{
                           setState(() { _win=false; });
                         }

                         results(_win,_number1,_number2,_sign,result);
                         _userAnswer=null;
                      }

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
  setState((){ 
    _rand1=getNumber(); 
    _rand2=getNumber(); 
    _rand3=getNumber(); 
    _rand4=getNumber(); 
    _rand5=getNumber(); 
    _rand6=getNumber(); 
    _rand7=getNumber(); 
    _rand8=getNumber(); 
    _rand9=getNumber(); 
  
  });

}


void results(bool win,int num1,int num2,int sign,int answer)
{
  String operation;

  if(win)
  {
    if(sign==10)
    {
      operation="+";
    }
    if(sign==11)
    {
      operation="-";
    }
    if(sign==12)
    {
      operation="x";
    }

   scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(num1.toString()+" "+operation+" "+num2.toString()+"= "+answer.toString()+" is Correct")));
   setState(() {
      _dataPassed = null; 
      _operation = null;
      _number1 = null;
      _number2 = null;
      _sign = null;
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
  int randomNumber = random.nextInt(9) + 0;
  return randomNumber;
}


void main() {
   runApp(new GamePlay());
 
}