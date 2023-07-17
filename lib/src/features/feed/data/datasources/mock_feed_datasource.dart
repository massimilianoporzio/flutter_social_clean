import 'package:flutter_social_clean/src/shared/data/datasources/post_data.dart';
import 'package:flutter_social_clean/src/shared/data/datasources/user_data.dart';
import 'package:flutter_social_clean/src/shared/data/models/post_model.dart';

import '../../../../shared/domain/entities/post.dart';

abstract class MockFeedDatasource {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
}

class MockFeedDatasourceImpl implements MockFeedDatasource {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {},
    );
    return posts.map((post) {
      Map<String, dynamic> user =
          users.firstWhere((user) => user['id'] == post['userId']);
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {},
    );
    return posts
        .where(
      (element) => element['userId'] == userId,
    )
        .map((post) {
      Map<String, dynamic> user =
          users.firstWhere((user) => user['id'] == post['userId']);
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }
}
