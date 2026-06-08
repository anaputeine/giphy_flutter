import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/gif/model/gif.dart';

part 'gif_response.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class GifResponse extends Equatable {
  final List<GifItem> data;

  const GifResponse({required this.data});

  factory GifResponse.fromJson(Map<String, dynamic> json) => _$GifResponseFromJson(json);

  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class GifItem extends Equatable {
  final String id;
  final String title;
  @JsonKey(name: 'import_datetime')
  final String importDateTime;
  @JsonKey(name: 'trending_datetime')
  final String trendingDateTime;
  final Images images;

  const GifItem({
    required this.id,
    required this.title,
    required this.importDateTime,
    required this.trendingDateTime,
    required this.images,
  });

  Gif toGif() {
    return Gif(
      id: id,
      title: title,
      url: images.link.url,
      importDateTime: _formatDate(importDateTime),
      trendingDateTime: _formatTrendingDate(trendingDateTime),
    );
  }

  String _formatTrendingDate(String value) {
    if (value == '0000-00-00 00:00:00') {
      return 'Not trending';
    }

    return _formatDate(value);
  }

  String _formatDate(String value) {
    final date = DateTime.parse(value);

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  factory GifItem.fromJson(Map<String, dynamic> json) => _$GifItemFromJson(json);

  @override
  List<Object?> get props =>
      [
        id,
        title,
        importDateTime,
        trendingDateTime,
        images,
      ];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Images extends Equatable {
  @JsonKey(name: 'fixed_height')
  final Link link;

  const Images({required this.link});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  @override
  List<Object?> get props => [link];
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class Link extends Equatable {
  final String url;

  const Link({required this.url});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  List<Object?> get props => [url];
}
