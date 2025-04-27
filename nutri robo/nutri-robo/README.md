# nutri-robo

Repositori ini dibuat untuk memenuhi tugas Proyek Tengah Semester (PTS) mata kuliah Pemrograman Berbasis Platform yang diselenggarakan Fakultas Ilmu Komputer, Universitas Indonesia Semester Ganjil 2022/2023 Kelompok A-08.

Tautan aplikasi (via Railway): https://nutrirobo.up.railway.app/

## Anggota Kelompok

+ Anindya Lokeswara - 2106633696
+ Bimo Henokh Barata - 2106752395
+ Afiq Ilyasa Akmal - 2106751291 
+ Eldira Lahanny Permata Sherman - 2106640360
+ Kathleen Daniella Wijaya - 2106637366 

## Tentang nutri-robo

Nutri-robo merupakan aplikasi yang dibuat dengan tujuan untuk mengusung tema Global Health. Secara garis besar, nutri-robo merupakan sebuah aplikasi yang akan membantu penggunanya untuk meningkatkan kualitas kesehatan masyarakat global dengan cara pemenuhan kebutuhan gizi, olahraga, dan waktu tidur. Nutri-robo akan memberikan suatu target yang sesuai dengan data diri masing-masing pengguna dan target ini perlu dipenuhi agar dapat mencapai kehidupan yang lebih sehat. Tidak berhenti sampai di situ saja, nutri-robo juga akan memberikan rekomendasi terkait makanan, olahraga, dan waktu tidur serta memberikan daily motivation dan feedback bagi pengguna untuk mempertahankan kebiasaan yang sudah baik dan meningkatkan kebiasaan yang masih bisa ditingkatkan.

Beberapa alasan kelompok kami memutuskan untuk membuat aplikasi nutri-robo antara lain adalah:
1. Stunting
- Terdapat banyak femomena stunting atau gagal tumbuh karena kekurangan gizi di Indonesia. Permasalahan stunting merupakan masalah yang serius karena dapat berdampak pada kualitas Sumber Daya Manusia (SDM). Dampak jangka pendeknya antara lain adalah terganggunya perkembangan otak yang dapat mempengaruhi kecerdasan serta gangguan pertumbuhan fisik dan metabolisme dalam tubuh. Dampak jangka panjang stunting adalah kemampuan kognitif, prestasi belajar, dan sistem kekebalan tubuh menurun, berisiko tinggi untuk terkena penyakit diabetes, jantung, kanker, stroke, dan disabilitas pada usia tua.
2. Obesitas
- Selain masalah stunting, angka obesitas di Indonesia juga cukup tinggi. Data Riskesdas 2018 menunjukkan bahwa 21,8% masyarakat Indonesia mengalami obesitas. Angka ini cukup tinggi jika dibandingkan dengan negara lain. Jika stunting lebih banyak dialami oleh anak-anak dan balita, masalah kelebihan berat badan (obesitas) justru lebih dominan dialami oleh populasi dewasa. Obesitas berisiko 2 kali lipat mengakibatkan terjadinya serangan jantung koroner, stroke, diabetes melitus, dan hipertensi, serta berisiko 3 kali lipat terkena batu empedu.
3. Dehidrasi
- Berdasarkan studi terkini, 46,1% masyarakat Indonesia mengalami dehidrasi ringan. Angka ini sangatlah tinggi sehingga membutuhkan perhatian khusus agar dapat segera ditangani. Saat tubuh tidak mendapatkan air yang cukup, maka seseorang dapat mengalami dehidrasi yang dapat membuat tekanan darah rendah, mual dan muntah, sembelit, sakit kepala, stroke, tidak bertenaga, kulit kering, serta penyakit batu ginjal dan infeksi saluran kencing.
4. Insomnia
- Insomnia merupakan gangguan yang menyebabkan penderitanya sulit tidur sehingga tidak mendapatkan waktu tidur yang cukup. Di Indonesia sendiri, CNN Indonesia menyatakan bahwa penderita insomnia diperkirakan mencapai 10%, yang artinya dari total 238 juta penduduk indonesia, sekitar 23 juta jiwa menderita insomnia. Gangguan ini dapat menyebabkan stroke, penyakit jantung, tekanan darah tinggi, obesitas, penurunan sistem kekebalan tubuh, bahkan gangguan kesehatan mental. 

Oleh karena itu, agar tubuh tetap sehat dan terhindar dari berbagai penyakit kronis atau penyakit tidak menular, maka pola hidup masyarakat perlu ditingkatkan ke arah yang lebih sehat dengan konsumsi gizi seimbang serta tidur dan olahraga yang cukup. Dengan demikian, kami berharap dengan adanya aplikasi nutri-robo, kami dapat membantu peningkatan kualitas hidup masyarakat global dengan cara memberi motivasi dan pemahaman mengenai pentingnya pemenuhan gizi dan tidur per hari, serta menjadi asisten kesehatan secara pribadi yang bersifat interaktif dan tidak membosankan.

## Modul

1. Home (landing page)
- Sambutan bagi pengguna pada halaman web nutri-robo
- Latar belakang dibuatnya nutri-robo secara singkat 
- Navigation bar ke menu-menu lain yang tersedia pada halaman web nutri-robo

2. Profile
- Data diri pengguna
- Kebutuhan kalori, gizi, air, olahraga, dan waktu tidur untuk setiap pengguna berdasarkan data pengguna (target yang harus dicapai untuk mencapai kehidupan yang sehat)
- Logout

3. Tracker
- Tracker untuk mencatat konsumsi pengguna baik makanan maupun minuman, apakah pengguna olahraga atau tidak, serta waktu tidur pengguna
- Feedback bagi pengguna agar dapat mempertahankan kebiasaan yang sudah baik dan meningkatkan kebiasaan yang masih kurang sehingga dapat mencapai kehidupan yang lebih sehat lagi

4. Blog
- Widget untuk daily motivation bagi pengguna
- Tips-tips kesehatan yang dapat diunggah oleh admin dan instruktur dan dapat dikomentari oleh user
- Berita terbaru terkait kesehatan

5. FAQ
- Jawaban dari pertanyaan yang sering ditanyakan oleh pengguna

## Role Pengguna

1. Pengguna
- Mengakses akun dan menggunakan fitur-fitur yang tersedia bagi pengguna.
- Role ini terbagi menjadi dua yaitu, user dan instruktur. Kedua role ini dibedakan dengan adanya simbol verifikasi di sebelah nama instruktur. Selain itu, instruktur memiliki akses untuk mengunggah sebuah artikel dalam modul blog, sementara user hanya boleh mengomentari artikel.

2. Admin 
- Melakukan authorization dan authentication pengguna, menjadi pengawas kegiatan pada halaman web nutri-robo, melakukan interaksi dengan pengguna seperti memberikan feedback dan mengunggah artikel dimodul blog.
