import 'package:flutter/material.dart';
import 'package:sus_app/services/api_service.dart';

import '../colors/colors.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController novController = TextEditingController();
  List<bool> _selectedTags = [false, false, false];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              child: const Icon(
                Icons.done,
                size: 40,
                color: textColor,
              ),
              onTap: () {
                post();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                autofocus: false,
                controller: titleController,
                onSaved: (value) {
                  titleController.text = value!;
                },
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 3,
                maxLength: 141,
                cursorColor: textColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write the title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                autofocus: false,
                controller: locationController,
                onSaved: (value) {
                  locationController.text = value!;
                },
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 2,
                maxLength: 70,
                cursorColor: textColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ex: Ho Chi Minh city',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                autofocus: false,
                controller: descriptionController,
                onSaved: (value) {
                  descriptionController.text = value!;
                },
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 15,
                maxLength: 750,
                cursorColor: textColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your description',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  ChoiceChip(
                    onSelected: (value) {
                      _selectedTags[0] = value;

                      if (value) {
                        _selectedTags[1] = false;
                        _selectedTags[2] = false;
                      }

                      setState(() {});
                    },
                    label: const Text('environment'),
                    selected: _selectedTags[0],
                    selectedColor: textColor,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ChoiceChip(
                    onSelected: (value) {
                      _selectedTags[1] = value;
                      if (value) {
                        _selectedTags[0] = false;
                        _selectedTags[2] = false;
                      }
                      setState(() {});
                    },
                    label: const Text('people'),
                    selected: _selectedTags[1],
                    selectedColor: textColor,
                    labelStyle: const TextStyle(color: Colors.white),
                    disabledColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ChoiceChip(
                    onSelected: (value) {
                      _selectedTags[2] = value;
                      if (value) {
                        _selectedTags[0] = false;
                        _selectedTags[1] = false;
                      }
                      setState(() {});
                    },
                    label: const Text('animal'),
                    selected: _selectedTags[2],
                    selectedColor: textColor,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Number of volunteer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                autofocus: false,
                controller: novController,
                onSaved: (value) {
                  novController.text = value!;
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
                cursorColor: textColor,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ex:10',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  post() async {
    String tag = '';
    if (_selectedTags[0]) {
      tag = 'environment';
    } else if (_selectedTags[1]) {
      tag = 'people';
    } else if (_selectedTags[2]) {
      tag = 'animal';
    }

    await ApiService.post(
      titleController.text,
      descriptionController.text,
      tag,
      locationController.text,
      0,
    );
  }
}


