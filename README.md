# Project_Eltraco 
<p>Project_eltraco (Explore – Tradisi – Community) adalah sebuah aplikasi quiz edukatif berbasis web & PWA yang mengajak pengguna menjelajahi kearifan lokal Indonesia melalui kuis interaktif, tantangan harian, dan sistem gamifikasi yang memikat.</p>
<br>
### 📂 Struktur Folder Proyek
FLUTTER_ELTRACO/
├── assets/                       # Aset gambar, ikon, dan animasi (Lottie/Rive)
├── lib/                          # Source code utama aplikasi
│   ├── core/                     # Utilitas global, tema, dan konstanta
│   ├── features/                 # Implementasi fitur (Clean Architecture)
│   │   ├── auth/                 # Fitur Autentikasi
│   │   │   └── presentation/     # UI: login_page.dart
│   │   ├── history/              # Fitur Riwayat Kuis
│   │   │   └── presentation/     # UI: history_page.dart
│   │   ├── leaderboard/          # Fitur Papan Skor
│   │   │   └── presentation/     # UI: leaderboard_page.dart
│   │   ├── profile/              # Fitur Profil Pengguna
│   │   ├── quiz/                 # Fitur Utama Kuis
│   │   │   ├── data/             # Model & Repository: quiz_model.dart, quiz_repo.dart
│   │   │   └── presentation/     # UI: quiz_create_page.dart, quiz_list_page.dart, quiz_play_page.dart
│   │   └── settings/             # Fitur Pengaturan
│   │       └── presentation/     # UI: settings_page.dart
│   ├── static/                   # Halaman statis: about_page.dart, info_page.dart
│   ├── firebase_options.dart     # Konfigurasi Firebase
│   └── main.dart                 # Titik masuk utama aplikasi
├── pubspec.yaml                  # Konfigurasi dependensi proyek
└── README.md                     # Dokumentasi proyek
<p>==========================================================================</p>
<p>Kemudian di dalam quiz tersebut ada fitur nya yaitu:</p>
<p>==============================================================================================================================================</p>
<li>
  <h1>Leaderboard</h1>
  <p>Leaderboard merupakan sebuah fitur yang dapat melihat peringkat setelah memilih quiz selesai</p>
  <img width="1919" height="1017" alt="Screenshot 2026-01-20 152518" src="https://github.com/user-attachments/assets/ccd2aeb2-38e8-494a-905d-f0919f77eded" />
</li>
<li>
  <h1>Profil</h1>
  <p>Profil merupakan sebuah fitur yang dapat melihat profil setelah melakukan login</p>
<img width="1919" height="1012" alt="Screenshot 2026-01-20 152542" src="https://github.com/user-attachments/assets/1c3ef264-0838-43b3-bdf5-ea4326ceaed2" />
</li>
<li>
  <h1>Riwayat</h1>
  <p>riwayat merupakan sebuah fitur yang dapat melihat ketika sudah selesai quiz nya</p>
<img width="1919" height="1019" alt="Screenshot 2026-01-20 152532" src="https://github.com/user-attachments/assets/5d4a235a-0caa-477d-9ca7-9e09e470aca7" />
</li>
<li>
  <h1>Pilih quiz</h1>
  <p>merupakan sebuah fitur yang dapat memilih quiz yang diinginkan oleh pengguna</p>
<img width="1919" height="1021" alt="Screenshot 2026-01-20 152502" src="https://github.com/user-attachments/assets/23c6f1be-0406-44a2-bba3-909bf5828ccb" />
</li>
<li>
  <h1>Pengaturan</h1>
  <p>pengaturan merupakan sebuah fitur yang dapat melihat dan mengatur yang diinginkan oleh pengguna</p>
<img width="1919" height="1013" alt="Screenshot 2026-01-20 152602" src="https://github.com/user-attachments/assets/a9bfa600-6934-4cf7-860c-1cec5a4ddf9d" />
</li>
<li>
  <h1>Tentang</h1>
  <p>merupakan tentang penjelasan dari sebuah platform tersebut</p>
<img width="1919" height="1022" alt="Screenshot 2026-01-20 152610" src="https://github.com/user-attachments/assets/2f5abec3-80b6-4597-b207-caffb4b96c4b" />
</li>
<li>
  <h1>Info</h1>
  <p>merupakan fitur dari penjelasan mengenai platform yang sudah dibuat</p>
