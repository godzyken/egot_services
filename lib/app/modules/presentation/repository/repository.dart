import 'package:egot_services/app/models/store_model.dart';
import 'package:egot_services/app/modules/presentation/providers/presentation_provider.dart';

abstract class IStoreRepository {
  Future<Store> getNews();
}

class StoreRepository implements IStoreRepository {
  StoreRepository({required this.provider});
  final IPresentationProvider provider;

  @override
  Future<Store> getNews() async {
    final response = await provider.getNews();
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response.body!;
    }
  }
}
