import 'package:alcohol_check/models/history_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<HistoryData>> getUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');
  DocumentSnapshot userDoc = await usersCollection.doc(user!.uid).get();

  try {
    if (userDoc.exists) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Explicitly cast 'data' to List<Map<String, dynamic>>
      List<Map<String, dynamic>> entries =
          (userData['data'] as List<dynamic>).cast<Map<String, dynamic>>();

      List<HistoryData> historyDataList = entries.map((entry) {
        return HistoryData(
          date: entry['date'].toDate(),
          bacResult: entry['bac_result'],
          isSober: entry['is_sober'],
        );
      }).toList();
      return historyDataList;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}
