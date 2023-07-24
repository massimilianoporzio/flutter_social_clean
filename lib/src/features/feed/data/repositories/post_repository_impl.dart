// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/data/datasources/local_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/logs/repository_logger.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/post.dart';

class PostRepositoryImpl with RepositoryLoggy implements PostRepository {
  final MockFeedDatasource mockFeedDatasource; // remote datasource
  final LocalFeedDatasource localFeedDatasource;
  PostRepositoryImpl({
    required this.mockFeedDatasource,
    required this.localFeedDatasource,
  });
  @override
  Future<List<Post>> getPosts() async {
    //TODO: check internet connection. Get from databse
    //if not get from loacl Hive the first Time then from hive
    if ((await localFeedDatasource.getPosts()).isEmpty) {
      //NON LI HO IN CACHE
      List<Post> posts = await mockFeedDatasource.getPosts();
      for (final post in posts) {
        localFeedDatasource.addPost(post); //serve await?
      }
      return posts;
    } else {
      loggy.debug("GET POSTS from CACHE (Hive)");
      return localFeedDatasource.getPosts();
    }
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    if ((await localFeedDatasource.getPostsByUser(userId)).isEmpty) {
      List<Post> posts = await mockFeedDatasource.getPostsByUser(userId);
      for (final post in posts) {
        localFeedDatasource.addPost(post); //li aggiungo in cache
      }
      return posts;
    } else {
      loggy.debug("GET POSTS By USER from CACHE (Hive)");
      return localFeedDatasource.getPostsByUser(userId);
    }
  }

  @override
  Future<void> createPost(Post post) {
    return localFeedDatasource.addPost(post); //SALVIAMO IN LOCALE
  }

  @override
  Future<void> deletePostById(String postId) {
    //TODO: delete from local and/or from remote datasource
    return localFeedDatasource.deletePostById(postId);
  }
}
