import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/config/ps_constants.dart';
import 'package:digitalproductstore/config/route_paths.dart';
import 'package:digitalproductstore/provider/user/user_provider.dart';
import 'package:digitalproductstore/repository/user_repository.dart';
import 'package:digitalproductstore/ui/user/profile/profile_view.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class ProfileContainerView extends StatefulWidget {
  @override
  _CityProfileContainerViewState createState() =>
      _CityProfileContainerViewState();
}

class _CityProfileContainerViewState extends State<ProfileContainerView>
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

  UserProvider userProvider;
  UserRepository userRepo;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
          body: CustomScrollView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              slivers: <Widget>[
                _SliverAppbar(
                  title: Utils.getString(context, 'profile__title'),
                  scaffoldKey: scaffoldKey,
                ),
                ProfileView(
                  scaffoldKey: scaffoldKey,
                  animationController: animationController,
                  flag: REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT,
                ),
              ]),
        ));
  }
}

class _SliverAppbar extends StatefulWidget {
  const _SliverAppbar(
      {Key key, @required this.title, this.scaffoldKey, this.menuDrawer})
      : super(key: key);
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Drawer menuDrawer;
  @override
  _SliverAppbarState createState() => _SliverAppbarState();
}

class _SliverAppbarState extends State<_SliverAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Utils.getBrightnessForAppBar(context),
      iconTheme: Theme.of(context).iconTheme,
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications_none,
              color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pushNamed(
              context,
              RoutePaths.notiList,
            );
          },
        ),
        IconButton(
          icon:
              Icon(Feather.book_open, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            // Navigator.pushNamed(
            //   context,
            //   Ecommerce1RoutePaths.blogList,
            // );
          },
        )
      ],
      //backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
