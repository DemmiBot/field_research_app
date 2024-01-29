import 'package:fieldresearch/models/researches_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fieldresearch/utils/repository_utils.dart';

class DataRepository {
  static List<ResearchesModel> researchesList = [];
  static var supabase = Supabase.instance.client;
  SupabaseKey key = SupabaseKey();

  Future<List<ResearchesModel>> fetchResearches() async {
    final data = await supabase.from('researches').select();
    print('data $data');
    researchesList =
        data.map((data) => ResearchesModel.fromJson(data)).toList();

    return researchesList;
  }

  static void testButton() async {
    final data = await supabase
      .rpc('create_table_type1', params: {'t_name': 'teste2'});
    print(data);
  }

}
