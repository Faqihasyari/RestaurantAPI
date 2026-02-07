String mapErrorToMessage(Object e) {
  final error = e.toString();

  if (error.contains('SocketException') ||
      error.contains('Failed host lookup')) {
    return 'Tidak ada koneksi internet.\nPeriksa koneksi Anda dan coba lagi.';
  }

  if (error.contains('TimeoutException')) {
    return 'Koneksi terlalu lambat.\nSilakan coba lagi.';
  }

  return 'Terjadi kesalahan.\nSilakan coba lagi nanti.';
}
