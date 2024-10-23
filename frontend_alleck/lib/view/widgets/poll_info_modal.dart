import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/model/user.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';
import 'package:frontend_alleck/providers/authentication_provider.dart';
import 'package:path_provider/path_provider.dart';

class PollInfoModal extends ConsumerStatefulWidget {
  PollInfoModal({super.key, required this.poll});
  final Poll poll;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PollInfoModal();
}

class _PollInfoModal extends ConsumerState<PollInfoModal> {
  Future<void> _downloadPoll(String pollId) async {
    final apiClient = ref.read(apiClientProvider);

    try {
      // Define the URL for the CSV export endpoint

      // Send a GET request to download the CSV
      var response = await apiClient.get('entries/export/' + '$pollId');

      // Get the directory to save the file
      final directory = await getApplicationDocumentsDirectory();

      // Define the file path
      final filePath = '${directory.path}/entries_$pollId.csv';

      // Write the file
      File file = File(filePath);
      await file.writeAsString(response);

      print('CSV downloaded and saved to $filePath');
      Navigator.pop(context);
    } catch (e) {
      print('Error occurred while downloading CSV: $e');
    }
  }

  void _deletePoll(String pollId) async {
    final apiClient = ref.read(apiClientProvider);

    try {
      var response = await apiClient.delete('polls/' + '$pollId');
      print("Success deleting poll!");
      Navigator.pop(context);
    } catch (e) {
      print('Error occurred while deleting poll: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not delete: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Id: ${widget.poll.pollId}"),
          Text("Titulo: ${widget.poll.title}"),
          Text("Descrição: ${widget.poll.description}"),
          Text("Status: ${widget.poll.status}"),
          Text("Quantidade de respostas: ${widget.poll.entryCount}"),
          if (user?.role == UserRole.ADMIN)
            FilledButton(
              onPressed: () {
                _downloadPoll(widget.poll.pollId.toString());
              },
              child: Text("Baixar CSV"),
            ),
          if (user?.role == UserRole.ADMIN)
            FilledButton(
              onPressed: () {
                _deletePoll(widget.poll.pollId.toString());
              },
              child: Text("Deletar"),
            ),
        ],
      ),
    );
  }
}
