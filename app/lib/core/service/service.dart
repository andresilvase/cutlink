import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cutlink/core/model/full_url.dart';
import 'package:dio/dio.dart';

class CutlinkService {
  Future<(bool, dynamic)> shorten(FullUrl fullURL) async {
    final String? apiUrl = dotenv.env['API_URL'];

    if (apiUrl == null) return (false, null);

    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    Duration timeoutDuration = const Duration(seconds: 5);
    bool timedOut = false;
    bool success = false;

    FutureOr<Response<dynamic>> onTimeout() {
      timedOut = true;

      throw DioException.connectionTimeout(
        requestOptions: RequestOptions(path: ""),
        timeout: timeoutDuration,
        error: success,
      );
    }

    try {
      final response = await dio.post("/cut", data: fullURL.toJson()).timeout(timeoutDuration, onTimeout: onTimeout);

      return (true, response.data);
    } catch (exception) {
      return (false, 'Connection timeout');
    }
  }
}
