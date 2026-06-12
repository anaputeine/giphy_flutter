import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../domain/gif/model/gif.dart';

class FbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> seedGifs() async {
    final firestore = FirebaseFirestore.instance;

    final jsonString =
    await rootBundle.loadString('assets/cats_filtered.json');

    final data = jsonDecode(jsonString);

    final gifs = data['data'] as List<dynamic>;

    final batch = firestore.batch();

    for (final gif in gifs) {
      final docRef = firestore
          .collection('gifs')
          .doc(gif['id']);
      batch.set(docRef, {
        'id': gif['id'],
        'title': gif['title'],
        'importDateTime': gif['import_datetime'],
        'trendingDateTime': gif['trending_datetime'],
        'url': gif['url'],
      });
    }

    await batch.commit();

    print('Seeded ${gifs.length} gifs');
  }

  Future<List<Gif>> getFirebaseGifs() async {
    try {
      print('fb service - this actually runs!');

      final snapshot = await _firestore.collection("gifs").get();

      print('Retrieved ${snapshot.docs.length} docs');

      for (final doc in snapshot.docs) {
        print("${doc.id} => ${doc.data()}");
      }

      print('fb service completed');
      return [];
    } catch (e, stackTrace) {
      print('Firestore error: $e');
      print(stackTrace);
      rethrow;
    }
  }
}

