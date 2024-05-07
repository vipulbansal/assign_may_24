import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'features/pixabay_images/presentation/bloc/images/remote/remote_image_bloc.dart';
import 'features/pixabay_images/presentation/bloc/images/remote/remote_image_event.dart';
import 'features/pixabay_images/presentation/pages/home/home_page.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteImageBloc>(
      create: (context) => sl()..add(const GetImages()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        routerConfig: AppRoutes().router,
      ),
    );
  }
}

