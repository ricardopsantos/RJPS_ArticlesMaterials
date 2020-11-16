//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
// swiftlint:disable file_length type_body_length

extension AppConstants.Mocks {

    public struct GalleryApp {

        public static var imageInfo_200: String {
            return """
            {
              "sizes": {
                "canblog": 0,
                "canprint": 0,
                "candownload": 1,
                "size": [
                  {
                    "label": "Square",
                    "width": 75,
                    "height": 75,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_s.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/sq\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Large Square",
                    "width": 150,
                    "height": 150,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_q.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/q\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Thumbnail",
                    "width": 100,
                    "height": 56,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_t.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/t\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Small",
                    "width": 240,
                    "height": 135,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_m.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/s\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Small 320",
                    "width": 320,
                    "height": 180,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_n.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/n\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Small 400",
                    "width": 400,
                    "height": 225,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_w.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/w\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Medium",
                    "width": 500,
                    "height": 281,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/m\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Medium 640",
                    "width": 640,
                    "height": 360,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_z.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/z\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Medium 800",
                    "width": 800,
                    "height": 450,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_c.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/c\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Large",
                    "width": 1024,
                    "height": 576,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5a0af4ddc8_b.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/l\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Large 1600",
                    "width": 1600,
                    "height": 900,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_5c3cd7e224_h.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/h\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Large 2048",
                    "width": 2048,
                    "height": 1152,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_3acfddf6e2_k.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/k\\/",
                    "media": "photo"
                  },
                  {
                    "label": "X-Large 3K",
                    "width": 3072,
                    "height": 1728,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_432b1bc25f_3k.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/3k\\/",
                    "media": "photo"
                  },
                  {
                    "label": "X-Large 4K",
                    "width": 4096,
                    "height": 2304,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_01cb808199_4k.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/4k\\/",
                    "media": "photo"
                  },
                  {
                    "label": "X-Large 5K",
                    "width": 4608,
                    "height": 2592,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_3140fd974f_5k.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/5k\\/",
                    "media": "photo"
                  },
                  {
                    "label": "Original",
                    "width": 4608,
                    "height": 2592,
                    "source": "https:\\/\\/live.staticflickr.com\\/5800\\/31456463045_fe2ef86591_o.jpg",
                    "url": "https:\\/\\/www.flickr.com\\/photos\\/alex53\\/31456463045\\/sizes\\/o\\/",
                    "media": "photo"
                  }
                ]
              },
              "stat": "ok"
            }
            """
        }

