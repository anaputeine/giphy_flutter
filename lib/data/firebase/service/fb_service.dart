import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giphy_flutter/data/firebase/model/fb_response.dart';

class FbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FbResponse>> getFirebaseGifs() async {
    final snapshot = await _firestore.collection('gifs').get();

    return snapshot.docs.map((doc) => FbResponse.fromFirestore(doc)).toList();
  }
}
