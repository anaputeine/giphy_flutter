// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gif_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GifResponse _$GifResponseFromJson(Map<String, dynamic> json) => GifResponse(
  data: (json['data'] as List<dynamic>)
      .map((e) => GifItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

GifItem _$GifItemFromJson(Map<String, dynamic> json) => GifItem(
  id: json['id'] as String,
  title: json['title'] as String,
  importDateTime: json['import_datetime'] as String,
  trendingDateTime: json['trending_datetime'] as String,
  images: Images.fromJson(json['images'] as Map<String, dynamic>),
);

Images _$ImagesFromJson(Map<String, dynamic> json) =>
    Images(link: Link.fromJson(json['fixed_height'] as Map<String, dynamic>));

Link _$LinkFromJson(Map<String, dynamic> json) =>
    Link(url: json['url'] as String);
