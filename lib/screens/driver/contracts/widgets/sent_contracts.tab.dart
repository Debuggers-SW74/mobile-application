// import 'package:fastporte/widgets/screen.template.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../common/constants/app.constraints.constant.dart';
// import '../../../../widgets/contracts/trip_resume.widget.dart';
// import '../../../../widgets/contracts/driver_resume.widget.dart';
//
// class SentContractsTab extends StatefulWidget {
//   const SentContractsTab({super.key});
//
//   @override
//   State<SentContractsTab> createState() => _SentContractsTabState();
// }
//
// class _SentContractsTabState extends State<SentContractsTab> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         right: 48.0,
//         left: 48.0,
//         bottom: AppConstrainsts.spacingLarge,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const Center(
//             child: Text(
//               'Sent contracts',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//           const SizedBox(height: AppConstrainsts.spacingSmall),
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return const TripResume(
//                   userResume: DriverResume(),
//                   rowButtons: Row(
//                     children: [
//                       TextButton(
//                         onPressed: null,
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: null,
//                         child: Text('View'),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
