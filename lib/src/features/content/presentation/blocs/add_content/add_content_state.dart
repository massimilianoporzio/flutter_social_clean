// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_content_cubit.dart';

enum AddContentStatus {
  initial,
  loading,
  success,
  error,
}

class AddContentState extends Equatable {
  final File? video;
  final String caption;
  final AddContentStatus status;
  const AddContentState({
    this.video,
    required this.caption,
    required this.status,
  });

  @override
  List<Object?> get props => [video, caption, status];

  factory AddContentState.initial() {
    return const AddContentState(
      caption: "",
      status: AddContentStatus.initial,
    );
  }

  AddContentState copyWith({
    File? video,
    String? caption,
    AddContentStatus? status,
  }) {
    return AddContentState(
      video: video ?? this.video,
      caption: caption ?? this.caption,
      status: status ?? this.status,
    );
  }
}
