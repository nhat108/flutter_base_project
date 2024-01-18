// import 'package:minakomi/blocs/auth/index.dart';
// import 'package:minakomi/config/app_metrics.dart';
// import 'package:minakomi/util/getLanguage.dart';
// import 'package:minakomi/widgets/bottom_space.dart';
// import 'package:minakomi/widgets/custom_dialog.dart';
// import 'package:minakomi/widgets/elevated_button_custom.dart';
// import 'package:minakomi/widgets/header_view.dart';
// import 'package:minakomi/widgets/input_field.dart';
// import 'package:minakomi/widgets/overlay_loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController controllerPassword;
//   FocusNode fnPassword;
//   @override
//   void initState() {
//     super.initState();
//     controllerPassword = TextEditingController(text: '12345678');
//     fnPassword = FocusNode();
//   }

//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     fnPassword.dispose();
//     controllerPassword.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.errorMessage != '') {
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return CustomDialog(
//                   descriptions: 'zxczcx',
//                   title: 'error',
//                 );
//               });
//         }
//       },
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
//                                   .getLanguage(context, 'login')),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 44, bottom: 38),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(AppTranslations()
//                                       .getLanguage(context, 'detail........')),
//                                 ),
//                               ),
//                               InputField(
//                                 focusNode: fnPassword,
//                                 title: AppTranslations()
//                                     .getLanguage(context, 'password'),
//                                 isPassword: true,
//                                 textInputAction: TextInputAction.done,
//                                 controller: controllerPassword,
//                                 icon: Icons.remove_red_eye,
//                               ),
//                             ],
//                           ),
//                         ),
//                         flex: 1),
//                     ElevatedButtonCustom(
//                       onPressed: () {
//                         context.read<AuthBloc>().add(AuthLogin(
//                             phoneNumber:
//                                 BlocProvider.of<AuthBloc>(context).state.phone,
//                             password: controllerPassword.text));
//                       },
//                       title: AppTranslations().getLanguage(context, 'login'),
//                     ),
//                     Padding(
//                         padding: EdgeInsets.only(top: 15.0),
//                         child: Text(
//                           AppTranslations()
//                               .getLanguage(context, 'forgotPassword'),
//                         )),
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
