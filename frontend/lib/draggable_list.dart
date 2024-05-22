// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final List<String> _types = ['text', 'int', 'enum'];
  List<_FieldData> _fieldDataList = [];

  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedType,
            items: _types.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedType = newValue;
              });
            },
            decoration: const InputDecoration(labelText: 'Select Type'),
          ),
          Expanded(
            child: DraggableList(
              fieldDataList: _fieldDataList,
              onFieldDataListChanged: (List<_FieldData> newDataList) {
                setState(() {
                  _fieldDataList = newDataList;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedType != null) {
                setState(() {
                  _fieldDataList.add(_FieldData(
                    type: _selectedType!,
                    key: UniqueKey(),
                    child: Text(
                      '${_selectedType!.toUpperCase()} Widget',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ));
                });
              }
            },
            child: const Text('Add Field'),
          ),
        ],
      ),
    );
  }
}

class DraggableList extends StatefulWidget {
  final List<_FieldData> fieldDataList;
  final Function(List<_FieldData>) onFieldDataListChanged;

  DraggableList({
    required this.fieldDataList,
    required this.onFieldDataListChanged,
  }) : super(key: UniqueKey());

  @override
  _DraggableListState createState() => _DraggableListState();
}

class _DraggableListState extends State<DraggableList> {
  late List<_FieldData> _fieldDataList;

  @override
  void initState() {
    super.initState();
    _fieldDataList = List.from(widget.fieldDataList);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _fieldDataList.removeAt(oldIndex);
          _fieldDataList.insert(newIndex, item);
          widget.onFieldDataListChanged(_fieldDataList);
        });
      },
      children: _fieldDataList
          .map(
            (fieldData) => ListTile(
              key: fieldData.key,
              title: fieldData.child,
            ),
          )
          .toList(),
    );
  }
}

class _FieldData {
  final String type;
  final Key key;
  final Widget child;

  _FieldData({
    required this.type,
    required this.key,
    required this.child,
  });
}
