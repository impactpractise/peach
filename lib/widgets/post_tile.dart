import 'package:flutter/material.dart';
import 'package:peach/widgets/custom_image.dart';
import 'package:peach/widgets/post.dart';

class PostTile extends StatelessWidget {
  final Post post;
  PostTile(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('show post'),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
