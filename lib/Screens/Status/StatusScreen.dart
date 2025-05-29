import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/Widgets/uihelper.dart';
import 'dart:io';
import 'package:whatsapp/Screens/Data/data.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  int statusCount = 0; // Number of statuses uploaded
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _statusImages = [];

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Upload from Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      setState(() {
                        _statusImages.add(XFile(image.path));
                        statusCount = _statusImages.length;
                      });
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Upload from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setState(() {
                        _statusImages.add(XFile(image.path));
                        statusCount = _statusImages.length;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }

  // ✅ Move this method out of build method
  List<double> generateDashPattern(int statusCount) {
    if (statusCount <= 1) {
      return [360]; // Full ring if only one status
    }

    double gapLength = 8.0;
    double dashLength = (360 - (gapLength * statusCount)) / statusCount;

    return List.generate(
      statusCount,
      (_) => [dashLength, gapLength],
    ).expand((e) => e).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: UiHelper.customText(
                    text: "Status",
                    textHeight: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                  iconSize: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      dashPattern: generateDashPattern(statusCount),
                      color: Colors.green,
                      strokeWidth: 3,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            _statusImages.isNotEmpty
                                ? FileImage(File(_statusImages.last.path))
                                : NetworkImage(
                                      "https://img.freepik.com/premium-vector/stylish-default-user-profile-photo-avatar-vector-illustration_664995-353.jpg?w=2000",
                                    )
                                    as ImageProvider,
                      ),
                    ),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xff00a884),
                      child: InkWell(
                        onTap: _showUploadOptions,
                        child: Icon(Icons.add, size: 15, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiHelper.customText(
                    text: "My Status",
                    textHeight: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5),
                  UiHelper.customText(text: "5 minutes", textHeight: 13),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.black26,
            indent: 20,
            endIndent: 20,
            thickness: 1,
            height: 10,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children:[ ListView.builder(
                itemCount: arrContent.length,
                itemBuilder: (context, index) {
                 return ListTile(
                    leading: DottedBorder(
                      borderType: BorderType.Circle,
                      dashPattern: generateDashPattern(statusCount),
                      color: Colors.green,
                      strokeWidth: 3,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                             NetworkImage(
                                      "https://img.freepik.com/premium-vector/stylish-default-user-profile-photo-avatar-vector-illustration_664995-353.jpg?w=2000",
                                    )
                                    as ImageProvider,
                      ),
                    ),
              
                    title: UiHelper.customText(text: "${arrContent[index]["first_name"].toString()} ${arrContent[index]["last_name"].toString()} ", textHeight: 20),
                    subtitle: UiHelper.customText(text: "${arrContent[index]["time"]}", textHeight: 15),
                    trailing: Icon(Icons.more_vert,size:20),
                  );
                },
              ),
              Positioned(
                bottom:30,
                right: 20,
                child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                    Container(
                      height:50,
                      width:50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xff00a884),
                          
                      ),
                        child:Icon(Icons.edit,size:35,color: Colors.white,)
                    ),
                    SizedBox( height:20),
                    Container(
                      height:50,
                      width:50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xff00a884),
                          
                      ),
                        child:Icon(Icons.camera_alt,size:35,color: Colors.white,)
                    ),
                            ],
                          ),
              ),
              ]
            ),
          ),
          
        ],
      ),
    );
  }
}
