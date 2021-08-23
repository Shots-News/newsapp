import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_const/flutter_const.dart';
import 'package:newsapp/constant/objects.dart';
import 'package:newsapp/locator.dart';
import 'package:newsapp/meta/icon.dart';
import 'package:newsapp/routes/move.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/view/screens/dynamic/categories_screen.dart';
import 'package:newsapp/view/screens/dynamic/saved_screen.dart';
import 'package:newsapp/view/screens/static/about_screen.dart';
import 'package:newsapp/view/screens/static/privacy_screen.dart';
import 'package:newsapp/view/screens/static/setting_screen.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            Container(
              color: Theme.of(context).secondaryHeaderColor,
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // locator<AuthService>().signInWIthGoogle();
                  Text(
                    _user == null ? "Sign In" : _user.displayName!,
                    style: textStyle.bodyBText(context),
                  ),
                  IconButton(
                    onPressed: () {
                      _user == null ? locator<AuthService>().signInWIthGoogle() : locator<AuthService>().signOut();
                    },
                    icon: Icon(MyIcons.settings_2),
                  )
                ],
              ),
            ),
            fcVSizedBox2,
            DrawerItemWidget(
              label: "News Feed",
              iconData: MyIcons.book,
              onTap: () => returnTo(context),
            ),
            DrawerItemWidget(
              label: "Categories",
              iconData: MyIcons.layers,
              onTap: () => moveTo(context, screen: MyCategoriesScreen()),
            ),
            DrawerItemWidget(
              label: "Saved",
              iconData: MyIcons.inbox,
              onTap: () => moveTo(context, screen: MySavedScreen()),
            ),
            DrawerItemWidget(
              label: "Settings",
              iconData: MyIcons.settings_1,
              onTap: () => moveTo(context, screen: MySettingScreen()),
            ),
            DrawerItemWidget(label: "Share", iconData: MyIcons.share),
            DrawerItemWidget(label: "Rate App", iconData: Icons.insights),
            DrawerItemWidget(
              label: "Privacy Policy",
              iconData: MyIcons.shield,
              onTap: () => moveTo(context, screen: MyPrivacyPolicyScreen()),
            ),
            DrawerItemWidget(
              label: "About Us",
              iconData: MyIcons.rss,
              onTap: () => moveTo(context, screen: MyAboutScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    Key? key,
    required String label,
    required IconData iconData,
    Function()? onTap,
  })  : _label = label,
        _iconData = iconData,
        _onTap = onTap,
        super(key: key);

  final String _label;
  final IconData _iconData;
  final Function()? _onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      leading: Icon(
        _iconData,
        color: Theme.of(context).secondaryHeaderColor,
      ),
      title: Text(
        _label,
        style: textStyle.buttonText(context),
      ),
    );
  }
}
