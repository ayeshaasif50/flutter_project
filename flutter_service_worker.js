'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "cd2327b2c5af085a9d58b929ce920d73",
"assets/AssetManifest.bin.json": "f1d7ddc52c92f0f0369eef04fbff476a",
"assets/AssetManifest.json": "e5d7f0c596fcea9351cb9c3f22378f24",
"assets/assets/bg.png": "e1601bc4ea028d4af4b769b1be076a99",
"assets/assets/coffee1.png": "6c22dacae10f9253365056929397086b",
"assets/assets/coffee10.png": "9d7aca69097cf3818823549f6da48802",
"assets/assets/coffee11.png": "388e605572a3b61a46fa7bdf63997a0b",
"assets/assets/coffee12.png": "94b3b75cdbb5b021e1a33bacd028f043",
"assets/assets/coffee13.png": "fb64568309e75d5808f46b87a43bfabd",
"assets/assets/coffee14.png": "64ca6f108ab4c332dc8918702b76f0a9",
"assets/assets/coffee2.png": "09eebfa82a36d87af460e18816eefbfa",
"assets/assets/coffee3.png": "9b14bb5676e641e86d1467c20b45233a",
"assets/assets/coffee4.png": "8e368c9e4f17a7101040de0e72b925c4",
"assets/assets/coffee5.png": "3379cdd1eb074f82fe37c71b8e3272e4",
"assets/assets/coffee6.png": "3379cdd1eb074f82fe37c71b8e3272e4",
"assets/assets/coffee7.png": "8be32e35814611a9f0a37e020361a5f8",
"assets/assets/coffee8.png": "62f1441f2d8323a16d528b4a0da54205",
"assets/assets/coffee9.png": "186a39ee89645d9aa97d23540c0cb04d",
"assets/assets/coffee_header.png": "8c2498b3475ed59cc3eb97dbbff91553",
"assets/assets/coffee_logo.png": "dbd7aac59aee5c214a6d9ec57bdba387",
"assets/assets/img.png": "743a3aa1904244de410cb5ec5a2060d2",
"assets/assets/img_1.png": "88963727e0021041192d673f3d1f4259",
"assets/assets/img_10.png": "1e476b0d51750517f1fddaca2b00f218",
"assets/assets/img_11.png": "81ffe63957edf82f4a41bdfd81ec0b57",
"assets/assets/img_12.png": "6904385e3071106d2ca556ba06cc7a86",
"assets/assets/img_13.png": "2f4d142a9fc075ceb2c991a24dffbb9a",
"assets/assets/img_14.png": "66bcef2ca85446a2710c5c6cd6c6bda2",
"assets/assets/img_15.png": "f3b7e4d20cb030273f4df0bb6b5a91b7",
"assets/assets/img_16.png": "31e18aafd3ccef72a1b6e862121be6a1",
"assets/assets/img_17.png": "c4d883c7f1022ae2cca139f833f878ad",
"assets/assets/img_18.png": "0f8e7d1d45959bd90541ef1dfa224818",
"assets/assets/img_19.png": "c4d883c7f1022ae2cca139f833f878ad",
"assets/assets/img_2.png": "c729141c9d6fd99378bebba50f22c526",
"assets/assets/img_20.png": "7dbc086c609bdde544d5840afebf3746",
"assets/assets/img_21.png": "4b4a4498ba5e5af51987826094237ab8",
"assets/assets/img_22.png": "2853c2a55f8d80af1f055535798cb766",
"assets/assets/img_23.png": "2d4467d31ff10adb6494724ac31732fe",
"assets/assets/img_24.png": "9706fcfdc1dc0b50ef3a72db0806cb52",
"assets/assets/img_25.png": "97a7793a084342bf922e487d74789ed1",
"assets/assets/img_26.png": "b3b3b32c36dcbbbbea07dfd0c8370114",
"assets/assets/img_27.png": "a327bf64c6f4c9527a7b8144f5a163a8",
"assets/assets/img_28.png": "2912b1789ca1fa5078ef9ac25ce9ef9c",
"assets/assets/img_29.png": "c76dda6021ff0f534728d2f38e3344f1",
"assets/assets/img_3.png": "f89cd8b645bd18e2f8a1fef8db2928b0",
"assets/assets/img_30.png": "4592fafe4ed8046cdb4548f11e4dbb03",
"assets/assets/img_31.png": "c1a38f8f0576f96de8e046358b1a66c9",
"assets/assets/img_32.png": "142c53ebb4666d7d4bba6404f22191c7",
"assets/assets/img_33.png": "1844e6c8505a735799fe3cf08eacadf0",
"assets/assets/img_35.png": "957c0e72c020250476257ed8a6fe79e8",
"assets/assets/img_36.png": "3cde7474934c26cdd2c81d697a5ce598",
"assets/assets/img_4.png": "7e7dba322441f007d34d4a6045e985ae",
"assets/assets/img_5.png": "f3302db638dfea045d6fdc44d8fe3616",
"assets/assets/img_6.png": "6aa02304b99d1b28ed501071b9b9c366",
"assets/assets/img_7.png": "b1b84cbeafdb016e8ebb84dca088744d",
"assets/assets/img_8.png": "369458c1b346114edd027872be972d37",
"assets/assets/img_9.png": "94b3b75cdbb5b021e1a33bacd028f043",
"assets/assets/logo.png": "5f5a29a4db78baf36a4eec776b5834c5",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "5a54df705e704089c449c5e4e1205171",
"assets/NOTICES": "a78dc8d3f00cfbf0916cc9e108fd3720",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "02ceb150b75f68773d917744c00ca654",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "8236d3a2f6b00bd8f970aab08a32675b",
"/": "8236d3a2f6b00bd8f970aab08a32675b",
"main.dart.js": "2d7ddf93b091904e659703b836ce4812",
"manifest.json": "7d40ac6453cc8dd7c47cae524836ea56",
"version.json": "ffbcabc4ed8f1a372480f95b1d36c6b9"};
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
