// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<Post> posts;
  const FeedLoaded({
    this.posts =
        const <Post>[], //inizializzo con lista vuota e lo uso come stato iniziale
  });

  @override
  List<Object> get props => [posts];
}
