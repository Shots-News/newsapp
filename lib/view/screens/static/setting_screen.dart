import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:line_icons/line_icons.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/meta/icon.dart';

class MySettingScreen extends StatefulWidget {
  const MySettingScreen({Key? key}) : super(key: key);

  @override
  _MySettingScreenState createState() => _MySettingScreenState();
}

class _MySettingScreenState extends State<MySettingScreen> {
  bool isSwitched = false;

  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Setting",
            style: textStyle.h5BText(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              /// Log In
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(LineIcons.googlePlay),
                      dense: true,
                      title: Text(
                        "Google Signin",
                        style: textStyle.h6Text(context)!.copyWith(color: Colors.lightBlueAccent),
                      ),
                      trailing: Icon(
                        Icons.login,
                        color: Colors.green,
                      ), // toggleableActiveColor
                    ),
                    fcVSizedBox2,
                  ],
                ),
              ),

              /// Notifications
              ListTile(
                leading: Icon(MyIcons.bell),
                isThreeLine: true,
                dense: true,
                title: Text(
                  "Notifications",
                  style: textStyle.h6Text(context),
                ),
                subtitle: Text(
                  "Manage Notification",
                  style: textStyle.smallText(context),
                ),
                trailing: Switch(value: isSwitched, onChanged: toggleSwitch), // toggleableActiveColor
              ),
              fcVSizedBox2,

              /// Log In
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(LineIcons.googlePlay),
                      dense: true,
                      title: Text(
                        "Sign Out",
                        style: textStyle.h6Text(context)!.copyWith(color: Colors.lightBlueAccent),
                      ),
                      trailing: Icon(
                        Icons.login,
                        color: Colors.green,
                      ), // toggleableActiveColor
                    ),
                    fcVSizedBox2,
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
