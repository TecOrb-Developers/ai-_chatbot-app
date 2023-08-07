class CardDetail {
  CardDetail({
    required this.data,
    required this.code,
    required this.message,
  });
  late final Data data;
  late final int code;
  late final String message;

  CardDetail.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['code'] = code;
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.url,
  });
  late final String object;
  late final List<Data> data;
  late final bool hasMore;
  late final String url;

  Data.fromJson(Map<String, dynamic> json) {
    object = json['object'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    hasMore = json['has_more'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['object'] = object;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['has_more'] = hasMore;
    _data['url'] = url;
    return _data;
  }
}
