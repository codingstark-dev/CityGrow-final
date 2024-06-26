import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalproductstore/model/user_model.dart';
import 'package:digitalproductstore/viewobject/default_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:digitalproductstore/api/common/ps_status.dart';
import 'package:digitalproductstore/config/ps_config.dart';
import 'package:digitalproductstore/viewobject/default_photo.dart';
import 'package:provider/provider.dart';

class PsNetworkImage extends StatelessWidget {
  const PsNetworkImage(
      {Key key,
      @required this.photoKey,
      @required this.defaultPhoto,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover,
      @required this.firebasePhoto})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final DefaultPhoto defaultPhoto;
  final dynamic firebasePhoto;
  @override
  Widget build(BuildContext context) {
    //Utils.psPrint("ImagePath : ${defaultPhoto.imgPath}");
    if (firebasePhoto == null) {
      return GestureDetector(
          onTap: onTap,
          // child: Hero(
          //   tag: 'dash',
          child: Image.asset(
            'assets/images/placeholder_image.png',
            width: width,
            height: height,
            fit: boxfit,

            // ),
          ));
    } else {
      // print('$ps_app_image_url${defaultPhoto.imgPath}');
      // print('$ps_app_image_thumbs_url${defaultPhoto.imgPath}');
      if (photoKey == '') {
        return GestureDetector(
          onTap: onTap,
          child: CachedNetworkImage(
            placeholder: (BuildContext context, String url) {
              return CachedNetworkImage(
                width: width,
                height: height,
                fit: boxfit,
                placeholder: (BuildContext context, String url) {
                  return Image.asset(
                    'assets/images/placeholder_image.png',
                    width: width,
                    height: height,
                    fit: boxfit,
                  );
                },
                imageUrl: ('$firebasePhoto'.contains('['))
                    ? '${firebasePhoto[0]}'
                    : firebasePhoto,
              );
            },
            width: width,
            height: height,
            fit: boxfit,
            imageUrl: ('$firebasePhoto'.contains('['))
                ? '${firebasePhoto[0]}'
                : firebasePhoto,
            errorWidget: (BuildContext context, String url, Object error) {
              return Image.asset(
                'assets/images/placeholder_image.png',
                width: width,
                height: height,
                fit: boxfit,
                // ),
              );
            },
          ),
        );
      } else {
        return GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: ('$firebasePhoto'.contains('['))
                ? '${firebasePhoto[0]}'
                : firebasePhoto,
            child: CachedNetworkImage(
              placeholder: (BuildContext context, String url) {
                return CachedNetworkImage(
                  width: width,
                  height: height,
                  fit: boxfit,
                  placeholder: (BuildContext context, String url) {
                    return Image.asset(
                      'assets/images/placeholder_image.png',
                      width: width,
                      height: height,
                      fit: boxfit,
                    );
                  },
                  imageUrl: ('$firebasePhoto'.contains('['))
                      ? '${firebasePhoto[0]}'
                      : firebasePhoto,
                );
              },
              width: width,
              height: height,
              fit: boxfit,
              imageUrl: ('$firebasePhoto'.contains('['))
                  ? '${firebasePhoto[0]}'
                  : firebasePhoto,
              errorWidget: (BuildContext context, String url, Object error) =>
                  Image.asset(
                'assets/images/placeholder_image.png',
                width: width,
                height: height,
                fit: boxfit,
              ),
            ),
          ),
        );
      }
    }
  }
}

