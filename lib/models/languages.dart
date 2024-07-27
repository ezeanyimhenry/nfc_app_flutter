class Languages {
  final List<String> languages = {
    // Global languages
    'Abkhazian', 'Afar', 'Afrikaans', 'Akan', 'Albanian', 'Amharic', 'Arabic',
    'Armenian', 'Assamese', 'Avaric', 'Avestan', 'Aymara', 'Azerbaijani',
    'Bashkir', 'Basque', 'Belarusian', 'Bengali', 'Bihari', 'Bislama',
    'Bosnian',
    'Breton', 'Bulgarian', 'Burmese', 'Catalan', 'Cebuano', 'Chichewa',
    'Chinese', 'Church Slavic', 'Chuvash', 'Cornish', 'Corsican', 'Croatian',
    'Czech',
    'Danish', 'Divehi', 'Dutch', 'English', 'Esperanto', 'Estonian', 'Ewe',
    'Fijian', 'Finnish', 'French', 'Fula', 'Galician', 'Georgian', 'German',
    'Greek', 'Guarani', 'Gujarati', 'Haitian Creole', 'Hausa', 'Hebrew',
    'Herero', 'Hiligaynon', 'Hmong', 'Hungarian', 'Ibanag', 'Icelandic',
    'Igbo', 'Indonesian', 'Interlingua', 'Interlingue', 'Inuktitut', 'Inupiat',
    'Irish', 'Italian', 'Japanese', 'Javanese', 'Kalaallisut', 'Kannada',
    'Kanuri', 'Kashmiri', 'Kazakh', 'Khmer', 'Kinyarwanda', 'Kirmanjki',
    'Kyrgyz', 'Lao', 'Latin', 'Latvian', 'Limburgish', 'Lingala', 'Lithuanian',
    'Luxembourgish', 'Macedonian', 'Malagasy', 'Malay', 'Malayalam', 'Maltese',
    'Manx', 'Mongolian', 'Nepali', 'Norwegian', 'Occitan', 'Oromo', 'Ossetian',
    'Pali', 'Pashto', 'Persian', 'Polish', 'Portuguese', 'Punjabi', 'Quechua',
    'Romanian', 'Russian', 'Samoan', 'Sanskrit', 'Scots Gaelic', 'Serbian',
    'Sesotho', 'Shona', 'Sindhi', 'Sinhala', 'Slovak', 'Slovene', 'Somali',
    'Spanish', 'Sundanese', 'Swahili', 'Swati', 'Swedish', 'Tajik', 'Tamil',
    'Tatar', 'Telugu', 'Thai', 'Tibetan', 'Tigrinya', 'Tok Pisin', 'Tonga',
    'Turkish', 'Turkmen', 'Twi', 'Ukrainian', 'Urdu', 'Uzbek', 'Vietnamese',
    'Volapük', 'Walloon', 'Welsh', 'Wolof', 'Xhosa', 'Yiddish', 'Yoruba',
    'Zulu',

    // Nigerian local languages
    'Afar', 'Ajawa', 'Akpafi', 'Amasiri', 'Anang', 'Aso', 'Babanki',
    'Bassa', 'Berom', 'Birom', 'Buru', 'Efik', 'Egbiri', 'Ejagham', 'Ekajuk',
    'Ekoid', 'Eku', 'Enang', 'Ewondo', 'Fulfulde', 'Gwari', 'Gwandara',
    'Idoma', 'Igala', 'Jukun', 'Kanuri', 'Koma', 'Kpelle', 'Mabia',
    'Mbiri', 'Mumuye', 'Ngas', 'Ngene', 'Piti', 'Rukuba', 'Shubi', 'Sokoto',
    'Tiv', 'Ugep',

    // Local languages from other countries
    // Africa
    'Acoli', 'Amo', 'Berber', 'Chaga', 'Digo', 'Fante', 'Kisii', 'Luo',
    'Malagasy', 'Ndebele', 'Shona', 'Tswana', 'Wolof', 'Xhosa', 'Zulu',

    // Asia
    'Bengali', 'Burmese', 'Cambodian', 'Farsi', 'Gujarati', 'Hmong', 'Hindi',
    'Javanese', 'Kazakh', 'Khmer', 'Kurdish', 'Malay', 'Nepali', 'Pashto',
    'Punjabi', 'Tagalog', 'Tamil', 'Thai', 'Turkish', 'Uighur', 'Urdu',
    'Vietnamese',

    // Europe
    'Catalan', 'Croatian', 'Czech', 'Danish', 'Dutch', 'Estonian', 'Finnish',
    'Galician', 'Georgian', 'German', 'Greek', 'Hungarian', 'Icelandic',
    'Irish', 'Italian', 'Latvian', 'Lithuanian', 'Macedonian', 'Maltese',
    'Norwegian', 'Polish', 'Portuguese', 'Romanian', 'Russian', 'Serbian',
    'Slovak', 'Slovene', 'Spanish', 'Swedish',

    // Americas
    'Aymara', 'Brazilian Portuguese', 'Quechua', 'Spanish', 'Guarani',
    'Nahuatl', 'Mayan', 'Mapudungun', 'Papiamento',

    // Oceania
    'Hiri Motu', 'Samoan', 'Tongan', 'Fijian', 'Bislama'
  }.toList()
    ..sort(); // Remove duplicates and sort alphabetically
}
