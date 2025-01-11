import 'package:cutlink/core/model/shortened_url.dart';
import 'package:cutlink/core/service/service.dart';
import 'package:cutlink/core/model/full_url.dart';
import 'package:get/get.dart';

class ShortenController {
  final Rx<ShortenedURL> _shortenedURL = ShortenedURL().obs;
  final CutlinkService _service = CutlinkService();
  final RxBool _loading = false.obs;
  final RxBool _hasError = false.obs;
  final RxString _errorMsg = ''.obs;

  String? get shortenedURL => _shortenedURL.value.data?.shortenedUrl;
  String? get errr => _shortenedURL.value.error;
  String get errorMsg => _errorMsg.value;
  bool get hasError => _hasError.value;
  bool get loading => _loading.value;

  void reset() {
    _shortenedURL.value = ShortenedURL();
    resetLoding();
    resetError();
  }

  void resetLoding() => _loading(false);
  void setLoding() => _loading(true);

  void resetError() => _hasError(false);
  void setError([String? errorMsg]) {
    _hasError(true);
    _errorMsg(errorMsg ?? '');
  }

  Future<void> shorten(String url) async {
    final RegExp regExp = RegExp(
      r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$",
    );

    if (!regExp.hasMatch(url)) {
      setError();
      return;
    } else {
      resetError();

      FullUrl fullURL = FullUrl(url: url);

      setLoding();
      (bool success, dynamic jsonData) response = await _service.shorten(fullURL);
      resetLoding();

      if (response.$1) {
        _shortenedURL.value = ShortenedURL.fromJson(response.$2);
        if (_shortenedURL.value.error != null) {
          setError();
        }
      } else {
        setError(response.$2.toString());
      }
    }
  }
}
