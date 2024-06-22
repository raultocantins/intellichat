import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_event_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_state_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/views/widgets/render_chat_widget.dart';

import 'package:lottie/lottie.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _listController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      return BlocListener<ChatBloc, ChatState>(
        listener: (context, state) => {
          if (state.messages.length > 1)
            {
              _listController.animateTo(
                _listController.position.maxScrollExtent + 100,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              )
            }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            forceMaterialTransparency: true,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dashboard),
            ),
            title: const Text('IntelliChat +'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              if (state.isLoading) const LinearProgressIndicator(),
              Expanded(
                child: state.messages.isEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: SizedBox(
                                height: 150,
                                child: Lottie.asset(
                                    'assets/animations/gemini.json'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => context.read<ChatBloc>().add(
                                          SendMessage(
                                              'Escreva um script em Python'),
                                        ),
                                    child: const Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Escreva um script em Python',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                                'automatizando relatórios diários'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => context.read<ChatBloc>().add(
                                          SendMessage(
                                              'Quero ajuda para estudar'),
                                        ),
                                    child: const Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Quero ajuda para estudar',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text('vocabulário para uma prova'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        controller: _listController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, i) => RenderChatWidget(
                          messageEntity: state.messages[i],
                        ),
                      ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera),
                  ),
                  Expanded(
                    child: TextSelectionTheme(
                      data: const TextSelectionThemeData(
                        cursorColor: Colors.white,
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent.withOpacity(0.2),
                          border: InputBorder.none,
                          hintText: 'Mensagem',
                        ),
                        keyboardType: TextInputType.text,
                        onSubmitted: (v) {
                          if (v.isNotEmpty) {
                            context.read<ChatBloc>().add(SendMessage(v));
                            if (state.messages.length > 1) {
                              _listController.animateTo(
                                _listController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            }
                          }
                          _searchController.clear();
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
