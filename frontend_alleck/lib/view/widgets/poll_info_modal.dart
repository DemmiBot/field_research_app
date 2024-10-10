import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';

class PollInfoModal extends StatelessWidget {
  PollInfoModal({super.key, required this.poll});

  final Poll poll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Id: ${poll.poll_id}"),
          Text("Titulo: ${poll.name}"),
          Text("Descrição: ${poll.description}"),
          Text("Status: ${poll.status.name}"),
          Text("Quantidade de contribuintes: 9999"),          
          Text("Quantidade de respostas: 9999"),
        ],
      ),
    );
  }
}
