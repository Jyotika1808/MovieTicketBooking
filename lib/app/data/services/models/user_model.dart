class UserModel {
  final String uId;
  final String name;
  final String email;
  // final String profilePic;
  // final String gender;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    // required this.profilePic,
    // required this.gender,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uId': uId,
      'name': name,
      'email': email,
      // 'profilePic': profilePic,
      // 'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      // profilePic: map['profilePic'] as String,
      // gender: map['gender'] as String,
    );
  }
}
