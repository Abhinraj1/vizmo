import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vizmo/core/model/event_model.dart';
import 'package:vizmo/widgets/event_details_widgets/event_background.dart';
import 'package:editable_text/editable_text.dart' as custom;
import '../maanger/font_manager.dart';
import '../widgets/event_details_widgets/image_slider.dart';


class EventDetailsScreen extends StatelessWidget {
  final Data data;
  final Function(Data) onSave;
  const EventDetailsScreen({super.key, required this.data, required this.onSave});

  @override
  Widget build(BuildContext context) {

    final List<String> imageList = data.images?? [];
    return Scaffold(

      body: EventDetailsScreenBackground(
          child: ListView(
            children: [
              SizedBox(
                height: 2.h,
              ),
              ImageSlider(
                imagesList: imageList,
              ),
              SizedBox(
                height: imageList.isEmpty ? 0: 4.h,
              ),
              Center(child:
              custom.EditableText(
                  initialText: "title",
                   style: eventTitle,
                   onTapOutside: () {
                   },
                   onSubmitted: (String text) {  },)),
              SizedBox(
                height: 2.h,
              ),
              Center(child:
              custom.EditableText(
                initialText: "title",
                style: eventDescription,
                onTapOutside: () {
                },
                onSubmitted: (String text) {  },)),
            ],
          )),
    );
  }
}
