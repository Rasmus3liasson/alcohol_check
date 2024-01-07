class AccountData {
  final String name;
  final String photoURL;

  AccountData({
    required this.name,
    required this.photoURL,
  });

  AccountData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        photoURL = json['photoURL'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'photoURL': photoURL,
      };
}