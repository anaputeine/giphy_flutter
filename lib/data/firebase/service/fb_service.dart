import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../../domain/gif/model/gif.dart';

class FbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

