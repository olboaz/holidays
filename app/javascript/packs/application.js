// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

import {createMap} from "../components/map";
import {initAutocomplete} from "../plugins/init_autocomplete"
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

//= require quagga
//= require_tree .
import Quagga from "quagga";


function order_by_occurrence(arr) {
  var counts = {};
  arr.forEach(function(value){
      if(!counts[value]) {
          counts[value] = 0;
      }
      counts[value]++;
  });

  return Object.keys(counts).sort(function(curKey,nextKey) {
      return counts[curKey] < counts[nextKey];
  });
}

function load_quagga(){
  if ($('#barcode-scanner').length > 0 && navigator.mediaDevices && typeof navigator.mediaDevices.getUserMedia === 'function') {

    var last_result = [];
    if (Quagga.initialized == undefined) {
      Quagga.onDetected(function(result) {
        var last_code = result.codeResult.code;
        console.log(last_code);
        last_result.push(last_code);
        console.log(last_result);
        console.log(last_result.length);
        if (last_result.length == 1) {
          var place = window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
          var code = last_code;
          console.log(code);
          last_result = [];
          Quagga.stop();
          $.ajax({
            type: "POST",
            url: '/places/get_barcode',
            data: { upc: code, id: place }
          });
        }
      });
    }

    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        numOfWorkers: navigator.hardwareConcurrency,
        target: document.querySelector('#barcode-scanner')
      },
      decoder: {
          readers : ['ean_reader']
      },
      locator: {
        "patchSize": "medium",
        "halfSample": true
      },
      numOfWorkers: 0,
      debug: {
      drawBoundingBox: false,
      showFrequency: false,
      drawScanline: false,
      showPattern: false
       },
      multiple: false
    },function(err) {
        if (err) { console.log(err); return }
        Quagga.initialized = true;
        Quagga.start();
    });

  }
};
$(document).on('turbolinks:load', load_quagga);


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
createMap();
initAutocomplete();
});
