import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glasscast/features/city_search/model/city_model.dart';
import 'package:glasscast/features/city_search/repository/city_repository.dart';
import 'package:glasscast/features/favorites/bloc/favorites_bloc.dart';
import 'package:glasscast/features/favorites/bloc/favorites_event.dart';
import 'package:glasscast/features/favorites/bloc/favorites_state.dart';
import 'package:glasscast/features/favorites/repository/favorites_repository.dart';
import 'package:glasscast/features/home/bloc/weather_bloc.dart';
import 'package:glasscast/features/home/bloc/weather_event.dart';
import 'package:glasscast/features/home/bloc/weather_state.dart';
import 'package:glasscast/features/home/model/weather_model.dart';
import 'package:glasscast/features/home/repository/weather_repository.dart';
import 'package:glasscast/features/login/bloc/auth_bloc.dart';
import 'package:glasscast/features/login/bloc/auth_event.dart';
import 'package:glasscast/features/settings/bloc/temperature_unit_cubit.dart';
import 'package:glasscast/features/settings/widgets/unit_toggle.dart';
import 'package:glasscast/features/city_search/bloc/city_search_bloc.dart';
import 'package:glasscast/features/city_search/bloc/city_search_state.dart';
import 'package:glasscast/features/city_search/bloc/city_serach_event.dart';
import 'package:glasscast/widgets/gradient_background.dart';
import 'package:glasscast/core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Pune as default city
  static const double _defaultLat = 18.5204;
  static const double _defaultLon = 73.8567;

  int _currentIndex = 0;

  void _showWeatherForCity(CityModel city) {
    context.read<WeatherBloc>().add(
          FetchWeather(
            lat: city.lat,
            lon: city.lon,
          ),
        );
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => WeatherBloc(WeatherRepository())
            ..add(
              FetchWeather(
                lat: _defaultLat,
                lon: _defaultLon,
              ),
            ),
        ),
        BlocProvider<CitySearchBloc>(
          create: (_) => CitySearchBloc(CityRepository()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) =>
              FavoritesBloc(FavoritesRepository())..add(LoadFavorites()),
        ),
        BlocProvider<TemperatureUnitCubit>(
          create: (_) => TemperatureUnitCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GradientBackground(
          child: SafeArea(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                const _HomeTab(),
                _SearchTab(onCitySelected: _showWeatherForCity),
                _FavoritesTab(onCitySelected: _showWeatherForCity),
                const _SettingsTab(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.glassBackground,
            border: Border(
              top: BorderSide(color: AppColors.glassBorder, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white54,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading || state is WeatherInitial) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (state is WeatherError) {
            return Center(
              child: Text(
                'Could not load weather.\n${state.message}',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is WeatherLoaded) {
            return _HomeContent(weather: state.weather);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final WeatherModel weather;

  const _HomeContent({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _LargeWeatherCard(weather: weather),
        const SizedBox(height: 24),
        const Text(
          '5-Day Forecast',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _ForecastStrip(forecast: weather.forecast),
      ],
    );
  }
}

class _LargeWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const _LargeWeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
      builder: (context, unit) {
        final temp = _convertTemperature(weather.temperature, unit);
        final condition = weather.condition;
        final unitLabel = unit == TemperatureUnit.celsius ? '°C' : '°F';

        final now = DateTime.now();
        final formattedDateTime = _formatDateTime(now);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF181818),
                Color(0xFF000000),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formattedDateTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white70,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${temp.round()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      unitLabel,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    condition.toLowerCase() == 'clear'
                        ? 'assets/icons/sun.svg'
                        : 'assets/icons/cloud.svg',
                    height: 56,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                condition,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ForecastStrip extends StatelessWidget {
  final List forecast;

  const _ForecastStrip({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
      builder: (context, unit) {
        return SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: forecast.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final day = forecast[index];
              final date = (day as dynamic).date as DateTime;
              final tempC = (day as dynamic).temp as double;
              final condition = (day as dynamic).condition as String;

              final temp = _convertTemperature(tempC, unit);

              return Container(
                width: 70,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _weekdayShort(date),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${temp.round()}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      condition,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _SearchTab extends StatefulWidget {
  final ValueChanged<CityModel> onCitySelected;

  const _SearchTab({required this.onCitySelected});

  @override
  State<_SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<_SearchTab> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Search',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Search cities',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.black,
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              if (value.length >= 3) {
                context.read<CitySearchBloc>().add(SearchCity(value));
              }
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<CitySearchBloc, CitySearchState>(
              builder: (context, state) {
                if (state is CitySearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (state is CitySearchError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is CitySearchLoaded) {
                  if (state.cities.isEmpty) {
                    return const Center(
                      child: Text(
                        'No cities found. Try a different name.',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.cities.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Colors.white12,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final city = state.cities[index];
                      return ListTile(
                        title: Text(
                          city.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          city.country,
                          style: const TextStyle(color: Colors.white60),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context
                                .read<FavoritesBloc>()
                                .add(AddFavoriteCity(city));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added ${city.name} to favorites'),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          widget.onCitySelected(city);
                        },
                      );
                    },
                  );
                }

                return const Center(
                  child: Text(
                    'Type at least 3 characters to search for a city.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoritesTab extends StatelessWidget {
  final ValueChanged<CityModel> onCitySelected;

  const _FavoritesTab({required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Favorites',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading || state is FavoritesInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (state is FavoritesError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is FavoritesLoaded) {
                  if (state.favorites.isEmpty) {
                    return const Center(
                      child: Text(
                        'No favorite cities yet.\nAdd some from the Search tab.',
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: state.favorites.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: Colors.white12,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final city = state.favorites[index];
                      return ListTile(
                        title: Text(
                          city.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          city.country,
                          style: const TextStyle(color: Colors.white60),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            context
                                .read<FavoritesBloc>()
                                .add(RemoveFavoriteCity(city));
                          },
                        ),
                        onTap: () => onCitySelected(city),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          _SettingsRow(
            title: 'Temperature unit',
            trailing: const UnitToggle(),
            onTap: () {
              context.read<TemperatureUnitCubit>().toggle();
            },
          ),
          const SizedBox(height: 16),
          _SettingsRow(
            title: 'Logout',
            trailing: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

double _convertTemperature(double celsius, TemperatureUnit unit) {
  if (unit == TemperatureUnit.celsius) return celsius;
  return celsius * 9 / 5 + 32;
}

String _weekdayShort(DateTime date) {
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[date.weekday - 1];
}

String _formatDateTime(DateTime dateTime) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final weekday = weekdays[dateTime.weekday - 1];
  final month = months[dateTime.month - 1];
  final day = dateTime.day;

  final hour12 = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

  return '$weekday, $month $day • $hour12:$minute $amPm';
}
