//
//  QuranRepo+Surha.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/4/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class SurhaManger {
    
    private func handleStartSurha(arr: [CSurha]) -> [CSurha]{
        var i: Int32 = 1
        for item in arr {
            item.start = i
            i += item.number_ayat
        }
        return arr
    }
    
    func installSurha() -> [CSurha] {
        var arr = [CSurha]()
        
        let repo = CoreDataRepository<CSurha>.init()
        
        let s1 = CSurha.init(context: repo.context!)
        s1.id = "1"
        s1.idInt = Int16(1)
        s1.name_ar = "الفاتحة"
        s1.number_ayat = 7
        arr.append(s1)
        
        let s2 = CSurha.init(context: repo.context!)
        s2.id = "2"
        s2.idInt = Int16(2)
        s2.name_ar = "البقرة"
        s2.number_ayat = 286
        arr.append(s2)
        
        let s3 = CSurha.init(context: repo.context!)
        s3.id = "3"
        s3.idInt = Int16(3)
        s3.name_ar = "ال عمران"
        s3.number_ayat = 200
        arr.append(s3)

        let s4 = CSurha.init(context: repo.context!)
        s4.id = "4"
        s4.idInt = Int16(4)
        s4.name_ar = "النساء"
        s4.number_ayat = 176
        arr.append(s4)
        
        let s5 = CSurha.init(context: repo.context!)
        s5.id = "5"
        s5.idInt = Int16(5)
        s5.name_ar = "المائدة"
        s5.number_ayat = 120
        arr.append(s5)

        let s6 = CSurha.init(context: repo.context!)
        s6.id = "6"
        s6.idInt = Int16(6)
        s6.name_ar = "الأنعام"
        s6.number_ayat = 165
        arr.append(s6)

        let s7 = CSurha.init(context: repo.context!)
        s7.id = "7"
        s7.idInt = Int16(7)
        s7.name_ar = "الأعراف"
        s7.number_ayat = 206
        arr.append(s7)

        
        let s8 = CSurha.init(context: repo.context!)
        s8.id = "8"
        s8.idInt = Int16(8)
        s8.name_ar = "الأنفال"
        s8.number_ayat = 75
        arr.append(s8)
        
        
        let s9 = CSurha.init(context: repo.context!)
        s9.id = "9"
        s9.idInt = Int16(9)
        s9.name_ar = "التوبة"
        s9.number_ayat = 129
        arr.append(s9)

        let s10 = CSurha.init(context: repo.context!)
        s10.id = "10"
        s10.idInt = Int16(10)
        s10.name_ar = "يونس"
        s10.number_ayat = 109
        arr.append(s10)

        let s11 = CSurha.init(context: repo.context!)
        s11.id = "11"
        s11.idInt = Int16(11)
        s11.name_ar = "هود"
        s11.number_ayat = 123
        arr.append(s11)

        

        let s12 = CSurha.init(context: repo.context!)
        s12.id = "12"
        s12.idInt = Int16(12)
        s12.name_ar = "يوسف"
        s12.number_ayat = 111
        arr.append(s12)

        let s13 = CSurha.init(context: repo.context!)
        s13.id = "13"
        s13.idInt = Int16(13)
        s13.name_ar = "الرعد"
        s13.number_ayat = 43
        arr.append(s13)

        
        let s14 = CSurha.init(context: repo.context!)
        s14.id = "14"
        s14.idInt = Int16(14)
        s14.name_ar = "ابراهيم"
        s14.number_ayat = 52
        arr.append(s14)
        
    
        
        let s15 = CSurha.init(context: repo.context!)
        s15.id = "15"
        s15.idInt = Int16(15)
        s15.name_ar = "الحجر"
        s15.number_ayat = 99
        arr.append(s15)
        
        
        let s16 = CSurha.init(context: repo.context!)
        s16.id = "16"
        s16.idInt = Int16(16)
        s16.name_ar = "النحل"
        s16.number_ayat = 128
        arr.append(s16)
        
        
        let s17 = CSurha.init(context: repo.context!)
        s17.id = "17"
        s17.idInt = Int16(17)
        s17.name_ar = "الإسراء"
        s17.number_ayat = 111
        arr.append(s17)
        
        
        let s18 = CSurha.init(context: repo.context!)
        s18.id = "18"
        s18.idInt = Int16(18)
        s18.name_ar = "الكهف"
        s18.number_ayat = 110
        arr.append(s18)
        
        
        let s19 = CSurha.init(context: repo.context!)
        s19.id = "19"
        s19.idInt = Int16(19)
        s19.name_ar = "مريم"
        s19.number_ayat = 98
        arr.append(s19)
        
        
        
        let s20 = CSurha.init(context: repo.context!)
        s20.id = "20"
        s20.idInt = Int16(20)
        s20.name_ar = "طه"
        s20.number_ayat = 135
        arr.append(s20)

        
        
        let s21 = CSurha.init(context: repo.context!)
        s21.id = "21"
        s21.idInt = Int16(21)
        s21.name_ar = "الأنبياء"
        s21.number_ayat = 112
        arr.append(s21)
        
        
        let s22 = CSurha.init(context: repo.context!)
        s22.id = "22"
        s22.idInt = Int16(22)
        s22.name_ar = "الحج"
        s22.number_ayat = 78
        arr.append(s22)
        
        
        let s23 = CSurha.init(context: repo.context!)
        s23.id = "23"
        s23.idInt = Int16(23)
        s23.name_ar = "المؤمنون"
        s23.number_ayat = 118
        arr.append(s23)
        
        
        let s24 = CSurha.init(context: repo.context!)
        s24.id = "24"
        s24.idInt = Int16(24)
        s24.name_ar = "النور"
        s24.number_ayat = 64
        arr.append(s24)
        
        
        
        let s25 = CSurha.init(context: repo.context!)
        s25.id = "25"
        s25.idInt = Int16(25)
        s25.name_ar = "الفرقان"
        s25.number_ayat = 77
        arr.append(s25)
        
        
        
        let s26 = CSurha.init(context: repo.context!)
        s26.id = "26"
        s26.idInt = Int16(26)
        s26.name_ar = "الشعراء"
        s26.number_ayat = 227
        arr.append(s26)
        
        
        let s27 = CSurha.init(context: repo.context!)
        s27.id = "27"
        s27.idInt = Int16(27)
        s27.name_ar = "النمل"
        s27.number_ayat = 93
        arr.append(s27)
        
        
        
        let s28 = CSurha.init(context: repo.context!)
        s28.id = "28"
        s28.idInt = Int16(28)
        s28.name_ar = "القصص"
        s28.number_ayat = 88
        arr.append(s28)
        
        
        
        let s29 = CSurha.init(context: repo.context!)
        s29.id = "29"
        s29.idInt = Int16(29)
        s29.name_ar = "العنكبوت"
        s29.number_ayat = 69
        arr.append(s29)
        
        
        
        let s30 = CSurha.init(context: repo.context!)
        s30.id = "30"
        s30.idInt = Int16(30)
        s30.name_ar = "الروم"
        s30.number_ayat = 60
        arr.append(s30)
        
        
        
        let s31 = CSurha.init(context: repo.context!)
        s31.id = "31"
        s31.idInt = Int16(31)
        s31.name_ar = "لقمان"
        s31.number_ayat = 34
        arr.append(s31)
        
        
        
        let s32 = CSurha.init(context: repo.context!)
        s32.id = "32"
        s32.idInt = Int16(32)
        s32.name_ar = "السجدة"
        s32.number_ayat = 30
        arr.append(s32)
        
        
        
        let s33 = CSurha.init(context: repo.context!)
        s33.id = "33"
        s33.idInt = Int16(33)
        s33.name_ar = "الأحزاب"
        s33.number_ayat = 73
        arr.append(s33)
        
        
        
        let s34 = CSurha.init(context: repo.context!)
        s34.id = "34"
        s34.idInt = Int16(34)
        s34.name_ar = "سبأ"
        s34.number_ayat = 54
        arr.append(s34)
        
        
        
        let s35 = CSurha.init(context: repo.context!)
        s35.id = "35"
        s35.idInt = Int16(35)
        s35.name_ar = "فاطر"
        s35.number_ayat = 45
        arr.append(s35)
        
        
        let s36 = CSurha.init(context: repo.context!)
        s36.id = "36"
        s36.idInt = Int16(36)
        s36.name_ar = "يس"
        s36.number_ayat = 83
        arr.append(s36)

        
        
        let s37 = CSurha.init(context: repo.context!)
        s37.id = "37"
        s37.idInt = Int16(37)
        s37.name_ar = "الصافات"
        s37.number_ayat = 182
        arr.append(s37)
        
        
        
        let s38 = CSurha.init(context: repo.context!)
        s38.id = "38"
        s38.idInt = Int16(38)
        s38.name_ar = "سورة ص"
        s38.number_ayat = 88
        arr.append(s38)
        
        
        
        let s39 = CSurha.init(context: repo.context!)
        s39.id = "39"
        s39.idInt = Int16(39)
        s39.name_ar = "الزمر"
        s39.number_ayat = 75
        arr.append(s39)
        
        
        let s40 = CSurha.init(context: repo.context!)
        s40.id = "40"
        s40.idInt = Int16(40)
        s40.name_ar = "غافر"
        s40.number_ayat = 85
        arr.append(s40)
        
        let s41 = CSurha.init(context: repo.context!)
        s41.id = "41"
        s41.idInt = Int16(41)
        s41.name_ar = "فصلت"
        s41.number_ayat = 54
        arr.append(s41)

        let s42 = CSurha.init(context: repo.context!)
        s42.id = "42"
        s42.idInt = Int16(42)
        s42.name_ar = "الشورى"
        s42.number_ayat = 53
        arr.append(s42)

        let s43 = CSurha.init(context: repo.context!)
        s43.id = "43"
        s43.idInt = Int16(43)
        s43.name_ar = "الزخرف"
        s43.number_ayat = 89
        arr.append(s43)

        let s44 = CSurha.init(context: repo.context!)
        s44.id = "44"
        s44.idInt = Int16(44)
        s44.name_ar = "الدخان"
        s44.number_ayat = 59
        arr.append(s44)

        let s45 = CSurha.init(context: repo.context!)
        s45.id = "45"
        s45.idInt = Int16(45)
        s45.name_ar = "الجاثية"
        s45.number_ayat = 37
        arr.append(s45)

        let s46 = CSurha.init(context: repo.context!)
        s46.id = "46"
        s46.idInt = Int16(46)
        s46.name_ar = "الاحقاف"
        s46.number_ayat = 35
        arr.append(s46)

        let s47 = CSurha.init(context: repo.context!)
        s47.id = "47"
        s47.idInt = Int16(47)
        s47.name_ar = "محمد"
        s47.number_ayat = 38
        arr.append(s47)

        let s48 = CSurha.init(context: repo.context!)
        s48.id = "48"
        s48.idInt = Int16(48)
        s48.name_ar = "الفتح"
        s48.number_ayat = 29
        arr.append(s48)

        let s49 = CSurha.init(context: repo.context!)
        s49.id = "49"
        s49.idInt = Int16(49)
        s49.name_ar = "الحجرات"
        s49.number_ayat = 18
        arr.append(s49)

        let s50 = CSurha.init(context: repo.context!)
        s50.id = "50"
        s50.idInt = Int16(50)
        s50.name_ar = "ق"
        s50.number_ayat = 45
        arr.append(s50)

        let s51 = CSurha.init(context: repo.context!)
        s51.id = "51"
        s51.idInt = Int16(51)
        s51.name_ar = "الذاريات"
        s51.number_ayat = 60
        arr.append(s51)

        let s52 = CSurha.init(context: repo.context!)
        s52.id = "52"
        s52.idInt = Int16(52)
        s52.name_ar = "الطور"
        s52.number_ayat = 49
        arr.append(s52)

        let s53 = CSurha.init(context: repo.context!)
        s53.id = "53"
        s53.idInt = Int16(53)
        s53.name_ar = "النجم"
        s53.number_ayat = 62
        arr.append(s53)

        let s54 = CSurha.init(context: repo.context!)
        s54.id = "54"
        s54.idInt = Int16(54)
        s54.name_ar = "القمر"
        s54.number_ayat = 55
        arr.append(s54)

        let s55 = CSurha.init(context: repo.context!)
        s55.id = "55"
        s55.idInt = Int16(55)
        s55.name_ar = "الرحمن"
        s55.number_ayat = 78
        arr.append(s55)

        let s56 = CSurha.init(context: repo.context!)
        s56.id = "56"
        s56.idInt = Int16(56)
        s56.name_ar = "الواقعة"
        s56.number_ayat = 96
        arr.append(s56)

        let s57 = CSurha.init(context: repo.context!)
        s57.id = "57"
        s57.idInt = Int16(57)
        s57.name_ar = "الحديد"
        s57.number_ayat = 29
        arr.append(s57)

        let s58 = CSurha.init(context: repo.context!)
        s58.id = "58"
        s58.idInt = Int16(58)
        s58.name_ar = "المجادلة"
        s58.number_ayat = 22
        arr.append(s58)

        let s59 = CSurha.init(context: repo.context!)
        s59.id = "59"
        s59.idInt = Int16(59)
        s59.name_ar = "الحشر"
        s59.number_ayat = 24
        arr.append(s59)

        let s60 = CSurha.init(context: repo.context!)
        s60.id = "60"
        s60.idInt = Int16(60)
        s60.name_ar = "الممتحنة"
        s60.number_ayat = 13
        arr.append(s60)

        let s61 = CSurha.init(context: repo.context!)
        s61.id = "61"
        s61.idInt = Int16(61)
        s61.name_ar = "الصف"
        s61.number_ayat = 14
        arr.append(s61)

        let s62 = CSurha.init(context: repo.context!)
        s62.id = "62"
        s62.idInt = Int16(62)
        s62.name_ar = "الجمعة"
        s62.number_ayat = 11
        arr.append(s62)

        let s63 = CSurha.init(context: repo.context!)
        s63.id = "63"
        s63.idInt = Int16(63)
        s63.name_ar = "المنافقون"
        s63.number_ayat = 11
        arr.append(s63)

        let s64 = CSurha.init(context: repo.context!)
        s64.id = "64"
        s64.idInt = Int16(64)
        s64.name_ar = "التغابن"
        s64.number_ayat = 18
        arr.append(s64)

        let s65 = CSurha.init(context: repo.context!)
        s65.id = "65"
        s65.idInt = Int16(65)
        s65.name_ar = "الطلاق"
        s65.number_ayat = 12
        arr.append(s65)

        let s66 = CSurha.init(context: repo.context!)
        s66.id = "66"
        s66.idInt = Int16(66)
        s66.name_ar = "التحريم"
        s66.number_ayat = 12
        arr.append(s66)

        let s67 = CSurha.init(context: repo.context!)
        s67.id = "67"
        s67.idInt = Int16(67)
        s67.name_ar = "الملك"
        s67.number_ayat = 30
        arr.append(s67)
        
        let s68 = CSurha.init(context: repo.context!)
        s68.id = "68"
        s68.idInt = Int16(68)
        s68.name_ar = "القلم"
        s68.number_ayat = 52
        arr.append(s68)

        let s69 = CSurha.init(context: repo.context!)
        s69.id = "69"
        s69.idInt = Int16(69)
        s69.name_ar = "الحاقة"
        s69.number_ayat = 52
        arr.append(s69)
        
        let s70 = CSurha.init(context: repo.context!)
        s70.id = "70"
        s70.idInt = Int16(70)
        s70.name_ar = "المعارج"
        s70.number_ayat = 44
        arr.append(s70)
        
        let s71 = CSurha.init(context: repo.context!)
        s71.id = "71"
        s71.idInt = Int16(71)
        s71.name_ar = "نوح"
        s71.number_ayat = 28
        arr.append(s71)
        
        let s72 = CSurha.init(context: repo.context!)
        s72.id = "72"
        s72.idInt = Int16(72)
        s72.name_ar = "الجن"
        s72.number_ayat = 28
        arr.append(s72)
        
        let s73 = CSurha.init(context: repo.context!)
        s73.id = "73"
        s73.idInt = Int16(73)
        s73.name_ar = "المزمل"
        s73.number_ayat = 20
        arr.append(s73)
        
        let s74 = CSurha.init(context: repo.context!)
        s74.id = "74"
        s74.idInt = Int16(74)
        s74.name_ar = "المدثر"
        s74.number_ayat = 56
        arr.append(s74)
        
        let s75 = CSurha.init(context: repo.context!)
        s75.id = "75"
        s75.idInt = Int16(75)
        s75.name_ar = "القيامة"
        s75.number_ayat = 40
        arr.append(s75)
        
        let s76 = CSurha.init(context: repo.context!)
        s76.id = "76"
        s76.idInt = Int16(76)
        s76.name_ar = "الإنسان"
        s76.number_ayat = 31
        arr.append(s76)
        
        let s77 = CSurha.init(context: repo.context!)
        s77.id = "77"
        s77.idInt = Int16(77)
        s77.name_ar = "المرسلات"
        s77.number_ayat = 50
        arr.append(s77)
        
        
        let s78 = CSurha.init(context: repo.context!)
        s78.id = "78"
        s78.idInt = Int16(78)
        s78.name_ar = "النبأ"
        s78.number_ayat = 40
        arr.append(s78)
        
        
        let s79 = CSurha.init(context: repo.context!)
        s79.id = "79"
        s79.idInt = Int16(79)
        s79.name_ar = "النازعات"
        s79.number_ayat = 46
        arr.append(s79)

        
        let s80 = CSurha.init(context: repo.context!)
        s80.id = "80"
        s80.idInt = Int16(80)
        s80.name_ar = "عبس"
        s80.number_ayat = 42
        arr.append(s80)

        
        let s81 = CSurha.init(context: repo.context!)
        s81.id = "81"
        s81.idInt = Int16(81)
        s81.name_ar = "التكوير"
        s81.number_ayat = 29
        arr.append(s81)

        
        let s82 = CSurha.init(context: repo.context!)
        s82.id = "82"
        s82.idInt = Int16(82)
        s82.name_ar = "الإنفطار"
        s82.number_ayat = 19
        arr.append(s82)

        
        let s83 = CSurha.init(context: repo.context!)
        s83.id = "83"
        s83.idInt = Int16(83)
        s83.name_ar = "المطففين"
        s83.number_ayat = 36
        arr.append(s83)

        
        let s84 = CSurha.init(context: repo.context!)
        s84.id = "84"
        s84.idInt = Int16(84)
        s84.name_ar = "الانشقاق"
        s84.number_ayat = 25
        arr.append(s84)

        
        let s85 = CSurha.init(context: repo.context!)
        s85.id = "85"
        s85.idInt = Int16(85)
        s85.name_ar = "البروج"
        s85.number_ayat = 22
        arr.append(s85)

        
        let s86 = CSurha.init(context: repo.context!)
        s86.id = "86"
        s86.idInt = Int16(86)
        s86.name_ar = "الطارق"
        s86.number_ayat = 17
        arr.append(s86)

        
        let s87 = CSurha.init(context: repo.context!)
        s87.id = "87"
        s87.idInt = Int16(87)
        s87.name_ar = "الأعلى"
        s87.number_ayat = 19
        arr.append(s87)

        
        let s88 = CSurha.init(context: repo.context!)
        s88.id = "88"
        s88.idInt = Int16(88)
        s88.name_ar = "الغاشية"
        s88.number_ayat = 26
        arr.append(s88)

        
        let s89 = CSurha.init(context: repo.context!)
        s89.id = "89"
        s89.idInt = Int16(89)
        s89.name_ar = "الفجر"
        s89.number_ayat = 30
        arr.append(s89)

        
        let s90 = CSurha.init(context: repo.context!)
        s90.id = "90"
        s90.idInt = Int16(90)
        s90.name_ar = "البلد"
        s90.number_ayat = 20
        arr.append(s90)

        let s91 = CSurha.init(context: repo.context!)
        s91.id = "91"
        s91.idInt = Int16(91)
        s91.name_ar = "الشمس"
        s91.number_ayat = 15
        arr.append(s91)

        let s92 = CSurha.init(context: repo.context!)
        s92.id = "92"
        s92.idInt = Int16(92)
        s92.name_ar = "الليل"
        s92.number_ayat = 21
        arr.append(s92)

        let s93 = CSurha.init(context: repo.context!)
        s93.id = "93"
        s93.idInt = Int16(93)
        s93.name_ar = "الضحى"
        s93.number_ayat = 11
        arr.append(s93)

        let s94 = CSurha.init(context: repo.context!)
        s94.id = "94"
        s94.idInt = Int16(94)
        s94.name_ar = "الشرح"
        s94.number_ayat = 8
        arr.append(s94)

        let s95 = CSurha.init(context: repo.context!)
        s95.id = "95"
        s95.idInt = Int16(95)
        s95.name_ar = "التين"
        s95.number_ayat = 8
        arr.append(s95)

        let s96 = CSurha.init(context: repo.context!)
        s96.id = "96"
        s96.idInt = Int16(96)
        s96.name_ar = "العلق"
        s96.number_ayat = 19
        arr.append(s96)

        let s97 = CSurha.init(context: repo.context!)
        s97.id = "97"
        s97.idInt = Int16(97)
        s97.name_ar = "القدر"
        s97.number_ayat = 5
        arr.append(s97)

        let s98 = CSurha.init(context: repo.context!)
        s98.id = "98"
        s98.idInt = Int16(98)
        s98.name_ar = "البينة"
        s98.number_ayat = 8
        arr.append(s98)

        let s99 = CSurha.init(context: repo.context!)
        s99.id = "99"
        s99.idInt = Int16(99)
        s99.name_ar = "الزلزلة"
        s99.number_ayat = 8
        arr.append(s99)

        let s100 = CSurha.init(context: repo.context!)
        s100.id = "100"
        s100.idInt = Int16(100)
        s100.name_ar = "العاديات"
        s100.number_ayat = 11
        arr.append(s100)

        
        let s101 = CSurha.init(context: repo.context!)
        s101.id = "101"
        s101.idInt = Int16(101)
        s101.name_ar = "القارعة"
        s101.number_ayat = 11
        arr.append(s101)

        
        let s102 = CSurha.init(context: repo.context!)
        s102.id = "102"
        s102.idInt = Int16(102)
        s102.name_ar = "التكاثر"
        s102.number_ayat = 8
        arr.append(s102)
        
        let s103 = CSurha.init(context: repo.context!)
        s103.id = "103"
        s103.idInt = Int16(103)
        s103.name_ar = "العصر"
        s103.number_ayat = 3
        arr.append(s103)
        
        let s104 = CSurha.init(context: repo.context!)
        s104.id = "104"
        s104.idInt = Int16(104)
        s104.name_ar = "الهمزة"
        s104.number_ayat = 9
        arr.append(s104)
        
        let s105 = CSurha.init(context: repo.context!)
        s105.id = "105"
        s105.idInt = Int16(105)
        s105.name_ar = "الفيل"
        s105.number_ayat = 5
        arr.append(s105)
        
        let s106 = CSurha.init(context: repo.context!)
        s106.id = "106"
        s106.idInt = Int16(106)
        s106.name_ar = "قريش"
        s106.number_ayat = 4
        arr.append(s106)
        
        let s107 = CSurha.init(context: repo.context!)
        s107.id = "107"
        s107.idInt = Int16(107)
        s107.name_ar = "الماعون"
        s107.number_ayat = 7
        arr.append(s107)
        
        let s108 = CSurha.init(context: repo.context!)
        s108.id = "108"
        s108.idInt = Int16(108)
        s108.name_ar = "الكوثر"
        s108.number_ayat = 3
        arr.append(s108)
        
        let s109 = CSurha.init(context: repo.context!)
        s109.id = "109"
        s109.idInt = Int16(109)
        s109.name_ar = "الكافرون"
        s109.number_ayat = 6
        arr.append(s109)
        
        let s110 = CSurha.init(context: repo.context!)
        s110.id = "110"
        s110.idInt = Int16(110)
        s110.name_ar = "النصر"
        s110.number_ayat = 3
        arr.append(s110)
        
        let s111 = CSurha.init(context: repo.context!)
        s111.id = "111"
        s111.idInt = Int16(111)
        s111.name_ar = "المسد"
        s111.number_ayat = 5
        arr.append(s111)
        
        let s112 = CSurha.init(context: repo.context!)
        s112.id = "112"
        s112.idInt = Int16(112)
        s112.name_ar = "الإخلاص"
        s112.number_ayat = 4
        arr.append(s112)
        
        let s113 = CSurha.init(context: repo.context!)
        s113.id = "113"
        s113.idInt = Int16(113)
        s113.name_ar = "الفلق"
        s113.number_ayat = 5
        arr.append(s113)
        
        let s114 = CSurha.init(context: repo.context!)
        s114.id = "114"
        s114.idInt = Int16(114)
        s114.name_ar = "الناس"
        s114.number_ayat = 6
        arr.append(s114)
        
        
        arr = handleStartSurha(arr: arr)
        
        return arr
    }

    static func surhaNames() -> [String]{
        return [
            "الفاتحة",
            "البقرة",
            "ال عمران",
            "النساء",
            "المائدة",
"الأنعام",
"الأعراف",
"الأنفال",
"التوبة",
"يونس",
"هود",
"يوسف",
"الرعد",
"ابراهيم",
"الحجر",
"النحل",
"الإسراء",
"الكهف",
"مريم",
"طه",
"الأنبياء",
"الحج",
"المؤمنون",
"النور",
"الفرقان",
"الشعراء",
"النمل",
"القصص",
"العنكبوت",
"الروم",
"لقمان",
"السجدة",
"الأحزاب",
"سبأ",
"فاطر",
"يس",
"الصافات",
"سورة ص",
"الزمر",
"غافر",
"فصلت",
"الشورى",
"الزخرف",
"الدخان",
"الجاثية",
"الاحقاف",
"محمد",
"الفتح",
"الحجرات",
"ق",
            "الذاريات",
"الطور",
"النجم",
"القمر",
"الرحمن",
"الواقعة",
"الحديد",
"المجادلة",
"الحشر",
"الممتحنة",
"الصف",
"الجمعة",
"المنافقون",
"التغابن",
"الطلاق",
"التحريم",
"الملك",
"القلم",
"الحاقة",
"المعارج",
"نوح",
"الجن",
"المزمل",
"المدثر",
"القيامة",
"الإنسان",
"المرسلات",
"النبأ",
"النازعات",
"عبس",
"التكوير",
"الإنفطار",
"المطففين",
"الانشقاق",
"البروج",
"الطارق",
"الأعلى",
"الغاشية",
"الفجر",
"البلد",
"الشمس",
"الليل",
"الضحى",
"الشرح",
"التين",
"العلق",
"القدر",
"البينة",
"الزلزلة",
"العاديات",
"القارعة",
"التكاثر",
"العصر",
"الهمزة",
"الفيل",
"قريش",
"الماعون",
"الكوثر",
"الكافرون",
"النصر",
"المسد",
"الإخلاص",
"الفلق",
"الناس",


        ]
    }
    
    static func correctSurhaNames() {
        let correctNames = surhaNames()
        let repo = CoreDataRepository<CSurha>.init()
        let surhas = repo.getAll() ?? []
        let orderSurhas = surhas.sorted{Int($0.id ?? "0")! < Int($1.id ?? "0")!}
        var index = 0
        for item in orderSurhas {
            item.name_ar = correctNames[index]
            index = index + 1
        }
        CoreDataRepository.save()

    }
    
    
}
