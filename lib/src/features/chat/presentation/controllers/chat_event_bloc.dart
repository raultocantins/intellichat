/// Event being processed by [CounterBloc].
abstract class ChatEvent {}

/// Notifies bloc to increment state.
class SendMessage extends ChatEvent {
  final String question;
  SendMessage(this.question);
}