<img width="1919" height="1018" alt="Screenshot 2026-01-20 153537" src="https://github.com/user-attachments/assets/5ff34ac7-7180-4341-86fd-7c005fc4f5fc" />
<img width="1919" height="906" alt="Screenshot 2026-01-20 153551" src="https://github.com/user-attachments/assets/5e5a66a3-2b5e-43dc-bdb5-5c07ac47c6cd" />
<li>
  <h1>Keluar</h1>
  <p>merupakan fitur yang dapat ketika keluar maka akan ke arah login untuk mengakses ke halaman lain tersebut</p>
<img width="1919" height="1020" alt="Screenshot 2026-01-20 153603" src="https://github.com/user-attachments/assets/c8f52937-b5ee-40d9-8a09-2f57c6b256d4" />
<img width="1919" height="1017" alt="Screenshot 2026-01-20 152444" src="https://github.com/user-attachments/assets/027d3c87-ca15-41f9-ac1d-ae0e6591cccd" />
</li>
<li>
  <h1>Login dan register</h1>
  <p>merupakan fitur yang dimana kalau register itu buat yang belum punya akun dan login itu yang sudah membuat register baru dan dari kedua nya bisa akses ke halaman pilih quiz dengan tombol kalau login itu masuk dan register itu daftar baru</p>
  <img width="1919" height="1017" alt="Screenshot 2026-01-20 152444" src="https://github.com/user-attachments/assets/5c833ffa-211c-4e7b-82dd-02185445e685" />
</li>
<br>
<p>berikut rekaman nya ada di youtube: </p>
<p><a href="https://youtu.be/nsy5b6OS1eU"></a>SistemquizEltraco</p>
<p>=============================================================================================================================================</p>
</br>
<h1>Tools yang digunakan yaitu:</h1>
<li>
  <p>Aplikasi untuk code nya: Visual studio code</p>
  <p>Framework              : Flutter</p>
</li>
<p>==========================================================================</p>

###Daftar Dependensi Project_Eltraco
| Kategori | Package | Versi | Deskripsi |
| :--- | :--- | :---: | :--- |
| **Firebase** | `firebase_core` | `^4.2.1` | Inisialisasi layanan Firebase dalam aplikasi. |
| | `firebase_auth` | `^6.1.2` | Sistem login dan autentikasi pengguna. |
| | `cloud_firestore` | `^6.1.0` | Database NoSQL real-time untuk menyimpan data kuis. |
| | `firebase_storage` | `^13.0.4` | Penyimpanan file gambar atau aset lainnya. |
| | `firebase_analytics` | `^12.0.4` | Pelacakan dan analisis perilaku pengguna. |
| **Networking** | `http` | `^1.6.0` | Request API standar untuk mengambil data dari internet. |
| | `dio` | `^5.7.0` | HTTP Client yang lebih powerful dengan fitur interceptor. |
| **UI & Animasi** | `flutter_animate` | `^4.5.0` | Menambahkan animasi pada widget dengan kode yang ringkas. |
| | `lottie` | `^3.3.2` | Menampilkan animasi berbasis JSON dari LottieFiles. |
| | `rive` | `^0.14.0` | Integrasi animasi vektor interaktif yang kompleks. |
| | `animated_text_kit` | `^4.2.2` | Berbagai macam efek animasi untuk teks. |
| | `percent_indicator` | `^4.2.5` | Menampilkan progres kuis dalam bentuk bar atau lingkaran. |
| **Navigation** | `go_router` | `^14.0.0` | Sistem navigasi/routing deklaratif untuk Flutter. |
| **State Management**| `provider` | `^6.1.5` | Manajemen state aplikasi yang efisien dan ringan. |
| **Utilities** | `cached_network_image`| `^3.4.1` | Mengunduh dan menyimpan cache gambar dari jaringan. |
| | `flutter_svg` | `^1.1.6` | Merender gambar dalam format vektor (SVG). |
| | `shared_preferences`| `^2.3.2` | Menyimpan data sederhana (key-value) secara lokal. |
| | `url_launcher` | `^6.3.2` | Membuka link web, email, atau nomor telepon. |
| | `collection` | `^1.19.1` | Fungsi bantuan untuk manipulasi list, set, dan map. |
| | `cupertino_icons` | `^1.0.8` | Kumpulan ikon bergaya iOS. |
