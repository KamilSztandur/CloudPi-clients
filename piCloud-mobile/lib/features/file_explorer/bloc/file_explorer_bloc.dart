import 'package:app/features/file_explorer/data/DirectoryManager.dart';
import 'package:app/features/file_explorer/data/models/file_item.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_explorer_event.dart';
part 'file_explorer_state.dart';

class FileExplorerBloc extends Bloc<FileExplorerEvent, FileExplorerState> {
  DirectoryManager _directoryManager = DirectoryManager();

  List<FileItem>? directoryContent;
  final String path;

  FileExplorerBloc({
    required this.path,
  }) : super(FileExplorerInitialState());

  @override
  Stream<FileExplorerState> mapEventToState(FileExplorerEvent event) async* {
    if (event is InitializeFileExplorerEvent) {
      yield FileExplorerInitialState();
    } else if (event is FetchDataFileExplorerEvent) {
      yield* _fetchPathDataEvent(event);
    } else if (event is FetchDataErrorOccuredFileExplorerEvent) {
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
      this.directoryContent = await _directoryManager.getCurrentDirectoryItems(
        this.path,
      );

      yield FetchedDataFileExplorerState();
    } catch (exception) {
      yield FetchingDataErrorFileExplorerState(
        errorMessage: "Failed to fetch data.",
      );
    }
  }

  Stream<FileExplorerState> _fetchPathDataErrorEvent(
    FetchDataErrorOccuredFileExplorerEvent event,
  ) async* {
    yield FetchingDataErrorFileExplorerState(
      errorMessage: "Failed to fetch data.",
    );
  }

  Stream<FileExplorerState> _fetchPathDataSuccessEvent(
    FetchingDataFinishedFileExplorerEvent event,
  ) async* {
    yield FetchedDataFileExplorerState();
  }
}
