import 'package:app_mixins/app_mixins.dart';
import 'package:fieldresearch/controller/form_controller.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/screens/adm_page/create_form_view/widgets/type_data/int_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultType extends StatefulWidget {
  final int identity;

  const DefaultType({
    super.key,
    required this.identity,
  });

  @override
  State<DefaultType> createState() => _DefaultTypeState();
}

class _DefaultTypeState extends State<DefaultType> with FormMixin {
  final FormController controller = FormController();
  final typeOptions = ['TEXTO', 'INTEIRO'];
  bool textType = false;
  bool intType = false;
  // bool listType = false;
//'LISTA SUSPENSA'
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 40.w),
      child: Column(
        children: [
          SizedBox(height: 15.h),
          FormBuilderTextField(
            key: Key('fieldName${widget.identity}'),
            validator: (value) => isNotEmptyFlutterForm(value),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              filled: true,
              fillColor: fillFormColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3.r),
                borderSide: BorderSide.none,
              ),
              hintText: ' Nome do campo',
              hintStyle: TextStyle(color: textColorForm, fontSize: 16.sp),
            ),
            name: 'fieldItem${widget.identity}',
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FormBuilderDropdown(
                  validator: (value) => isNotEmptyFlutterForm(value),
                  key: Key('fieldName_${widget.identity}'),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    filled: true,
                    fillColor: fillFormColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.r),
                      borderSide: BorderSide.none,
                    ),
                    hintText: ' Tipo de dado',
                    hintStyle: TextStyle(color: textColorForm, fontSize: 13.sp),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value == 'INTEIRO') {
                        intType = true;
                        textType = false;
                        // listType = false;
                      }
                      if (value == 'TEXTO') {
                        textType = true;
                        intType = false;
                        // listType = false;
                      }
                      if (value == 'LISTA SUSPENSA') {
                        // listType = true;
                        textType = false;
                        intType = false;
                      }
                    });
                  },
                  name: 'drop${widget.identity}',
                  items: typeOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(
                        option,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                flex: 2,
                child: FormBuilderCheckbox(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  name: 'required${widget.identity}',
                  title: Text(
                    'Obrigatório',
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5.h),
          if (intType) IntTypeData(identity: widget.identity),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
