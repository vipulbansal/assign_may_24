import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/helpers_utils/common_utils.dart';
import '../../../domain/entities/image_entity.dart';
import '../../../domain/repository/image_param.dart';
import '../../bloc/images/remote/remote_image_bloc.dart';
import '../../bloc/images/remote/remote_image_event.dart';
import '../../bloc/images/remote/remote_image_state.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  bool isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Images From Pixabay',
        style: TextStyle(color: Colors.black),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Images',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (query) {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                _onSearchTextChanged(context, query);
              });
            },
          ),
        ),
      ),
    );
  }

  void _onSearchTextChanged(BuildContext context, String query) {
    BlocProvider.of<RemoteImageBloc>(context).add(SearchImages(ImageParam(
        1,
        query)));
  }

  _buildBody(BuildContext context) {
    return BlocConsumer<RemoteImageBloc, RemoteImagesState>(
        listener: (context, state) {
      if (state is RemoteArticlesDone || state is RemoteArticlesError) {
        isLoadingMore = false;
      }
      // TODO: implement listener
    }, builder: (context, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteArticlesError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteArticlesDone || state is RemoteArticlesLoadingMore) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if (state is! RemoteArticlesLoadingMore && !isLoadingMore) {
                  isLoadingMore = true;
                  // Trigger loading more articles
                  BlocProvider.of<RemoteImageBloc>(context).add(
                      GetImagesMore(ImageParam(
                          state.pageNumber + 1, _searchController.text)));
                }
              }
              return false;
            },
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          CommonUtils.calculateCrossAxisCount(context),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GridTile(
                        child: GestureDetector(
                          onTap: () =>
                              _onImagePressed(context, state.images![index]),
                          child: _buildImage(context, state.images![index]),
                        ),
                        footer: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          child: Container(
                            height: 40,
                            // Fixed height for footer
                            color: Colors.black45,
                            // Semi-transparent black background
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${state.images![index].views} views",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${state.images![index].likes} likes",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.images!.length,
                  ),
                ),
                if (state is RemoteArticlesLoadingMore && isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }

  Widget _buildImage(BuildContext context, ImageEntity article) {
    double width = MediaQuery.of(context).size.width /
            CommonUtils.calculateCrossAxisCount(context) -
        CommonUtils.calculateCrossAxisCount(context) * 10;
    return Hero(
      tag: 'imageHero${article.id}',
      child: CachedNetworkImage(
          imageUrl: article.webformatUrl,
          imageBuilder: (context, imageProvider) => ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: width,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: width,
                    height: double.maxFinite,
                    child: const CupertinoActivityIndicator(),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ),
                ),
              ),
          errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: width,
                    height: double.maxFinite,
                    child: const Icon(Icons.error),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ),
                ),
              )),
    );
  }

  void _onImagePressed(BuildContext context, ImageEntity article) {
    context.push( '/ImageDetails', extra: article);
  }

}
