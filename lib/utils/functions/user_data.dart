import 'package:alcohol_check/models/history_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<HistoryData>> getUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');

  try {
    // Retrieve all documents from user
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await usersCollection.doc(user!.uid).collection('results').get();

    List<HistoryData> historyDataList = querySnapshot.docs.map((doc) {
      // Map document to history data object
      return HistoryData(
        date: doc['date'].toDate(),
        bacResult: (doc['bac_result'] as num).toDouble(),
        isSober: doc['is_sober'],
      );
    }).toList();

    return historyDataList;
  } catch (e) {
    print('Error retrieving user data: $e');
    return [];
  }
}