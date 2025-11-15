import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_item.dart';
import '../utils/data_loader.dart';

class CartNotifier extends StateNotifier<AsyncValue<List<CartItem>>> {
  CartNotifier() : super(const AsyncValue.loading()) {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    try {
      final items = await DataLoader.loadCartItems();
      state = AsyncValue.data(items);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  void addToCart(CartItem item) {
    state.whenData((items) {
      state = AsyncValue.data([...items, item]);
    });
  }

  void removeFromCart(String itemId) {
    state.whenData((items) {
      final newItems = items.where((i) => i.id != itemId).toList();
      state = AsyncValue.data(newItems);
    });
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, AsyncValue<List<CartItem>>>((ref) {
  return CartNotifier();
});

final cartItemsProvider = Provider<List<CartItem>>((ref) {
  final cartAsync = ref.watch(cartProvider);
  return cartAsync.maybeWhen(
    data: (items) => items,
    orElse: () => [],
  );
});
