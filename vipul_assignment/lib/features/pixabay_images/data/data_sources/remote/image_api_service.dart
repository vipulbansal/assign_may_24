import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/constants.dart';
import 'package:dio/dio.dart';
part 'image_api_service.g.dart';

@RestApi(baseUrl:newsAPIBaseURL)
abstract class ImageApiService {
  factory ImageApiService(Dio dio) = _ImageApiService;

  @GET("/")
  Future<HttpResponse<dynamic>> getImages(
      @Query("key") String apiKey,
      @Query("page") int page,
      @Query("q") String? search);

}