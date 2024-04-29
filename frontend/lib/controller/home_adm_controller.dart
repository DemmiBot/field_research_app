import 'package:fieldresearch/models/researches_model.dart';
import 'package:fieldresearch/repositories/researches_repository.dart';
import 'package:flutter/material.dart';

class HomeAdmController {
  //final IResearchesRepository repository;

  //HomeAdmController({required this.repository});

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  final ValueNotifier<List<ResearchesModel>> researches = ValueNotifier([]);

  Future getResearches() async {
    //   isLoading.value = true;
    //   try {
    //     researches.value = await repository.getResearches();
    //   } catch (e) {
    //     print(e.toString());
    //   }
    //   isLoading.value = false;
    // }
  }
}
