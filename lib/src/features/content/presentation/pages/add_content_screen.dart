import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_clean/src/features/content/presentation/blocs/add_content/add_content_cubit.dart';
import 'package:flutter_social_clean/src/shared/presentation/widgets/custom_video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddContentScreen extends StatelessWidget with UiLoggy {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
        actions: [
          BlocBuilder<AddContentCubit, AddContentState>(
            builder: (context, state) {
              if (state.video != null) {
                return IconButton(
                    onPressed: () {
                      loggy.debug("pressed reset");
                      context.read<AddContentCubit>().reset();
                    },
                    icon: const Icon(Icons.clear));
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
      body: BlocConsumer<AddContentCubit, AddContentState>(
        buildWhen: (previous, current) => previous.video != current.video,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Select a Video',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onPressed: () async {
                  //ASPETTO L'UPLOAD DEL VIDEO POI CHOAMO IL CUBIT A DIRE CHE è CAMBIATO
                  await _handleVideo().then((video) {
                    if (video != null) {
                      context.read<AddContentCubit>().videoChanged(video!);
                    }
                  });
                },
              ),
            );
          } else if (state.video != null) {
            loggy.debug(state.video!.path);
            return Stack(fit: StackFit.expand, children: [
              CustomVideoPlayer(
                assetPath: state.video!.path,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        _addCaption(context);
                      },
                      child: Text(
                        'Share',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
            ]);
          } else {
            return const Text("Something went wrong");
          }
        },
      ),
    );
  }

  Future<File?> _handleVideo() async {
    XFile? uploadedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (uploadedVideo == null) {
      return null;
    }
    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadedVideo.path);
    final savedVideo =
        await File(uploadedVideo.path).copy('${directory.path}/$fileName');
    loggy.debug(savedVideo);
    return savedVideo;
  }

  Future<dynamic> _addCaption(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (newContext) {
        return Container(
          color: Colors.white.withAlpha(175),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add you caption',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
