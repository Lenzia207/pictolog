// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pictolog/src/features/projects/domain/project_model.dart';

// import '../../../../../l10n/localization_extension.dart';
// import '../../../../constants/constants.dart';
// import '../../../../widgets/primary_button.dart';
// import '../../../pdf_reader/presentation/pictolog_pdf_preview_screen.dart';
// import '../../../reports/presentations/widgets/report_reorderable_list.dart';
// import '../project_detail_screen.dart';
// import '../widgets/empty_entries_message.dart';
// import 'pictolog_details_overview.dart';

// class ProjectDetailUi extends StatelessWidget {
//   const ProjectDetailUi({super.key,
//     required this.projectModel,
//     required this.onPressedSort,
//     required this.onPressedCreatePdf,
//     required this.isReorderMode,
//     required this.isSelectionMode,
//     required this.selectedKeys,
//   }); 

//   final ProjectModel projectModel;
//   final VoidCallback onPressedSort;
//   final VoidCallback onPressedCreatePdf;
//   final ValueNotifier<bool> isReorderMode;
//   final ValueNotifier<bool> isSelectionMode;
//   final ValueNotifier<Set<Object>> selectedKeys;
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 PictologDetailsOverview(
//                   pictolog: projectModel,
//                   title: projectModel.name,
//                   icon: isReorderMode.value ? Icons.check : Icons.sort,
//                   onPressedIcon: onPressedSort
//                   // () =>
//                   //     isReorderMode.value = !isReorderMode.value,
//                 ),

//                 // Pages List
//                 if (projectModel.reports.isEmpty)
//                   const EmptyEntriesMessage()
//                 else ...[
//                   ReportReorderableList(
//                     pictolog: projectModel,
//                     isReorderMode: isReorderMode,
//                     isSelectionMode: isSelectionMode,
//                     selectedKeys: selectedKeys,
//                   ),
//                   Space.h50,
//                 ],
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: p10,
//                   ),
//                   child: PrimaryButton(
//                     label: context.appLanguage.createPdf,
//                     onPressed: onPressedCreatePdf,
                    
//                     // () {
//                     //   context.pushNamed(
//                     //     PictologPdfPreviewScreen.name,
//                     //     pathParameters: {
//                     //       PictologDetailsScreen.paramId: pictologKey.toString(),
//                     //     },
//                     //     extra: pictolog,
//                     //   );
//                     // },
//                   ),
//                 ),
//                 Space.h300,
//               ],
//             ),
//           )
//   }
// }
