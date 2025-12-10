import 'package:advanced_task_manager/ui/screens/countries/countries_screen.dart';
import 'package:advanced_task_manager/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Provider para manejar el índice actual del BottomNavigationBar
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationApp extends ConsumerWidget {
  const BottomNavigationApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    
    // Pantallas que vamos a mostrar
    final screens = const [
      HomeTasksListScreen(),
      CountriesScreen(),
    ];

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Países',
          ),
        ],
      ),
    );
  }
}
