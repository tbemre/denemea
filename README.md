# OpenLane: Açık Kaynak Donanım Tasarım Akışı

## Table of Contents
1. [Giriş](#giriş)
   - [OpenLane Nedir?](#openlane-nedir)
   - [OpenLane'de Kullanılan Temel Araçlar](#openlanede-kullanılan-temel-araçlar)
   - [OpenLane Akış Diyagramı](#openlane-akış-diyagramı)

3. [OpenLane ile Tasarım Süreci](#openlane-ile-tasarım-süreci)
   - [RTL Tasarımı](#rtl-tasarımı)
   - [Synthesis](#sentez-synthesis)
   - [Floorplaning](#floorplaning)
   - [Placement](#yerleştirme-ve-rotalama-placement-and-routing)
   - [Clock Tree Synthesis](#clock-tree-synthesis)
   - [Routing](#routing)
   - [Tapeout](#tapeout)
   - [Signoff](#signoff)
   - [Tasarım Sürecinin Özeti](#tasarım-sürecinin-özeti)

4. [OpenLane Kurulumu](#openlane-kurulumu)

5. [Openlane Kullanımı](#openlane-kullanımı)

6. [OpenLane ile İlgili Kaynaklar ve Topluluk](#openlane-ile-ilgili-kaynaklar-ve-topluluk)
   - [OpenLane Dokümantasyonu](#openlane-dokümantasyonu)
   - [OpenLane GitHub Deposu](#openlane-github-deposu)
   - [Topluluk Desteği ve Forumlar](#topluluk-desteği-ve-forumlar)
   - [Eğitim Materyalleri ve Öğreticiler](#eğitim-materyalleri-ve-öğreticiler)
   - [Örnek Projeler ve Kaynak Kodlar](#örnek-projeler-ve-kaynak-kodlar)
   - [Faydalı Bağlantılar](#faydalı-bağlantılar)

---

## 1. Giriş

### OpenLane Nedir?
OpenLane, açık kaynaklı bir donanım tasarım akışı (hardware design flow) aracıdır. Bu araç, özellikle ASIC (Application-Specific Integrated Circuit) tasarım süreçlerini otomatikleştirmek ve bu süreçleri daha erişilebilir hale getirmek amacıyla geliştirilmiştir. OpenLane, RTL (Register Transfer Level) tasarımından başlayarak fiziksel tasarımın tamamlanmasına kadar olan tüm adımları kapsayan bir tasarım akışı sunar. OpenLane, OpenROAD (Open-source EDA) projesinin bir parçası olarak geliştirilmiştir.

### OpenLane'de Kullanılan Temel Araçlar
- **Yosys (Sentez Aracı):** RTL tasarımını mantık kapıları seviyesine dönüştürür.
- **OpenROAD (Yerleştirme ve Rotalama):** Mantık kapılarının fiziksel olarak yerleştirilmesini ve bağlantılarının oluşturulmasını sağlar.
- **Magic (Fiziksel Doğrulama):** Tasarımın fiziksel kurallara uygun olup olmadığını kontrol eder.
- **Netgen (LVS - Layout vs. Schematic):** Fiziksel tasarımın, mantık şemasıyla uyumlu olup olmadığını kontrol eder.
- **OpenSTA (Zamanlama Analizi):** Tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığını analiz eder.
- **KLayout (GDSII Görüntüleme ve Düzenleme):** GDSII formatındaki tasarımları görselleştirme ve düzenleme imkanı sunar.

### OpenLane Akış Diyagramı
1. RTL Tasarımı
2. Sentez (Yosys)
3. Yerleştirme ve Rotalama (OpenROAD)
4. Zamanlama Analizi (OpenSTA)
5. Fiziksel Doğrulama (Magic ve Netgen)
6. GDSII Çıktısı

![OpenLane Flow Stages](https://github.com/tbemre/denemea/blob/main/images/flow.png)

---

## 2. OpenLane ile Tasarım Süreci

### RTL Tasarımı
RTL (Register Transfer Level) tasarımı, donanımın davranışsal tanımını içerir. Bu aşamada, tasarımınızı Verilog veya VHDL gibi bir donanım tanımlama dili kullanarak oluşturursunuz.

### Synthesis
Sentez aşamasında, RTL tasarımı mantık kapıları seviyesine dönüştürülür. Bu aşama, Yosys aracı tarafından gerçekleştirilir.

### Yerleştirme ve Rotalama (Placement and Routing)
Yerleştirme ve rotalama aşaması, OpenROAD aracı tarafından gerçekleştirilir. Bu aşamada, mantık kapıları fiziksel olarak yerleştirilir ve birbirleriyle bağlantıları oluşturulur.

### Zamanlama Analizi (Timing Analysis)
Zamanlama analizi, tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığını kontrol eder. Bu aşama, OpenSTA aracı tarafından gerçekleştirilir.

### Fiziksel Doğrulama (Physical Verification)
Fiziksel doğrulama, tasarımın fiziksel kurallara uygun olup olmadığını kontrol eder. Bu aşama, Magic ve Netgen araçları tarafından gerçekleştirilir.

### GDSII Çıktısı
Tasarım sürecinin son aşamasında, tasarımınız GDSII formatında dışa aktarılır. GDSII, çip üretimi için kullanılan standart bir dosya formatıdır.


Aşağıda, belirttiğiniz başlıklar altındaki araçların tanımlarını ve yaptıklarını 2-3 cümleyle açıklıyorum:

---

### **Synthesis**
- **Yosys**: RTL (Register Transfer Level) kodunu sentezleyerek mantık kapılarına dönüştürür ve teknoloji haritalama işlemi gerçekleştirir. Bu, tasarımın donanım uyumlu hale getirilmesi için ilk adımdır.
- **OpenSTA**: Sentezlenmiş netlist üzerinde statik zamanlama analizi yaparak, tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığını kontrol eder ve zamanlama raporları oluşturur.

---

### **Floorplaning**
- **OpenROAD/Initialize Floorplan**: Tasarımın çekirdek alanını, makro blokların yerleşimi için satırları ve yönlendirme için izleri tanımlar. Bu, fiziksel tasarımın temelini oluşturur.
- **OpenLane IO Placer**: Tasarımın giriş ve çıkış portlarını yerleştirir. Bu, sinyallerin doğru şekilde bağlanabilmesi için kritik bir adımdır.
- **OpenROAD/PDN Generator**: Güç dağıtım ağını (Power Distribution Network) oluşturur. Bu, tasarımın güç ve toprak bağlantılarını sağlamak için gereklidir.
- **OpenROAD/Tapcell**: Welltap ve endcap hücrelerini yerleştirir. Bu hücreler, sızıntı akımlarını önlemek ve tasarımın fiziksel kurallara uygun olmasını sağlamak için kullanılır.

---

### **Placement**
- **OpenROAD/RePlace**: Global yerleştirme işlemi gerçekleştirir. Bu, tasarım bileşenlerinin yaklaşık olarak nereye yerleştirileceğini belirler.
- **OpenROAD/Resizer**: İsteğe bağlı olarak tasarım üzerinde optimizasyonlar yapar. Örneğin, hücre boyutlarını ayarlayarak performansı artırabilir.
- **OpenROAD/OpenDP**: Global yerleştirme sonrası bileşenlerin kesin yerlerini belirleyerek legalizasyon işlemi gerçekleştirir.

---

### **CTS (Clock Tree Synthesis)**
- **OpenROAD/TritonCTS**: Saat dağıtım ağını (clock tree) sentezler. Bu, saat sinyalinin tüm tasarımda eşit şekilde dağıtılmasını sağlar.

---

### **Routing**
- **OpenROAD/FastRoute**: Global yönlendirme işlemi yaparak, detaylı yönlendirici için bir kılavuz dosyası oluşturur. Bu, sinyallerin genel rotalarını belirler.
- **OpenROAD/TritonRoute**: Detaylı yönlendirme işlemi gerçekleştirir. Bu, sinyallerin kesin bağlantılarını oluşturur.
- **OpenROAD/OpenRCX**: SPEF (Standard Parasitic Exchange Format) dosyası çıkarır. Bu, tasarımın parazitik etkilerini modellemek için kullanılır.

---

### **Tapeout**
- **Magic**: Yönlendirilmiş DEF dosyasından final GDSII layout dosyasını oluşturur. GDSII, üretim için kullanılan standart bir dosya formatıdır.
- **KLayout**: Magic'e alternatif olarak GDSII dosyasını oluşturur. Bu, yedekleme amacıyla kullanılabilir.

---

### **Signoff**
- **Magic**: DRC (Design Rule Check) ve Antenna Check işlemlerini gerçekleştirir. Bu, tasarımın üretim kurallarına uygun olup olmadığını kontrol eder.
- **Magic**: İki GDSII dosyası arasında XOR kontrolü yaparak tutarlılığı doğrular.
- **Netgen**: LVS (Layout vs. Schematic) kontrolü yapar. Bu, layoutun orijinal şematikle eşleştiğini doğrular.

---

Bu araçlar, OpenLane akışında ücretsiz, açık kaynaklı ve özgür yazılımlar olarak kullanılır. OpenLane, Apache 2.0 lisansı altında olmasına rağmen, bazı araçlar daha katı lisanslara sahip olabilir.




---

## 3. OpenLane Kurulumu

Detaylı kurulum için ["bu"](https://www.youtube.com/watch?v=jEGq7JVHGvQ) linki takip ederek gerekli olan tüm temel araçların kulumunu tamamlamış olursunuz.

---

## 4. OpenLane ile Tasarım Süreci

### RTL Tasarımı
RTL (Register Transfer Level) tasarımı, donanımın davranışsal tanımını içerir. Bu aşamada, tasarımınızı Verilog veya VHDL gibi bir donanım tanımlama dili kullanarak oluşturursunuz.

### Sentez (Synthesis)
Sentez aşamasında, RTL tasarımı mantık kapıları seviyesine dönüştürülür. Bu aşama, Yosys aracı tarafından gerçekleştirilir.

### Yerleştirme ve Rotalama (Placement and Routing)
Yerleştirme ve rotalama aşaması, OpenROAD aracı tarafından gerçekleştirilir. Bu aşamada, mantık kapıları fiziksel olarak yerleştirilir ve birbirleriyle bağlantıları oluşturulur.

### Zamanlama Analizi (Timing Analysis)
Zamanlama analizi, tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığını kontrol eder. Bu aşama, OpenSTA aracı tarafından gerçekleştirilir.

### Fiziksel Doğrulama (Physical Verification)
Fiziksel doğrulama, tasarımın fiziksel kurallara uygun olup olmadığını kontrol eder. Bu aşama, Magic ve Netgen araçları tarafından gerçekleştirilir.

### GDSII Çıktısı
Tasarım sürecinin son aşamasında, tasarımınız GDSII formatında dışa aktarılır. GDSII, çip üretimi için kullanılan standart bir dosya formatıdır.



## 5. OpenLane Kullanımı


---

## 7. OpenLane ile İlgili Kaynaklar ve Topluluk

### OpenLane Dokümantasyonu
OpenLane'in resmi dokümantasyonu, kullanıcılar için en önemli kaynaktır. Bu dokümantasyon, OpenLane'in nasıl kurulacağını, nasıl kullanılacağını ve tasarım süreçlerinin nasıl yönetileceğini adım adım açıklar.

### OpenLane GitHub Deposu
OpenLane'in GitHub deposu, projenin tüm kaynak kodlarını, örnek projeleri ve dokümantasyonu içerir.

### Topluluk Desteği ve Forumlar
OpenLane, aktif bir topluluk tarafından desteklenir. Bu topluluk, kullanıcıların sorularını yanıtlamak ve projeyi geliştirmek için çalışır.

### Eğitim Materyalleri ve Öğreticiler
OpenLane'i öğrenmek isteyenler için birçok eğitim materyali ve öğretici bulunmaktadır.

### Örnek Projeler ve Kaynak Kodlar
OpenLane ile gerçekleştirilmiş birçok örnek proje ve kaynak kod, kullanıcılar için faydalı bir kaynaktır.

### Faydalı Bağlantılar
- OpenLane Resmi GitHub Sayfası: [https://github.com/The-OpenROAD-Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- OpenROAD Projesi: [https://theopenroadproject.org/](https://theopenroadproject.org/)
- SkyWater PDK Dokümantasyonu: [https://skywater-pdk.readthedocs.io/](https://skywater-pdk.readthedocs.io/)
- OpenLane Discord Sunucusu: [https://discord.gg/OpenROAD](https://discord.gg/OpenROAD)


## 8. Gelecek Trendleri ve OpenLane'in Gelişimi

### Açık Kaynak Donanım Tasarımının Geleceği
- Daha Fazla Açık Kaynak PDK
- Topluluk Katkılarının Artması
- Eğitim ve Araştırma

### OpenLane'in Gelecekteki Potansiyel Gelişmeleri
- Yapay Zeka Destekli Tasarım
- Daha Fazla PDK Desteği
- Performans İyileştirmeleri
- Kullanıcı Dostu Arayüzler

### Yeni Teknolojilerle Entegrasyon
- Yapay Zeka ve Makine Öğrenmesi
- Bulut Tabanlı Tasarım
- Yeni Üretim Teknolojileri


## 9. Sonuç ve Öneriler

### OpenLane'in Önemi
OpenLane, açık kaynaklı bir donanım tasarım akışı aracı olarak, donanım tasarım süreçlerini kolaylaştıran ve erişilebilir hale getiren güçlü bir araçtır.

### Yeni Başlayanlar İçin Öneriler
- Temel Bilgileri Öğrenin
- OpenLane Dokümantasyonunu İnceleyin
- Topluluk Desteğinden Yararlanın
- Pratik Yapın
- Sürekli Öğrenin

### OpenLane'i Etkili Kullanmak İçin İpuçları
- Tasarımınızı Modüler Hale Getirin
- Zamanlama Analizini İhmal Etmeyin
- Fiziksel Doğrulamayı Yapın
- Toplulukla İletişimde Kalın


## 10. Ekler

### Terimler Sözlüğü
- **RTL (Register Transfer Level):** Donanımın davranışsal tanımını ifade eden bir tasarım seviyesi.
- **Sentez (Synthesis):** RTL tasarımının, mantık kapıları seviyesine dönüştürülmesi işlemi.
- **Yerleştirme (Placement):** Mantık kapılarının fiziksel olarak çip üzerinde yerleştirilmesi işlemi.
- **Rotalama (Routing):** Mantık kapıları arasındaki bağlantıların oluşturulması işlemi.
- **Zamanlama Analizi (Timing Analysis):** Tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığının kontrol edilmesi.
- **Fiziksel Doğrulama (Physical Verification):** Tasarımın fiziksel kurallara uygun olup olmadığının kontrol edilmesi.
- **PDK (Process Design Kit):** Belirli bir yarı iletken üretim süreci için gerekli bilgileri içeren kit.
- **GDSII:** Çip üretimi için kullanılan standart bir dosya formatı.
- **ASIC (Application-Specific Integrated Circuit):** Belirli bir uygulama için tasarlanmış özelleştirilmiş entegre devre.
- **FPGA (Field-Programmable Gate Array):** Programlanabilir mantık bloklarından oluşan ve tasarım sonrasında yapılandırılabilen bir entegre devre türü.

### Faydalı Bağlantılar ve Referanslar
- OpenLane Resmi GitHub Sayfası: [https://github.com/The-OpenROAD-Project/OpenLane](https://github.com/The-OpenROAD-Project/OpenLane)
- OpenROAD Projesi: [https://theopenroadproject.org/](https://theopenroadproject.org/)
- SkyWater PDK Dokümantasyonu: [https://skywater-pdk.readthedocs.io/](https://skywater-pdk.readthedocs.io/)
- OpenLane Discord Sunucusu: [https://discord.gg/OpenROAD](https://discord.gg/OpenROAD)

### Örnek Proje Dosyaları ve Kod Parçacıkları
- **Örnek Verilog Kodu (Basit Bir Tasarım):**
  ```verilog
  module my_design (
      input wire clk,
      input wire rst,
      input wire [7:0] data_in,
      output reg [7:0] data_out
  );
      always @(posedge clk or posedge rst) begin
          if (rst) begin
              data_out <= 8'b0;
          end else begin
              data_out <= data_in;
          end
      end
  endmodule
  ```

  