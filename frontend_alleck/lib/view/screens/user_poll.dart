import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';

class UserPoll extends StatefulWidget {
  const UserPoll({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<StatefulWidget> createState() {
    return _UserPoll();
  }
}

class _UserPoll extends State<UserPoll> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("widget.options."),
    );
  }
}