class ShortenedURL {
  Data? data;

  ShortenedURL({this.data});

  ShortenedURL.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? shortenedUrl;

  Data({this.shortenedUrl});

  Data.fromJson(Map<String, dynamic> json) {
    shortenedUrl = json['shortened_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shortened_url'] = shortenedUrl;
    return data;
  }
}
