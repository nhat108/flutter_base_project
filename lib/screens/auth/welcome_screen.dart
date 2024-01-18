// import 'package:minakomi/blocs/auth/index.dart';
// import 'package:minakomi/config/app_metrics.dart';
// import 'package:minakomi/util/getLanguage.dart';
// import 'package:minakomi/widgets/bottom_space.dart';
// import 'package:minakomi/widgets/elevated_button_custom.dart';
// import 'package:minakomi/widgets/header_view.dart';
// import 'package:minakomi/widgets/input_field.dart';
// import 'package:minakomi/widgets/overlay_loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Welcome extends StatefulWidget {
//   @override
//   _WelcomeState createState() => _WelcomeState();
// }

// class _WelcomeState extends State<Welcome> {
//   TextEditingController controllerPhone;
//   @override
//   void initState() {
//     super.initState();
//     controllerPhone = TextEditingController(text: '+61411689759');
//   }

//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     controllerPhone.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {},
//       child: Scaffold(
//         appBar: HeaderView(),
//         body: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             FocusScope.of(context).requestFocus(new FocusNode());
//           },
//           child: Stack(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: AppMetrics.paddingHorizotal),
//                 child: Column(
//                   children: [
//                     Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Text(AppTranslations()
//                                   .getLanguage(context, 'welcome')),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 44, bottom: 38),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(AppTranslations()
//                                       .getLanguage(context, 'detail........')),
//                                 ),
//                               ),
//                               InputField(
//                                 title: AppTranslations()
//                                     .getLanguage(context, 'phoneNumber'),
//                                 textInputType: TextInputType.number,
//                                 textInputAction: TextInputAction.next,
//                                 controller: controllerPhone,
//                                 icon: Icons.check_circle,
//                               ),
//                             ],
//                           ),
//                         ),
//                         flex: 1),
//                     BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
//                       return ElevatedButtonCustom(
//                         onPressed: () {
//                           context.read<AuthBloc>().add(AuthGetStarted(
//                               phoneNumber: controllerPhone.text));
//                         },
//                         title: AppTranslations().getLanguage(context, 'next'),
//                       );
//                     }),
//                     BottomSpace(),
//                   ],
//                 ),
//               ),
//               BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
//                 if (state.requesting) return OverlayLoading();
//                 return Container();
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
