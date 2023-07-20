import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';
import 'package:hive/hive.dart';

import '../../../services/service_locator.dart';
import '../mappers/user_mapper.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final int followers;
  @HiveField(03)
  final int followings;
  @HiveField(4)
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'],
      followers: json['followers']?.toInt() ?? 0,
      followings: json['followings']?.toInt() ?? 0,
      imagePath: json['imagePath'],
    );
  }
  factory UserModel.fromEntity(User user) {
    return sl<UserMapper>().fromEntity(user);
  }

  String toJson() => json.encode(toMap());
  User toEntity() => sl<UserMapper>().toEntity(this);
}
