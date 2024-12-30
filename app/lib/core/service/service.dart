import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app/core/model/full_url.dart';
import 'package:dio/dio.dart';

class CutlinkService {
  Future<(bool, dynamic)> shorten(FullUrl fullURL) async {
    final String? apiUrl = dotenv.env['API_URL'];

    if (apiUrl == null) return (false, null);

    Dio dio = Dio();
    Uri uri = Uri.parse("$apiUrl/cut");

    final response = await dio.postUri(uri, data: fullURL.toJson());

    return (true, response.data);
  }
}
