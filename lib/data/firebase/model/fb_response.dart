import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/gif/model/gif.dart';

class FbResponse {
  final String id;
  final String title;
  final String importDateTime;
  final String trendingDateTime;
  final String url;

  FbResponse({
    required this.id,
    required this.title,
    required this.importDateTime,
    required this.trendingDateTime,
    required this.url,
  });

  factory FbResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return FbResponse(
      id: doc.id,
      title: data['title'],
      importDateTime: data['importDateTime'],
      trendingDateTime: data['trendingDateTime'],
      url: data['url'],
    );
  }

  Gif toGif() {
    return Gif(
      id: id,
      title: title,
      importDateTime: _formatDate(importDateTime),
      trendingDateTime: _formatTrendingDate(trendingDateTime),
      url: url,
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
}
