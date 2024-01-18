// import 'package:minakomi/blocs/auth/index.dart';
// import 'package:minakomi/config/app_colors.dart';
// import 'package:minakomi/config/app_metrics.dart';
// import 'package:minakomi/util/getLanguage.dart';
// import 'package:minakomi/widgets/bottom_space.dart';
// import 'package:minakomi/widgets/elevated_button_custom.dart';
// import 'package:minakomi/widgets/header_view.dart';
// import 'package:minakomi/widgets/overlay_loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class VerifyCode extends StatefulWidget {
//   @override
//   _VerifyCodeState createState() => _VerifyCodeState();
// }

// class _VerifyCodeState extends State<VerifyCode> {
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
//     double width = MediaQuery.of(context).size.width;
//     double widthPinCode = (width - (AppMetrics.paddingHorizotal * 2)) / 7;
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
//                                   .getLanguage(context, 'verifyYourPhone')),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 44, bottom: 38),
//                                 child: Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(AppTranslations()
//                                       .getLanguage(context, 'detail........')),
//                                 ),
//                               ),
//                               PinCodeTextField(
//                                 appContext: context,
//                                 pastedTextStyle: TextStyle(
//                                   color: Colors.green.shade600,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 length: 6,
//                                 blinkWhenObscuring: true,
//                                 animationType: AnimationType.fade,
//                                 validator: (v) {
//                                   // if (v!.length < 3) {
//                                   //   return "I'm from validator";
//                                   // } else {
//                                   return null;
//                                   // }
//                                 },
//                                 pinTheme: PinTheme(
//                                   shape: PinCodeFieldShape.box,
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   fieldHeight: widthPinCode,
//                                   fieldWidth: widthPinCode,
//                                   inactiveFillColor: AppColors.blueLight,
//                                   inactiveColor: Colors.transparent,
//                                   selectedFillColor: AppColors.blueLight,
//                                   selectedColor: Colors.transparent,
//                                   // activeFillColor: hasError
//                                   //     ? Colors.blue.shade100
//                                   //     : Colors.white,
//                                 ),
//                                 cursorColor: Colors.black,
//                                 animationDuration: Duration(milliseconds: 300),
//                                 enableActiveFill: true,
//                                 // errorAnimationController: errorController,
//                                 // controller: textEditingController,
//                                 keyboardType: TextInputType.number,
//                                 boxShadows: [
//                                   BoxShadow(
//                                     offset: Offset(0, 1),
//                                     color: Colors.black12,
//                                     blurRadius: 10,
//                                   )
//                                 ],
//                                 onCompleted: (v) {
//                                   print("Completed");
//                                 },
//                                 onChanged: (value) {
//                                   print(value);
//                                   setState(() {
//                                     // currentText = value;
//                                   });
//                                 },
//                                 beforeTextPaste: (text) {
//                                   print("Allowing to paste $text");
//                                   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                                   //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                                   return true;
//                                 },
//                               )
//                             ],
//                           ),
//                         ),
//                         flex: 1),
//                     ElevatedButtonCustom(
//                       onPressed: () {
//                         context.read<AuthBloc>().add(AuthLogin(
//                             phoneNumber: '+61411689111',
//                             password: controllerPassword.text));
//                       },
//                       title: AppTranslations().getLanguage(context, 'verify'),
//                     ),
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
