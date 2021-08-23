import 'dart:convert';

class UserInfoModel {
  final String? uid;
  final String? name;
  final String? email;
  final bool? isVerified;
  final String? phone;
  final String? userImg;

  UserInfoModel({this.uid, this.name, this.email, this.isVerified, this.phone, this.userImg});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      "verify": isVerified,
      "number": phone,
      'image': userImg,
    };
  }
}

class Demo {
  final String? uid;
  final String? name;
  final String? email;

  Demo({this.uid, this.name, this.email});

  Demo copyWith({String? uid, String? name, String? email}) {
    return Demo(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  factory Demo.fromMap(Map<String, dynamic> map) {
    return Demo(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Demo.fromJson(String source) => Demo.fromMap(json.decode(source));

  @override
  String toString() => 'Demo(uid: $uid, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Demo && other.uid == uid && other.name == name && other.email == email;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ email.hashCode;
}
