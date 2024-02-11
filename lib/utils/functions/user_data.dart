import 'package:alcohol_check/models/history_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('user');

Future<List<HistoryData>> getUserData() async {
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
    throw Exception('Error getting user data: $e');
  }
}

Future<void> postResultToFirestore(
    String userId, double bac, bool isSober) async {
  try {
    if (user == null) {
      return;
    }
    // Create a new object for the result data
    Map<String, dynamic> resultData = {
      'bac_result': bac,
      'date': FieldValue.serverTimestamp(),
      'is_sober': isSober,
    };

    // Get a reference to the user's document
    DocumentReference userDocRef = usersCollection.doc(userId);

    // Add a new document to a subcollection
    await userDocRef.collection('results').add(resultData);
  } catch (e) {
    throw Exception('Error posting result to firestore: $e');
  }
}
