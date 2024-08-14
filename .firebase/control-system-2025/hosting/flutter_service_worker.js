'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "b4d2f7a6359c9f92e742823c52c6a593",
"assets/AssetManifest.bin.json": "54f07482dd2f75e9698a2dd371c5f9f5",
"assets/AssetManifest.json": "532573323b14df08ec8a7d3a2ba52a0f",
"assets/assets/animation/loading_aimation.json": "19f6948f87480e5ababdcebe8684cb0f",
"assets/assets/animation/scanner.json": "e1e794c481f0ea851e4f3c8d1f3303c7",
"assets/assets/files/template.pdf": "f535779e1934e1865f3931826ec112b0",
"assets/assets/fonts/Nunito-Black.ttf": "529509f5501c7f45315210d280a456d4",
"assets/assets/fonts/Nunito-Bold.ttf": "c0844c990ecaaeb9f124758d38df4f3f",
"assets/assets/fonts/Nunito-Light.ttf": "08bc5f85e4505782d3fa279944f2feab",
"assets/assets/fonts/Nunito-Regular.ttf": "d8de52e6c5df1a987ef6b9126a70cfcc",
"assets/assets/fonts/Nunito-SemiBold.ttf": "876701bc4fbf6166f07f152691b15159",
"assets/assets/fonts/open-sans.ttf": "996d0154a25c63500dee2ae91e4f2ea7",
"assets/assets/fonts/PlayfairDisplay-Bold.ttf": "d27b6b12d96d9cf68f493c78113ce390",
"assets/assets/fonts/PlayfairDisplay-Medium.ttf": "c697dace361898b149c70043f722d6eb",
"assets/assets/fonts/PlayfairDisplay-Regular.ttf": "b3721ba3bde34e5b38b0e1523cccfd7f",
"assets/assets/fonts/PlayfairDisplay-SemiBold.ttf": "68ac1d23ba6429b7dea082e8e761cde3",
"assets/assets/icons/admin.png": "64e52f94f98d6106785eeb554d5d34f4",
"assets/assets/icons/arabic.png": "3940e635469edb93cead69cbea5902ca",
"assets/assets/icons/campus.png": "a36ac86998bc7f54c9ed02252132b8c5",
"assets/assets/icons/certificates.png": "b190df285d589296894876e8652ed15b",
"assets/assets/icons/class.png": "8ca6b8284b5f353855fd1906cc2faa83",
"assets/assets/icons/classRooms.png": "24130ed7d2f8d898fcfb61339daa184d",
"assets/assets/icons/cohort.png": "8394bd56f6ce5d94f859654e85737bd8",
"assets/assets/icons/dashboard.png": "f4a9c1ab5bc71e77a5644f9e0ef86eb5",
"assets/assets/icons/exam.png": "a3ab010250bbc34af294cb1130428138",
"assets/assets/icons/logout.png": "f277ca59e3ff6d348ecd9c768899c072",
"assets/assets/icons/more.png": "48872501243cd173e89b04d1693ae5f2",
"assets/assets/icons/notification_image.png": "0d291870bd273d45bfc2811cddf7c107",
"assets/assets/icons/patchDoc.png": "b604fc9b7afb86ebb5b118511ae4f93f",
"assets/assets/icons/proccess.png": "9c60c96507377e22ea0df4fed583dc79",
"assets/assets/icons/roles.png": "4d9cf5bf361d2d5f60fef1a6cf5ec990",
"assets/assets/icons/student.png": "d6ee05e22204f565587ad91c3391e2ce",
"assets/assets/icons/student_degrees.png": "99212d8b02c83816e088fc6dd8fd0110",
"assets/assets/icons/supject.png": "92841a65c25462b6cfd48fd4950663e3",
"assets/assets/images/background.png": "36364c1c826cfaedbd1fa4f8d2a4c3f6",
"assets/assets/images/class_desk.png": "4c8cc8046233c470d7271df37a9dbe0a",
"assets/assets/images/nis1.jpg": "2654c9a24975c3d7fc420cbd195b2aa6",
"assets/assets/images/nis2.jpg": "2faa9c9dc6e7dcae39eaf604722ea500",
"assets/assets/images/nis3.jpg": "a8cfeb77b66d8247fcebf79ef4eca4e9",
"assets/assets/logos/NIS5.png": "08432cdcd55b1152cd5f6b7bff271ca8",
"assets/assets/logos/nis_logo.png": "728f93d3c5a77278002eb1dd3e4aa64d",
"assets/assets/logos/nis_logo22.png": "e88bad9f217e8d2932fd9dd154dd4cb6",
"assets/FontManifest.json": "5e94f8b4834b233c80bf53e1714d62c1",
"assets/fonts/MaterialIcons-Regular.otf": "72110071c57030d19e9001ea1365db0d",
"assets/NOTICES": "1d5a66982ed586d02af323036120c773",
"assets/packages/awesome_dialog/assets/flare/error.flr": "e3b124665e57682dab45f4ee8a16b3c9",
"assets/packages/awesome_dialog/assets/flare/info.flr": "bc654ba9a96055d7309f0922746fe7a7",
"assets/packages/awesome_dialog/assets/flare/info2.flr": "21af33cb65751b76639d98e106835cfb",
"assets/packages/awesome_dialog/assets/flare/info_without_loop.flr": "cf106e19d7dee9846bbc1ac29296a43f",
"assets/packages/awesome_dialog/assets/flare/question.flr": "1c31ec57688a19de5899338f898290f0",
"assets/packages/awesome_dialog/assets/flare/succes.flr": "ebae20460b624d738bb48269fb492edf",
"assets/packages/awesome_dialog/assets/flare/succes_without_loop.flr": "3d8b3b3552370677bf3fb55d0d56a152",
"assets/packages/awesome_dialog/assets/flare/warning.flr": "68898234dacef62093ae95ff4772509b",
"assets/packages/awesome_dialog/assets/flare/warning_without_loop.flr": "c84f528c7e7afe91a929898988012291",
"assets/packages/awesome_dialog/assets/rive/error.riv": "e74e21f8b53de4b541dd037c667027c1",
"assets/packages/awesome_dialog/assets/rive/info.riv": "2a425920b11404228f613bc51b30b2fb",
"assets/packages/awesome_dialog/assets/rive/info_reverse.riv": "c6e814d66c0e469f1574a2f171a13a76",
"assets/packages/awesome_dialog/assets/rive/question.riv": "00f02da4d08c2960079d4cd8211c930c",
"assets/packages/awesome_dialog/assets/rive/success.riv": "73618ab4166b406e130c2042dc595f42",
"assets/packages/awesome_dialog/assets/rive/warning.riv": "0becf971559a68f9a74c8f0c6e0f8335",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17ee8e30dde24e349e70ffcdc0073fb0",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "247d5d9e89e5984ca7dcb972d5efe4a5",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "b5faf4b91e3310205cce452fa2c0480b",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "7d844e596d4c0da5e4d0b6b35c196b97",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"flutter_bootstrap.js": "9c3dc571ca4dad02764cd0e32f85c523",
"icons/Icon-192.png": "db9fb010616d67905d18a3c517479f4e",
"icons/Icon-512.png": "4f1685b6f43d89b05e30955afc5f7aae",
"icons/Icon-maskable-192.png": "db9fb010616d67905d18a3c517479f4e",
"icons/Icon-maskable-512.png": "4f1685b6f43d89b05e30955afc5f7aae",
"index.html": "a63c964448a147502c4910b06bcd20f6",
"/": "a63c964448a147502c4910b06bcd20f6",
"main.dart.js": "dc6cf4a514157af37c51cd6d2e580b95",
"manifest.json": "31f4ff8120e377f75301a2ee07e32f0e",
"version.json": "f336be7c7b8ab7b3df739ed5c4eef322"};
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
