import 'package:fieldresearch/controller/login_controller.dart';
import 'package:fieldresearch/utils/repository_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCreateTable extends StatefulWidget {
  const AdminCreateTable({Key? key}) : super(key: key);

  @override State<AdminCreateTable> createState() => _AdminCreateTable();
}

class _AdminCreateTable extends State<AdminCreateTable> {

  static var supabase = Supabase.instance.client;
  SupabaseKey key = SupabaseKey();

  final _formKey = GlobalKey<FormState>();
  String valueChoose = 'INT';
  List tiposDeCampos = ['INT', 'FLOAT', 'STRING', 'ENUM', 'DATE'];
  static var fieldController = new TextEditingController();
  final c_name = fieldController.text.trim();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Form
            (
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: fieldController,
                    decoration: const InputDecoration(
                      label: Text('Novo Campo'), hintText: 'adicione o nome'
                    ),
                  ),              
                  DropdownButtonFormField(
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue as String;
                        });
                      },
                      items: tiposDeCampos.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem)
                        );
                      }).toList(),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: Color.fromARGB(255, 0, 21, 255),
                      
                    ),
                    child: Text("Inserir nova coluna"),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          LoginController.loading = true;
                        });
                        final data = await supabase
                          .rpc('add_column',
                            params: { 'c_name': fieldController.text.trim(),  'col_type': valueChoose, 't_name': 'teste'});
                        print(data);
                        
                      }
                    },
                  ),
                ],
              ) 
            
            ),
          ),
        ),
      );
    }
  }