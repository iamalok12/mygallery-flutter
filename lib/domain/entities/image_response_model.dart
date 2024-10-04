// ignore_for_file: unnecessary_new

class ImageResponseModel {
  int? total;
  int? totalHits;
  List<Hits>? hits;

  ImageResponseModel({this.total, this.totalHits, this.hits});

  ImageResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalHits = json['totalHits'];
    if (json['hits'] != null) {
      hits = <Hits>[];
      json['hits'].forEach((v) {
        hits!.add(new Hits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalHits'] = totalHits;
    if (hits != null) {
      data['hits'] = hits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hits {
  int? id;
  String? previewURL;
  int? views;
  int? likes;

  Hits({this.id, this.previewURL, this.views, this.likes});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    previewURL = json['previewURL'];
    views = json['views'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['previewURL'] = previewURL;
    data['views'] = views;
    data['likes'] = likes;
    return data;
  }
}
