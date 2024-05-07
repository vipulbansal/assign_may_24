import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vipul_assignment/features/pixabay_images/presentation/bloc/images/remote/remote_image_event.dart';
import 'package:vipul_assignment/features/pixabay_images/presentation/bloc/images/remote/remote_image_state.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/entities/image_entity.dart';
import '../../../../domain/repository/image_param.dart';
import '../../../../domain/usecases/get_image.dart';

class RemoteImageBloc extends Bloc<RemoteImagesEvent, RemoteImagesState> {
  final GetImageUseCase _getArticleUseCase;

  RemoteImageBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetImages>(onGetArticles);
    on<GetImagesMore>(onGetMoreArticles);
    on<SearchImages>(onSearchImages);
  }

  void onGetArticles(GetImages event, Emitter<RemoteImagesState> emit) async {
    final dataState = await _getArticleUseCase(params: ImageParam(1,null));

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!, 1));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!, state));
    }
  }

  void onGetMoreArticles(
      GetImagesMore event, Emitter<RemoteImagesState> emit) async {
    emit(RemoteArticlesLoadingMore(state));
    final dataState = await _getArticleUseCase(params: event.imageParam);
    List<ImageEntity> newImages = dataState.data!.map((e) => e).toList();
    newImages.insertAll(0, state.images ?? []);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(newImages, event.imageParam.pageNumber));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!, state));
    }
  }

  void onSearchImages(
      SearchImages event, Emitter<RemoteImagesState> emit) async {
    emit(const RemoteArticlesLoading());
    final dataState = await _getArticleUseCase(params: event.imageParam);
    List<ImageEntity> newImages = dataState.data!.map((e) => e).toList();
    newImages.addAll(state.images ?? []);
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(newImages, event.imageParam.pageNumber));
    }
    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!, state));
    }
  }
}
