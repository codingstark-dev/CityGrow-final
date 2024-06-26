import 'package:digitalproductstore/config/ps_colors.dart';
import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/provider/user/user_provider.dart';
import 'package:digitalproductstore/repository/user_repository.dart';
import 'package:digitalproductstore/ui/user/phone/verify_phone/verify_phone_view.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyPhoneContainerView extends StatefulWidget {
  const VerifyPhoneContainerView({
    Key key,
    @required this.userName,
    @required this.phoneNumber,
    @required this.phoneId,
  }) : super(key: key);
  final String userName;
  final String phoneNumber;
  final String phoneId;
  @override
  _CityVerifyPhoneContainerViewState createState() =>
      _CityVerifyPhoneContainerViewState();
}

class _CityVerifyPhoneContainerViewState extends State<VerifyPhoneContainerView>
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
                Utils.getString(context, 'home_verify_phone'),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              elevation: 0,
            ),
            body: VerifyPhoneView(
              userName: widget.userName,
              phoneNumber: widget.phoneNumber,
              phoneId: widget.phoneId,
              animationController: animationController,
            )));
  }
}
