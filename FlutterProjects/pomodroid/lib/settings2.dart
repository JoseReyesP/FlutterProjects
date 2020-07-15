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
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    txtTest.text = "hola mundo";
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text(
            'Work',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
              Color(0xff455A64), '-', 10, -1, WORKTIME, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
            onChanged: (value) {
              int val = int.parse(value);
              if (val >= 1 && val <= 180) {
                preferences.setInt(WORKTIME, val);
              } else if (val < 1) {
                preferences.setInt(WORKTIME, 1);
              } else if (val > 180) {
                preferences.setInt(WORKTIME, 180);
              }
            },
          ),
          SettingButton(
              Color(0xff009688), '+', 10, 1, WORKTIME, updateSettings),
          Text(
            'Short',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
              Color(0xff455A64), '-', 10, -1, SHORTBREAK, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
            onChanged: (value) {
              int val = int.parse(value);
              if (val >= 1 && val <= 180) {
                preferences.setInt(SHORTBREAK, val);
              } else if (val < 1) {
                preferences.setInt(SHORTBREAK, 1);
              } else if (val > 180) {
                preferences.setInt(SHORTBREAK, 180);
              }
            },
          ),
          SettingButton(
              Color(0xff009688), '+', 10, 1, SHORTBREAK, updateSettings),
          Text(
            'Long',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
              Color(0xff455A64), '-', 10, -1, LONGBREAK, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
            onChanged: (value) {
              int val = int.parse(value);
              if (val >= 1 && val <= 180) {
                preferences.setInt(LONGBREAK, val);
              } else if (val < 1) {
                preferences.setInt(LONGBREAK, 1);
              } else if (val > 180) {
                preferences.setInt(LONGBREAK, 180);
              }
            },
          ),
          SettingButton(
              Color(0xff009688), '+', 10, 1, LONGBREAK, updateSettings),
        ],
      ),
    );
  }

  readSettings() async {
    preferences = await SharedPreferences.getInstance();
    workTime = preferences.getInt(WORKTIME);
    shortBreak = preferences.getInt(SHORTBREAK);
    longBreak = preferences.getInt(LONGBREAK);

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = preferences.getInt(key);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            preferences.setInt(WORKTIME, workTime);
            txtWork.text = workTime.toString();
          }
        }
        break;

      case SHORTBREAK:
        {
          int short = preferences.getInt(SHORTBREAK);
          short += value;
          if (short >= 1 && short <= 120) {
            preferences.setInt(SHORTBREAK, short);
            txtShort.text = short.toString();
          }
        }
        break;

      case LONGBREAK:
        {
          int long = preferences.getInt(LONGBREAK);
          long += value;
          if (long >= 1 && long <= 180) {
            preferences.setInt(LONGBREAK, long);
            txtLong.text = long.toString();
          }
        }
    }
    setState(() {});
  }
}
