


import '../../../../core/resources/data_state.dart';
import '../entities/image_entity.dart';
import 'image_param.dart';

abstract class ImageRepository {
  // API methods
  Future<DataState<List<ImageEntity>>> getImages(ImageParam imageParam);

}