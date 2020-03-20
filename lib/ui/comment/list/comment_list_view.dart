import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalproductstore/Service/firestore_loc.dart';
import 'package:digitalproductstore/api/common/ps_resource.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';

import 'package:digitalproductstore/config/ps_colors.dart';
import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/config/ps_dimens.dart';
import 'package:digitalproductstore/config/route_paths.dart';
import 'package:digitalproductstore/model/user_model.dart';
import 'package:digitalproductstore/provider/comment/comment_header_provider.dart';
import 'package:digitalproductstore/repository/comment_header_repository.dart';
import 'package:digitalproductstore/ui/common/base/ps_widget_with_appbar.dart';
import 'package:digitalproductstore/ui/common/dialog/error_dialog.dart';
import 'package:digitalproductstore/ui/common/dialog/warning_dialog_view.dart';
import 'package:digitalproductstore/ui/common/ps_textfield_widget.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:digitalproductstore/viewobject/comment_header.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:digitalproductstore/viewobject/holder/comment_header_holder.dart';
import 'package:digitalproductstore/viewobject/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../locator.dart';
import '../item/comment_list_item.dart';

class CommentListView extends StatefulWidget {
  const CommentListView({
    Key key,
    @required this.product,
    @required this.commentsList,
    @required this.productList,
  }) : super(key: key);
  final DocumentSnapshot productList;

