// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  final List<User> users;
  const DiscoverLoaded({
    this.users = const <User>[], //lista vuota se non passo
  });

  @override
  List<Object> get props => [users];
}
