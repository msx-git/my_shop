import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_shop/controllers/auth_controller.dart';
import 'package:my_shop/controllers/categories_controller.dart';
import 'package:my_shop/utils/extensions.dart';
import 'package:my_shop/views/widgets/my_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../utils/show_loader.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () async => await context.read<AuthController>().signOut(),
          title: const Text("Sign Out"),
          trailing: const Icon(Icons.logout),
        ),
        if (FirebaseAuth.instance.currentUser!.email == 'msx.tuit@gmail.com')
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const AddCategoryDialog();
                },
              );
            },
            title: const Text("Add category"),
            trailing: const Icon(Icons.chevron_right),
          )
      ],
    );
  }
}

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  File? imageFile;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void addCategory() async {
    Messages.showLoadingDialog(context);
    await context
        .read<CategoriesController>()
        .addCategory(
          imageId: DateTime.now().microsecondsSinceEpoch.toString(),
          imageFile: imageFile!,
          title: titleController.text,
        )
        .then(
      (value) {
        titleController.clear();
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add a category"),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextFormField(
              label: "Category title",
              controller: titleController,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter title of category!";
                }
                return null;
              },
            ),
            10.height,
            const Text(
              "Rasm Qo'shish",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: openCamera,
                  label: const Text("Camera"),
                  icon: const Icon(Icons.camera),
                ),
                TextButton.icon(
                  onPressed: openGallery,
                  label: const Text("Gallery"),
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
            if (imageFile != null)
              SizedBox(
                height: 150,
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: addCategory,
          child: const Text("Add"),
        ),
      ],
    );
  }
}
