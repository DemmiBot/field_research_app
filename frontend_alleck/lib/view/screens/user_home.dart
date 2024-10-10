import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/view/widgets/poll_list_item.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UserHome();
  }
}

class _UserHome extends State<UserHome> {
  final username = "Alleck";
  final orgname = "PesquisasAlleck";
  final Poll poll1= new Poll(
    poll_id: "1",
    name: "Poll1 and the purpose of poll 1 is to make sure table 1 gets everything it needs to work :D",
    description: "This is poll 1, and the purpose of poll 1 is to make sure table 1 gets everithing",
    status: Status.closed,
    questions: [Question(id: "1", label: "What is poll", poll_id: "1", questionType: QuestionType.string)]
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bem vindo, ${username}!"),
              Text("$orgname"),
              Divider(height: 2,),
              PollListItem(poll: poll1),
              PollListItem(poll: poll1),

            ],
          ),
        ),
      ),
    );
  }
}