class PsNetworkImageWithUrl extends StatelessWidget {
  const PsNetworkImageWithUrl(
      {Key key,
      @required this.photoKey,
      @required this.url,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final String url;

  @override
  Widget build(BuildContext context) {
    //Utils.psPrint("ImagePath : ${defaultPhoto.imgPath}");
    if (url == '') {
      return GestureDetector(
          onTap: onTap,
          // child: Hero(
          //   tag: 'dash',
          child: Image.asset(
            'assets/images/placeholder_image.png',
            width: width,
            height: height,
            fit: boxfit,

            // ),
          ));
    } else {
      // print('$ps_app_image_url${defaultPhoto.imgPath}');
      // print('$ps_app_image_thumbs_url${defaultPhoto.imgPath}');
      if (photoKey == '') {
        return GestureDetector(
          onTap: onTap,
          child: CachedNetworkImage(
            placeholder: (BuildContext context, String url) {
              return CachedNetworkImage(
                width: width,
                height: height,
                fit: boxfit,
                placeholder: (BuildContext context, String url) {
                  return Image.asset(
                    'assets/images/placeholder_image.png',
                    width: width,
                    height: height,
                    fit: boxfit,
                  );
                },
                imageUrl: '$url',
              );
            },
            width: width,
            height: height,
            fit: boxfit,
            imageUrl: '$url',
            errorWidget: (BuildContext context, String url, Object error) =>
                Image.asset(
              'assets/images/placeholder_image.png',
              width: width,
              height: height,
              fit: boxfit,
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: onTap,
          // child: Hero(
          //   tag: '$photoKey$ps_app_image_url$url',
          child: CachedNetworkImage(
            placeholder: (BuildContext context, String url) =>
                CachedNetworkImage(
              width: width,
              height: height,
              fit: boxfit,
              placeholder: (BuildContext context, String url) {
                return Image.asset(
                  'assets/images/placeholder_image.png',
                  width: width,
                  height: height,
                  fit: boxfit,
                );
              },
              imageUrl: '$url',
            ),
            width: width,
            height: height,
            fit: boxfit,
            imageUrl: '$url',
            errorWidget: (BuildContext context, String url, Object error) =>
                Image.asset(
              'assets/images/placeholder_image.png',
              width: width,
              height: height,
              fit: boxfit,
            ),
          ),
          // ),
        );
      }
    }
  }
}

class PsFileImage extends StatelessWidget {
  const PsFileImage(
      {Key key,
      @required this.photoKey,
      @required this.file,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final File file;

  @override
  Widget build(BuildContext context) {
    //Utils.psPrint("ImagePath : ${defaultPhoto.imgPath}");
    if (file == null) {
      return GestureDetector(
          onTap: onTap,
          // child: Hero(
          //   tag: 'dash',
          child: Image.asset(
            'assets/images/placeholder_image.png',
            width: width,
            height: height,
            fit: boxfit,

            // ),
          ));
    } else {
      // print('$ps_app_image_url${defaultPhoto.imgPath}');
      // print('$ps_app_image_thumbs_url${defaultPhoto.imgPath}');
      if (photoKey == '') {
        return GestureDetector(
            onTap: onTap,
            child: Image(
              image: FileImage(file),
            ));
      } else {
        return GestureDetector(
            onTap: onTap,
            // child: Hero(
            //   tag: '$photoKey$ps_app_image_url$url',
            child: Image(
              image: FileImage(file),
            ));
      }
    }
  }
}

class PsNetworkCircleImage extends StatelessWidget {
  const PsNetworkCircleImage(
      {Key key,
      @required this.photoKey,
      this.url,
      this.asset,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final String url;
  final String asset;

  @override
  Widget build(BuildContext context) {
    if (url == null || url == '') {
      if (asset == null || asset == '') {
        return GestureDetector(
            onTap: onTap,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: Image.asset(
                  'assets/images/placeholder_image.png',
                  width: width,
                  height: height,
                  fit: boxfit,

                  // ),
                )));
      } else {
        print('I Key : $photoKey$asset');
        print('');
        return GestureDetector(
            onTap: onTap,
            child: Hero(
              tag: '$photoKey$asset',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child:
                    //   Container(
                    // width: width,
                    // height: height,
                    // child:
                    Image.asset(asset,
                        width: width, height: height, fit: boxfit),
              ),
              // )
            ));
      }
    } else {
      if (photoKey == '') {
        return GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                placeholder: (BuildContext context, String url) {
                  return CachedNetworkImage(
                    width: width,
                    height: height,
                    fit: boxfit,
                    placeholder: (BuildContext context, String url) {
                      return Image.asset(
                        'assets/images/placeholder_image.png',
                        width: width,
                        height: height,
                        fit: boxfit,
                      );
                    },
                    imageUrl: '$url',
                  );
                },
                width: width,
                height: height,
                fit: boxfit,
                imageUrl: '$url',
                errorWidget: (BuildContext context, String url, Object error) =>
                    Image.asset(
                  'assets/images/placeholder_image.png',
                  width: width,
                  height: height,
                  fit: boxfit,
                ),
              ),
            ));
      } else {
        return GestureDetector(
          onTap: onTap,
          child: Hero(
              tag: '$url',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: CachedNetworkImage(
                  placeholder: (BuildContext context, String url) =>
                      CachedNetworkImage(
                    width: width,
                    height: height,
                    fit: boxfit,
                    placeholder: (BuildContext context, String url) {
                      return Image.asset(
                        'assets/images/placeholder_image.png',
                        width: width,
                        height: height,
                        fit: boxfit,
                      );
                    },
                    imageUrl: '$url',
                  ),
                  width: width,
                  height: height,
                  fit: boxfit,
                  imageUrl: '$url',
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          Image.asset(
                    'assets/images/placeholder_image.png',
                    width: width,
                    height: height,
                    fit: boxfit,
                  ),
                ),
              )),
        );
      }
    }
  }
}

class PsFileCircleImage extends StatelessWidget {
  const PsFileCircleImage(
      {Key key,
      @required this.photoKey,
      this.file,
      this.asset,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final File file;
  final String asset;

  @override
  Widget build(BuildContext context) {
    if (file == null) {
      if (asset == null || asset == '') {
        return GestureDetector(
            onTap: onTap,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: Container(
                    width: width, height: height, child: Icon(Icons.image))));
      } else {
        print('I Key : $photoKey$asset');
        print('');
        return GestureDetector(
            onTap: onTap,
            child: Hero(
              tag: '$photoKey$asset',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: Image.asset(asset,
                    width: width, height: height, fit: boxfit),
              ),
            ));
      }
    } else {
      if (photoKey == '') {
        return GestureDetector(
            onTap: onTap,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: Image(
                  image: FileImage(file),
                )));
      } else {
        return GestureDetector(
          onTap: onTap,
          child: Hero(
              tag: file,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10000.0),
                  child: Image(image: FileImage(file)))),
        );
      }
    }
  }
}

