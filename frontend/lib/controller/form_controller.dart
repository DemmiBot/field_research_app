import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:fieldresearch/screens/widgets/type_data/default_type.dart';
import 'package:flutter/material.dart';

class FormController extends ChangeNotifier {
  List<DragAndDropList> typeDataForm = [];
  List<List<DragAndDropItem>> sectionItems = [];
  int identity = 0;

  void addType(bool isSection) {
    if (isSection) {
      // Adiciona uma nova lista vazia para os itens da próxima seção
      sectionItems.add([]);

      // Adiciona uma nova seção
      var sectionList = DragAndDropList(
        canDrag: false,
        contentsWhenEmpty: const Text(''),
        header: const Divider(),
        children: sectionItems.last,
      );

      // Adiciona a nova seção à lista de seções
      typeDataForm.add(sectionList);
    } else {
      identity++;
      // Adiciona um novo item à última seção criada, se houver alguma
      sectionItems.last.add(
        DragAndDropItem(
          canDrag: false,
          child: DefaultType(
            identity: identity,
          ),
        ),
      );
    }
    notifyListeners();
  }

  List<TypeState> typeState = [
    TypeState(intType: false, listType: false, textType: false)
  ];
  void changeType(value) {}
}

class TypeState {
  late bool intType;
  late bool textType;
  late bool listType;
  TypeState(
      {required this.intType, required this.listType, required this.textType});
}
// TO DO

// -state keep the same after drag and drop 'tipo de dado'
// - 1º map order 
// -add type "gender"
// -resolve bug add list (final)

