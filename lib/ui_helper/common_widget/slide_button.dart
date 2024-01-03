// import 'dart:async';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
// import 'package:shovving_pre/util/safe_print.dart';
// import 'package:slide_action/slide_action.dart';
//
// class DeleteSlideButton extends StatelessWidget {
//   const DeleteSlideButton({Key? key, required this.iconPath, required this.destinationIconPath, required this.text, required this.action, required this.iconColor, required this.destinationIconColor}) : super(key: key);
//
//   final String iconPath;
//   final Color iconColor;
//   final String destinationIconPath;
//   final String text;
//   final FutureOr<void> Function()? action;
//   final Color destinationIconColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideAction(
//       rightToLeft: true,
//       trackBuilder: (context, state) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: const Color(0xfff8f8f8),
//           ),
//           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//               CommonContainer(
//                 containerColor: const Color(0xffeeeeee),
//                 width: 60,height: 60,
//                 child: DottedBorder(
//                     color: CColor.gray,
//                     radius: const Radius.circular(12),
//                     strokeWidth: 1,
//                     strokeCap: StrokeCap.butt,
//                     dashPattern: const [2,2],
//                     borderType: BorderType.RRect, child:
//                 Center(child: SvgPicture.asset(destinationIconPath, color: destinationIconColor, width: 28,height: 28,))
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.only(right: 68),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       text,
//                       style: CTextStyle.regular10,
//                     ),
//                     const SizedBox(height:  6),
//                     Row(
//                       children: [
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.leftTriangle,width: 10,height: 10,),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//
//
//             ],
//           ),
//         );
//       },
//       thumbBuilder: (context, state) {
//         return Container(
//           decoration: BoxDecoration(
//             color: CColor.deepBlueBlack,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Center(
//               child: SvgPicture.asset(iconPath, color:iconColor, width: 28,height: 28,)
//           ),
//         );
//       },
//       action: () async {
//         await action!();
//       },
//     );
//   }
// }
//
// class CreateSlideButton extends StatelessWidget {
//   const CreateSlideButton({Key? key, required this.iconPath, required this.destinationIconPath, required this.text, required this.action, required this.iconColor, required this.destinationIconColor, required this.iconBGColor}) : super(key: key);
//
//   final String iconPath;
//   final Color iconColor;
//   final String destinationIconPath;
//   final String text;
//   final FutureOr<void> Function()? action;
//   final Color destinationIconColor;
//   final Color iconBGColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideAction(
//       trackBuilder: (context, state) {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: const Color(0xfff8f8f8),
//           ),
//           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//
//
//
//               Padding(
//                 padding: const EdgeInsets.only(left: 68),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       text,
//                       style: CTextStyle.regular10,
//                     ),
//                     const SizedBox(height:  6),
//                     Row(
//                       children: [
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                         const SizedBox(width: 2,),
//                         SvgPicture.asset(CIconPath.rightTriangle,width: 10,height: 10,),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               CommonContainer(
//                 containerColor: const Color(0xffeeeeee),
//                 width: 60,height: 60,
//                 child: DottedBorder(
//                     color: CColor.gray,
//                     radius: const Radius.circular(12),
//                     strokeWidth: 1,
//                     strokeCap: StrokeCap.butt,
//                     dashPattern: const [2,2],
//                     borderType: BorderType.RRect, child:
//                 Center(child: SvgPicture.asset(destinationIconPath, color: destinationIconColor, width: 28,height: 28,))
//                 ),
//               ),
//
//             ],
//           ),
//         );
//       },
//       thumbBuilder: (context, state) {
//         return Container(
//           decoration: BoxDecoration(
//             color: iconBGColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Center(
//               child: SvgPicture.asset(iconPath, color:iconColor, width: 28,height: 28,)
//           ),
//         );
//       },
//       action: () async {
//         await action!();
//       },
//     );
//   }
// }
// */