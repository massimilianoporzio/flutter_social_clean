import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User extends Equatable {
  final String id;
  final String username;
  final int followers;
  final int followings;
  final String? imagePath;
  const User({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

  static const empty = User(id: "user_0", username: "-");

  @override
  List<Object?> get props {
    return [
      id,
      username,
      followers,
      followings,
      imagePath,
    ];
  }
}
