import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'features/pixabay_images/data/data_sources/remote/image_api_service.dart';
import 'features/pixabay_images/data/repository/article_repository_impl.dart';
import 'features/pixabay_images/domain/repository/image_repository.dart';
import 'features/pixabay_images/domain/usecases/get_image.dart';
import 'features/pixabay_images/presentation/bloc/images/remote/remote_image_bloc.dart';



final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<ImageApiService>(ImageApiService(sl()));

  sl.registerSingleton<ImageRepository>(
    ImageRepositoryImpl(sl())
  );
  
  //UseCases
  sl.registerSingleton<GetImageUseCase>(
    GetImageUseCase(sl())
  );


  //Blocs
  sl.registerFactory<RemoteImageBloc>(
    ()=> RemoteImageBloc(sl())
  );



}