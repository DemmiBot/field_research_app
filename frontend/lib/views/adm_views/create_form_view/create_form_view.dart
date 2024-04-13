import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:fieldresearch/controller/form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DragAndDropList> sections = [];
  int index = 0;
  @override
  void initState() {
    context.read<FormController>().typeDataForm = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Consumer<FormController>(
        builder:
            (BuildContext context, FormController controller, Widget? child) =>
                Scaffold(
          body: FormBuilder(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 26.h),
                    Text('Nome da pesquisa...',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                    const Divider(),
                    SizedBox(height: 40.w),
                    Expanded(
                      child: Center(
                        child: DragAndDropLists(
                          children: controller.typeDataForm,
                          onItemReorder: _onItemReorder,
                          onListReorder: _onListReorder,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed: () {
                              controller.addType(true);
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            style: const ButtonStyle(),
                            onPressed: () {
                              setState(() {
                                index++;
                                controller.addType(false);
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            _formKey.currentState?.save();
                            var value = _formKey.currentState!.value;

                            print(value);
                          },
                          child: const Text('Save and Read')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Expanded(
  //                     child: ListView.builder(
  //                       itemCount: sections,
  //                       itemBuilder: (context, index) {
  //                         return const SectionData();
  //                       },
  //                     ),
  //                   ),

  // _onItemReorder(
  //     int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
  //   setState(() {
  //     var movedItem = (context)
  //         .read<FormController>()
  //         .typeDataForm[oldListIndex]
  //         .children
  //         .removeAt(oldItemIndex);
  //     (context)
  //         .read<FormController>()
  //         .typeDataForm[newListIndex]
  //         .children
  //         .insert(newItemIndex, movedItem);
  //   });
  // }

  // _onListReorder(int oldListIndex, int newListIndex) {
  //   setState(() {
  //     var movedList =
  //         (context).read<FormController>().typeDataForm.removeAt(oldListIndex);
  //     (context)
  //         .read<FormController>()
  //         .typeDataForm
  //         .insert(newListIndex, movedList);
  //   });
  // }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = sections[oldListIndex].children.removeAt(oldItemIndex);
      sections[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = sections.removeAt(oldListIndex);
      sections.insert(newListIndex, movedList);
    });
  }
}

class SectionData extends StatefulWidget {
  int index = 0;
  SectionData({super.key, required this.index});

  @override
  State<SectionData> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SectionData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // key: Key('${widget.index}'),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text('Section ${widget.index}'),
            const Divider(),
          ],
        ),
      ),
    );
  }
}






// Expanded(
//                       child: DragAndDropLists(
//                         children: controller.typeDataForm,
//                         onItemReorder: _onItemReorder,
//                         onListReorder: _onListReorder,
//                         contentsWhenEmpty: const Text('vazioo'),
//                         itemDivider: const Divider(color: Colors.amber),
//                         itemDecorationWhileDragging: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 2,
//                               blurRadius: 3,
//                               offset: const Offset(0, 0),
//                             ),
//                           ],
//                         ),
//                         lastItemTargetHeight: 8,
//                         addLastItemTargetHeightToTop: true,
//                         lastListTargetSize: 40,
//                         listDragHandle: const DragHandle(
//                           verticalAlignment: DragHandleVerticalAlignment.top,
//                           child: Icon(
//                             Icons.delete,
//                             color: Colors.transparent,
//                           ),
//                         ),
//                         itemDragHandle: const DragHandle(
//                           child: Icon(
//                             Icons.menu,
//                             color: Colors.blueGrey,
//                           ),
//                         ),
//                       ),
//                     ),




