import 'package:app_client/blocs/notes_state.dart';
import 'package:app_client/constants/custom_colors.dart';
import 'package:app_client/ui/appbar/main_app_bar.dart';
import 'package:app_client/ui/main_screen_with_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'main_screen_empty.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();

    return Scaffold(
      appBar: MainAppBar(
        onInfoPress: () => openDialog(context),
        onSearchPress: () => Navigator.pushNamed(context, '/search'),
      ),
      body: StreamBuilder<NotesState>(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {
          if (snapshot.data!.currentNotes.isEmpty) {
            return const MainScreenEmpty();
          } else {
            return MainScreenWithContent(
              notes: snapshot.requireData.currentNotes.reversed.toList(),
            );
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton(
          onPressed: () => {
            Navigator.pushNamed(context, '/add'),
          },
          elevation: 24,
          backgroundColor: Colors.grey[100],
          child: const Icon(Icons.add_rounded, color: CustomColors.darkGrey,),
        ),
      ),
    );
  }

  Future openDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 330,
          height: 46,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Google Akademi Uygulaması',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Aleyna Seçer, XXXX, XXXX',
                style: TextStyle(color: Colors.white),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
