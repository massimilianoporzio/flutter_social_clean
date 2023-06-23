import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final int followers;
  final int followings;
  final String? imagePath;

  const UserModel({
    required this.id,
    required this.username,
    this.followers = 0,
    this.followings = 0,
    this.imagePath,
  });

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

  @override
  bool? get stringify => true;

  UserModel copyWith({
    String? id,
    String? username,
    int? followers,
    int? followings,
    String? imagePath,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'username': username});
    result.addAll({'followers': followers});
    result.addAll({'followings': followings});
    if (imagePath != null) {
      result.addAll({'imagePath': imagePath});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'],
      followers: json['followers']?.toInt() ?? 0,
      followings: json['followings']?.toInt() ?? 0,
      imagePath: json['imagePath'],
    );
  }
  factory UserModel.fromEntity(User user) {
    return UserModel(
        id: user.id,
        username: user.username.value,
        followers: user.followers,
        followings: user.followings,
        imagePath: user.imagePath);
  }

  String toJson() => json.encode(toMap());
  User toEntity() => User(
        id: id,
        username: Username.dirty(username),
        imagePath: imagePath,
        followers: followers,
        followings: followings,
      );
}
