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

// class CompleteSignUp extends StatefulWidget {
//   @override
//   _CompleteSignUpState createState() => _CompleteSignUpState();
// }

// class _CompleteSignUpState extends State<CompleteSignUp> {
//   TextEditingController controllerFirstName;
//   TextEditingController controllerLastName;
//   TextEditingController controllerEmail;
//   FocusNode fnFirstName;
//   FocusNode fnLastName;
//   FocusNode fnEmail;
//   @override
//   void initState() {
//     super.initState();
//     controllerFirstName = TextEditingController(text: 'Join');
//     controllerLastName = TextEditingController(text: 'Jack');
//     controllerEmail = TextEditingController(text: 'mail@com');
//     fnFirstName = FocusNode();
//     fnLastName = FocusNode();
//     fnEmail = FocusNode();
//   }

//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     fnFirstName.dispose();
//     fnLastName.dispose();
//     fnEmail.dispose();
//     controllerFirstName.dispose();
//     controllerLastName.dispose();
//     controllerEmail.dispose();
//     super.dispose();
//   }

//   Widget rowCheckBox(BuildContext context, String text1, text2) {
//     return Row(
//       children: [
//         Checkbox(value: true, onChanged: (b) {}),
//         Expanded(
//           child: Wrap(
//             children: [
//               text1 == '' ? Container() : Text('$text1 '),
//               Text('$text2'),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state.errorMessage == '') {
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
//                             child: Column(
//                       children: [
//                         Text(AppTranslations().getLanguage(context, 'login')),
//                         Padding(
//                           padding: EdgeInsets.only(top: 44, bottom: 38),
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Text(AppTranslations()
//                                 .getLanguage(context, 'detail........')),
//                           ),
//                         ),
//                         InputField(
//                           autofocus: true,
//                           focusNode: fnFirstName,
//                           title: AppTranslations()
//                               .getLanguage(context, 'firstName'),
//                           textInputAction: TextInputAction.next,
//                           controller: controllerFirstName,
//                           onEditingComplete: () {
//                             fnFirstName.unfocus();
//                             fnLastName.requestFocus();
//                           },
//                         ),
//                         InputField(
//                           title: AppTranslations()
//                               .getLanguage(context, 'lastName'),
//                           textInputAction: TextInputAction.next,
//                           controller: controllerLastName,
//                           focusNode: fnLastName,
//                           onEditingComplete: () {
//                             fnLastName.unfocus();
//                             fnEmail.requestFocus();
//                           },
//                         ),
//                         InputField(
//                           title:
//                               AppTranslations().getLanguage(context, 'email'),
//                           textInputAction: TextInputAction.done,
//                           controller: controllerEmail,
//                           focusNode: fnEmail,
//                           onEditingComplete: () {
//                             fnEmail.unfocus();
//                           },
//                         ),
//                       ],
//                     ))),
//                     rowCheckBox(
//                         context,
//                         AppTranslations()
//                             .getLanguage(context, 'termAndCondition'),
//                         AppTranslations()
//                             .getLanguage(context, 'termAndCondition1')),
//                     rowCheckBox(
//                         context,
//                         AppTranslations()
//                             .getLanguage(context, 'checkReceiveEmail'),
//                         ''),
//                     BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
//                       return ElevatedButtonCustom(
//                         onPressed: () {},
//                         title: AppTranslations().getLanguage(context, 'signUp'),
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
