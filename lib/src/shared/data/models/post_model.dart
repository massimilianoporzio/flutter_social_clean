// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_social_clean/src/shared/data/mappers/post_mapper.dart';

import '../../../services/service_locator.dart';
import '../../domain/entities/post.dart';
import 'user_model.dart';

class PostModel {
  final String id;
  final UserModel userModel; //user created the post
  final String caption;
  final String assetPath;
  PostModel({
    required this.id,
    required this.userModel,
    required this.caption,
    required this.assetPath,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userModel': userModel.toMap(),
      'caption': caption,
      'assetPath': assetPath,
    };
  }

  //dati dal json post e dallo user json
  factory PostModel.fromJson(
      Map<String, dynamic> post, Map<String, dynamic> user) {
    return PostModel(
      id: post['id'] as String,
      userModel: UserModel.fromJson(user),
      caption: post['caption'] as String,
      assetPath: post['assetPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory PostModel.fromEntity(Post post) {
    return sl<PostMapper>().fromEntity(post);
  }

  Post toEntity() {
    return sl<PostMapper>().toEntity(this);
  }
}
