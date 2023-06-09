import 'package:app_client/blocs/notes_color_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_color_cubit.dart';
import '../blocs/notes_cubit.dart';
import '../constants/custom_colors.dart';
import '../database/tables.dart';
import 'appbar/show_note_app_bar.dart';

class ShowNoteScreen extends StatelessWidget {
  ShowNoteScreen({super.key});

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();
    var colorCubit = context.read<NotesColorCubit>();

    Note note = (ModalRoute.of(context)?.settings.arguments as Map)['note'];

    colorCubit.changeColor(note.color);
    _titleController.text = note.title;
    _bodyController.text = note.content;

    return StreamBuilder<NotesColorState>(
        stream: colorCubit.stream,
        initialData: colorCubit.state,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: ShowNoteAppBar(
              onBackPressed: () async {
                await saveChanges(context, cubit, colorCubit, note);
              },
              color: colorCubit.state.noteColor,
              onColorChangePress: () => changeColor(context, colorCubit),
            ),
            body: WillPopScope(
              onWillPop: () async {
                return await saveChanges(context, cubit, colorCubit, note);
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        textCapitalization: TextCapitalization.sentences,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 38),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _bodyController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<void> changeColor(BuildContext context, NotesColorCubit colorCubit) {
    return showDialog(
      context: context,
      builder: (context) => StreamBuilder<NotesColorState>(
        initialData: colorCubit.state,
        stream: colorCubit.stream,
        builder: (context, snapshot) {
          return AlertDialog(
            content: SizedBox(
              width: 210,
              height: 110,
              child: GridView.builder(
                itemCount: CustomColors.colorsData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, childAspectRatio: 1),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () => {
                        colorCubit
                            .changeColor(CustomColors.colorsData[index].value),
                        Navigator.pop(context)
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Ink(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          color: CustomColors.colorsData[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> saveChanges(BuildContext context, NotesCubit cubit,
      NotesColorCubit colorCubit, Note note) async {
    cubit.updateNote(Note(
        id: note.id,
        title: _titleController.text,
        content: _bodyController.text,
        color: colorCubit.state.noteColor));
    Navigator.pop(context);
    return false;
  }
}