        public static var search_200: String {
            return """
            {
              "photos": {
                "page": 1,
                "pages": 10033,
                "perpage": 100,
                "total": "1003236",
                "photo": [
                  {
                    "id": "50268246367",
                    "owner": "51388540@N05",
                    "secret": "aefb133f59",
                    "server": "65535",
                    "farm": 66,
                    "title": "8945 - Cat bite",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267826756",
                    "owner": "145392722@N03",
                    "secret": "c6737321a5",
                    "server": "65535",
                    "farm": 66,
                    "title": "Come & Dance With Me",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267553361",
                    "owner": "51388540@N05",
                    "secret": "cfd2089b5b",
                    "server": "65535",
                    "farm": 66,
                    "title": "8909 - Soccer player",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50266871238",
                    "owner": "125409966@N08",
                    "secret": "3c7ec60faa",
                    "server": "65535",
                    "farm": 66,
                    "title": "Coco",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267585242",
                    "owner": "151415700@N07",
                    "secret": "584c9436bc",
                    "server": "65535",
                    "farm": 66,
                    "title": "young girl portrait with cats",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267552692",
                    "owner": "55433629@N07",
                    "secret": "cef4822b65",
                    "server": "65535",
                    "farm": 66,
                    "title": "Wondering eyes",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267279266",
                    "owner": "7270070@N06",
                    "secret": "ef33ba28fb",
                    "server": "65535",
                    "farm": 66,
                    "title": "",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267278766",
                    "owner": "7270070@N06",
                    "secret": "a6389e18dc",
                    "server": "65535",
                    "farm": 66,
                    "title": "",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267456627",
                    "owner": "7270070@N06",
                    "secret": "d39c530b2b",
                    "server": "65535",
                    "farm": 66,
                    "title": "",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50265931728",
                    "owner": "184307436@N07",
                    "secret": "9e170a3001",
                    "server": "65535",
                    "farm": 66,
                    "title": "Face of a Fuzzle Wuzzin",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50266740862",
                    "owner": "23745614@N04",
                    "secret": "e42ee54001",
                    "server": "65535",
                    "farm": 66,
                    "title": "Buzz & Cookie 22-08-20",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "49681708863",
                    "owner": "98062192@N08",
                    "secret": "2d368726d6",
                    "server": "65535",
                    "farm": 66,
                    "title": "Manni",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50265608478",
                    "owner": "91619997@N04",
                    "secret": "593e488fbb",
                    "server": "65535",
                    "farm": 66,
                    "title": "Origami Kitten (Ryo Aoki)",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264823728",
                    "owner": "88868852@N02",
                    "secret": "6f11c93c62",
                    "server": "65535",
                    "farm": 66,
                    "title": "Surrounded In Spring",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264337398",
                    "owner": "22013974@N06",
                    "secret": "d01107e394",
                    "server": "65535",
                    "farm": 66,
                    "title": "Luna - Norwegian Forest Cat",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264989631",
                    "owner": "22013974@N06",
                    "secret": "21c177b2ee",
                    "server": "65535",
                    "farm": 66,
                    "title": "Luna - Norwegian Forest Cat",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264664376",
                    "owner": "46743603@N08",
                    "secret": "ca727aec3d",
                    "server": "65535",
                    "farm": 66,
                    "title": "Si les moustaches passent, tout passe ..",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264795312",
                    "owner": "91280126@N05",
                    "secret": "0d91470119",
                    "server": "65535",
                    "farm": 66,
                    "title": "Melo obscure #366photos2020",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264049281",
                    "owner": "57256462@N07",
                    "secret": "21c085ebef",
                    "server": "65535",
                    "farm": 66,
                    "title": "Playing geoffroy's cat cub",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50264004072",
                    "owner": "33949419@N06",
                    "secret": "8414ff522c",
                    "server": "65535",
                    "farm": 66,
                    "title": "meowwww",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50263768857",
                    "owner": "51388540@N05",
                    "secret": "aff9cf57ca",
                    "server": "65535",
                    "farm": 66,
                    "title": "8920 - Someone, please, help me!",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50263292566",
                    "owner": "51388540@N05",
                    "secret": "6164b4c637",
                    "server": "65535",
                    "farm": 66,
                    "title": "8893 - A cup of fresh water",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262736506",
                    "owner": "39683033@N08",
                    "secret": "aac14ab109",
                    "server": "65535",
                    "farm": 66,
                    "title": "Mandy Monday: Just Cuteness",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262599556",
                    "owner": "183761962@N05",
                    "secret": "53958b8c01",
                    "server": "65535",
                    "farm": 66,
                    "title": "Billie Nova - Sleepy Kitty 2",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262599506",
                    "owner": "183761962@N05",
                    "secret": "06e1220b47",
                    "server": "65535",
                    "farm": 66,
                    "title": "Billie Nova - Sleepy Kitty 1",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50261629438",
                    "owner": "106123975@N05",
                    "secret": "562e3502ef",
                    "server": "65535",
                    "farm": 66,
                    "title": "Roxy en couleurs.",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262277261",
                    "owner": "147167930@N04",
                    "secret": "e9a8e87da5",
                    "server": "65535",
                    "farm": 66,
                    "title": "lenny",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262277251",
                    "owner": "147167930@N04",
                    "secret": "a2fcfdb69b",
                    "server": "65535",
                    "farm": 66,
                    "title": "lenny",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50262466937",
                    "owner": "147167930@N04",
                    "secret": "cfd559ebd3",
                    "server": "65535",
                    "farm": 66,
                    "title": "lenny",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50261442468",
                    "owner": "87695420@N02",
                    "secret": "7d8268f221",
                    "server": "65535",
                    "farm": 66,
                    "title": "Zadig",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50261197587",
                    "owner": "145114455@N02",
                    "secret": "cd1ca47eb1",
                    "server": "65535",
                    "farm": 66,
                    "title": "Sipping Some Milk",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260488582",
                    "owner": "8595783@N08",
                    "secret": "006bbaee5b",
                    "server": "65535",
                    "farm": 66,
                    "title": "01-IMG_2610",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260487317",
                    "owner": "8595783@N08",
                    "secret": "72f6a106ee",
                    "server": "65535",
                    "farm": 66,
                    "title": "02-IMG_2613",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259641298",
                    "owner": "8595783@N08",
                    "secret": "5b36851658",
                    "server": "65535",
                    "farm": 66,
                    "title": "03-IMG_2614",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260295681",
                    "owner": "8595783@N08",
                    "secret": "fdfaa5b6bc",
                    "server": "65535",
                    "farm": 66,
                    "title": "04-IMG_2615",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260484177",
                    "owner": "8595783@N08",
                    "secret": "b3ce8f49ed",
                    "server": "65535",
                    "farm": 66,
                    "title": "05-IMG_2616",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260292541",
                    "owner": "8595783@N08",
                    "secret": "8bc98f40f4",
                    "server": "65535",
                    "farm": 66,
                    "title": "06-IMG_2619",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260481372",
                    "owner": "8595783@N08",
                    "secret": "05ae11ae1e",
                    "server": "65535",
                    "farm": 66,
                    "title": "07-IMG_2620",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260289581",
                    "owner": "8595783@N08",
                    "secret": "4c4b95984d",
                    "server": "65535",
                    "farm": 66,
                    "title": "08-IMG_2623",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260287786",
                    "owner": "8595783@N08",
                    "secret": "0462b96ccd",
                    "server": "65535",
                    "farm": 66,
                    "title": "09-IMG_2626",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259629848",
                    "owner": "8595783@N08",
                    "secret": "023fb52fa9",
                    "server": "65535",
                    "farm": 66,
                    "title": "10-IMG_2628",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260473502",
                    "owner": "8595783@N08",
                    "secret": "4455df2d0b",
                    "server": "65535",
                    "farm": 66,
                    "title": "11-IMG_2629",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260471767",
                    "owner": "8595783@N08",
                    "secret": "74ae2e0553",
                    "server": "65535",
                    "farm": 66,
                    "title": "12-IMG_2631",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260470537",
                    "owner": "8595783@N08",
                    "secret": "00c3a21ba8",
                    "server": "65535",
                    "farm": 66,
                    "title": "13-IMG_2633",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259623063",
                    "owner": "8595783@N08",
                    "secret": "5ddbcace56",
                    "server": "65535",
                    "farm": 66,
                    "title": "14-IMG_2634",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259621613",
                    "owner": "8595783@N08",
                    "secret": "09a9e6c884",
                    "server": "65535",
                    "farm": 66,
                    "title": "15-IMG_2635",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260466247",
                    "owner": "8595783@N08",
                    "secret": "c3b2e794ef",
                    "server": "65535",
                    "farm": 66,
                    "title": "16-IMG_2638",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260465072",
                    "owner": "8595783@N08",
                    "secret": "d07df977d2",
                    "server": "65535",
                    "farm": 66,
                    "title": "17-IMG_2640",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260272796",
                    "owner": "8595783@N08",
                    "secret": "f3b49a9008",
                    "server": "65535",
                    "farm": 66,
                    "title": "18-IMG_2643",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260271376",
                    "owner": "8595783@N08",
                    "secret": "d83a362791",
                    "server": "65535",
                    "farm": 66,
                    "title": "19-IMG_2646",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260460647",
                    "owner": "8595783@N08",
                    "secret": "c16ce6b7db",
                    "server": "65535",
                    "farm": 66,
                    "title": "20-IMG_2647",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259613658",
                    "owner": "8595783@N08",
                    "secret": "2ddcd7be25",
                    "server": "65535",
                    "farm": 66,
                    "title": "21-IMG_2651",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260458527",
                    "owner": "8595783@N08",
                    "secret": "eb630483c8",
                    "server": "65535",
                    "farm": 66,
                    "title": "22-IMG_2656",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260196991",
                    "owner": "85730035@N04",
                    "secret": "dcbdf04f98",
                    "server": "65535",
                    "farm": 66,
                    "title": "Harry is playing",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50260298997",
                    "owner": "138171302@N03",
                    "secret": "d9243e5d27",
                    "server": "65535",
                    "farm": 66,
                    "title": "\\u2116 046",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259106103",
                    "owner": "123905050@N02",
                    "secret": "275819dae5",
                    "server": "65535",
                    "farm": 66,
                    "title": "@GBM and @Liz_Art_Berlin Hero kitten",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259019478",
                    "owner": "51388540@N05",
                    "secret": "ba4b1aae6c",
                    "server": "65535",
                    "farm": 66,
                    "title": "8943 - My finger! My finger!",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259471407",
                    "owner": "109677547@N08",
                    "secret": "c04386e019",
                    "server": "65535",
                    "farm": 66,
                    "title": "Missy",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50259199837",
                    "owner": "115464896@N07",
                    "secret": "86b9e1049e",
                    "server": "65535",
                    "farm": 66,
                    "title": "Oriental Shorthair, Male",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258765361",
                    "owner": "187259778@N07",
                    "secret": "74ed0f707f",
                    "server": "65535",
                    "farm": 66,
                    "title": "Neptune",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258949337",
                    "owner": "187259778@N07",
                    "secret": "c9b1366743",
                    "server": "65535",
                    "farm": 66,
                    "title": "Neptune",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258949292",
                    "owner": "187259778@N07",
                    "secret": "a041fb1af6",
                    "server": "65535",
                    "farm": 66,
                    "title": "Neptune",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258105388",
                    "owner": "187259778@N07",
                    "secret": "70ca206982",
                    "server": "65535",
                    "farm": 66,
                    "title": "Neptune",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258634381",
                    "owner": "131486025@N07",
                    "secret": "cc4b0ff018",
                    "server": "65535",
                    "farm": 66,
                    "title": "Buster",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258605151",
                    "owner": "87642046@N00",
                    "secret": "80a7178515",
                    "server": "65535",
                    "farm": 66,
                    "title": "Day 235 - The rarely seen Bitty",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258604876",
                    "owner": "87642046@N00",
                    "secret": "1819362c65",
                    "server": "65535",
                    "farm": 66,
                    "title": "Day 233 - A week old now",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258789422",
                    "owner": "87642046@N00",
                    "secret": "1f2c7af77f",
                    "server": "65535",
                    "farm": 66,
                    "title": "Day 232 - Meet Ted",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50257946153",
                    "owner": "87642046@N00",
                    "secret": "c2b7fc62b5",
                    "server": "65535",
                    "farm": 66,
                    "title": "Day 230 - New member of the menagerie",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258775192",
                    "owner": "131486025@N07",
                    "secret": "2a614534a1",
                    "server": "65535",
                    "farm": 66,
                    "title": "Buster",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50043767592",
                    "owner": "98062192@N08",
                    "secret": "0dab85d5bf",
                    "server": "65535",
                    "farm": 66,
                    "title": "Mein s\\u00fc\\u00dfer Kater Manfred",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258273526",
                    "owner": "57256462@N07",
                    "secret": "eca255cb5b",
                    "server": "65535",
                    "farm": 66,
                    "title": "Playing geoffroy's cat cub",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258375432",
                    "owner": "29617521@N06",
                    "secret": "1ac6189122",
                    "server": "65535",
                    "farm": 66,
                    "title": "Meet Milo",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258040591",
                    "owner": "147140262@N03",
                    "secret": "98a206a63a",
                    "server": "65535",
                    "farm": 66,
                    "title": "Suki #5",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50258023132",
                    "owner": "151397551@N04",
                    "secret": "9d1cb837f7",
                    "server": "65535",
                    "farm": 66,
                    "title": "Tired Pixel",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256441642",
                    "owner": "188662281@N03",
                    "secret": "d000236e18",
                    "server": "0",
                    "farm": 0,
                    "title": "You Can't Take Away Kitty From Night Football Game",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255587733",
                    "owner": "188662281@N03",
                    "secret": "5690086a2e",
                    "server": "0",
                    "farm": 0,
                    "title": "Yumy Yumy Roasted Backed Bones For Kitten Lunch",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256271236",
                    "owner": "188662281@N03",
                    "secret": "07c5f3ecc1",
                    "server": "0",
                    "farm": 0,
                    "title": "What's Kitten Favorite Food",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255611703",
                    "owner": "188662281@N03",
                    "secret": "c3bb3a527c",
                    "server": "0",
                    "farm": 0,
                    "title": "Twins Kitties Play On Stairs",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256279556",
                    "owner": "188662281@N03",
                    "secret": "46c4ee8b63",
                    "server": "0",
                    "farm": 0,
                    "title": "Twins Kitten First Food Party",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255601618",
                    "owner": "188662281@N03",
                    "secret": "6173a79525",
                    "server": "0",
                    "farm": 0,
                    "title": "Wrestling Kitties At Home",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255491558",
                    "owner": "51388540@N05",
                    "secret": "cb18674e86",
                    "server": "65535",
                    "farm": 66,
                    "title": "8911 - Pericle",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256249977",
                    "owner": "57256462@N07",
                    "secret": "c4f711b1ba",
                    "server": "65535",
                    "farm": 66,
                    "title": "Playing geoffroy's cat cub",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255348723",
                    "owner": "59847966@N06",
                    "secret": "f922c6ae4f",
                    "server": "65535",
                    "farm": 66,
                    "title": "Loveliness",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256155917",
                    "owner": "124651729@N04",
                    "secret": "bbf979ffb5",
                    "server": "65535",
                    "farm": 66,
                    "title": "Kiwi in her Little House",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255307388",
                    "owner": "8185859@N08",
                    "secret": "6e4a3115e4",
                    "server": "65535",
                    "farm": 66,
                    "title": "Lilli",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256017372",
                    "owner": "188662281@N03",
                    "secret": "b17051fba1",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Lunch With Sibilings",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255838646",
                    "owner": "188662281@N03",
                    "secret": "32ce29dda7",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Lunch Bone Crusher",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255998422",
                    "owner": "188662281@N03",
                    "secret": "58d010f9c0",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten On Bed After Mother Shower",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255182268",
                    "owner": "188662281@N03",
                    "secret": "a1895063b7",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Fresh Cleaning With Sibilings",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255794611",
                    "owner": "188662281@N03",
                    "secret": "ea7fddc28c",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Play Time On Onion Basket",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256051352",
                    "owner": "188662281@N03",
                    "secret": "3f47a649de",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Fight Brother On Bed",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255118073",
                    "owner": "188662281@N03",
                    "secret": "4c932082ec",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Triplets Bed Fight",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256003887",
                    "owner": "188662281@N03",
                    "secret": "fd2ca63f94",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Mummy Sleep While Owner Watch Movie",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50256063502",
                    "owner": "188662281@N03",
                    "secret": "26d51df34d",
                    "server": "0",
                    "farm": 0,
                    "title": "Sofi Kitten Double Breastfeeding",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50267407948",
                    "owner": "184307436@N07",
                    "secret": "e121d5d146",
                    "server": "65535",
                    "farm": 66,
                    "title": "I don\\u2019t play rough, not me.",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  },
                  {
                    "id": "50255594453",
                    "owner": "188662281@N03",
                    "secret": "c5a11d2f54",
                    "server": "0",
                    "farm": 0,
                    "title": "Yumy Fresh Bones For 4 Twins Kittens",
                    "ispublic": 1,
                    "isfriend": 0,
                    "isfamily": 0
                  }
                ]
              },
              "stat": "ok"
            }
            """
        }
    }
}
