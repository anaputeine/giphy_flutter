import 'package:equatable/equatable.dart';

class Gif extends Equatable {
  final String id;
  final String title;
  final String url;
  final String importDateTime;
  final String trendingDateTime;

  const Gif({
    required this.id,
    required this.title,
    required this.url,
    required this.importDateTime,
    required this.trendingDateTime,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    url,
    importDateTime,
    trendingDateTime,
  ];
}
