class AccountData {
  final String name;
  final String photoURL;
  final String uid;
  

  AccountData({
    required this.name,
    required this.photoURL,
    required this.uid
  });

  AccountData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photoURL = json['photoURL'],
        uid = json['uid']
        ;

  Map<String, dynamic> toJson() => {
        'name': name,
        'photoURL': photoURL,
        'uid': uid
      };
}