//
//  ReciterManger.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/6/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit


class ReciterManger {
    
    /*
     
     -> algorhim to play ayat for reciters :
     1- format ayah = 000-000
     1.1- first three digit for surha number
     1.2- second three digit for ayah number
     
     ex: let say surha elNaas الناس
     surha num = 114
     so for play ayah number 1 -> 114001 and so on ....
     
     
     */
    
    func isSurhaDownloaded(reciter: CReciter, surha: CSurha)  -> Bool {
        //2_1_002200
        //id_type_surha&Ayah
        let reciter_id = reciter.id ?? "0"
        let reciter_type = reciter.type.description
        let id = Int(surha.id ?? "0")!
        let surhaNum = String(format: "%.3i",  id)
        var flag = true
        for item in (surha.ayat?.array as? [CAyatModel]) ?? [] {
            let id = Int(item.sort)
            let ayahNum = String(format: "%.3i",  id)
            let path = "\(reciter_id)_\(reciter_type)_\(surhaNum)\(ayahNum).mp3"
            let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(path)
            let data = FileManager.default.fileExists(atPath: cacheURL?.relativePath ?? "")
            if data == false {
                flag = false
                break
            }
        }
        return flag
    }
    
    func downloadAyat(indentifer: String,reciter: CReciter, ayat: [CAyatModel], process: @escaping(Int,Int)->(), fail: @escaping(String)->()) {
        //process: (Int,Int)
        //currentDownloaded / total
        if ayat.count <= 0 {
            DispatchQueue.main.async {

                fail("Number of Ayat can't be zero"); return;
            }
        }
        let reciter_id = reciter.id ?? "0"
        let reciter_type = reciter.type.description
        let task =  UIApplication.shared.beginBackgroundTask(withName: "download", expirationHandler: {})
        DispatchQueue.global(qos: .background).async {
            var index = 0
            for item in ayat {
                let sid = Int(item.surha?.id ?? "0")!
                let surhaNum = String(format: "%.3i",  sid)
                let id = Int(item.sort)
                let ayahNum = String(format: "%.3i",  id)
                let stopDown = UserDefaultClass.getValue(indentifer) as? Bool
                if stopDown == true {
                    DispatchQueue.main.async {
                        print("Download stop by user")
                        fail("Download stop by user")
                    }
                    UserDefaultClass.setValue(indentifer, nil)
                    break
                }
                let path = "\(reciter_id)_\(reciter_type)_\(surhaNum)\(ayahNum).mp3"
                let url = URL.init(string: "\(reciter.link ?? "")\(surhaNum)\(ayahNum).mp3")!
                let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(path)
                let cacheData = FileManager.default.fileExists(atPath: cacheURL?.relativePath ?? "")
                index += 1
                if cacheData == true {
                    if index == (ayat.count) {
                        DispatchQueue.main.async {
                            process(index ,ayat.count)
                        }
                    }
                    print("exited before ayah", ayahNum)
                    continue
                }
                let data =  NSData.init(contentsOf: url)
                if data == nil {
                    DispatchQueue.main.async {
                        fail("Can't Download")
                    }
                    print("Can't Download")
                    break
                }
                do {
                    try data!.write(to: cacheURL!, options: .atomicWrite)
                    DispatchQueue.main.async {
                        process(index ,ayat.count)
                    }
                    print("cached ayah", index)
                } catch let err {
                    DispatchQueue.main.async {
                        fail(err.localizedDescription)
                    }
                    print("Failed with error:", err.localizedDescription)
                    break
                }
            }
        }
        UIApplication.shared.endBackgroundTask(task)
    }
    
    
    func installReciters(finish: (()->())? = nil) {
        
        let repo = CoreDataRepository<CReciter>.init()
        
        let r1 = CReciter.init(context: repo.context!)
        r1.id = ReciterName.AbdulBaset.rawValue.description
        r1.image_path = "Abdul_Basit_Mujawwad.png"
        r1.link = "http://www.everyayah.com/data/AbdulSamad_64kbps_QuranExplorer.Com/"
        r1.name_ar = "عبد الباسط عبد الصمد"
        r1.name_en = "AbdulBasit"
        r1.type = ReciterType.Mujawad.rawValue

        let r2 = CReciter.init(context: repo.context!)
        r2.id = ReciterName.AbdulBaset.rawValue.description
        r2.image_path = "Abdul_Basit_Mujawwad.png"
        r2.link = "http://www.everyayah.com/data/Abdul_Basit_Murattal_64kbps/"
        r2.name_ar = "عبد الباسط عبد الصمد"
        r2.name_en = "AbdulBasit"
        r2.type = ReciterType.Murattal.rawValue

        let r3 = CReciter.init(context: repo.context!)
        r3.id = ReciterName.Abdullaah_3awwaad_AlJuhaynee.rawValue.description
        r3.image_path = "abdullah_awad_Al-juhani.png"
        r3.link = "http://www.everyayah.com/data/Abdullaah_3awwaad_Al-Juhaynee_128kbps/"
        r3.name_ar = "عبدالله عواد الجهينى"
        r3.name_en = "Abdullaah 3awwaad Al-Juhaynee"
        r3.type = ReciterType.Murattal.rawValue

        let r4 = CReciter.init(context: repo.context!)
        r4.id = ReciterName.Abdullah_Basfar.rawValue.description
        r4.image_path = "Abdullah Basfar.png"
        r4.link = "http://www.everyayah.com/data/Abdullah_Basfar_64kbps/"
        r4.name_ar = "عبدالله بن على بصفر"
        r4.name_en = "Abdullah Basfar"
        r4.type = ReciterType.Murattal.rawValue

        let r5 = CReciter.init(context: repo.context!)
        r5.id = ReciterName.Abdullah_Matroud.rawValue.description
        r5.image_path = "abdallah_matroud.png"
        r5.link = "http://www.everyayah.com/data/Abdullah_Matroud_128kbps/"
        r5.name_ar = "عبدالله مطرود"
        r5.name_en = "Abdullah Matroud"
        r5.type = ReciterType.Murattal.rawValue

        let r6 = CReciter.init(context: repo.context!)
        r6.id = ReciterName.Abdurrahmaan_AlSudais.rawValue.description
        r6.image_path = "Abdul Rahman Al Sudais.png"
        r6.link = "http://www.everyayah.com/data/Abdurrahmaan_As-Sudais_64kbps/"
        r6.name_ar = "عبدالرحمن السديسى"
        r6.name_en = "Abdul Rahman Al Sudais"
        r6.type = ReciterType.Murattal.rawValue

        let r7 = CReciter.init(context: repo.context!)
        r7.id = ReciterName.Abu_Bakr_Ash_Shaatree.rawValue.description
        r7.image_path = "Abu Bakr Shatri.jpg"
        r7.link = "http://www.everyayah.com/data/Abu_Bakr_Ash-Shaatree_64kbps/"
        r7.name_ar = "ابو بكر الشاطرى"
        r7.name_en = "Abu Bakr Al Shatri"
        r7.type = ReciterType.Murattal.rawValue

        let r8 = CReciter.init(context: repo.context!)
        r8.id = ReciterName.Ahmed_Neana.rawValue.description
        r8.image_path = "Ahmed Nuinaa.jpg"
        r8.link = "http://www.everyayah.com/data/Ahmed_Neana_128kbps/"
        r8.name_ar = "احمد نعينع"
        r8.name_en = "Ahmed Neana"
        r8.type = ReciterType.Murattal.rawValue

        let r9 = CReciter.init(context: repo.context!)
        r9.id = ReciterName.Ahmed_ibn_Ali_alAjamy.rawValue.description
        r9.image_path = "Ahmed Al Ajmi.png"
        r9.link = "http://www.everyayah.com/data/Ahmed_ibn_Ali_al-Ajamy_64kbps_QuranExplorer.Com/"
        r9.name_ar = "احمد بن على العجمى"
        r9.name_en = "Ahmed ibn Ali al-Ajamy"
        r9.type = ReciterType.Murattal.rawValue

        let r10 = CReciter.init(context: repo.context!)
        r10.id = ReciterName.Akram_AlAlaqimy.rawValue.description
        r10.image_path = "Akram Al Aalakmi.png"
        r10.link = "http://www.everyayah.com/data/Akram_AlAlaqimy_128kbps/"
        r10.name_ar = "اكرم العلاقمي"
        r10.name_en = "Akram AlAlaqimy"
        r10.type = ReciterType.Murattal.rawValue

        let r11 = CReciter.init(context: repo.context!)
        r11.id = ReciterName.Alafasy.rawValue.description
        r11.image_path = "Mishary Al Afasy.png"
        r11.link = "http://www.everyayah.com/data/Alafasy_64kbps/"
        r11.name_ar = "مشارى بن راشد العفاسى"
        r11.name_en = "Alafasy"
        r11.type = ReciterType.Murattal.rawValue

        let r12 = CReciter.init(context: repo.context!)
        r12.id = ReciterName.Ali_Hajjaj_AlSuesy.rawValue.description
        r12.image_path = "ali-hajjaj-souissi.png"
        r12.link = "http://www.everyayah.com/data/Ali_Hajjaj_AlSuesy_128kbps/"
        r12.name_ar = "على حجاج السويسى"
        r12.name_en = "Ali Hajjaj AlSuesy"
        r12.type = ReciterType.Murattal.rawValue

        let r13 = CReciter.init(context: repo.context!)
        r13.id = ReciterName.Ali_Jaber.rawValue.description
        r13.image_path = "ali-jaber.png"
        r13.link = "http://www.everyayah.com/data/Ali_Jaber_64kbps/"
        r13.name_ar = "على جابر"
        r13.name_en = "Ali Jaber"
        r13.type = ReciterType.Murattal.rawValue

        let r14 = CReciter.init(context: repo.context!)
        r14.id = ReciterName.Ayman_Sowaid.rawValue.description
        r14.image_path = "ayman-swid.jpg"
        r14.link = "http://www.everyayah.com/data/Ayman_Sowaid_64kbps/"
        r14.name_ar = "أيمن سويد"
        r14.name_en = "Ayman Sowaid"
        r14.type = ReciterType.Murattal.rawValue

        let r15 = CReciter.init(context: repo.context!)
        r15.id = ReciterName.English.rawValue.description
        r15.image_path = "english.png"
        r15.link = "http://www.everyayah.com/data/English/Sahih_Intnl_Ibrahim_Walk_192kbps/"
        r15.name_ar = "English"
        r15.name_en = "English"
        r15.type = ReciterType.Translate.rawValue

        let r16 = CReciter.init(context: repo.context!)
        r16.id = ReciterName.Fares_Abbad.rawValue.description
        r16.image_path = "fares-abbad.png"
        r16.link = "http://www.everyayah.com/data/Fares_Abbad_64kbps/"
        r16.name_ar = "فارس عباد"
        r16.name_en = "Fares Abbad"
        r16.type = ReciterType.Murattal.rawValue

        let r17 = CReciter.init(context: repo.context!)
        r17.id = ReciterName.Ghamadi.rawValue.description
        r17.image_path = "saad-el-ghamidi.png"
        r17.link = "http://www.everyayah.com/data/Ghamadi_40kbps/"
        r17.name_ar = "سعد الغامدى"
        r17.name_en = "Saad AlGhamadi"
        r17.type = ReciterType.Murattal.rawValue

        let r18 = CReciter.init(context: repo.context!)
        r18.id = ReciterName.Hani_Rifai.rawValue.description
        r18.image_path = "hani-ar-rifai.png"
        r18.link = "http://www.everyayah.com/data/Hani_Rifai_64kbps/"
        r18.name_ar = "هانى الرفاعى"
        r18.name_en = "Hani Rifai"
        r18.type = ReciterType.Murattal.rawValue

        let r19 = CReciter.init(context: repo.context!)
        r19.id = ReciterName.Hudhaify.rawValue.description
        r19.image_path = "ali-alhodaifi.png"
        r19.link = "http://www.everyayah.com/data/Hudhaify_64kbps/"
        r19.name_ar = "على الحذيفى"
        r19.name_en = "Hudhaify"
        r19.type = ReciterType.Murattal.rawValue

        let r20 = CReciter.init(context: repo.context!)
        r20.id = ReciterName.Husary.rawValue.description
        r20.image_path = "mahmoud-khalil-al-hussary.png"
        r20.link = "http://www.everyayah.com/data/Husary_64kbps/"
        r20.name_ar = "الحصرى"
        r20.name_en = "Husary"
        r20.type = ReciterType.Murattal.rawValue

        let r21 = CReciter.init(context: repo.context!)
        r21.id = ReciterName.Husary.rawValue.description
        r21.image_path = "mahmoud-khalil-al-hussary.png"
        r21.link = "http://www.everyayah.com/data/Husary_Mujawwad_64kbps/"
        r21.name_ar = "الحصرى"
        r21.name_en = "Husary"
        r21.type = ReciterType.Mujawad.rawValue

        let r22 = CReciter.init(context: repo.context!)
        r22.id = ReciterName.Husary.rawValue.description
        r22.image_path = "mahmoud-khalil-al-hussary.png"
        r22.link = "http://www.everyayah.com/data/Husary_Muallim_128kbps/"
        r22.name_ar = "الحصرى"
        r22.name_en = "Husary"
        r22.type = ReciterType.Muallim.rawValue

        let r23 = CReciter.init(context: repo.context!)
        r23.id = ReciterName.Ibrahim_Akhdar.rawValue.description
        r23.image_path = "ibrahim-al-akhdar.png"
        r23.link = "http://www.everyayah.com/data/Ibrahim_Akhdar_32kbps/"
        r23.name_ar = "إبراهيم الأخضر"
        r23.name_en = "Ibrahim Akhdar"
        r23.type = ReciterType.Murattal.rawValue

        let r24 = CReciter.init(context: repo.context!)
        r24.id = ReciterName.Karim_Mansoori.rawValue.description
        r24.image_path = "karim-mansouri.jpg"
        r24.link = "http://www.everyayah.com/data/Karim_Mansoori_40kbps/"
        r24.name_ar = "كريم منصورى"
        r24.name_en = "Karim Mansoori"
        r24.type = ReciterType.Mujawad.rawValue

        let r25 = CReciter.init(context: repo.context!)
        r25.id = ReciterName.Khaalid_Abdullaah_alQahtaanee.rawValue.description
        r25.image_path = "khaled-al-qahtani.png"
        r25.link = "http://www.everyayah.com/data/Khaalid_Abdullaah_al-Qahtaanee_192kbps/"
        r25.name_ar = "خالد القحطاني"
        r25.name_en = "Khaalid Abdullaah al-Qahtaanee"
        r25.type = ReciterType.Murattal.rawValue

        let r26 = CReciter.init(context: repo.context!)
        r26.id = ReciterName.Maher_AlMuaiqly.rawValue.description
        r26.image_path = "maher-al-mueaqly.png"
        r26.link = "http://www.everyayah.com/data/Maher_AlMuaiqly_64kbps/"
        r26.name_ar = "ماهر المعيقلي"
        r26.name_en = "Maher AlMuaiqly"
        r26.type = ReciterType.Murattal.rawValue

        let r27 = CReciter.init(context: repo.context!)
        r27.id = ReciterName.Menshawi.rawValue.description
        r27.image_path = "mohamed-seddik-el-menchaoui.png"
        r27.link = "http://www.everyayah.com/data/Menshawi_16kbps/"
        r27.name_ar = "محمد صديق المنشاوى"
        r27.name_en = "Mohamed Seddik ElMenshawi"
        r27.type = ReciterType.Murattal.rawValue

        let r28 = CReciter.init(context: repo.context!)
        r28.id = ReciterName.Menshawi.rawValue.description
        r28.image_path = "mohamed-seddik-el-menchaoui.png"
        r28.link = "http://www.everyayah.com/data/Minshawy_Mujawwad_64kbps/"
        r28.name_ar = "محمد صديق المنشاوى"
        r28.name_en = "Mohamed Seddik ElMenshawi"
        r28.type = ReciterType.Mujawad.rawValue

        let r29 = CReciter.init(context: repo.context!)
        r29.id = ReciterName.Mohammad_al_Tablaway.rawValue.description
        r29.image_path = "mohamed-tablawi.png"
        r29.link = "http://www.everyayah.com/data/Mohammad_al_Tablaway_64kbps/"
        r29.name_ar = "محمد الطبلاوى"
        r29.name_en = "Mohammad AlTablaway"
        r29.type = ReciterType.Murattal.rawValue

        let r30 = CReciter.init(context: repo.context!)
        r30.id = ReciterName.Muhammad_AbdulKareem.rawValue.description
        r30.image_path = "muhammad-abdulkareem.png"
        r30.link = "http://www.everyayah.com/data/Muhammad_AbdulKareem_128kbps/"
        r30.name_ar = "محمد عبدالكريم"
        r30.name_en = "Muhammad AbdulKareem"
        r30.type = ReciterType.Murattal.rawValue

        let r31 = CReciter.init(context: repo.context!)
        r31.id = ReciterName.Muhammad_Ayyoub.rawValue.description
        r31.image_path = "mohamed-ayoub.png"
        r31.link = "http://www.everyayah.com/data/Muhammad_Ayyoub_64kbps/"
        r31.name_ar = "محمد أيوب"
        r31.name_en = "Muhammad Ayyoub"
        r31.type = ReciterType.Murattal.rawValue

        let r32 = CReciter.init(context: repo.context!)
        r32.id = ReciterName.Muhammad_Jibreel.rawValue.description
        r32.image_path = "muhammad-jebril.png"
        r32.link = "http://www.everyayah.com/data/Muhammad_Jibreel_64kbps/"
        r32.name_ar = "محمد جبريل"
        r32.name_en = "Muhammad Jibreel"
        r32.type = ReciterType.Murattal.rawValue

        let r33 = CReciter.init(context: repo.context!)
        r33.id = ReciterName.Muhsin_Al_Qasim.rawValue.description
        r33.image_path = "abdulmohsen-al-qasim.png"
        r33.link = "http://www.everyayah.com/data/Muhsin_Al_Qasim_192kbps/"
        r33.name_ar = "عبدالمحسن القاسم"
        r33.name_en = "Abdulmohsen Al Qasim"
        r33.type = ReciterType.Murattal.rawValue

        let r34 = CReciter.init(context: repo.context!)
        r34.id = ReciterName.Abdullah_Basfar.rawValue
        r34.image_path = "Abdullah Basfar.png"
        r34.link = "http://www.everyayah.com/data/MultiLanguage/Basfar_Walk_192kbps/"
        r34.name_ar = "عبدالله بن على بصفر"
        r34.name_en = "Abdullah Basfar"
        r34.type = ReciterType.Translate.rawValue

        let r35 = CReciter.init(context: repo.context!)
        r35.id = ReciterName.Mustafa_Ismail.rawValue
        r35.image_path = "mustapha-ismail.png"
        r35.link = "http://www.everyayah.com/data/Mustafa_Ismail_48kbps/"
        r35.name_ar = "مصطفى اسماعيل"
        r35.name_en = "Mustafa Ismail"
        r35.type = ReciterType.Murattal.rawValue

        let r36 = CReciter.init(context: repo.context!)
        r36.id = ReciterName.Nasser_Alqatami.rawValue
        r36.image_path = "nasser-al-qatami.png"
        r36.link = "http://www.everyayah.com/data/Nasser_Alqatami_128kbps/"
        r36.name_ar = "ناصر القطامى"
        r36.name_en = "Nasser_Alqatami"
        r36.type = ReciterType.Murattal.rawValue

        let r37 = CReciter.init(context: repo.context!)
        r37.id = ReciterName.Parhizgar.rawValue
        r37.image_path = "shahriar-parhizgar.jpg"
        r37.link = "http://www.everyayah.com/data/Parhizgar_48kbps/"
        r37.name_ar = "شهریار پرهیزگار "
        r37.name_en = "Shahriar Parhizgar"
        r37.type = ReciterType.Murattal.rawValue

        let r38 = CReciter.init(context: repo.context!)
        r38.id = ReciterName.Sahl_Yassin.rawValue
        r38.image_path = "sahl-yassin.png"
        r38.link = "http://www.everyayah.com/data/Sahl_Yassin_128kbps/"
        r38.name_ar = "سهل ياسين"
        r38.name_en = "Sahl Yassin"
        r38.type = ReciterType.Murattal.rawValue

        let r39 = CReciter.init(context: repo.context!)
        r39.id = ReciterName.Salaah_AbdulRahman_Bukhatir.rawValue
        r39.image_path = "salah-bukhatir.png"
        r39.link = "http://www.everyayah.com/data/Salaah_AbdulRahman_Bukhatir_128kbps/"
        r39.name_ar = "صلاح عبدالرحمن بوخاطر"
        r39.name_en = "Salaah AbdulRahman Bukhatir"
        r39.type = ReciterType.Murattal.rawValue

        let r40 = CReciter.init(context: repo.context!)
        r40.id = ReciterName.Salah_Al_Budair.rawValue
        r40.image_path = "salah-al-budair.png"
        r40.link = "http://www.everyayah.com/data/Salah_Al_Budair_128kbps/"
        r40.name_ar = "صلاح البدير"
        r40.name_en = "Salah AlBudair"
        r40.type = ReciterType.Murattal.rawValue

        let r41 = CReciter.init(context: repo.context!)
        r41.id = ReciterName.Saoud_Shuraim.rawValue
        r41.image_path = "saoud-shuraim.png"
        r41.link = "http://www.everyayah.com/data/Saood_ash-Shuraym_64kbps/"
        r41.name_ar = "سعود الشريم"
        r41.name_en = "Saood al-Shuraym"
        r41.type = ReciterType.Murattal.rawValue

        let r42 = CReciter.init(context: repo.context!)
        r42.id = ReciterName.Yaser_Salamah.rawValue
        r42.image_path = "yasser-salama.jpg"
        r42.link = "http://www.everyayah.com/data/Yaser_Salamah_128kbps/"
        r42.name_ar = "ياسر سلامه"
        r42.name_en = "Yaser Salamah"
        r42.type = ReciterType.Murattal.rawValue

        let r43 = CReciter.init(context: repo.context!)
        r43.id = ReciterName.Yasser_AdDussary.rawValue
        r43.image_path = "yasser-al-dossari.png"
        r43.link = "http://www.everyayah.com/data/Yasser_Ad-Dussary_128kbps/"
        r43.name_ar = "ياسر الدوسرى"
        r43.name_en = "Yasser Ad-Dussary"
        r43.type = ReciterType.Murattal.rawValue

        let r44 = CReciter.init(context: repo.context!)
        r44.id = ReciterName.Aziz_Alili.rawValue
        r44.image_path = "aziz-alili.jpg"
        r44.link = "http://www.everyayah.com/data/aziz_alili_128kbps/"
        r44.name_ar = "عزيز عليلى"
        r44.name_en = "Aziz Alili"
        r44.type = ReciterType.Murattal.rawValue

        let r45 = CReciter.init(context: repo.context!)
        r45.id = ReciterName.khalefa_al_tunaiji.rawValue
        r45.image_path = "khalifa-al-tunaiji.png"
        r45.link = "http://www.everyayah.com/data/khalefa_al_tunaiji_64kbps/"
        r45.name_ar = "خليفة الطنيجى"
        r45.name_en = "khalefa_al_tunaiji"
        r45.type = ReciterType.Murattal.rawValue

        let r46 = CReciter.init(context: repo.context!)
        r46.id = ReciterName.mahmoud_ali_al_banna.rawValue
        r46.image_path = "mahmud-ali-al-banna.png"
        r46.link = "http://www.everyayah.com/data/mahmoud_ali_al_banna_32kbps/"
        r46.name_ar = "محمود على البنا"
        r46.name_en = "Mahmoud Ali AlBanna"
        r46.type = ReciterType.Murattal.rawValue

       
        
        CoreDataRepository.save()
        finish?()
        
    }
    
    
    
    
}
