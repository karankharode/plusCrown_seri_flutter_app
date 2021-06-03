// import 'package:flutter/material.dart';
// import 'package:seri_flutter_app//flutter_icons.dart';
// import 'package:get/get.dart';
//
// // import '../../../common/text.dart';
// // import '../../../common/sized_box.dart';
// // import '../../../common/text_field.dart';
// // import '../../../common/buttons.dart';
// // import '../../../res/app_colors.dart';
// import 'forgot_password_controller.dart';
//
// class ForgotPassword extends StatelessWidget {
//   const ForgotPassword({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ForgetPasswordController());
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//           Text( 'Reset Password',
//           textAlign: textAlign,
//           overflow: overflow,
//           style: TextStyle(
//             fontSize: size == null
//                 ? 2.17 * SizeConfig.textMultiplier
//                 : size * SizeConfig.textMultiplier,
//             fontWeight: fontWeight,
//             fontFamily: fontFamily,
//             color: color,
//             letterSpacing: letterSpacing,
//             height: lineHeight,
//           ),
//         )
//             BuildText(
//               'Reset Password',
//               size: 5.0,
//               color: AppColors.violet,
//               fontFamily: 'MavenProEB',
//             ),
//             BuildText(
//               'Create new password',
//               size: 1.9,
//             ),
//             BuildSizedBox(
//               height: 3.0,
//             ),
//             Obx(
//               () => BuildCustomTextField(
//                 label: 'Enter New Password',
//                 controller: controller.passwordCtrl,
//                 isPassword: !controller.showPassword.value,
//                 prefixIcon: Icon(Feather.lock),
//                 suffixIcon: GestureDetector(
//                   onTap: () => controller.togglePassword(),
//                   child: Icon(
//                     controller.showPassword.value
//                         ? Feather.eye
//                         : Feather.eye_off,
//                   ),
//                 ),
//               ),
//             ),
//             BuildSizedBox(
//               height: 2.0,
//             ),
//             Obx(
//               () => BuildCustomTextField(
//                 label: 'Confirm Password',
//                 controller: controller.confrimPasswordCtrl,
//                 isPassword: !controller.showConfirmPassword.value,
//                 prefixIcon: Icon(Feather.lock),
//                 suffixIcon: GestureDetector(
//                   onTap: () => controller.toggleConfrimPassword(),
//                   child: Icon(
//                     controller.showConfirmPassword.value
//                         ? Feather.eye
//                         : Feather.eye_off,
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: BuildPrimaryButton(
//                 onTap: () {},
//                 label: 'Reset Password',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
