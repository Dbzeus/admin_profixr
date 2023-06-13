import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoView extends GetView {
  GalleryPhotoView({
    Key? key,
    this.loadingBuilder,
    required this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    required this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  RxInt initialIndex;
  final PageController pageController = PageController(initialPage: 0);
  final List<String> galleryItems;
  final Axis scrollDirection;

  void onPageChanged(int index) {
    initialIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            "Image ${initialIndex.value + 1}",
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: backgroundDecoration,
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: _buildItem,
            itemCount: galleryItems.length,
            loadingBuilder: loadingBuilder,
            backgroundDecoration: backgroundDecoration,
            pageController: pageController,
            onPageChanged: onPageChanged,
            scrollDirection: scrollDirection,
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: galleryItems[index].isURL ? CachedNetworkImageProvider(galleryItems[index]) as ImageProvider : FileImage(File(galleryItems[index])),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index]),
    );
  }
}
