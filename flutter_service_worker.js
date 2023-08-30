'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/assets/audios/background.mp3": "13d0df437aeeccada1c72a744e3dc855",
"assets/assets/fonts/Epilogue-MediumItalic.ttf": "e2cbdeec7a60e12ef2ec3faa9b75dc34",
"assets/assets/fonts/Epilogue-ExtraBold.ttf": "d133224a2743e366e45c079664a86cb0",
"assets/assets/fonts/Epilogue-ExtraLight.ttf": "3c1b5d9a6d4c8b2e16eac821a1b846df",
"assets/assets/fonts/Epilogue-BlackItalic.ttf": "d1bfbea07fe834d8b1e9ae0990966725",
"assets/assets/fonts/Epilogue-Italic.ttf": "95cfc76527b61c63b024b92b78de44a4",
"assets/assets/fonts/Epilogue-SemiBoldItalic.ttf": "2e84b1515084c45282acaecc48875a82",
"assets/assets/fonts/Epilogue-BoldItalic.ttf": "a0dfc1b71f1af788e522d92efbd0fcfb",
"assets/assets/fonts/Epilogue-ThinItalic.ttf": "c5a14f92b2d4f34c14a3cbcee4077484",
"assets/assets/fonts/Epilogue-Bold.ttf": "764e39bb6e91b0ed834e0de514579380",
"assets/assets/fonts/Epilogue-Medium.ttf": "bd730aea0ad122a44607a7af97a64988",
"assets/assets/fonts/Epilogue-Black.ttf": "22401d43170db2900c8efacd87f9332b",
"assets/assets/fonts/Epilogue-Regular.ttf": "2c092196a0c31438829ac67a5bd07255",
"assets/assets/fonts/Epilogue-Thin.ttf": "7f577a39697a74057abeafed8519064e",
"assets/assets/fonts/Epilogue-LightItalic.ttf": "13bff47a90ef4d0db15401ea14aa2790",
"assets/assets/fonts/Epilogue-SemiBold.ttf": "de57d7ea55a2a87a6d408683fb3d7f07",
"assets/assets/fonts/Epilogue-ExtraBoldItalic.ttf": "0ed8e10b747c16b2542ec25aecc932ac",
"assets/assets/fonts/Epilogue-ExtraLightItalic.ttf": "5ca630dc5b9bebddd77fe4a30f0078d7",
"assets/assets/fonts/Epilogue-Light.ttf": "9be8208d5e5066757607355b30beb0c0",
"assets/fonts/MaterialIcons-Regular.otf": "9debb5d27231f55fd6f018214c82c25b",
"assets/AssetManifest.json": "55aed13fe7f25189abd0d964bb12a179",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "7a92b116557925554b2fdd3c51fd18b6",
"assets/FontManifest.json": "8145ca0fd850fdb13b7c02d8b5059b7e",
"assets/NOTICES": "2f2038bcfcf5c8c5900ef5230a89746c",
"version.json": "5a456dc7aaef7c5550b3cdb1015caa3d",
"favicon.ico": "928eb9255e263a9a7ba8e05720906ca6",
"manifest.json": "0bbbdeef74e8b89400c2bd16d078b8df",
"index.html": "ba18bbb6f8f3d831936762dd65925ae8",
"/": "ba18bbb6f8f3d831936762dd65925ae8",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"CNAME": "403c02cd24acb353d39d02fd4e0e68b6",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"main.dart.js": "c28ce34bf89d590e3c63c94d4daf78a8",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
