// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/post.dart';

class PostRepositoryImpl implements PostRepository {
  final MockFeedDatasource mockFeedDatasource; // remote datasource
  //TODO add also a local datasource using Hive
  PostRepositoryImpl({
    required this.mockFeedDatasource,
  });
  @override
  Future<List<Post>> getPosts() {
    return mockFeedDatasource.getPosts();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) {
    return mockFeedDatasource.getPostsByUser(userId);
  }
}
