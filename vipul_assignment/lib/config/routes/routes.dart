import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/pixabay_images/domain/entities/image_entity.dart';
import '../../features/pixabay_images/presentation/pages/home/home_page.dart';
import '../../features/pixabay_images/presentation/pages/image_detail/full_screen_image_view.dart';




class AppRoutes {

  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/imageDetails',
        builder: (context, state) {
          final ImageEntity image = state.extra as ImageEntity;
          return FullScreenImageView(article: image);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(state.error.toString())),
    ),
  );

}
