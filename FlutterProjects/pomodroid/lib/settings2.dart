import 'package:flutter/material.dart';
import 'package:pomodroid/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings2(),
    );
  }
}

class Settings2 extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings2> {
  TextStyle textStyle = TextStyle(fontSize: 24);

  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  int workTime;
  int shortBreak;
  int longBreak;

  SharedPreferences preferences;

  TextEditingController txtTest = TextEditingController();

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    txtTest.text = "hola mundo";
    return Container(
      child: TextField(
        textAlign: TextAlign.center,
        controller: txtTest,
      ),
    );
  }
}
