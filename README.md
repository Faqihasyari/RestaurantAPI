# 🍽️ Restaurant App

Aplikasi Flutter yang menampilkan daftar restoran menggunakan API publik dari Dicoding.  
Aplikasi ini menerapkan state management menggunakan Provider serta mendukung fitur pencarian dan penambahan review.

---

## 🚀 Fitur Utama

- ✅ Menampilkan daftar restoran
- ✅ Detail restoran lengkap (deskripsi, menu, review)
- ✅ Hero Animation (List → Detail & Search → Detail)
- ✅ Pencarian restoran
- ✅ Tambah review restoran
- ✅ Pull to Refresh
- ✅ Dark & Light Theme
- ✅ Loading indicator pada List & Detail
- ✅ Error handling dengan pesan yang user-friendly

---

## 🧠 State Management

Menggunakan:

- **Provider** untuk state management
- **ResultState** (Loading, HasData, ErrorState) untuk mengatur kondisi UI
- Repository Pattern untuk pemisahan logic data dan UI

---

## 🌐 API

Menggunakan API publik dari Dicoding

Endpoint yang digunakan:

- `/list`
- `/detail/{id}`
- `/search?q=query`
- `/review`

---
