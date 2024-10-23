import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/view/screens/dynamic_form.dart';
import 'package:frontend_alleck/view/widgets/poll_info_modal.dart';

class PollListItem extends StatelessWidget {
  const PollListItem({super.key, required this.poll});

  final Poll poll;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          if(poll.status != "CLOSED")
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DynamicForm(fields: poll.questions, poll: poll,),
              ),
            );
        },
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(poll.title), //Nome da Poll
                    Container(
                      height: 20,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: poll.status == "CLOSED"
                                    ? Colors.red
                                    : Colors.green,
                                shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(poll.status == "CLOSED" ? "Fechado" : "Aberto"),
                          VerticalDivider(
                            thickness: 2,
                          ),
                          Text(
                            poll.entryCount > 1 ? poll.entryCount.toString() + ' Respostas' : poll.entryCount.toString() + ' Resposta',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => PollInfoModal(
                    poll: poll,
                  ),
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
