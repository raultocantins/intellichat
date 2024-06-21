import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/src/features/chat/domain/entities/message_entity.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_event_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_state_bloc.dart';
import 'package:intellichat/src/shared/repositories/artificial_intelligence/artificial_intelligente.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ArtificialIntelligence _repository;

  ChatBloc(this._repository) : super((ChatState())) {
    on<SendMessage>(_sendMessage);
  }

  _sendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          messages: [
            ...state.messages,
            MessageEntity(isQuestionMy: true, text: event.question),
          ],
        ),
      );
      final responseAi = await _repository.sendMessage(event.question);
      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            MessageEntity(isQuestionMy: false, text: responseAi ?? ''),
          ],
          isLoading: false,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(isLoading: false),
      );
    }
  }
}
