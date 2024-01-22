import 'package:fieldresearch/models/researches_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fieldresearch/utils/repository_utils.dart';

class DataRepository {
  static List<ResearchesModel> researchesList = [];
  static var supabase = Supabase.instance.client;
  SupabaseKey key = SupabaseKey();

  Future<List<ResearchesModel>> fetchResearches() async {
    final data = await supabase.from('researches').select();
    print('dataa $data');

    researchesList =
        data.map((data) => ResearchesModel.fromJson(data)).toList();
    print('lista do fromJson ${researchesList[0].name}');
    return researchesList;
  }

  static void testButton() async {
    // final data = await supabase
    //     .rpc('create_table_type1', params: {'t_name': 'mesanova'});
    // print(data);
  }

//   Future<void> createTable() async {
//    final response = await supabase
//       .from('rpc/create_table')  // Use o endpoint RPC para criar a tabela
//       .select()
//       .execute();

//   if (response.error != null) {
//     print('Erro ao criar tabela: ${response.error!.message}');
//   } else {
//     print('Tabela criada com sucesso!');
//   }
// }
}
