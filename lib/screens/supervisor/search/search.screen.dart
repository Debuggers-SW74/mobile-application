import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/screens/supervisor/search/widgets/driver_result_tile.widget.dart';
import 'package:fastporte/services/supervisor/supervisor.service.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app.colors.constant.dart';
import '../../../common/constants/app.constraints.constant.dart';
import '../../../common/constants/app.text_styles.constant.dart';
import '../../../widgets/app_bar/logged.app_bar.dart';
import '../../../widgets/text_field/template.input_decoration.dart';
import '../../../widgets/text_field/template.prefix_icon.dart';

class SupervisorSearchScreen extends StatefulWidget {
  const SupervisorSearchScreen({super.key});

  @override
  State<SupervisorSearchScreen> createState() => _SupervisorSearchScreenState();
}

class _SupervisorSearchScreenState extends State<SupervisorSearchScreen> {
  final TextEditingController _driverNameController = TextEditingController();
  final SupervisorService _supervisorService = SupervisorService();

  late Future<void> _futureDrivers;
  List<Driver> _drivers = [];
  List<Driver> _filteredDrivers = [];

  @override
  void initState() {
    super.initState();
    _futureDrivers = _loadDrivers();
  }

  Future<void> _loadDrivers() async {
    final results = await _supervisorService.getDriversBySupervisorId();
    setState(() {
      _drivers = results;
      _filteredDrivers = results; // Initially, show all drivers
    });
  }

  @override
  void dispose() {
    _driverNameController.dispose();
    super.dispose();
  }

  void _filterDrivers(String query) {
    if (query.isEmpty) {
      // Si la consulta está vacía, mostrar todos los conductores
      setState(() {
        _filteredDrivers = _drivers;
      });
    } else {
      // De lo contrario, filtrar los conductores por el nombre completo
      setState(() {
        _filteredDrivers = _drivers.where((driver) {
          // Concatenar el nombre y los apellidos en minúsculas
          String fullName = '${driver.name} ${driver.firstLastName} ${driver.secondLastName}'.toLowerCase();
          // Comparar el nombre completo con la consulta
          return fullName.contains(query.toLowerCase());
        }).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoggedAppBar(title: 'Search'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Assign a trip to a driver',
              style: AppTextStyles.headlineSmall(context)
                  .copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: AppConstrainsts.spacingLarge),
            Text(
              'Driver name',
              style: AppTextStyles.titleMedium(context).copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppConstrainsts.spacingSmall),
            TextFormField(
              controller: _driverNameController,
              style: AppTextStyles.labelTextFormField(context),
              decoration: templateInputDecoration(
                labelStyle: AppTextStyles.labelTextFormField(context),
                prefixIcon: const TemplatePrefixIcon(
                  iconData: Icons.person_outline,
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                _filterDrivers(value);
              },
            ),
            const SizedBox(height: AppConstrainsts.spacingMedium),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadDrivers,
                child: FutureBuilder<void>(
                  future: _futureDrivers,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (_filteredDrivers.isEmpty) {
                      return const Center(child: Text('No drivers found'));
                    } else {
                      return ListView.builder(
                        itemCount: _filteredDrivers.length,
                        itemBuilder: (context, index) {
                          Driver driver = _filteredDrivers[index];
                          return DriverResultTile(
                            driver: driver,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
