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


## 2. OpenLane ile Tasarım Süreci

### **Synthesis**
- **Yosys**: RTL (Register Transfer Level) kodunu sentezleyerek mantık kapılarına dönüştürür ve teknoloji haritalama işlemi gerçekleştirir. Bu, tasarımın donanım uyumlu hale getirilmesi için ilk adımdır.
- **OpenSTA**: Sentezlenmiş netlist üzerinde statik zamanlama analizi yaparak, tasarımın zamanlama gereksinimlerini karşılayıp karşılamadığını kontrol eder ve zamanlama raporları oluşturur.

### **Floorplaning**
- **OpenROAD/Initialize Floorplan**: Tasarımın çekirdek alanını, makro blokların yerleşimi için satırları ve yönlendirme için izleri tanımlar. Bu, fiziksel tasarımın temelini oluşturur.
- **OpenLane IO Placer**: Tasarımın giriş ve çıkış portlarını yerleştirir. Bu, sinyallerin doğru şekilde bağlanabilmesi için kritik bir adımdır.
- **OpenROAD/PDN Generator**: Güç dağıtım ağını (Power Distribution Network) oluşturur. Bu, tasarımın güç ve toprak bağlantılarını sağlamak için gereklidir.
- **OpenROAD/Tapcell**: Welltap ve endcap hücrelerini yerleştirir. Bu hücreler, sızıntı akımlarını önlemek ve tasarımın fiziksel kurallara uygun olmasını sağlamak için kullanılır.


### **Placement**
- **OpenROAD/RePlace**: Global yerleştirme işlemi gerçekleştirir. Bu, tasarım bileşenlerinin yaklaşık olarak nereye yerleştirileceğini belirler.
- **OpenROAD/Resizer**: İsteğe bağlı olarak tasarım üzerinde optimizasyonlar yapar. Örneğin, hücre boyutlarını ayarlayarak performansı artırabilir.
- **OpenROAD/OpenDP**: Global yerleştirme sonrası bileşenlerin kesin yerlerini belirleyerek legalizasyon işlemi gerçekleştirir.


### **CTS (Clock Tree Synthesis)**
- **OpenROAD/TritonCTS**: Saat dağıtım ağını (clock tree) sentezler. Bu, saat sinyalinin tüm tasarımda eşit şekilde dağıtılmasını sağlar.


### **Routing**
- **OpenROAD/FastRoute**: Global yönlendirme işlemi yaparak, detaylı yönlendirici için bir kılavuz dosyası oluşturur. Bu, sinyallerin genel rotalarını belirler.
- **OpenROAD/TritonRoute**: Detaylı yönlendirme işlemi gerçekleştirir. Bu, sinyallerin kesin bağlantılarını oluşturur.
- **OpenROAD/OpenRCX**: SPEF (Standard Parasitic Exchange Format) dosyası çıkarır. Bu, tasarımın parazitik etkilerini modellemek için kullanılır.


### **Tapeout**
- **Magic**: Yönlendirilmiş DEF dosyasından final GDSII layout dosyasını oluşturur. GDSII, üretim için kullanılan standart bir dosya formatıdır.
- **KLayout**: Magic'e alternatif olarak GDSII dosyasını oluşturur. Bu, yedekleme amacıyla kullanılabilir.


### **Signoff**
- **Magic**: DRC (Design Rule Check) ve Antenna Check işlemlerini gerçekleştirir. Bu, tasarımın üretim kurallarına uygun olup olmadığını kontrol eder.
- **Magic**: İki GDSII dosyası arasında XOR kontrolü yaparak tutarlılığı doğrular.
- **Netgen**: LVS (Layout vs. Schematic) kontrolü yapar. Bu, layoutun orijinal şematikle eşleştiğini doğrular.

### **Tasarım Sürecinin Özeti**
Openlane hardware design flow aracı olduğu için buradaki bir çok aracı kullanarak otomatikleştirmektedir(basit düzeyde). 

