import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart' as customList;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';

class NewFormScreen extends ConsumerStatefulWidget {  // Changed to ConsumerStatefulWidget
  @override
  _NewFormScreenState createState() => _NewFormScreenState();
}

class _NewFormScreenState extends ConsumerState<NewFormScreen> {
  List<Question> currentQuestions = [];
  String formTitle = '';
  String formDescription = '';
  String formStatus = 'OPEN'; // Default to 'OPEN'

  // Function to open modal
  void _openAddFieldModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.count(
          crossAxisCount: 2,
          children: [
            _buildFieldIcon('Text Field', Icons.text_fields, 'text'),
            _buildFieldIcon('Integer Field', Icons.format_list_numbered, 'numerical'),
            _buildFieldIcon('Dropdown Field (Enum)', Icons.arrow_drop_down, 'enum'),
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

  // Function to handle form creation (post request)
  Future<void> _createForm() async {
    final apiClient = ref.read(apiClientProvider);
    
    final data = {
      'title': formTitle,
      'description': formDescription,
      'status': formStatus, // OPEN or CLOSED
      'questions': currentQuestions.map((q) => {
        'text': q.text,
        'type': q.type,
        // 'enumValues': q.enumValues, // Uncomment once API supports enum values
      }).toList(),
    };

    try {
      final response = await apiClient.post('polls', data);
      print('Form created successfully: $response');
      Navigator.pop(context);
    } catch (e) {
      print('Failed to create form: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Form'),
      ),
      body: Column(
        children: [
          // Title TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Form Title'),
              onChanged: (value) {
                setState(() {
                  formTitle = value;
                });
              },
            ),
          ),
          // Description TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: 'Form Description'),
              onChanged: (value) {
                setState(() {
                  formDescription = value;
                });
              },
            ),
          ),
          // Status Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Form Status'),
              value: formStatus,
              items: [
                DropdownMenuItem(value: 'OPEN', child: Text('Open')),
                DropdownMenuItem(value: 'CLOSED', child: Text('Closed')),
              ],
              onChanged: (value) {
                setState(() {
                  formStatus = value!;
                });
              },
            ),
          ),
          // Draggable List of current questions using flutter_reorderable_list
          Expanded(
            child: customList.ReorderableList(
              onReorder: this._onReorder,
              onReorderDone: this._onReorderDone,
              child: ListView.builder(
                itemCount: currentQuestions.length,
                itemBuilder: (context, index) {
                  Question question = currentQuestions[index];

                  // Render enum-specific widget if the type is 'enum'
                  if (question.type == 'enum') {
                    return customList.ReorderableItem(
                      key: ValueKey(question),
                      childBuilder: (BuildContext context, customList.ReorderableItemState state) {
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Field '${removedQuestion.text}' dismissed"),
                              action: SnackBarAction(
                                label: "Undo",
                                onPressed: () {
                                  setState(() {
                                    currentQuestions.insert(index, removedQuestion);
                                  });
                                },
                              ),
                            ));
                          },
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
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
                                SizedBox(height: 10),
                                TextFormField(
                                  initialValue: '', // Initially empty
                                  decoration: InputDecoration(
                                    hintText: 'Enter comma-separated enum values',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      // question.enumValues = value.split(',').map((e) => e.trim()).toList();
                                    });
                                  },
                                ),
                              ],
                            ),
                            trailing: customList.ReorderableListener(
                              child: Icon(Icons.drag_handle), // Drag handle for reordering
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    // Render other field types (text, numerical) as usual
                    return customList.ReorderableItem(
                      key: ValueKey(question),
                      childBuilder: (BuildContext context, customList.ReorderableItemState state) {
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

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Field '${removedQuestion.text}' dismissed"),
                              action: SnackBarAction(
                                label: "Undo",
                                onPressed: () {
                                  setState(() {
                                    currentQuestions.insert(index, removedQuestion);
                                  });
                                },
                              ),
                            ));
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
                              child: Icon(Icons.drag_handle), // Drag handle for reordering
                            ),
                          ),
                        );
                      },
                    );
                  }
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
                  onPressed: _createForm,
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
    final oldIndex = currentQuestions.indexWhere((question) => ValueKey(question) == item);
    final newIndex = currentQuestions.indexWhere((question) => ValueKey(question) == newPosition);

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