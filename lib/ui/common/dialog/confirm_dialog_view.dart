import 'package:digitalproductstore/config/ps_colors.dart';
import 'package:digitalproductstore/config/ps_dimens.dart';
import 'package:digitalproductstore/utils/utils.dart';
import 'package:flutter/material.dart';

class ConfirmDialogView extends StatefulWidget {
  const ConfirmDialogView(
      {Key key,
      this.description,
      this.leftButtonText,
      this.rightButtonText,
      this.onAgreeTap})
      : super(key: key);

  final String description, leftButtonText, rightButtonText;
  final Function onAgreeTap;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ConfirmDialogView> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ConfirmDialogView widget;

  @override
  Widget build(BuildContext context) {
    const Widget _spacingWidget = SizedBox(
      width: ps_space_4,
    );
    const Widget _largeSpacingWidget = SizedBox(
      height: ps_space_20,
    );
    final Widget _headerWidget = Row(
      children: <Widget>[
        _spacingWidget,
        Icon(
          Icons.live_help,
          color: Colors.white,
        ),
        _spacingWidget,
        Text(
          Utils.getString(context, 'logout_dialog__confirm'),
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );

    final Widget _messageWidget = Text(
      widget.description,
      style: Theme.of(context).textTheme.subhead,
    );
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: ps_space_60,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  border: Border.all(color: Colors.orange, width: 5),
                  color: Colors.orange),
              child: _headerWidget),
          _largeSpacingWidget,
          Container(
            padding: const EdgeInsets.only(
                left: ps_space_16,
                right: ps_space_16,
                top: ps_space_8,
                bottom: ps_space_8),
            child: _messageWidget,
          ),
          _largeSpacingWidget,
          Divider(
            color: Theme.of(context).iconTheme.color,
            height: 0.4,
          ),
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                widget.leftButtonText,
                style: Theme.of(context).textTheme.button,
              ),
            )),
            Container(
                height: 50,
                width: 0.4,
                color: Theme.of(context).iconTheme.color),
            Expanded(
                child: MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onAgreeTap();
              },
              child: Text(
                widget.rightButtonText,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: ps_ctheme__color_speical),
              ),
            )),
          ])
        ],
      ),
    );
  }
}
