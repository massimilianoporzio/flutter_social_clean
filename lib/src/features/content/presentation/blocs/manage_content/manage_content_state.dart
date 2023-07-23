// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'manage_content_bloc.dart';

abstract class ManageContentState extends Equatable {
  const ManageContentState();

  @override
  List<Object> get props => [];
}

class ManageContentLoading extends ManageContentState {}

class ManageContentLoaded extends ManageContentState {
  final List<Post> posts;
  const ManageContentLoaded({
    this.posts = const <Post>[], //lista vuota iniziale ma sempre presente
  });

  @override
  List<Object> get props => [posts];
}
