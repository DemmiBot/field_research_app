import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/providers/poll_data_provider.dart';
import 'package:frontend_alleck/view/screens/new_form_screen.dart';
import 'package:frontend_alleck/view/widgets/poll_list_item.dart';

class UserHome extends ConsumerStatefulWidget {
  const UserHome({super.key});

  @override
  ConsumerState<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends ConsumerState<UserHome> {
  final username = "Alleck";
  final orgname = "PesquisasAlleck";

  // Function to reload polls when user pulls to refresh
  Future<void> _refreshPolls() async {
    // Force re-fetching of the poll data by invalidating the provider
    ref.invalidate(pollDataProvider);
    await ref.refresh(pollDataProvider.future); // Await the fresh data fetch
  }

  @override
  Widget build(BuildContext context) {
    // Watching the pollDataProvider to fetch poll data
    final pollAsyncValue = ref.watch(pollDataProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bem vindo, $username!"),
              Text(orgname),
              const Divider(height: 2),
              
              // Expanded section for poll list and refresh functionality
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshPolls,  // Pull-to-refresh action
                  child: pollAsyncValue.when(
                    data: (pollList) {
                      return ListView.builder(
                        itemCount: pollList.length,
                        itemBuilder: (context, index) {
                          final poll = Poll.fromJson(pollList[index]);
                          return PollListItem(poll: poll);
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error: $error')),
                  ),
                ),
              ),

              // Button to navigate to NewFormScreen
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewFormScreen()),
                  );
                },
                child: const Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
