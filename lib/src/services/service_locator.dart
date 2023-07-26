import 'package:flutter_social_clean/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:flutter_social_clean/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_social_clean/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/get_auth_status.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/login_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/logout_user.dart';
import 'package:flutter_social_clean/src/features/auth/domain/usecases/signup_user.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_social_clean/src/features/auth/presentation/blocs/signup/signup_cubit.dart';
import 'package:flutter_social_clean/src/features/chat/data/datasources/local_chat_datasource.dart';
import 'package:flutter_social_clean/src/features/chat/data/datasources/mock_chat_datasource.dart';
import 'package:flutter_social_clean/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:flutter_social_clean/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_social_clean/src/features/chat/domain/usecases/get_chat_by_id.dart';
import 'package:flutter_social_clean/src/features/chat/domain/usecases/get_chats_by_user.dart';
import 'package:flutter_social_clean/src/features/chat/domain/usecases/update_chat.dart';
import 'package:flutter_social_clean/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:flutter_social_clean/src/features/content/domain/usecases/create_post.dart';
import 'package:flutter_social_clean/src/features/content/presentation/blocs/add_content/add_content_cubit.dart';
import 'package:flutter_social_clean/src/features/feed/data/datasources/local_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'package:flutter_social_clean/src/features/feed/data/repositories/post_repository_impl.dart';
import 'package:flutter_social_clean/src/features/feed/data/repositories/user_repository_impl.dart';
import 'package:flutter_social_clean/src/features/feed/domain/repositories/post_repository.dart';
import 'package:flutter_social_clean/src/features/feed/domain/repositories/user_repository.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/delete_post.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_posts.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_posts_by_user.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_users.dart';
import 'package:flutter_social_clean/src/features/feed/presentation/blocs/discover/discover_bloc.dart';
import 'package:flutter_social_clean/src/features/feed/presentation/blocs/feed/feed_bloc.dart';
import 'package:flutter_social_clean/src/shared/data/mappers/user_mapper.dart';
import 'package:get_it/get_it.dart';

import '../features/auth/presentation/blocs/login/login_cubit.dart';
import '../features/content/presentation/blocs/manage_content/manage_content_bloc.dart';
import '../shared/data/mappers/post_mapper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //*DATASOURCES:
  //AUTH
  sl.registerLazySingleton<MockAuthDatasource>(() => MockAuthDatasourceImpl());
  //FEED
  sl.registerLazySingleton<MockFeedDatasource>(() => MockFeedDatasourceImpl());
  sl.registerLazySingleton<LocalFeedDatasource>(
      () => LocalFeedDatasourceImpl());
  //CHAT
  sl.registerLazySingleton<LocalChatDatasource>(
      () => LocalChatDatasourceImpl());
  sl.registerLazySingleton<MockChatDatasource>(() => MockChatDatasourceImpl());

  //*REPOSITORIES:
  //AUTH:
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDatasource: sl<MockAuthDatasource>()));
  //FEED:
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      mockFeedDatasource: sl<MockFeedDatasource>(),
      localFeedDatasource: sl<LocalFeedDatasource>(),
    ),
  );
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(mockFeedDatasource: sl<MockFeedDatasource>()));

  //CHAT:
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
        localChatDatasource: sl<LocalChatDatasource>(),
        remoteChatDatasource: sl<MockChatDatasource>(),
      ));

  //*USECASES
  //AUTH:
  sl.registerLazySingleton<GetAuthStatus>(
      () => GetAuthStatus(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<GetLoggedInUser>(
      () => GetLoggedInUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<LoginUser>(
      () => LoginUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<LogoutUser>(
      () => LogoutUser(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<SignupUser>(
      () => SignupUser(authRepository: sl<AuthRepository>()));

  //FEED:
  sl.registerLazySingleton<GetPosts>(
      () => GetPosts(postRepository: sl<PostRepository>()));
  sl.registerLazySingleton<GetUsers>(
      () => GetUsers(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<GetPostsByUser>(
      () => GetPostsByUser(postRepository: sl<PostRepository>()));

  //CONTENT
  sl.registerLazySingleton<CreatePost>(
      () => CreatePost(postRepository: sl<PostRepository>()));
  sl.registerLazySingleton<DeletePost>(
      () => DeletePost(postRepository: sl<PostRepository>()));

  //CHAT
  sl.registerLazySingleton<GetChatsByUser>(
      () => GetChatsByUser(chatRepository: sl<ChatRepository>()));
  sl.registerLazySingleton<GetChatById>(
      () => GetChatById(chatRepository: sl<ChatRepository>()));
  sl.registerLazySingleton<UpdateChat>(
      () => UpdateChat(chatRepository: sl<ChatRepository>()));

  //*BLOCS / CUBITS

  //Auth SINGLETON PARLA A TUTTI GLI ALTRI BLOC E RICEVE EVENTI DA LORO
  //POSSO USARLO NEL ROUTER CON DEPENDENCY INJECTION
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(
        logoutUser: sl<LogoutUser>(),
        getAuthStatus: sl<GetAuthStatus>(),
        getLoggedInUser: sl<GetLoggedInUser>(),
      ));

  sl.registerFactory<LoginCubit>(() => LoginCubit(loginUser: sl<LoginUser>()));
  sl.registerFactory<SignupCubit>(
      () => SignupCubit(signupUser: sl<SignupUser>()));

  //FEED
  sl.registerFactory<FeedBloc>(() => FeedBloc(getPostsUsecase: sl<GetPosts>()));
  sl.registerFactory<DiscoverBloc>(
      () => DiscoverBloc(getUsers: sl<GetUsers>()));

  //CONTENT
  sl.registerFactory<AddContentCubit>(
      () => AddContentCubit(createPostUsecase: sl<CreatePost>()));
  sl.registerFactory<ManageContentBloc>(() => ManageContentBloc(
        getPostsByUser: sl<GetPostsByUser>(),
        deletePost: sl<DeletePost>(),
      ));

  //CHAT
  sl.registerFactory<ChatListBloc>(
      () => ChatListBloc(getChatsByUser: sl<GetChatsByUser>()));

  //*MAPPERS
  sl.registerLazySingleton<UserMapper>(() => UserMapper());
  sl.registerLazySingleton<PostMapper>(() => PostMapper());
}
