abstract class IUsersRepository {
  Future fetchUsers();
}

class UsersRepository {
  // final IClientHttp client;
  // final SpringConection spConection = SpringConection();
  // UsersRepository({required this.client});

  // @override
  // Future<List<Map<String, dynamic>>> fetchUsers() async {
  //   var response = await client.get(url: '${spConection.adressIP}/users');
  //   var userList = jsonDecode(response.body);
  //   List<Map<String, dynamic>> usersList =
  //       userList.cast<Map<String, dynamic>>();
  //   return usersList;
  // }
}
