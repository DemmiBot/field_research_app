import 'package:fieldresearch/repositories/csv_request.dart';

class CsvController {
  CSVGeneratorRepository csvRepository = CSVGeneratorRepository();

  void generateAndDownloadCSV() {
    // print('começando...');
    csvRepository.generateCSV();
    // print('csv Gerado');

    // csvRepository.downloadCsv();
    // print('Download Realizado');
  }
}
