import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class CSVGeneratorRepository {
  var supabase = Supabase.instance.client;

  Future<String> getCsv() async {
    final data =
        await supabase.from('users').select('''name, is_admin, email''').csv();
    return data;
  }

  Future<String> filePath() async {
    // Obter o diretório de downloads no dispositivo
    final directory = await getExternalStorageDirectory();

    // Criar o caminho completo para o arquivo CSV
    String filePath = '${directory!.path}/seu_arquivo.csv';
    return filePath;
  }

  Future<void> generateCSV() async {
    // Escrever o conteúdo no arquivo
    String path = await filePath();
    String csv = await getCsv();
    print(csv);
    File file = File(path);
    await file.writeAsString(csv);
  }

//   void downloadCsv() async {
//     String openPath = await filePath();
//     OpenFile.open(openPath);
//   }
//   // Fazer o download do arquivo
//   // Você pode usar uma biblioteca como `open_file` para abrir o arquivo no dispositivo
//   // Certifique-se de adicionar a dependência `open_file` ao seu pubspec.yaml
//   // dependencies:
//   //   open_file: ^3.0.1
//   // Importe a biblioteca: import 'package:open_file/open_file.dart';
// }

// // await generateAndDownloadCSV(csvData);
}
