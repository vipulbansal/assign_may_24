import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/image_entity.dart';

class FullScreenImageView extends StatelessWidget {
  final ImageEntity article;

  const FullScreenImageView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero${article.id}',
          child: CachedNetworkImage(
            imageUrl: article.largeImageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
