// import 'package:minakomi/blocs/auth/auth_bloc.dart';
// import 'package:minakomi/blocs/auth/auth_state.dart';
// import 'package:minakomi/blocs/auth/index.dart';
// import 'package:minakomi/config/app_metrics.dart';
// import 'package:minakomi/widgets/cached_image.dart';
// import 'package:minakomi/widgets/elevated_button_custom.dart';
// import 'package:minakomi/widgets/header_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: HeaderView(
//           color: Colors.grey,
//           height: 90.0,
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: AppMetrics.paddingHorizotal,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Row(
//                     children: [
//                       Padding(
//                         child: Icon(Icons.border_all),
//                         padding: EdgeInsets.only(right: 10.0),
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 10.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('Welcome,'),
//                                 BlocBuilder<AuthBloc, AuthState>(
//                                     buildWhen: (preState, state) {
//                                   return false;
//                                 }, builder: (_, state) {
//                                   return Text('');
//                                 }),
//                               ],
//                             ),
//                           ))
//                     ],
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CachedImage(
//                       isBorderRadius: true,
//                     ),
//                     Text('Zoe')
//                   ],
//                 )
//               ],
//             ),
//           )),
//       body: SingleChildScrollView(
//         child: Container(
//             color: Colors.red,
//             child: ElevatedButtonCustom(
//               onPressed: () {
//                 context.read<AuthBloc>().add(AuthLogout());
//               },
//               title: 'log out',
//             )),
//       ),
//     );
//   }
// }
