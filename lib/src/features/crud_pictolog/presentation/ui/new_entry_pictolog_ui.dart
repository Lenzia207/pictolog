import 'package:flutter/material.dart';

class NewEntryPictologUi extends StatelessWidget {
  const NewEntryPictologUi({
    super.key,
    required this.nameController,
    required this.overviewController,
    required this.icon,
    required this.savePictolog,
  });

  final TextEditingController nameController;
  final TextEditingController overviewController;
  final Widget icon;
  final Future<void> Function()? savePictolog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
        actions: [IconButton(onPressed: savePictolog, icon: icon)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name of Project',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Overview Field
            TextField(
              controller: overviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText:
                    'General description about the project... (optional)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            // Reports Section Header
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Reports (${tempReports.value.length})',
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //     TextButton.icon(
            //       onPressed: addPhoto,
            //       icon: const Icon(Icons.add_a_photo),
            //       label: const Text('Add Photo'),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 8),

            // Reports List
            // if (tempReports.value.isEmpty)
            //   Container(
            //     padding: const EdgeInsets.all(32),
            //     alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.grey.shade300),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: const Text('No photos added yet'),
            //   )
            // else
            //   ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: tempReports.value.length,
            //     itemBuilder: (context, index) {
            //       final tempReport = tempReports.value[index];
            //       return Card(
            //         margin: const EdgeInsets.only(bottom: 16),
            //         clipBehavior: Clip.antiAlias,
            //         child: Column(
            //           children: [
            //             // Image Preview
            //             Stack(
            //               children: [
            //                 SizedBox(
            //                   height: 200,
            //                   width: double.infinity,
            //                   child: Image.file(
            //                     File(tempReport.imageFile.path),
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //                 Positioned(
            //                   top: 8,
            //                   right: 8,
            //                   child: CircleAvatar(
            //                     backgroundColor: Colors.black54,
            //                     child: IconButton(
            //                       icon: const Icon(
            //                         Icons.close,
            //                         color: Colors.white,
            //                       ),
            //                       onPressed: () {
            //                         final newList = [...tempReports.value];
            //                         newList.removeAt(index);
            //                         tempReports.value = newList;
            //                       },
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             // Description Field for this specific report
            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: TextField(
            //                 decoration: const InputDecoration(
            //                   labelText: 'Description',
            //                   border: InputBorder.none,
            //                   prefixIcon: Icon(Icons.description),
            //                 ),
            //                 onChanged: (val) {
            //                   tempReport.description = val;
            //                 },
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}
