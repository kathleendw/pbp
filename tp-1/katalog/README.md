Kathleen Daniella Wijaya | 2106637366 
# TUGAS 2 PBP

Link menuju aplikasi Heroku yang sudah dideploy:
https://tugasduapebepe.herokuapp.com/

dengan path: https://tugasduapebepe.herokuapp.com/katalog/ 

# Bagan dan Penjelasan
https://ristek.link/BaganRequestClient 
- User mengirim HTTP request pada server Django melalui browser internet
- Terdapat bagian/bot pada server yang mendeteksi dan mengekstraksi host dan port dari HTTP request user
- URL routing akan menentukan dan mengarahkan rute ke source code yang diinginkan. Pada server Django, URL routing dilakukan pada urls.py dimana file tersebut berisi path-path yang bisa diakses
- Masing-masing path ditangani oleh views.py yang berbeda sehingga urls.py akan forward request ke views.py yang menangani path yang diinginkan user
- Views.py tidak dapat mengakses langsung database sehingga views.py akan memanggil query ke models.py untuk mengambil data yang diperlukan. Models.py akan mengembalikan hasil dari query tersebut ke views.py
- Views.py akan mengambil template file HTML, lalu data yang sudah diberikan oleh models.py akan ditambahkan ke file HTML tersebut. Template file HTML bisa berbeda-beda untuk setiap path
- File HTML yang sudah diisi oleh data yang diinginkan akan dikembalikan ke user sebagai HTTP response melalui browser internet

# Virtual Environment
Virtual environment adalah sebuah lingkungan virtual yang tidak bisa diakses oleh dependencies utama. Oleh karena itu, virtual environment penting untuk digunakan karena dapat memisahkan dependencies yang diinstal pada setiap proyek Django sehingga perubahan yang dilakukan pada satu proyek tidak akan mempengaruhi proyek lainnya. Kita tetap dapat membuat aplikasi web berbasis Django tanpa menggunakan virtual environment. Namun, akan lebih baik jika setiap proyek Django memiliki virtual environment-nya sendiri agar perubahan yang terjadi pada satu proyek tidak akan berpengaruh pada proyek lain.

# Implementasi poin 1 sampai 4
- Masuk ke repositori source code yang disediakan dan memilih aksi "Use this template" (membuat repositori baru untuk aplikasi Django bernama "Tugas-2-PBP")
- Mengclone repositori tersebut ke laptop
- Masuk ke dalam repositori yang sudah diclone ke laptop pada terminal
- Membuat dan menyalakan virtual environment
- Menginstal dependencies yang diperlukan untuk menjalankan proyek Django 
- Membuat sebuah fungsi yang menerima parameter request dan mengembalikan render(request, "katalog.html") pada file views.py yang ada pada folder katalog
- Mengimplementasikan URL routing pada file urls.py yang ada pada folder katalog dan folder project_django
- Mempersiapkan migrasi skema model ke dalam database Django lokal dan menerapkan skema model tersebut
- Memasukkan data ke dalam database Django lokal
- Mengimport models yang sudah dibuat pada file views.py agar dapat melakukan pengambilan data dari database
- Menambahkan kode pada fungsi di views.py untuk memanggil fungsi query ke model database dan menyimpan hasil query tersebut ke dalam sebuah variabel
- Menambahkan variabel berisi hasil query sebagai parameter ketiga pada pengembalian fungsi di views.py agar data yang ada pada variabel tersebut akan ikut di-render oleh Django sehingga dapat dimunculkan pada halaman HTML
- Mengubah bagian "Fill me!" yang ada di katalog.html menjadi nama variabel yang menyimpan data yang ingin ditampilkan pada halaman HTML (nama dan student_id)
- Melakukan iterasi terhadap variabel list_barang yang telah ikut di-render ke dalam HTML untuk menampilkan daftar barang ke dalam tabel
- Membuat aplikasi baru pada Heroku bernama "tugasduapebepe"
- Mengubah setiap variabel "project_django" menjadi "tugasduapebepe"
- Melakukan add, commit, dan push perubahan yang telah dilakukan ke Github
- Melakukan deployment ke Heroku terhadap aplikasi Django yang sudah dibuat 
