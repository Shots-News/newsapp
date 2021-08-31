import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constant/objects.dart';

class MySavedScreen extends StatelessWidget {
  const MySavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// [FirebaseCrashlytics]
    // FirebaseCrashlytics.instance.crash();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved News",
            style: textStyle.h5BText(context),
          ),
        ),
      ),
    );
  }
}
