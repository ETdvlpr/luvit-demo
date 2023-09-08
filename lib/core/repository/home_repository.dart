
import 'package:firebase_database/firebase_database.dart';
import 'package:luvit/core/models/profile.dart';

/*
  Implementation for Home api requests
*/
class HomeRepository {
  DatabaseReference ref = FirebaseDatabase.instance.ref('data');

  HomeRepository();

  Future<List<Profile>?> fetchProfiles() async {
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final data = snapshot.value as Map<Object?, Object?>;
      final profiles = data.entries
          .map((e) => Profile.fromJson(
              Map<String, dynamic>.from(e.value as Map<Object?, Object?>)))
          .toList();
      return profiles;
    } else {
      print('No data available.');
    }
    return null;
  }
}
