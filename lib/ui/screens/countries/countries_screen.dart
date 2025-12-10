import 'package:advanced_task_manager/ui/screens/countries/countries_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountriesScreen extends ConsumerWidget {
  const CountriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(countriesNotifierProvider);
    final notifier = ref.read(countriesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Países')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.error}'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => notifier.loadCountries(),
                        child: const Text('Reintentar'),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state.countries.length,
                  itemBuilder: (context, index) {
                    final country = state.countries[index];
                    return ListTile(
                      title: Text(country.name),
                      subtitle: Text(country.id),
                      leading: Text(country.flag),
                    );
                  },
                ),
    );
  }
}
