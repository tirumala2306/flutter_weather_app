import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glasscast/core/theme/app_colors.dart';
import 'package:glasscast/widgets/gradient_background.dart';
import 'package:glasscast/widgets/glass_container.dart';
import 'package:glasscast/features/city_search/bloc/city_serach_event.dart';
import '../bloc/city_search_bloc.dart';
import '../bloc/city_search_state.dart';
import '../repository/city_repository.dart';
import '../model/city_model.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CitySearchBloc(CityRepository()),
      child: const _CitySearchView(),
    );
  }
}

class _CitySearchView extends StatelessWidget {
  const _CitySearchView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GradientBackground(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),
              
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GlassContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search for a city...',
                            hintStyle: TextStyle(color: AppColors.textHint),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                          ),
                          onChanged: (value) {
                            if (value.length >= 3) {
                              context.read<CitySearchBloc>().add(SearchCity(value));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Results
              Expanded(
                child: BlocConsumer<CitySearchBloc, CitySearchState>(
                  listener: (context, state) {
                    if (state is CitySavedSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('City saved to favorites')),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CitySearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
    
                    if (state is CitySearchLoaded) {
                      if (state.cities.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                size: 80,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No cities found',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.cities.length,
                        itemBuilder: (context, index) {
                          final CityModel city = state.cities[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GlassContainer(
                              padding: const EdgeInsets.all(16),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  '${city.name}, ${city.country}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.favorite_border, color: Colors.white),
                                  onPressed: () {
                                    context
                                        .read<CitySearchBloc>()
                                        .add(SaveFavoriteCity(city));
                                  },
                                ),
                                onTap: () {
                                  Navigator.pop(context, city);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
    
                    if (state is CitySearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
    
                    // Empty state
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_outlined,
                            size: 120,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Search for a city',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter a city name to see the weather',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
