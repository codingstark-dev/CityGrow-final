import 'package:digitalproductstore/api/common/ps_status.dart';

import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/provider/subcategory/sub_category_provider.dart';
import 'package:digitalproductstore/repository/sub_category_repository.dart';
import 'package:digitalproductstore/ui/common/base/ps_widget_with_appbar.dart';
import 'package:digitalproductstore/ui/common/ps_frame_loading_widget.dart';
import 'package:digitalproductstore/ui/common/ps_ui_widget.dart';
import 'package:digitalproductstore/ui/subcategory/item/sub_category_search_list_item.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SubCategorySearchListView extends StatefulWidget {
  const SubCategorySearchListView({@required this.categoryId});

  final String categoryId;
  @override
  State<StatefulWidget> createState() {
    return _SubCategorySearchListViewState();
  }
}

class _SubCategorySearchListViewState extends State<SubCategorySearchListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  SubCategoryProvider _subCategoryProvider;
  // final CategoryParameterHolder categoryIconList = CategoryParameterHolder();
  AnimationController animationController;
  Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _subCategoryProvider.nextSubCategoryList(widget.categoryId);
      }
    });

    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController);
    super.initState();
  }

  SubCategoryRepository repo1;

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

    repo1 = Provider.of<SubCategoryRepository>(context);

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<SubCategoryProvider>(
          appBarTitle: Utils.getString(
                  context, 'sub_category_list__sub_category_list') ??
              '',
          initProvider: () {
            return SubCategoryProvider(
              repo: repo1,
              // psValueHolder: Provider.of<PsValueHolder>(context)
            );
          },
          onProviderReady: (SubCategoryProvider provider) {
            provider.loadSubCategoryList(widget.categoryId);
            _subCategoryProvider = provider;
          },
          builder: (BuildContext context, SubCategoryProvider provider,
              Widget child) {
            return Stack(children: <Widget>[
              Container(
                  child: RefreshIndicator(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: provider.subCategoryList.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (provider.subCategoryList.status ==
                          PsStatus.BLOCK_LOADING) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.white,
                            child: Column(children: const <Widget>[
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                              PsFrameUIForLoading(),
                            ]));
                      } else {
                        final int count = provider.subCategoryList.data.length;
                        animationController.forward();
                        return FadeTransition(
                            opacity: animation,
                            child: SubCategorySearchListItem(
                              animationController: animationController,
                              animation:
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              ),
                              subCategory: provider.subCategoryList.data[index],
                              onTap: () {
                                print(provider.subCategoryList.data[index]
                                    .defaultPhoto.imgPath);
                                Navigator.pop(context,
                                    provider.subCategoryList.data[index]);
                                print(
                                    provider.subCategoryList.data[index].name);
                                // if (index == 0) {
                                //   Navigator.pushNamed(
                                //     context,
                                //     RoutePaths.searchCategory,
                                //   );
                                // }
                              },
                            ));
                      }
                    }),
                onRefresh: () {
                  return provider.resetSubCategoryList(widget.categoryId);
                },
              )),
              PSProgressIndicator(provider.subCategoryList.status)
            ]);
          }),
    );
  }
}
