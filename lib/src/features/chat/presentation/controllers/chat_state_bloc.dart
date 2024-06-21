import 'package:equatable/equatable.dart';
import 'package:intellichat/src/features/chat/domain/entities/message_entity.dart';

// ignore: must_be_immutable
class ChatState extends Equatable {
  ChatState({
    List<MessageEntity>? msgs,
    bool? isLoading,
  })  : messages = msgs ?? const [],
        isLoading = isLoading ?? false;

  List<MessageEntity> messages;
  bool isLoading;

  @override
  List<Object?> get props => [messages];

  ChatState copyWith({List<MessageEntity>? messages, bool? isLoading}) {
    return ChatState(
      msgs: messages,
      isLoading: isLoading,
    );
  }
}
