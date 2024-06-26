import 'package:digitalproductstore/config/ps_colors.dart';
import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/provider/user/user_provider.dart';
import 'package:digitalproductstore/repository/user_repository.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'verify_email_view.dart';

class VerifyEmailContainerView extends StatefulWidget {
  @override
  _CityVerifyEmailContainerViewState createState() =>
      _CityVerifyEmailContainerViewState();
}

class _CityVerifyEmailContainerViewState extends State<VerifyEmailContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserProvider userProvider;
  UserRepository userRepo;

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    userRepo = Provider.of<UserRepository>(context);

    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: ps_ctheme__color_speical,
              brightness: Utils.getBrightnessForAppBar(context),
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: Colors.white),
              title: Text(
                Utils.getString(context, 'email_verify__title'),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              elevation: 0,
            ),
            body: VerifyEmailView(
              animationController: animationController,
            )));
  }
}
