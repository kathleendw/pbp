[![Staging](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/staging.yml/badge.svg)](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/staging.yml) [![Release](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/release.yml/badge.svg)](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/release.yml) [![Pre-Release](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/pre-release.yml/badge.svg)](https://github.com/afiqilyasakmal/nutri-robo-mobile/actions/workflows/pre-release.yml) [![Build status](https://build.appcenter.ms/v0.1/apps/0c325bf0-89ef-4044-a0b9-3249217f0574/branches/main/badge)](https://appcenter.ms)
## Link Tautan APK
[Nutrirobo's app on Appcenter](https://install.appcenter.ms/orgs/a08-nutri-robo/apps/nutri-robo/distribution_groups/public)
## Anggota Kelompok 👥 
- Anindya Lokeswara - 2106633696 (Home) <br>
- Bimo Henokh Barata - 2106752395 (FAQ) <br>
- Afiq Ilyasa Akmal - 2106751291 (Blog) <br>
- Eldira Lahanny Permata Sherman - 2106640360 (Target Health) <br>
- Kathleen Daniella Wijaya - 2106637366 (Tracker) <br>

## About Nutri-Robo 🩺
*In order to help the world, you must help yourself first.* <br>

Nutri-robo merupakan aplikasi yang dibuat dengan tujuan untuk mengusung tema **Global Health**. Secara garis besar, nutri-robo merupakan sebuah aplikasi yang akan membantu penggunanya dalam meningkatkan kualitas kesehatan masyarakat global dengan cara pemenuhan kebutuhan gizi, air, olahraga, dan waktu tidur.<br>

## How Nutri-Robo Works 📥
Nutri-robo akan memberikan suatu target yang sesuai dengan data diri masing-masing pengguna. Target ini perlu dipenuhi agar dapat mencapai kehidupan yang lebih sehat. Untuk memantau proses pencapaian target, nutri-robo menawarkan fitur tracker. Tidak berhenti sampai di situ saja, nutri-robo juga akan memberikan informasi terkait kesehatan yang akan memberikan motivasi bagi pengguna untuk menjalani pola hidup yang sehat.<br>

## Why Nutri-Robo 📝
Berikut ini adalah beberapa masalah kesehatan dengan kasus yang tinggi di Indonesia: <br>
- Stunting yang dapat berdampak pada kualitas Sumber Daya Manusia (SDM) <br>
- Obesitas yang meningkatkan resiko terjadinya berbagai penyakit sebanyak 2-3 kali lipat <br>
- Dehidrasi yang dapat membuat tekanan darah rendah, sembelit, stroke, kulit kering, dan lain sebagainya. <br>
- Insomnia yang menyebabkan penderitanya sulit tidur sehingga tidak mendapatkan waktu tidur yang cukup. <br>

Oleh karena itu, agar tubuh tetap sehat dan terhindar dari berbagai penyakit kronis atau penyakit tidak menular, maka pola hidup masyarakat perlu ditingkatkan ke arah yang lebih sehat dengan konsumsi gizi seimbang serta tidur dan olahraga yang cukup. Dengan demikian, kami berharap dengan adanya aplikasi nutri-robo, kami dapat membantu peningkatan kualitas hidup masyarakat global dengan menjadi asisten kesehatan pribadi yang bersifat interaktif dan tidak membosankan. <br>

## Persona 🧑‍💻
1. Pengguna <br>
- Dapat mengakses akun dan menggunakan fitur-fitur yang tersedia bagi pengguna <br>
- Terbagi menjadi dua yaitu, user dan instruktur. Kedua role ini dibedakan dengan adanya simbol verifikasi di sebelah nama instruktur. Selain itu, instruktur memiliki akses untuk mengunggah sebuah artikel dalam modul blog, sementara user hanya memiliki akses untuk mengomentari artikel <br>

2. Admin <br>
- Melakukan authorization dan authentication pengguna <br>
- Menjadi pengawas kegiatan pada aplikasi nutri-robo <br>
- Melakukan interaksi dengan pengguna seperti memberikan feedback dan mengunggah artikel di modul blog <br>

## Daftar Modul 📲
#### 1. Home (landing page) 👋
- Sambutan bagi pengguna pada aplikasi nutri-robo <br>
- Perkenalan nutri-robo secara singkat <br>
- Navigation bar ke menu-menu lain yang tersedia pada aplikasi nutri-robo <br>
- Feedback user pada nutri-robo <br>

#### 2. Profile 👤
- Data diri pengguna <br>
- Kebutuhan kalori, air, olahraga, dan waktu tidur untuk setiap pengguna berdasarkan data pengguna (target yang harus dicapai untuk mencapai pola hidup yang sehat) <br>

#### 3. Tracker 🛣️
- Tracker untuk mencatat konsumsi pengguna baik makanan maupun minuman, aktivitas pengguna, serta waktu tidur pengguna <br>
- Feedback bagi pengguna agar dapat mempertahankan kebiasaan yang sudah baik dan meningkatkan kebiasaan yang masih kurang baik <br>

#### 4. Blog 🖥️
- Widget untuk daily motivation bagi pengguna <br>
- Tips-tips kesehatan yang dapat diunggah oleh admin dan instruktur dan dapat dikomentari oleh user <br>
- Berita terbaru terkait kesehatan <br>

#### 5. FAQ ❓
- Jawaban dari pertanyaan yang sering ditanyakan oleh pengguna <br>

## Alur Pengintegrasian dengan Web Service 💻
1. Menambahkan dependency `http` ke proyek untuk bertukar data melalui HTTP request <br>
2. Membuat model sesuai dengan respons dari data yang berasal dari web service <br>
3. Melakukan pengambilan data pada suatu web service dengan menggunakan dependensi http get <br>
4. Mengkonversikan objek yang sudah didapatkan dari web service ke model yang telah dibuat sebelumnya <br>
5. Menampilkan data yang terlah berhasil dikonversi ke aplikasi menggunakan `FutureBuilder` <br>
