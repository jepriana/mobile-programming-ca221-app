import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:myapp/core/resources/constants.dart';

import '../../core/helpers/dio_interceptor.dart';
import '../contracts/abs_api_upload_repository.dart';

class ApiUploadRepository extends AbsApiUploadRepository {
  final _baseUri = '$baseUrl/api/upload';
  late Dio _dio;
  late BaseOptions _options;

  ApiUploadRepository() {
    _options = BaseOptions(baseUrl: _baseUri);
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<String?> imageUpload(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ),
      });
      final response = await _dio.post('', data: formData);
      if (response.statusCode == 200) {
        return response.data['imageUrl'];
      }
    } catch (e) {
      log(e.toString(), name: 'ApiUploadRepository:imageUpload');
    }
    return null;
  }
}
