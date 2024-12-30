import 'dart:convert';

class FullUrl {
  final String url;
  FullUrl({
    required this.url,
  });

  FullUrl copyWith({
    String? url,
  }) {
    return FullUrl(
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
    };
  }

  factory FullUrl.fromMap(Map<String, dynamic> map) {
    return FullUrl(
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FullUrl.fromJson(String source) => FullUrl.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FullUrl(url: $url)';

  @override
  bool operator ==(covariant FullUrl other) {
    if (identical(this, other)) return true;

    return other.url == url;
  }

  @override
  int get hashCode => url.hashCode;
}
