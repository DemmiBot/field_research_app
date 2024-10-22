import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart'
    as customList;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';

class NewFormScreen extends ConsumerStatefulWidget {
  @override
  _NewFormScreenState createState() => _NewFormScreenState();
}

class _NewFormScreenState extends ConsumerState<NewFormScreen> {
  List<Question> currentQuestions = [];
  String formTitle = '';
  String formDescription = '';
  String formStatus = 'OPEN'; // Default to 'OPEN'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Form'),
      ),
      body: Column(
        children: [
          _buildTextField('Form Title', (value) => formTitle = value),
          _buildTextField(
              'Form Description', (value) => formDescription = value),
          _buildStatusDropdown(),
          _buildQuestionsList(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        onChanged: (value) {
          setState(() => onChanged(value));
        },
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Padding(
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
    );
  }

  Widget _buildQuestionsList() {
    return Expanded(
      child: customList.ReorderableList(
        onReorder: _onReorder,
        onReorderDone: _onReorderDone,
        child: ListView.builder(
          itemCount: currentQuestions.length,
          itemBuilder: (context, index) {
            return _buildQuestionItem(currentQuestions[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildQuestionItem(Question question, int index) {
    return customList.ReorderableItem(
      key: ValueKey(question),
      childBuilder:
          (BuildContext context, customList.ReorderableItemState state) {
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
            _dismissQuestion(index);
          },
          child: ListTile(
            title: _buildQuestionInput(question),
            trailing: customList.ReorderableListener(
              child: Icon(Icons.drag_handle), // Drag handle for reordering
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionInput(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: question.label,
          decoration: InputDecoration(hintText: 'Enter question label'),
          onChanged: (value) => setState(() => question.label = value),
        ),
        SizedBox(height: 10),
        if (question.type == 'LIST')
          TextFormField(
            initialValue: '', // Initially empty
            decoration:
                InputDecoration(hintText: 'Enter comma-separated enum values'),
            onChanged: (value) {
              setState(() {
                question.listValues =
                    value.split(',').map((e) => e.trim()).toList();
              });
            },
          ),
        if (question.type == 'NUMBER')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Min Value'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      question.min = value;
                    });
                  },
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Max Value'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      question.max = value;
                    });
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
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
    );
  }

  void _dismissQuestion(int index) {
    final removedQuestion = currentQuestions[index];
    setState(() {
      currentQuestions.removeAt(index);
    });

    // Show SnackBar with undo option
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Field '${removedQuestion.label}' dismissed"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            currentQuestions.insert(index, removedQuestion);
          });
        },
      ),
    ));
  }

  // Function to handle reorder
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

  void _onReorderDone(Key item) {
    print("Reordering complete");
  }

  void _openAddFieldModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GridView.count(
          crossAxisCount: 2,
          children: [
            _buildFieldIcon('Text Field', Icons.text_fields, 'TEXT'),
            _buildFieldIcon(
                'Integer Field', Icons.format_list_numbered, 'NUMBER'),
            _buildFieldIcon(
                'Dropdown Field (Enum)', Icons.arrow_drop_down, 'LIST'),
          ],
        );
      },
    );
  }

  Widget _buildFieldIcon(String label, IconData icon, String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentQuestions.add(Question(label: '', type: type));
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

  Future<void> _createForm() async {
    final apiClient = ref.read(apiClientProvider);
    final data = {
      'title': formTitle,
      'description': formDescription,
      'status': formStatus, // OPEN or CLOSED
      'questions': currentQuestions
          .map((q) => {
                'label': q.label,
                'type': q.type,
                'listValues': q.listValues != null ? q.listValues!.join(',') : null,
                'min': q.min,
                'max': q.max
              })
          .toList(),
    };

    try {
      final response = await apiClient.post('polls', data);
      print('Form created successfully: $response');
      Navigator.pop(context);
    } catch (e) {
      print('Failed to create form: $e');
    }
  }
}
