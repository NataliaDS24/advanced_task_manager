import 'package:advanced_task_manager/config/config_imports.dart';
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
      appBar: AppBar(
        title: 
          Center(
            child: Text(
              AppStrings.titleListCountries,
              style: AppTextStyles.whiteInterBold20,
              )
          ),
        ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.errorImportingCountries,
                        style: AppTextStyles.primaryInterBold20,
                        ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(AppColors.primary),
                        ),
                        onPressed: () => notifier.loadCountries(),
                        child: Text(AppStrings.retry,
                          style: AppTextStyles.whiteInterBold16,
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: state.countries.length,
                  itemBuilder: (context, index) {
                    final country = state.countries[index];
                    return Card(
                      color: AppColors.greyLight,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: 
                          Text(
                            country.name,
                            style: AppTextStyles.blackInterBold16,
                          ),
                        leading: Text(
                          country.flag,
                          style: TextStyle(fontSize: 40),
                          ),
                      ),
                    );
                  },
                ),
    );
  }
}
