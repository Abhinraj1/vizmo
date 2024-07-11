import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vizmo/core/cubit/event_details_cubit/event_details_cubit.dart';
import 'package:vizmo/core/cubit/event_details_cubit/event_details_cubit.dart';
import 'package:vizmo/core/cubit/event_details_cubit/event_details_cubit.dart';
import 'package:vizmo/core/cubit/home_cubit/home_cubit.dart';
import 'package:vizmo/core/model/event_model.dart';
import 'package:vizmo/widgets/event_details_widgets/event_background.dart';
import 'package:editable_text/editable_text.dart' as custom;
import '../maanger/font_manager.dart';
import '../widgets/event_details_widgets/image_slider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  List<String> imageList = [];
  bool showSave = false;
  Data eventData = Data();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        BlocProvider.of<HomeCubit>(context).getData();
      },
      child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          if (state is EventDetailsLoading) {
            return const Material(
                child: Center(child: CircularProgressIndicator()));
          }
          if (state is EventDetailsLoaded) {
            eventData = state.data;
            imageList = state.data.images ?? [];
          }
          return Scaffold(
              floatingActionButton: showSave
                  ? FloatingActionButton(
                      backgroundColor: Colors.blue.shade800,
                      onPressed: () {
                        BlocProvider.of<EventDetailsCubit>(context)
                            .editData(updatedData: eventData);
                      },
                      child: Text(
                        "Save",
                        style: floatingActionButtonTitle,
                      ),
                    )
                  : const SizedBox(),
              body: EventDetailsScreenBackground(
                  child: ListView(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: custom.EditableText(
                        initialText: eventData.title ?? "N/A",
                        style: eventTitle,
                        onTapOutside: () {},
                        onSubmitted: (String text) {
                          setState(() {
                            showSave = true;
                            eventData.title = text.trim();
                          });
                        },
                      )),
                  ImageSlider(
                    imagesList: imageList,
                  ),
                  SizedBox(
                    height: imageList.isEmpty ? 0 : 4.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: custom.EditableText(
                      initialText: eventData.description ?? "N/A",
                      style: eventDescription,
                      onTapOutside: () {},
                      onSubmitted: (String text) {
                        setState(() {
                          showSave = true;
                          eventData.description = text.trim();
                        });
                      },
                    ),
                  )),
                ],
              )));
        },
      ),
    );
  }
}
