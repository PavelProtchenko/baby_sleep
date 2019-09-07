require 'json'
require 'awesome_print'

arr = [{
    "threegeonames" => "MARKS-PICENO-EAGAN",
        "geonumber" => "8483489531649",
          "nearest" => {
            "inlatt" => "51.987198",
          "distance" => "2.787",
          "timezone" => "Europe/Saratov",
         "elevation" => "208",
            "region" => {},
              "name" => "Gora Peschanaya Shishka",
             "state" => "RU",
              "latt" => "51.9947",
             "longt" => "47.2061",
              "city" => "Vol’sk",
              "prov" => "Saratovskaya Oblast",
           "inlongt" => "47.244943",
        "altgeocode" => "SHPES-TJJHP"
    },
          "osmtags" => {
               "wikidata" => "Q21195295",
              "wikipedia" => "ru:Муниципальное образование город Вольск",
               "alt-name" => "муниципального образования город Вольск",
                   "name" => "городское поселение Вольск",
        "official-status" => "ru:городское поселение",
            "admin-level" => "8",
                  "state" => "RU",
               "boundary" => "administrative",
                     "id" => "358079",
                   "type" => "boundary"
    },
          "geocode" => "VOL-TJJHP",
            "major" => {
           "inlatt" => "51.987198",
         "distance" => "11.279",
         "timezone" => "Europe/Saratov",
        "elevation" => "83",
           "region" => {},
             "name" => "Vol’sk",
            "state" => "RU",
             "latt" => "52.04541",
            "longt" => "47.37993",
             "city" => "Vol'sk",
             "prov" => "Saratovskaya Oblast",
          "inlongt" => "47.244943"
    }
}]

ap arr[0]['major']

