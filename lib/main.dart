import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/controllers/chat_bloc.dart';
import 'package:intellichat/src/features/chat/presentation/views/chart_view.dart';
import 'package:intellichat/src/shared/repositories/artificial_intelligence/gemini/gemini_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          // colorScheme: const ColorScheme.dark(
          //   primary: Color(0XFF333333),
          // ),
          useMaterial3: true),
      home: BlocProvider(
        create: (context) => ChatBloc(GeminiAi()),
        child: const ChatView(),
      ),
    );
  }
}
