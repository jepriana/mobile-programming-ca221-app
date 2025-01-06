import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../core/helpers/dio_interceptor.dart';
import '../../core/resources/constants.dart';
import '../contracts/abs_api_upload_repository.dart';

class ApiUploadRepository extends AbsApiUploadRepository {
  final _baseUri = '$baseUrl/api/upload';
  late final Dio _dio;
  late BaseOptions _options;

  ApiUploadRepository() {
    _options = BaseOptions(
      baseUrl: _baseUri.toString(),
    );
    _dio = Dio(_options);
    _dio.interceptors.add(DioInterceptor(dio: _dio));
  }

  @override
  Future<String?> imageUpload(File file) async {
    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: MediaType("image", "png"),
      ),
    });
    try {
      final response = await _dio.post(
        '',
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data['imageUrl'];
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }
}
