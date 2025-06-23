//
//  LanguageSwitcherData.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

struct LanguageSwitcherData: Codable {
    let value: String
    let label: String
}

let appLanguageSwitcherData: [LanguageSwitcherData] = [
    LanguageSwitcherData(value: "en", label: "English"), // English
    LanguageSwitcherData(value: "ar", label: "العربية"), // Arabic
    LanguageSwitcherData(value: "de", label: "Deutsch"), //German
    LanguageSwitcherData(value: "es", label: "Español"), //Spanish
    LanguageSwitcherData(value: "fr", label: "Français"), //French
    LanguageSwitcherData(value: "he", label: "עברית"), //Hebrew
    LanguageSwitcherData(value: "hi", label: "हिन्दी"), //Hindi
    LanguageSwitcherData(value: "it", label: "Italiano"), //Italian
    LanguageSwitcherData(value: "ja", label: "日本語"), //Japanese
    LanguageSwitcherData(value: "ko", label: "한국어"), //Korean
    LanguageSwitcherData(value: "pt-PT", label: "Português"), //Portuguese
    LanguageSwitcherData(value: "zh-Hans", label: "中文 (简体)"), //Chinese (Simplified)
    LanguageSwitcherData(value: "zh-Hant", label: "中文 (繁體)") // Chinese (Traditional)
]

let mapLanguageSwitcherData: [LanguageSwitcherData] = [
    LanguageSwitcherData(value: "en", label: "English"), // English
    LanguageSwitcherData(value: "ar", label: "العربية"), // Arabic
    LanguageSwitcherData(value: "as", label: "অসমীয়া"), // Assamese
    LanguageSwitcherData(value: "az", label: "Azərbaycan dili"), //Azerbaijani
    LanguageSwitcherData(value: "be", label: "беларуская"), //Belarusian
    LanguageSwitcherData(value: "bg", label: "български"), //Bulgarian
    LanguageSwitcherData(value: "bn", label: "বাংলা"), //Bengali
    LanguageSwitcherData(value: "bs", label: "Bosanski"), //Bosnian
    LanguageSwitcherData(value: "ca", label: "Català"), //Catalan
    LanguageSwitcherData(value: "cs", label: "Čeština"), //Czech
    LanguageSwitcherData(value: "cy", label: "Cymraeg"), //Welsh
    LanguageSwitcherData(value: "da", label: "Dansk"), //Danish
    LanguageSwitcherData(value: "de", label: "Deutsch"), //German
    LanguageSwitcherData(value: "el", label: "Ελληνικά"), //Greek
    LanguageSwitcherData(value: "es", label: "Español"), //Spanish
    LanguageSwitcherData(value: "et", label: "Eesti"), //Estonian
    LanguageSwitcherData(value: "eu", label: "Euskara"), //Basque
    LanguageSwitcherData(value: "fi", label: "Suomi"), //Finnish
    LanguageSwitcherData(value: "fo", label: "Føroyskt"), //Faroese
    LanguageSwitcherData(value: "fr", label: "Français"), //French
    LanguageSwitcherData(value: "ga", label: "Gaeilge"), //Irish
    LanguageSwitcherData(value: "gl", label: "Galego"), //Galician
    LanguageSwitcherData(value: "gn", label: "Avañe'ẽ"), //Guarani
    LanguageSwitcherData(value: "gu", label: "ગુજરાતી"), //Gujarati
    LanguageSwitcherData(value: "he", label: "עברית"), //Hebrew
    LanguageSwitcherData(value: "hi", label: "हिन्दी"), //Hindi
    LanguageSwitcherData(value: "hr", label: "Hrvatski"), //Croatian
    LanguageSwitcherData(value: "hu", label: "Magyar"), //Hungarian
    LanguageSwitcherData(value: "hy", label: "Հայերեն"), //Armenian
    LanguageSwitcherData(value: "id", label: "Bahasa Indonesia"), //Indonesian
    LanguageSwitcherData(value: "is", label: "Íslenska"), //Icelandic
    LanguageSwitcherData(value: "it", label: "Italiano"), //Italian
    LanguageSwitcherData(value: "ja", label: "日本語"), //Japanese
    LanguageSwitcherData(value: "ka", label: "ქართული"), //Georgian
    LanguageSwitcherData(value: "kk", label: "Қазақша"), //Kazakh
    LanguageSwitcherData(value: "km", label: "ភាសាខ្មែរ"), //Khmer
    LanguageSwitcherData(value: "kn", label: "ಕನ್ನಡ"), //Kannada
    LanguageSwitcherData(value: "ko", label: "한국어"), //Korean
    LanguageSwitcherData(value: "ky", label: "Кыргызча"), //Kyrgyz
    LanguageSwitcherData(value: "lt", label: "Lietuvių"), //Lithuanian
    LanguageSwitcherData(value: "lv", label: "Latviešu"), //Latvian
    LanguageSwitcherData(value: "mk", label: "Македонски"), //Macedonian
    LanguageSwitcherData(value: "ml", label: "മലയാളം"), //Malayalam
    LanguageSwitcherData(value: "mr", label: "मराठी"), //Marathi
    LanguageSwitcherData(value: "ms", label: "Bahasa Melayu"), //Malay
    LanguageSwitcherData(value: "mt", label: "Malti"), //Maltese
    LanguageSwitcherData(value: "my", label: "မြန်မာ"), //Burmese
    LanguageSwitcherData(value: "nl", label: "Nederlands"), //Dutch
    LanguageSwitcherData(value: "no", label: "Norsk"), //Norwegian
    LanguageSwitcherData(value: "or", label: "ଓଡ଼ିଆ"), //Odia
    LanguageSwitcherData(value: "pa", label: "ਪੰਜਾਬੀ"), //Punjabi
    LanguageSwitcherData(value: "pl", label: "Polski"), //Polish
    LanguageSwitcherData(value: "pt", label: "Português"), //Portuguese
    LanguageSwitcherData(value: "ro", label: "Română"), //Romanian
    LanguageSwitcherData(value: "ru", label: "Русский"), //Russian
    LanguageSwitcherData(value: "sk", label: "Slovenčina"), //Slovak
    LanguageSwitcherData(value: "sl", label: "Slovenščina"), //Slovenian
    LanguageSwitcherData(value: "sq", label: "Shqip"), //Albanian
    LanguageSwitcherData(value: "sr", label: "Српски"), //Serbian
    LanguageSwitcherData(value: "sv", label: "Svenska"), //Swedish
    LanguageSwitcherData(value: "ta", label: "தமிழ்"), //Tamil
    LanguageSwitcherData(value: "te", label: "తెలుగు"), //Telugu
    LanguageSwitcherData(value: "th", label: "ไทย"), //Thai
    LanguageSwitcherData(value: "tr", label: "Türkçe"), //Turkish
    LanguageSwitcherData(value: "uk", label: "Українська"), //Ukrainian
    LanguageSwitcherData(value: "uz", label: "Oʻzbekcha"), //Uzbek
    LanguageSwitcherData(value: "vi", label: "Tiếng Việt"), //Vietnamese
    LanguageSwitcherData(value: "zh", label: "中文 (简体)"), //Chinese (Simplified)
    LanguageSwitcherData(value: "zh-Hant", label: "中文 (繁體)") // Chinese (Traditional)
]
