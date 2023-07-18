// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_social_clean/src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/domain/repositories/user_repository.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  final MockFeedDatasource mockFeedDatasource;
  UserRepositoryImpl({
    required this.mockFeedDatasource,
  });
  @override
  Future<User> getUser(String userId) {
    return mockFeedDatasource.getUser(userId);
  }

  @override
  Future<List<User>> getUsers() {
    return mockFeedDatasource.getUsers();
  }
}