## 3. OpenLane Kurulumu
**Ubuntu** için [bu](https://www.youtube.com/watch?v=jEGq7JVHGvQ) linki takip ederek gerekli olan tüm temel araçların kulumunu tamamlamış olursunuz.

## 4. OpenLane Kullanımı

openlane ile çalışmak için
```bash
cd Openlane
make mount
```
![Openlane Terminal](https://github.com/tbemre/denemea/blob/main/images/Openlane_container.png)
burayı openlane container olarak adandırıyorum. Openlane örnek dizaynını çalıştırarak işe başlayabiliriz.

```bash
./flow.tcl -design spm
```
kurulumu doğru şekilde yapılmışsa herhangi bir hata ile karşılaşılmaz ve akış tamamlanır. çalışma sonuçları `design/spm/runs/RUN_20xx.xx/results/final` klasöründe oluşacaktır.
Open the result file(gds) with klayout:
```bash
klayout design/spm/runs/RUN_20xx.xx/results/final/gds/spm.gds
```
![spm Klayout](https://github.com/tbemre/denemea/blob/main/images/spm_klayot.png)
Open the magic file:
```bash
magic design/spm/runs/RUN_20xx.xx/results/final/mag/spm.mag
```
![spm magic](https://github.com/tbemre/denemea/blob/main/images/spm_magic.png)

proje her çalıştığında yeni bir RUN_20xx.xx klasörü oluşacaktır. Tarih ve saati içeren bilgiler sizin için önemli değilse ve karmaşadan kurtulmak istiyorsanız `-tag` argümanını kullanmak en mantıklısı.
 ```bash
./flow.tcl -design spm -tag spm-run
```
artık çalışma sonuçları `design/spm/runs/spm-run/results/final` şeklinde yol almaktadır. `-overwrite` argümanı aynı taga sahip çalışmanın üzerine yazmaya yarar. beraber kullanılması mantıklı olacaktır.

Open the def file with OpenRoad GUI:
```bash
python3 gui.py --viewer openroad ./designs/spm/runs/spm-run/
```
![spm gui](https://github.com/tbemre/denemea/blob/main/images/spm_openroad_gui.png)

### Make project

yeni bir dizayn oluşturmak için aşağıdaki komut kullanılabilir.
```bash
./flow.tcl -design <design_name> -init_design_config -add_to_designs
```
bu komut aşağıdaki gibi dizin oluşturacaktık.
```bash
designs/<design_name>
├── config.json
├── src/
```
`src`klasörünün içine verilog dosyası oluşturulması gerekmektedir. Proje buradaki verilog dosyası üzerinden şekil alacaktır.

**Inverter**

inverter yapmak deneysel olarak Openlane'i anlamak için mantıklı bir projedir. yapımı oldukça basittir. işe proje dosyası oluşturmakla başlayalım.

```bash
./flow.tcl -design inverter -init_design_config -add_to_designs
cd designs/inverter/src
touch inverter.v
```
gerekli dosyalar oluşturulduktan sonra verilog kodu yazılmalı.

```bash
module inverter(
	input in,
	output out
);
assign out = ~in;
endmodule
```
bu adımda projeyi çalıştırmaya çalışmak hatalı olacaktık çünkü varsayılan alandan çok daha küçük bir alan kullandığı için **Floorplaning** adımında hata alacaktır. şimdiki adımları uygulamadan projeyi çalıştırıp hata ile karşılaşmak ve kendiniz çözmeniz sizi büyük oranda geliştirir. bu hata düzeltmek için dökümantasyondaki [Flow Configuration Variables](https://openlane.readthedocs.io/en/latest/reference/configuration.html#floorplanning-fp) kısmından `FP_SIZING` `DIE_AREA` değişkenlerini anlamanız gerekiyor. `config.json` dosyasından bu değişkenlerin değerlerini değiştirmeliyiz.

```bash
{
    "DESIGN_NAME": "inverter",
    "VERILOG_FILES": "dir::src/*.v",
    "RUN_CTS": false,
    "CLOCK_PORT": null,
    "PL_RANDOM_GLB_PLACEMENT": true,
    "FP_SIZING": "absolute",
    "DIE_AREA": "0 0 40 50",
}
```
inverter tam olarak doğru olmasa da çalışacaktır ve aşağıdaki çıktıyı verecektir.

![inverter layout](https://github.com/tbemre/denemea/blob/main/images/inverter_layout.png)

**8:1 Multiplexer**

Multiplexer, konuyu anlamak ve değişkenleri pekiştirmek için mantıklı bir projedir. konuya girecek olursak yukarıdaki adımları izlenerek `mux8_1` adlı proje oluşturalım.

```bash
designs/mux8_1
├── config.json
├── src/mux8_1.v
```
projeyi oluşturduktan sonra `mux8_1.v` kodlanabilir.

[mux8_1.v]()
`config.json`
```bash
{
    "DESIGN_NAME": "mux8_1",
    "VERILOG_FILES": "dir::src/*.v",
    "CLOCK_PORT": null,
    "FP_SIZING": "absolute",
    "DIE_AREA": "0 0 50 50",
    "FP_PDN_AUTO_ADJUST": false,
    "FP_PDN_VPITCH": 30,
    "FP_PDN_HPITCH": 30,
    "FP_PDN_VOFFSET": 1.8,
    "FP_PDN_HOFFSET": 1.8
}
```
proje bu noktada tamamlanmıştır. eğer bir sorun oluşmadıysa aşağıdaki çıktıyı elde etmeniz gerekiyor.
![mux layout](https://github.com/tbemre/denemea/blob/main/images/mux_layout.png)
eğer pinleri incelediysen rastgele şekilde dağıldığını göreceksiniz bunu önlemek için pinlerin konumlarını belittiğimiz dosyas oluşturmamız gerekiyor. örnek olarak `spm/pin_order.cfg` verebiliriz. proje klasörüne **pin_order.cfg** dosyası oluşturup pin konumları belirlenebilir.

`pin_order.cfg`
```bash
#N

#S
@min_distance=0.2
S.*
#E
Y
#W
@min_distance=0.1
A.*
```
`config.json` dosyasında aşağıdaki değişkenleri ayarlamalıyız.
```bash
    "//": "Pin Order",
    "FP_PIN_ORDER_CFG": "dir::pin_order.cfg",
```
![mux layout pin order](https://github.com/tbemre/denemea/blob/main/images/mux_layout2.png)

artık çalışan bir multiplexer'a sahibiz.



## 7. OpenLane ile İlgili Kaynaklar 

[Openlane Dokümantasyonu](https://openlane.readthedocs.io/en/latest/)
[Örnek Projeler](https://github.com/efabless/openlane-ci-designs/)


emre çalışkan tarafından hazırlanmıştır.