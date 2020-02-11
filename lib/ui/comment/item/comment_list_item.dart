import 'package:digitalproductstore/config/ps_colors.dart';
import 'package:digitalproductstore/config/ps_dimens.dart';
import 'package:digitalproductstore/ui/common/ps_ui_widget.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:digitalproductstore/viewobject/comment_header.dart';
import 'package:flutter/material.dart';

class CommetListItem extends StatelessWidget {
  const CommetListItem({
    Key key,
    @required this.comment,
    this.animationController,
    this.animation,
    this.onTap,
  }) : super(key: key);

  final CommentHeader comment;
  final Function onTap;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    if (comment != null) {
      return AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
                opacity: animation,
                child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 100 * (1.0 - animation.value), 0.0),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Card(
                        elevation: 0.3,
                        margin: const EdgeInsets.symmetric(
                            horizontal: ps_space_12, vertical: ps_space_4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _ImageAndTextWidget(
                            comment: comment,
                          ),
                        ),
                      ),
                    )));
          });
    } else {
      return Container();
    }
  }
}

class _ImageAndTextWidget extends StatelessWidget {
  const _ImageAndTextWidget({
    Key key,
    @required this.comment,
  }) : super(key: key);

  final CommentHeader comment;

  @override
  Widget build(BuildContext context) {
    final Widget _iconWidget = Icon(
      Icons.reply_all,
      size: ps_space_20,
      color: Colors.grey,
    );

    final Widget _textWidget = Text(comment.addedDateStr,
        style:
            Theme.of(context).textTheme.caption.copyWith(color: Colors.grey));

    if (comment != null && comment.user != null) {
      return Row(
        children: <Widget>[
          PsNetworkImageWithUrl(
            photoKey: '',
            width: ps_space_40,
            height: ps_space_40,
            url: comment.user.userProfilePhoto,
          ),
          const SizedBox(
            width: ps_space_8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: ps_space_8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          comment.user.userName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                      _iconWidget
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: ps_space_8),
                  child: Text(
                    comment.headerComment,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: ps_space_180,
                        child: Text(
                          comment.commentReplyCount == '0'
                              ? ''
                              : '- ${comment.commentReplyCount} ${Utils.getString(context, 'comment_list__replies')}',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: ps_ctheme__color_application),
                        ),
                      ),
                    ),
                    _textWidget
                  ],
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
