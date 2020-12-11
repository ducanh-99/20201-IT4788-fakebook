import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/constants.dart';
import 'package:facebook/data/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Post post;

  const DetailScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: post.image1,
              placeholder: (context, url) => SizedBox(
                child: Container(
                  child: CircularProgressIndicator(),
                  color: kBackgroundGrey,
                  height: 40,
                  width: 40,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              errorWidget: (context, url, error) => SizedBox(
                child: Container(
                  child: new Icon(
                    Icons.error,
                    size: 40,
                  ),
                  color: kBackgroundGrey,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailAvatarScreen extends StatelessWidget {
  final String avatar;

  const DetailAvatarScreen({Key key, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: avatar,
              placeholder: (context, url) => SizedBox(
                child: Container(
                  child: CircularProgressIndicator(),
                  color: kBackgroundGrey,
                  height: 40,
                  width: 40,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              errorWidget: (context, url, error) => SizedBox(
                child: Container(
                  child: new Icon(
                    Icons.error,
                    size: 40,
                  ),
                  color: kBackgroundGrey,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
