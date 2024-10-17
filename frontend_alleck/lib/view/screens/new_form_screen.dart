import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart'
    as customList;

class NewFormScreen extends StatefulWidget {
  @override
  _NewFormScreenState createState() => _NewFormScreenState();
}

class _NewFormScreenState extends State<NewFormScreen> {
  List<Question> currentQuestions = [];

  // Function to open modal
  void _openAddFieldModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.count(
          crossAxisCount: 2,
          children: [
            _buildFieldIcon('Text Field', Icons.text_fields, 'text'),
            _buildFieldIcon(
                'Integer Field', Icons.format_list_numbered, 'integer'),
            _buildFieldIcon('Dropdown Field', Icons.arrow_drop_down, 'enum'),
          ],
        );
      },
    );
  }

  // Function to build icons for field types in the modal
  Widget _buildFieldIcon(String label, IconData icon, String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentQuestions.add(Question(text: '', type: type));
        });
        Navigator.pop(context); // Close the modal
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Form'),
      ),
      body: Column(
        children: [
          // Draggable List of current questions using flutter_reorderable_list
          Expanded(
            child: customList.ReorderableList(
              onReorder: this._onReorder,
              onReorderDone: this._onReorderDone,
              child: ListView.builder(
                itemCount: currentQuestions.length,
                itemBuilder: (context, index) {
                  Question question = currentQuestions[index];

                  return customList.ReorderableItem(
                    key: ValueKey(
                        question), // Use the object itself as a unique key
                    childBuilder: (BuildContext context,
                        customList.ReorderableItemState state) {
                      return Dismissible(
                        key: ValueKey(question),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          final removedQuestion = currentQuestions[index];
                          setState(() {
                            currentQuestions.removeAt(index);
                          });

                          // Show SnackBar with undo option
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Field '${removedQuestion.text}' dismissed"),
                              action: SnackBarAction(
                                label: "Undo",
                                onPressed: () {
                                  setState(
                                    () {
                                      currentQuestions.insert(
                                          index, removedQuestion);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                            title: TextFormField(
                              initialValue: question.text,
                              decoration: InputDecoration(
                                hintText: 'Enter question label',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  question.text = value;
                                });
                              },
                            ),
                            trailing: customList.ReorderableListener(
                              child: Icon(Icons.drag_handle),
                            ) // This is the drag handle
                            ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          // Buttons at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _openAddFieldModal,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 5),
                      Text('Add Field'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle form creation logic here
                    print(currentQuestions); // Display questions for now
                  },
                  child: Text('Create Form'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Handle reorder with correct callback signature
  bool _onReorder(Key item, Key newPosition) {
    final oldIndex =
        currentQuestions.indexWhere((question) => ValueKey(question) == item);
    final newIndex = currentQuestions
        .indexWhere((question) => ValueKey(question) == newPosition);

    if (oldIndex != -1 && newIndex != -1) {
      setState(() {
        final item = currentQuestions.removeAt(oldIndex);
        currentQuestions.insert(newIndex, item);
      });
      return true;
    }
    return false;
  }

  // Reorder done callback
  void _onReorderDone(Key item) {
    print("Reordering complete");
  }
}
