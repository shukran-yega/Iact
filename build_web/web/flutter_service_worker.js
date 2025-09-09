'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "45c10e17e19cce78a501147e2f434272",
"assets/AssetManifest.bin.json": "37a45ad0bf87adc0ec8ae83828979ff4",
"assets/AssetManifest.json": "faa60d36691df1c3647d775becf64273",
"assets/assets/aaph.jpg": "5a6b3c9b7c58404926297afdec13d0d8",
"assets/assets/aaph.png": "4fecf38c1f04cb3009a6a8455183889a",
"assets/assets/apo.jpeg": "7c4e9e052a53510190b34f9dc6d0e2a5",
"assets/assets/cloud.jpg": "cb867f8150c9a0a17e0431a6d53e5f52",
"assets/assets/computer.jpg": "f28d8e57fd1715d90a72341c24cee494",
"assets/assets/dhis2.jpg": "cc8b9e650f51957b2b0de82670901638",
"assets/assets/dhis2.png": "1ed9a78a2451d62917251b9b03cd280b",
"assets/assets/emblem.png": "4d31c5bbd74dbe0bb610b660b3fc553b",
"assets/assets/experts.jpg": "56a9ccd097d48fe9010a9dcc69449d86",
"assets/assets/farida.jpeg": "ae4313d7c0aeec4648ce04cf34d33add",
"assets/assets/fern.png": "bc4ea04d44410852c6a881ce91b16112",
"assets/assets/fernLogo.png": "ca386f955332cac069952cb92e41b14a",
"assets/assets/fern_1.png": "d94639b1d5642590d4419e622f38098c",
"assets/assets/field.jpg": "adb18a92a5fcb158f16449e5f038febd",
"assets/assets/field10.jpg": "e59a1777398bc1828e386ed4707dce8e",
"assets/assets/field11.jpg": "1e1ecb95c6bc4a20fb4148976ddc4eb0",
"assets/assets/field11_2.jpg": "41696bd94a93e496c43223f0e776ed52",
"assets/assets/field12.jpg": "e24c2a12f230fa5435f9c8fa2c790ee2",
"assets/assets/field13.png": "4456003647c5601aa856d150c5b7fdab",
"assets/assets/field14.jpg": "791ecbff356b8cca6231ccea0b1856ae",
"assets/assets/field2.jpg": "bb4697f4dc95a2e91ab8097cd704d69b",
"assets/assets/field3.jpg": "6b515e33d3c8da2508c4ba32491a4d3b",
"assets/assets/field4.jpg": "a7bd9584c6397654d7d4f6ef02215728",
"assets/assets/field5.jpg": "1a427cc024b081b6d7d07ceec56a85e9",
"assets/assets/field5_2.jpg": "5829bc0f9b952707474baa6bbf43220a",
"assets/assets/field7.jpg": "aa9e24e2d9d1322906a40e05c7dd2dd2",
"assets/assets/field8.jpg": "3d204b0d5ab5e01c606715ee91e8875d",
"assets/assets/field9.jpg": "7a7102e82afeede7563a74cb7b3a6616",
"assets/assets/Godfrey.jpg": "6c94c71aadf36815242aae1e0becc14a",
"assets/assets/iact.png": "d9f2e3a77fd6cc6eaf988dadf8d52929",
"assets/assets/IACTProfile.pdf": "022006f746fa69dfb58c7998ab688756",
"assets/assets/ihi.jpg": "2e6e2ae4039ada6bc5276d64b571ecf0",
"assets/assets/isaac.jpg": "b7a71f98e1821b7613a4bdef91cbe6a5",
"assets/assets/jonas.jpg": "24f09b683922953d0073c82f8832c9ab",
"assets/assets/logo.png": "7648a76278a5099689a26b7656647c48",
"assets/assets/meeting.jpg": "b370bba6c80502887d6edd496bd3213f",
"assets/assets/mentor.jpg": "a6c6ea079902431af67a858694e50aa3",
"assets/assets/mentors.jpg": "0d9c009e20e9acd43e163632162a0815",
"assets/assets/mentors.png": "28643465b8afa745cacdf240b01b3a76",
"assets/assets/mobile.jpg": "10226be21646ed5969eeaa59cc9f6a8d",
"assets/assets/pact.jpg": "440026e892c0dd50c6ef1cc54d3a8816",
"assets/assets/pic1.jpg": "787927dafde50889326a02f2feb21283",
"assets/assets/PIC2.jpg": "81668c6675719d7dd589cfc13a3a4ed7",
"assets/assets/t4d.jpg": "2a08c6a649605c5a3a894c513c53d2c5",
"assets/assets/toronto.jpg": "4ae9c7eb7f9c559e722ff0b5a36bd2c2",
"assets/assets/twaweza.jpg": "307df060feb6e5b91cdc85a6199d8142",
"assets/assets/ut.png": "434c90711512f357937caa316347791b",
"assets/assets/water.png": "0396474f7feee638cce51a0bd0d25eaa",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "26eb4476558d4bbcad6346fb9e29b535",
"assets/gears.json": "56ea3daf21493d01b82d9f5bef6bcf5b",
"assets/logo.png": "7648a76278a5099689a26b7656647c48",
"assets/NOTICES": "33c007233b467c827344dfc778be3422",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "e0b0ea7aabfe00c0c83c90c3fb4092af",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "10ad8fe9f406955b28afc34bcd65e227",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "8c9082b77139f2688275f83267e41006",
"/": "8c9082b77139f2688275f83267e41006",
"main.dart.js": "7f5ebb193980304e3f9b9d58969a7eb0",
"manifest.json": "0f36efd48a523738217866ad783e80aa",
"version.json": "4928ea61cf29fdab83af8a8f3b67ac60"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
