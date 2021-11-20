import 'package:app/features/file_explorer/data/directory_manager.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  FileExplorerBloc({
    required this.path,
  }) : super(FileExplorerInitialState());

  final _directoryManager = DirectoryManager();

  List<FileItem>? directoryContent;
  final String path;

  @override
  Stream<FileExplorerState> mapEventToState(FileExplorerEvent event) async* {
    if (event is InitializeFileExplorerEvent) {
      yield FileExplorerInitialState();
    } else if (event is FetchDataFileExplorerEvent) {
      yield* _fetchPathDataEvent(event);
    } else if (event is FetchDataErrorOccurredFileExplorerEvent) {
      yield* _fetchPathDataErrorEvent(event);
    } else if (event is FetchingDataFinishedFileExplorerEvent) {
      yield* _fetchPathDataSuccessEvent(event);
    }
  }

  Stream<FileExplorerState> _fetchPathDataEvent(
    FetchDataFileExplorerEvent event,
  ) async* {
    yield FetchingDataFileExplorerState();

    try {
      directoryContent = await _directoryManager.getCurrentDirectoryItems(path);

      yield FetchedDataFileExplorerState();
    } catch (exception) {
      yield const FetchingDataErrorFileExplorerState(
        errorMessage: 'Failed to fetch data.',
      );
    }
  }

  Stream<FileExplorerState> _fetchPathDataErrorEvent(
    FetchDataErrorOccurredFileExplorerEvent event,
  ) async* {
    yield const FetchingDataErrorFileExplorerState(
      errorMessage: 'Failed to fetch data.',
    );
  }

  Stream<FileExplorerState> _fetchPathDataSuccessEvent(
    FetchingDataFinishedFileExplorerEvent event,
  ) async* {
    yield FetchedDataFileExplorerState();
  }
}
