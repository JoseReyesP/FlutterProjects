import 'package:flutter/material.dart';
import 'package:pomodroid/timermodel.dart';
import 'package:pomodroid/widget.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './settings.dart';

void main()=>runApp(MyApp());

String appTitle = 'My Work Timer';
final double defaultPadding = 5.0;
final CountDownTimer timer = CountDownTimer();

class MyApp extends StatelessWidget{

    

  @override
  Widget build(BuildContext buildContext){
    timer.startWork();
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage()
    );
  }

  

}


class  TimerHomePage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = List<PopupMenuItem<String>>();
    menuItems.add(PopupMenuItem(
      value: 'Settings',
      child:  Text('Settings'),
    ));
    return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context){
              return menuItems.toList();
              },
              onSelected: (s){
                if(s=='Settings'){
                  goToSettings(context);
                }
              },  
            ),
          ],
        ),
        body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints){
          final double availableWidth = constraints.maxWidth;
          return Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff607D8B), 
                        text: 'Work', 
                        onPressed: timer.startWork, 
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff607D8B), 
                        text: 'Short Break', 
                        onPressed: () => timer.startBreak(true), 
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff455A64), 
                        text: 'Long Break', 
                        onPressed: () => timer.startBreak(false), 
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
                StreamBuilder(
                    initialData: '00:00',
                    stream: timer.stream(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      TimerModel timer = (snapshot.data == '00:00') ? TimerModel('00:00', 1) : snapshot.data;
                      return Expanded(
                        child: CircularPercentIndicator(
                          radius: availableWidth - 40 ,
                          lineWidth: 30.0,
                          percent: timer.percent,
                          center: Text(timer.time, style: Theme.of(context).textTheme.headline4,),
                          progressColor: Color(0xff009688),                  
                        ),
                      );
                }), 
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(defaultPadding)),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff212121), 
                        text: 'Stop', 
                        onPressed: timer.stopTimer, 
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Color(0xff009688), 
                        text: 'Restart', 
                        onPressed: timer.startTimer, 
                        ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );
  }

  void emptyMethod(){}

  void goToSettings(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
  }

}