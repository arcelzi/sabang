import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabang/widgets/button.dart';

class SelectPhotoOptions extends StatelessWidget {
  final Function(ImageSource source) ontap;
  const SelectPhotoOptions({
    Key?key,
    required this.ontap,
    }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -35,
            child: Container(
              width: 50,
              height: 6,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: Colors.white
              ),
            ), 
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              SelectPhoto(
                textLabel: 'Browse Gallery', 
                icon: Icons.image, 
                onTap: () => ontap(ImageSource.gallery),
                ),
                const SizedBox(
                  height: 10,
                ),
                SelectPhoto(
                  textLabel: 'Use Camera', 
                  icon: Icons.camera_alt_outlined, 
                  onTap: () => ontap(ImageSource.camera))
            ],)
        ],

      ),
    );
  }
}