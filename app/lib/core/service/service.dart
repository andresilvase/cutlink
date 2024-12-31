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

    final response = await dio.post("/cut", data: fullURL.toJson());

    return (true, response.data);
  }
}
