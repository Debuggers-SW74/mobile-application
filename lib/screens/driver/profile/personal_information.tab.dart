import 'package:fastporte/common/constants/app.constraints.constant.dart';
import 'package:fastporte/providers/driver_info.provider.dart';
import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/widgets/row/information.row.dart';
import 'package:fastporte/widgets/screen.template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PersonalInformationTab extends StatefulWidget {
  const PersonalInformationTab({super.key});

  @override
  State<PersonalInformationTab> createState() => _PersonalInformationTabState();
}

class _PersonalInformationTabState extends State<PersonalInformationTab> {
  late Driver? driver;

  @override
  Widget build(BuildContext context) {
    final driverProvider = Provider.of<DriverInfoProvider>(context);
    driver = driverProvider.driver;

    return ScreenTemplate(
      paddingTop: 20.0,
      children: [
        InformationRow(label: 'Full name', value: driver!.name),
        const SizedBox(height: AppConstrainsts.spacingMedium),
        InformationRow(label: 'Email', value: driver!.email),
        const SizedBox(height: AppConstrainsts.spacingMedium),
        const InformationRow(label: 'Age', value: '20'),
        const SizedBox(height: AppConstrainsts.spacingMedium),
        const InformationRow(label: 'Phone', value: '923654788'),
        const SizedBox(height: AppConstrainsts.spacingMedium),
      ],
    );
  }
}
