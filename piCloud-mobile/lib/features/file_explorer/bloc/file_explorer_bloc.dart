import 'package:app/features/file_explorer/data/DirectoryManager.dart';
import 'package:app/features/file_explorer/presentation/widgets/file_explorer_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  DirectoryManager _directoryManager = DirectoryManager();
  final String path;

  List<FileExplorerItem>? directoryContent;

  FileExplorerBloc({
    required this.path,
  }) : super(FileExplorerInitialState());

  @override
  Stream<FileExplorerState> mapEventToState(FileExplorerEvent event) async* {
    if (event is InitializeFileExplorerEvent) {
      yield FileExplorerInitialState();
    } else if (event is FetchDataFileExplorerEvent) {
      yield* _fetchPathDataEvent(event);
    } else if (event is FetchDataErrorFileExplorerEvent) {
      yield* _fetchPathDataErrorEvent(event);
    } else if (event is FetchingDataFinishedFileExplorerEvent) {
      yield* _fetchPathDataSuccessEvent(event);
    }
  }

  Stream<FileExplorerState> _fetchPathDataEvent(
    FetchDataFileExplorerEvent event,
  ) async* {
    yield FetchningDataFileExplorerState();

    try {
      //TODO
      await Future.delayed(Duration(seconds: 5));

      this.directoryContent =
          _directoryManager.getCurrentDirectoryItems(this.path);
      yield FetchedDataFileExplorerState(data: this.directoryContent!);
    } catch (exception) {
      yield FetchingDataErrorFileExplorerState(
        errorMessage: "Failed to fetch data.",
      );
    }
  }

  Stream<FileExplorerState> _fetchPathDataErrorEvent(
    FetchDataErrorFileExplorerEvent event,
  ) async* {
    yield FetchingDataErrorFileExplorerState(
      errorMessage: "Failed to fetch data.",
    );
  }

  Stream<FileExplorerState> _fetchPathDataSuccessEvent(
    FetchingDataFinishedFileExplorerEvent event,
  ) async* {
    yield FetchedDataFileExplorerState(data: this.directoryContent!);
  }
}
