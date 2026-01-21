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
  <img width="1919" height="1017" alt="Screenshot 2026-01-20 152518" src="https://github.com/user-attachments/assets/4f8ad290-5844-41a9-a611-df056f1ae0b0" />
</li>
<li>
  <h1>Profil</h1>
  <p>Profil merupakan sebuah fitur yang dapat melihat profil setelah melakukan login</p>
  <img width="1919" height="1012" alt="Screenshot 2026-01-20 152542" src="https://github.com/user-attachments/assets/c3edc354-1d69-4149-a871-f22507b8f9c2" />
</li>
<li>
  <h1>Riwayat</h1>
  <p>riwayat merupakan sebuah fitur yang dapat melihat ketika sudah selesai quiz nya</p>
<img width="1919" height="1019" alt="Screenshot 2026-01-20 152532" src="https://github.com/user-attachments/assets/deb7b39f-d6b9-47a7-bf08-bcc865b9e5c9" />
</li>
<li>
  <h1>Pilih quiz</h1>
  <p>merupakan sebuah fitur yang dapat memilih quiz yang diinginkan oleh pengguna</p>
<img width="1919" height="1021" alt="Screenshot 2026-01-20 152502" src="https://github.com/user-attachments/assets/80d53056-21a9-4d45-9bca-6c4a927a1884" />
</li>
<li>
  <h1>Pengaturan</h1>
  <p>pengaturan merupakan sebuah fitur yang dapat melihat dan mengatur yang diinginkan oleh pengguna</p>
<img width="1919" height="1013" alt="Screenshot 2026-01-20 152602" src="https://github.com/user-attachments/assets/176a554a-4ce0-4a08-ad18-d940e3d998e0" />
</li>
<li>
  <h1>Tentang</h1>
  <p>merupakan tentang penjelasan dari sebuah platform tersebut</p>
<img width="1919" height="1022" alt="Screenshot 2026-01-20 152610" src="https://github.com/user-attachments/assets/d50ae512-3236-406b-96dc-0fd4df083d2f" />
</li>
<li>
  <h1>Info</h1>
  <p>merupakan fitur dari penjelasan mengenai platform yang sudah dibuat</p>
<img width="1919" height="1018" alt="Screenshot 2026-01-20 153537" src="https://github.com/user-attachments/assets/9248f640-8fb1-4668-8692-c576161650f0" />
<img width="1919" height="906" alt="Screenshot 2026-01-20 153551" src="https://github.com/user-attachments/assets/d0947fce-ac06-4ab2-bad8-ae2d828a5a80" />
</li>
<li>
  <h1>Keluar</h1>
  <p>merupakan fitur yang dapat ketika keluar maka akan ke arah login untuk mengakses ke halaman lain tersebut</p>
<img width="1919" height="1020" alt="Screenshot 2026-01-20 153603" src="https://github.com/user-attachments/assets/b7d4f05b-96b9-48cd-8cc5-79f67110c814" />
<img width="1919" height="1017" alt="Screenshot 2026-01-20 152444" src="https://github.com/user-attachments/assets/c97a207b-d426-44dc-a92b-aa59e5a3587f" />
</li>
<br>
<p>berikut rekaman nya</p>

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
