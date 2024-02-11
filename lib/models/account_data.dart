class AccountData {
  final String name;
  final String photoURL;
  final String uid;
  final String email;

  AccountData(
      {required this.name,
      required this.photoURL,
      required this.uid,
      required this.email});

  AccountData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photoURL = json['photoURL'],
        uid = json['uid'],
        email = json['email'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'photoURL': photoURL, 'uid': uid, 'email': email};
}
