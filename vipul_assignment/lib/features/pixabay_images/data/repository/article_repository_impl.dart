import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/repository/image_param.dart';
import '../../domain/repository/image_repository.dart';
import '../data_sources/remote/image_api_service.dart';


import '../models/image_model.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageApiService _imagesApiService;

  ImageRepositoryImpl(
    this._imagesApiService,
  );

  @override
  Future<DataState<List<ImageModel>>> getImages(
      ImageParam imageParam) async {
    try {
      final httpResponse = await _imagesApiService.getImages(
          newsAPIKey, imageParam.pageNumber, imageParam.search);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<ImageModel> images =
            parseImages(jsonEncode(httpResponse.response.data));
        return DataSuccess(images);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
