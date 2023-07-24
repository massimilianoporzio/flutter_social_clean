// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/user.dart';
import 'message.dart';

class Chat extends Equatable {
  final String id; //uuid della chat
  final User currentUser; //utente corrente
  final User otherUser; //altro utente a cui scrivo
  final List<Message>? messages; //eventuali messaggi
  const Chat({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages,
  });

  @override
  List<Object?> get props => [
        id,
        currentUser,
        otherUser,
        messages,
      ];
  //* ogni volta che ho un nuovo messaggio voglio AGGIORNARE la chat
  //* cambiando la lista dei messaggi quindi creerç NUOVA chat che metterò
  //* nello stato del BLOC che verrà riflesso dalla UI
  Chat copyWith({
    String? id,
    User? currentUser,
    User? otherUser,
    List<Message>? messages,
  }) {
    return Chat(
      id: id ?? this.id,
      currentUser: currentUser ?? this.currentUser,
      otherUser: otherUser ?? this.otherUser,
      messages: messages ?? this.messages,
    );
  }
}
