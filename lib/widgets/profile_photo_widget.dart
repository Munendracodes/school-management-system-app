import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school_management_app/core/constants/app_colors.dart';
import '../services/firebase_file_service.dart';
import 'package:image_picker/image_picker.dart';


class ProfilePhotoWidget extends StatefulWidget {

  final String profileId;

  final ProfileType profileType;

  final double radius;

  const ProfilePhotoWidget({

    super.key,

    required this.profileId,

    required this.profileType,

    this.radius = 45,
  });

  /// Student Constructor
  const ProfilePhotoWidget.student({

    super.key,

    required String studentId,

    this.radius = 45,

  })  : profileId = studentId,
        profileType = ProfileType.student;

  /// Teacher Constructor
  const ProfilePhotoWidget.teacher({

    super.key,

    required String teacherId,

    this.radius = 45,

  })  : profileId = teacherId,
        profileType = ProfileType.teacher;

  @override
  State<ProfilePhotoWidget> createState() =>
      _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState
    extends State<ProfilePhotoWidget> {

  final FirebaseFileService _service =
  FirebaseFileService();

  File? selectedImage;

  String? photoUrl;

  bool loading = true;

  bool uploading = false;

  bool uploaded = false;

  @override
  void initState() {
    super.initState();

    loadPhoto();
  }

  Future<void> loadPhoto() async {
    photoUrl =
    await _service.getProfilePhoto(

      type: widget.profileType,

      id: widget.profileId,
    );

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  Widget _buildImage() {

    if (uploading) {

      return Container(

        color: Colors.black26,

        child: const Center(

          child: CircularProgressIndicator(),
        ),
      );
    }

    if (uploaded) {

      return Container(

        color: Colors.green,

        child: const Center(

          child: Icon(

            Icons.check,

            color: Colors.white,

            size: 36,
          ),
        ),
      );
    }

    if (selectedImage != null) {

      return Image.file(

        selectedImage!,

        fit: BoxFit.cover,
      );
    }

    if (photoUrl != null) {

      return CachedNetworkImage(

        imageUrl: photoUrl!,

        fit: BoxFit.cover,
      );
    }

    return Icon(

      Icons.person,

      size: 50,

      color: Colors.white,
    );
  }

  Future<void> showPhotoOptions() async {

    showModalBottomSheet(

      context: context,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(

        borderRadius: BorderRadius.vertical(

          top: Radius.circular(28),
        ),
      ),

      builder: (_) {

        return SafeArea(

          child: Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(

                  "Update Profile Photo",

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Take Photo"),
                  onTap: () {
                    Navigator.pop(context);

                    Future.delayed(const Duration(milliseconds: 250), () {
                      pickImage(ImageSource.camera);
                    });
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Choose from Gallery"),
                  onTap: () {
                    Navigator.pop(context);

                    Future.delayed(const Duration(milliseconds: 250), () {
                      pickImage(ImageSource.gallery);
                    });
                  },
                ),

                if(photoUrl != null || selectedImage != null)

                  ListTile(

                    leading: const Icon(Icons.visibility),

                    title: const Text("View Photo"),

                    onTap: () {

                      Navigator.pop(context);

                      viewPhoto();
                    },
                  ),

                if(photoUrl != null || selectedImage != null)

                  ListTile(

                    leading: const Icon(

                      Icons.delete,

                      color: Colors.red,
                    ),

                    title: const Text(

                      "Remove Photo",

                      style: TextStyle(

                        color: Colors.red,
                      ),
                    ),

                    onTap: () async {

                      Navigator.pop(context);

                      await removePhoto();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {

    try {

      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(

        source: source,

        imageQuality: 50,

        maxWidth: 512,

        maxHeight: 512,
      );

      if (pickedFile == null) return;

      final image = File(pickedFile.path);

      setState(() {

        selectedImage = image;

        uploading = true;
      });

      final url = await _service.uploadProfilePhoto(

        type: widget.profileType,

        id: widget.profileId,

        image: image,
      );

      setState(() {

        photoUrl = url;

        uploading = false;

        uploaded = true;
      });

      await Future.delayed(

        const Duration(seconds: 1),
      );

      if (mounted) {

        setState(() {

          uploaded = false;
        });
      }

    } catch (e) {

      if (mounted) {

        setState(() {

          uploading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> removePhoto() async {

    await _service.deleteProfilePhoto(

      type: widget.profileType,

      id: widget.profileId,
    );

    if (!mounted) return;

    setState(() {

      photoUrl = null;

      selectedImage = null;
    });
  }

  void viewPhoto() {

    if (photoUrl == null) return;

    showDialog(

      context: context,

      builder: (_) {

        return Dialog(

          backgroundColor: Colors.transparent,

          child: InteractiveViewer(

            child: ClipRRect(

              borderRadius: BorderRadius.circular(20),

              child: CachedNetworkImage(

                imageUrl: photoUrl!,

                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(

      alignment: Alignment.bottomRight,

      children: [

        Container(

          height: widget.radius * 2,

          width: widget.radius * 2,

          decoration: BoxDecoration(

            shape: BoxShape.circle,

            border: Border.all(

              color: const Color(0xFF2457FF),

              width: 2,
            ),

            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(.08),

                blurRadius: 10,

                offset: const Offset(0,4),
              ),
            ],
          ),

          child: ClipOval(

            child: _buildImage(),
          ),
        ),

        GestureDetector(
          onTap: uploading ? null : showPhotoOptions,
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              color: Color(0xFF2457FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 16,
            ),
          ),
        )
      ],
    );
  }

}