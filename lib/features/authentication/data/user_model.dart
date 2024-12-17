import 'package:cloud_firestore/cloud_firestore.dart';

enum UserType {
  user("user"),
  guest("guest"),
  support("support"),
  admin("admin");

  const UserType(String value);
}

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? profileImage;
  final String? phoneNumber;
  final String? address;
  final DateTime? createdAt;
  final List<String>? orderHistory; // List of order IDs
  final List<String>? favList; // List of favList IDs
  final UserType userType;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.profileImage,
    this.phoneNumber,
    this.address,
    this.createdAt,
    this.orderHistory,
    this.favList,
    this.userType = UserType.user,
  });

  // Factory method for creating a UserModel from JSON (e.g., when fetching from API or database)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profileImage: json['profileImage'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
      orderHistory: json['orderHistory'] != null
          ? List<String>.from(json['orderHistory'])
          : null,
      favList:
          json['favList'] != null ? List<String>.from(json['favList']) : null,
      userType: UserType.values.firstWhere(
        (e) => e.name == json['userType'],
        orElse: () => UserType.guest,
      ),
    );
  }

  // Convert UserModel to JSON (e.g., for storing in a database or sending over API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': createdAt?.toUtc(),
      'orderHistory': orderHistory,
      'favList': favList,
      'userType': userType.name,
    };
  }

  // CopyWith method to create a new UserModel with modified fields
  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? profileImage,
    String? phoneNumber,
    String? address,
    DateTime? createdAt,
    List<String>? orderHistory,
    List<String>? favList,
    UserType? userType,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      orderHistory: orderHistory ?? this.orderHistory,
      favList: favList ?? this.favList,
      userType: userType ?? this.userType,
    );
  }

  // Override toString method for printing UserModel in a readable format
  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, email: $email, profileImage: $profileImage, '
        'phoneNumber: $phoneNumber, address: $address, createdAt: $createdAt, '
        'orderHistory: $orderHistory, favList: $favList, userType: $userType}';
  }
}
