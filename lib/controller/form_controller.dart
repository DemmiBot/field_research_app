import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:fieldresearch/views/adm_views/create_form_view/widgets/type_data/default_type.dart';
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
        contentsWhenEmpty: const Text(''),
        header: const Divider(),
        children: sectionItems.last,
      );

      // Adiciona a nova seção à lista de seções
      typeDataForm.add(sectionList);
    } else {
      // Adiciona um novo item à última seção criada, se houver alguma
      if (sectionItems.isNotEmpty) {
        identity++;
        sectionItems.last.add(
          DragAndDropItem(
            child: DefaultType(
              identity: identity,
            ),
          ),
        );
      }
      notifyListeners();
    }
  }
}

// TO DO

// -state keep the same after drag and drop 'tipo de dado'
// - 1º map order 
// -add type "gender"
// -resolve bug add list (final)

