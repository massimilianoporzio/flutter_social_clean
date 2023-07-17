import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/feed/domain/usecases/get_posts.dart';
import 'package:flutter_social_clean/src/logs/bloc_logger.dart';
import 'package:flutter_social_clean/src/shared/domain/entities/post.dart';
import 'package:flutter_social_clean/src/shared/domain/usecases/usecases.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> with BlocLoggy {
  //usecases
  final GetPosts _getPosts;
  FeedBloc({required GetPosts getPostsUsecase})
      : _getPosts = getPostsUsecase,
        super(FeedLoading()) {
    on<FeedGetPosts>(_onFeedGetPosts);
  }

  FutureOr<void> _onFeedGetPosts(
      FeedGetPosts event, Emitter<FeedState> emit) async {
    loggy.debug('Start getting posts with');
    List<Post> posts = await _getPosts(NoParams());
    emit(FeedLoaded(posts: posts));
  }
}