  final Product product;
  final List<DocumentSnapshot> commentsList;
  @override
  _CommentListViewState createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  CommentHeaderRepository commentHeaderRepo;
  PsValueHolder psValueHolder;
  CommentHeaderProvider _commentHeaderProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _commentHeaderProvider.nextCommentList(widget.product.id);
      }
    });
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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

    commentHeaderRepo = Provider.of<CommentHeaderRepository>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<CommentHeaderProvider>(
        appBarTitle: Utils.getString(context, 'comment_list__title') ?? '',
        initProvider: () {
          return CommentHeaderProvider(
              repo: commentHeaderRepo, psValueHolder: psValueHolder);
        },
        // onProviderReady: (CommentHeaderProvider provider) {
        //   provider.loadCommentList(widget.product.id);
        //   _commentHeaderProvider = provider;
        // },
        builder: (BuildContext context, CommentHeaderProvider provider,
            Widget child) {
          if (widget.commentsList != null &&
              widget.commentsList.length != null) {
            return Container(
              color: Utils.isLightMode(context)
                  ? Colors.grey[100]
                  : Colors.grey[900],
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: ps_space_8),
                          child: CustomScrollView(
                              controller: _scrollController,
                              reverse: true,
                              slivers: <Widget>[
                                CommentListWidget(
                                    commentsList: widget.commentsList,
                                    animationController: animationController,
                                    provider: provider),
                              ]),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              width: double.infinity,
                              child: EditTextAndButtonWidget(
                                productList: widget.productList,
                                commentsList: widget.commentsList,
                                provider: provider,
                                product: widget.product,
                              ))),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: provider.commentHeaderList.status ==
                              PsStatus.PROGRESS_LOADING
                          ? 1.0
                          : 0.0,
                      child: const LinearProgressIndicator(),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class EditTextAndButtonWidget extends StatefulWidget {
  const EditTextAndButtonWidget({
    Key key,
    @required this.provider,
    @required this.product,
    @required this.commentsList,
    @required this.productList,
  }) : super(key: key);
  final List<DocumentSnapshot> commentsList;
  final CommentHeaderProvider provider;
  final Product product;
  final DocumentSnapshot productList;

  @override
  _EditTextAndButtonWidgetState createState() =>
      _EditTextAndButtonWidgetState();
}

class _EditTextAndButtonWidgetState extends State<EditTextAndButtonWidget> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of<Users>(context);
    if (widget.commentsList != null && widget.commentsList.length != null) {
      return SizedBox(
        width: double.infinity,
        height: ps_space_72,
        child: Container(
          decoration: BoxDecoration(
            color: Utils.isLightMode(context) ? Colors.white : Colors.grey[850],
            border: Border.all(
                color: Utils.isLightMode(context)
                    ? Colors.grey[200]
                    : Colors.grey[900]),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ps_space_12),
                topRight: Radius.circular(ps_space_12)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Utils.isLightMode(context)
                    ? Colors.grey[300]
                    : Colors.grey[900],
                blurRadius: 1.0, // has the effect of softening the shadow
                spreadRadius: 0, // has the effect of extending the shadow
                offset: const Offset(
                  0.0, // horizontal, move right 10
                  0.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(ps_space_1),
            child: StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('AppUsers')
                    .document(users.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Row(
                    children: <Widget>[
                      const SizedBox(
                        width: ps_space_4,
                      ),
                      Expanded(
                          flex: 6,
                          child: PsTextFieldWidget(
                            hintText: Utils.getString(
                                context, 'comment_list__comment_hint'),
                            textEditingController: commentController,
                            showTitle: false,
                          )),
                      // Expanded(
                      //   flex: 6,
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     height: ps_space_44,
                      //     margin: const EdgeInsets.only(
                      //         right: ps_space_4, left: ps_space_4),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(width: 2.0, color: Colors.grey),
                      //       borderRadius: BorderRadius.circular(ps_space_8),
                      //     ),
                      //     child: TextField(
                      //       maxLines: null,
                      //       controller: commentController,
                      //       style: Theme.of(context).textTheme.body1,
                      //       decoration: InputDecoration(
                      //           contentPadding: const EdgeInsets.only(
                      //               left: ps_space_12,
                      //               bottom: ps_space_8,
                      //               right: ps_space_12),
                      //           border: InputBorder.none,
                      //           hintText: Utils.getString(
                      //               context, 'comment_list__comment_hint')),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: ps_space_4,
                      // ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: ps_space_44,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              left: ps_space_4, right: ps_space_4),
                          decoration: BoxDecoration(
                            color: ps_ctheme__color_speical,
                            borderRadius: BorderRadius.circular(ps_space_4),
                            border: Border.all(
                                color: Utils.isLightMode(context)
                                    ? Colors.grey[200]
                                    : Colors.black87),
                          ),
                          child: InkWell(
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: ps_space_20,
                              ),
                            ),
                            onTap: () async {
                              if (commentController.text.isEmpty) {
                                showDialog<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WarningDialog(
                                        message: Utils.getString(
                                            context,
                                            Utils.getString(
                                                context, 'comment__empty')),
                                      );
                                    });
                              } else {
                                if (await utilsCheckInternetConnectivity()) {
                                  utilsNavigateOnUserVerificationView(context,
                                      () async {
                                    // final CommentHeaderParameterHolder
                                    //     commentHeaderParameterHolder =
                                    //     CommentHeaderParameterHolder(
                                    //   userId:
                                    //       widget.provider.psValueHolder.loginUserId,
                                    //   productId: widget.product.id,
                                    //   headerComment: commentController.text,
                                    // );

                                    // final PsResource<List<CommentHeader>> _apiStatus =
                                    //     await widget.provider.postCommentHeader(
                                    //         commentHeaderParameterHolder.toMap());
                                    if (widget.commentsList != null) {
                                      sl.get<FirebaseBloc>().commentData({
                                        'productName':
                                            widget.productList['ProductName'],
                                        'reference':
                                            widget.productList['Reference'],
                                        'uid': users.uid,
                                        'image':
                                            snapshot.data.data['ProfileImage'],
                                        'createdtime': Timestamp.now(),
                                        'name':  snapshot.data.data['name'],
                                        'Comments': commentController.text
                                      });
                                      Navigator.pop(context);
                                      // widget.provider
                                      //     .resetCommentList(widget.product.id);
                                      // commentController.clear();
                                    } else {
                                      showDialog<dynamic>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ErrorDialog(
                                              message: Utils.getString(
                                                  context,
                                                  Utils.getString(context,
                                                      '_apiStatus.message')),
                                            );
                                          });
                                    }
                                  });
                                } else {
                                  showDialog<dynamic>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ErrorDialog(
                                          message: Utils.getString(context,
                                              'error_dialog__no_internet'),
                                        );
                                      });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: ps_space_4,
                      ),
                    ],
                  );
                }),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class CommentListWidget extends StatefulWidget {
  const CommentListWidget({
    Key key,
    this.animationController,
    this.provider,
    @required this.commentsList,
  }) : super(key: key);
  final List<DocumentSnapshot> commentsList;
  final AnimationController animationController;
  final CommentHeaderProvider provider;
  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          widget.animationController.forward();
          final int count = widget.commentsList.length;
          return CommetListItem(
            comments: widget.commentsList[index],
            animationController: widget.animationController,
            animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            ),
            // comment: widget.commentsList[index][''],
            onTap: () async {
              final dynamic data = await Navigator.pushNamed(
                  context, RoutePaths.commentDetail,
                  arguments: widget.commentsList[index]);

              if (data != null) {
                await widget.provider.refreshCommentList(''
                    // widget.provider.commentHeaderList.data[index].productId
                    );
              }
            },
          );
        },
        childCount: widget.commentsList.length,
      ),
    );
  }
}
