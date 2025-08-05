import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:task_P2/core/enums/image_type_enum.dart';

import 'package:task_P2/ui/shared/size.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage(
      {super.key,
      this.applyImageRadius = true,
      this.border,
      this.borderRadius = TSize.md,
      this.fit = BoxFit.contain,
      this.image,
      this.imageType = ImageType.ASSET,
      this.overlayColor,
      this.backgroundColor,
      this.memoryImage,
      this.width = 56,
      this.height = 56,
      this.padding = TSize.sm,
      this.margin,
      this.file});
  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRadius;
  final BoxFit fit;
  final String? image;
  final io.File? file;

  final ImageType imageType;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.NETWORK:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.MEMORY:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.FILE:
        imageWidget = _buildFileImage();
        break;
      case ImageType.ASSET:
        imageWidget = _buildAssetImage();
        break;
    }
    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.circular(0),
      child: imageWidget,
    );
  }

  Widget _buildFileImage() => (file != null)
      ? Image(
          fit: fit,
          image: FileImage(file!),
          color: overlayColor,
        )
      : Container();
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
        fit: fit,
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null) {
      return Image(
        fit: fit,
        image: AssetImage(image!),
        color: overlayColor,
      );
    } else {
      return Container();
    }
  }

  Widget _buildNetworkImage() {
    if (image != null) {
      return Image.network(
        fit: fit,
        color: overlayColor,
        image!,
      );
    } else {
      return Container();
    }
  }
}
