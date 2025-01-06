import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/resources/colors.dart';
import '../../../repositories/contracts/abs_api_upload_repository.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  final String? imageUrl;
  final CropAspectRatio? aspectRatio;
  const ImageInput({
    required this.onSelectImage,
    this.imageUrl,
    this.aspectRatio,
    super.key,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  String? _imageUrl;
  late AbsApiUploadRepository _repository;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _repository = RepositoryProvider.of<AbsApiUploadRepository>(context);
    _imageUrl = widget.imageUrl;
  }

  Future<File?> _getImage(ImageSource imageSource) async {
    if (Platform.isAndroid) {
      final bool isGranted = await _requestPermission();
      if (!isGranted) {
        return null;
      }
    }
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: imageSource,
      maxHeight: 1080,
      maxWidth: 1440,
      imageQuality: 90,
    );
    if (imageFile != null) {
      return File(imageFile.path);
    }
    return null;
  }

  Future<CroppedFile?> _cropImage(String imagePath) async {
    CroppedFile? croppedfile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatio:
          widget.aspectRatio ?? const CropAspectRatio(ratioX: 4, ratioY: 3),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper',
          // toolbarColor: darkBackground,
          activeControlsWidgetColor: primaryColor,
          cropGridColor: primaryColor,
          cropFrameColor: primaryColor,
          toolbarWidgetColor: primaryColor,
          // statusBarColor: darkBackground,
          // backgroundColor: darkBackground,
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          lockAspectRatio: false,
          aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(width: 800, height: 600),
          zoomable: true,
          zoomOnWheel: true,
          zoomOnTouch: true,
          guides: true,
        ),
      ],
    );

    if (croppedfile != null) {
      return croppedfile;
    }
    return null;
  }

  Future<void> _uploadImage(CroppedFile imageFile) async {
    setState(() {
      _isLoading = true;
    });
    final pickedImageFile = File(imageFile.path);
    final result = await _repository.imageUpload(pickedImageFile);
    if (result != null) {
      setState(() {
        _imageUrl = result;
      });
    }
    setState(() {
      _isLoading = false;
    });
    widget.onSelectImage(result);
  }

  Future<void> _takePicture(ImageSource imageSource) async {
    if (Platform.isAndroid) {
      final bool isGranted = await _requestPermission();
      if (!isGranted) {
        return;
      }
    }

    final result = await _getImage(imageSource);
    if (result != null) {
      final cropped = await _cropImage(result.path);
      if (cropped != null) {
        await _uploadImage(cropped);
      }
    }
  }

  Future<bool> _requestPermission() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.camera,
      Permission.photos
    ].request();
    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.camera] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: _imageUrl != null ? 4 / 3 : 100 / 1,
          child: _imageUrl == null
              ? null
              : Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: _imageUrl != null ? 0 : 1,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: _imageUrl!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const Text(
                              'No image selected',
                              textAlign: TextAlign.center,
                            ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.image_search_rounded),
              onPressed: () => _takePicture(ImageSource.gallery),
              label: const Text('Browse'),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextButton.icon(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () => _takePicture(ImageSource.camera),
              label: const Text('Capture'),
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
