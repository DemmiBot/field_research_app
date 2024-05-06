// import 'package:fieldresearch/models/users_model.dart';

// import 'package:fieldresearch/repositories/users_repository.dart';
// import 'package:flutter/material.dart';

// class UsersAdmController {
//   final IUsersRepository repository;

//   // LoginController currentUser =
//   //     LoginController(repository: UserRepository(client: HttpClient()));

//   // ValueNotifier<List<UserAdmModel>> users =
//   //     ValueNotifier<List<UserAdmModel>>([]);

//   ValueNotifier<bool> isLoading = ValueNotifier(false);

//   UsersAdmController({required this.repository});

//   void fetchUsers() async {
//     isLoading.value = true;
//     List<Map<String, dynamic>> aux = await repository.fetchUsers();
//     users.value = aux
//         .asMap()
//         .map((index, map) {
//           return MapEntry(index, UserAdmModel.fromJson(map, index));
//         })
//         .values
//         .toList();
//     isLoading.value = false;
//   }

//   List<UserAdmModel> filterUser() {
//     // Obtém o login do usuário atual
//     //  String currentLogin = currentUser.getCurrentUser.username;

//     // Filtra a lista de usuários removendo aqueles que possuem o mesmo login do usuário atual
//     // users.value =
//     //     users.value.where((user) => user.name != currentLogin).toList();
//     return users.value;
//   }

//   // List<UserAdmModel> researchesList = [];
//   // static List selectedItem = [];
//   // List<int> indexes = [];
//   // List<UserAdmModel> snapshot = [];

//   // bool convertBool(String text) {
//   //   if (text.toLowerCase() == 'true') {
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }

//   // void modifiedUser(email, value) {
//   //   var existingItem =
//   //       selectedItem.indexWhere((item) => item['email'] == email);

//   //   if (existingItem != -1) {
//   //     selectedItem.removeAt(existingItem);
//   //   }

//   //   selectedItem.add({'email': email, 'admin': value});
//   // }

//   // void updateUser(var snack) async {
//   //   if (selectedItem.isEmpty) {
//   //     ErrorFeedback.errorFeddback('Nenhuma alteração de usuário', snack, true);
//   //   } else {
//   //     for (var item in selectedItem) {
//   //       String email = item['email'];
//   //       String newAdminStatus = item['admin'];

//   //       try {
//   //         // await dataProvider.updateUsers(email, convertBool(newAdminStatus));
//   //       } catch (e) {
//   //         ErrorFeedback.errorFeddback(e, snack, false);
//   //       }
//   //     }
//   //     ErrorFeedback.errorFeddback('Alterações salvas', snack, true);
//   //   }
//   // }

//   // // List<UserAdmModel> verifyUser(List<UserAdmModel> snapshot) {
//   // //   snapshot.removeWhere((user) => user.email == AdmProvider.nameUser.email);

//   // //   return snapshot;
//   // // }

//   // void deleteUsers(var snack) async {
//   //   //   try {
//   //   //     if (indexes.isEmpty) {
//   //   //       ErrorFeedback.errorFeddback('Nenhum usuário selecionado', snack, true);
//   //   //     } else {
//   //   //       for (var i in indexes) {
//   //   //         await UsersRepositoryy.removeUsers(snapshot[i].email);
//   //   //       }
//   //   //     }
//   //   //   } catch (e) {
//   //   //     ErrorFeedback.errorFeddback(e, snack, false);
//   //   //   }

//   //   //   ErrorFeedback.errorFeddback('Usúarios removidos', snack, true);
//   //   //
//   // }
// }
