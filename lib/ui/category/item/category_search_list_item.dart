import 'package:digitalproductstore/config/ps_dimens.dart';
import 'package:digitalproductstore/viewobject/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryFilterListItem extends StatelessWidget {
  const CategoryFilterListItem(
      {Key key,
      @required this.category,
      this.onTap,
      this.animationController,
      this.animation})
      : super(key: key);

  final Category category;
  final Function onTap;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext contenxt, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 100 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: ps_space_52,
                child: Padding(
                  padding: const EdgeInsets.all(ps_space_16),
                  child: Text(
                    category.name,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
