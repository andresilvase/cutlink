import 'package:app/core/service/service.dart';
import 'package:app/core/model/shortened_url.dart';
import 'package:app/core/model/full_url.dart';

class ShortenController {
  final CutlinkService _service = CutlinkService();

  Future<(bool, ShortenedURL?)> shorten(FullUrl fullURL) async {
    (bool success, dynamic jsonData) response = await _service.shorten(fullURL);

    if (response.$1) {
      return (response.$1, ShortenedURL.fromJson(response.$2));
    } else {
      return (response.$1, null);
    }
  }
}