class PSProgressIndicator extends StatefulWidget {
  const PSProgressIndicator(this._status);
  final PsStatus _status;

  @override
  _PSProgressIndicator createState() => _PSProgressIndicator();
}

class _PSProgressIndicator extends State<PSProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: widget._status == PsStatus.PROGRESS_LOADING ? 1.0 : 0.0,
          child: const LinearProgressIndicator(),
        ),
      ),
    );
  }
}

class PsNetworkCircleIconImage extends StatelessWidget {
  const PsNetworkCircleIconImage(
      {Key key,
      @required this.photoKey,
      @required this.defaultIcon,
      this.width,
      this.height,
      this.onTap,
      this.boxfit = BoxFit.cover})
      : super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String photoKey;
  final BoxFit boxfit;
  final DefaultIcon defaultIcon;

  @override
  Widget build(BuildContext context) {
    //Utils.psPrint("ImagePath : ${defaultPhoto.imgPath}");
    if (defaultIcon.imgPath == '') {
      return GestureDetector(
          onTap: onTap,
          // child: Hero(
          //   tag: 'dash',
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: Image.asset(
                'assets/images/placeholder_image.png',
                width: width,
                height: height,
                fit: boxfit,

                // ),
              )));
    } else {
      // print('$ps_app_image_url${defaultIcon.imgPath}');
      // print('$ps_app_image_thumbs_url${defaultIcon.imgPath}');
      if (photoKey == '') {
        return GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10000.0),
              child: CachedNetworkImage(
                placeholder: (BuildContext context, String url) =>
                    CachedNetworkImage(
                  width: width,
                  height: height,
                  fit: boxfit,
                  placeholder: (BuildContext context, String url) {
                    return Image.asset(
                      'assets/images/placeholder_image.png',
                      width: width,
                      height: height,
                      fit: boxfit,
                    );
                  },
                  imageUrl: '$ps_app_image_thumbs_url${defaultIcon.imgPath}',
                ),
                width: width,
                height: height,
                fit: boxfit,
                imageUrl: '$ps_app_image_url${defaultIcon.imgPath}',
                errorWidget: (BuildContext context, String url, Object error) =>
                    Image.asset(
                  'assets/images/placeholder_image.png',
                  width: width,
                  height: height,
                  fit: boxfit,
                ),
              ),
            ));
      } else {
        return GestureDetector(
          onTap: onTap,
          child: Hero(
              tag: '$photoKey$ps_app_image_url${defaultIcon.imgPath}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: CachedNetworkImage(
                  placeholder: (BuildContext context, String url) =>
                      CachedNetworkImage(
                    width: width,
                    height: height,
                    fit: boxfit,
                    placeholder: (BuildContext context, String url) {
                      return Image.asset(
                        'assets/images/placeholder_image.png',
                        width: width,
                        height: height,
                        fit: boxfit,
                      );
                    },
                    imageUrl: '$ps_app_image_thumbs_url${defaultIcon.imgPath}',
                  ),
                  width: width,
                  height: height,
                  fit: boxfit,
                  imageUrl: '$ps_app_image_url${defaultIcon.imgPath}',
                  errorWidget:
                      (BuildContext context, String url, Object error) =>
                          Image.asset(
                    'assets/images/placeholder_image.png',
                    width: width,
                    height: height,
                    fit: boxfit,
                  ),
                ),
              )),
        );
      }
    }
  }
}
// Widget buildProgressIndicator() {
//   return new Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: new Center(
//       child: new Opacity(
//         opacity: 1.0,
//         child: new LinearProgressIndicator(),
//       ),
//     ),
//   );
// }

// class SpacePaddingWidget extends StatelessWidget {
//   const SpacePaddingWidget({Key key, this.padding}) : super(key: key);
//   final double padding;

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Padding(padding: EdgeInsets.all(padding)));
//   }
// }
