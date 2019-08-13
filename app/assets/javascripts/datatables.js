//= require datatables/jquery.dataTables

// optional change '//' --> '//=' to enable

// require datatables/extensions/AutoFill/dataTables.autoFill
// require datatables/extensions/Buttons/dataTables.buttons
// require datatables/extensions/Buttons/buttons.html5
// require datatables/extensions/Buttons/buttons.print
// require datatables/extensions/Buttons/buttons.colVis
// require datatables/extensions/Buttons/buttons.flash
// require datatables/extensions/ColReorder/dataTables.colReorder
// require datatables/extensions/FixedColumns/dataTables.fixedColumns
// require datatables/extensions/FixedHeader/dataTables.fixedHeader
// require datatables/extensions/KeyTable/dataTables.keyTable
// require datatables/extensions/Responsive/dataTables.responsive
// require datatables/extensions/RowGroup/dataTables.rowGroup
// require datatables/extensions/RowReorder/dataTables.rowReorder
// require datatables/extensions/Scroller/dataTables.scroller
// require datatables/extensions/Select/dataTables.select

//= require datatables/dataTables.bootstrap4
// require datatables/extensions/AutoFill/autoFill.bootstrap4
// require datatables/extensions/Buttons/buttons.bootstrap4
// require datatables/extensions/Responsive/responsive.bootstrap4

//Global setting and initializer

$.extend( $.fn.dataTable.defaults, {
  responsive: true,
  pagingType: 'full',
  language: {
    url: "/he_he.lang"
  },
  "order": [],
  "pageLength": 25
  // ,
  // columnDefs: [{
  //    "targets": "_all",
  // "createdCell": function (td, cellData, rowData, row, col) {
  //       $(td).attr('class', col);},
  //
  //      // { type: 'natural', targets: 0 }
  //    }],

  //dom:
  //  "<'row'<'col-sm-4 text-left'f><'right-action col-sm-8 text-right'<'buttons'B> <'select-info'> >>" +
  //  "<'row'<'dttb col-12 px-0'tr>>" +
  //  "<'row'<'col-sm-12 table-footer'lip>>"
});



$(document).on('preInit.dt', function(e, settings) {
  var api, table_id, url;
  api = new $.fn.dataTable.Api(settings);
  table_id = "#" + api.table().node().id;
  url = $(table_id).data('source');
  if (url) {
    return api.ajax.url(url);
  }
});


// init on turbolinks load
$(document).on('turbolinks:load', function() {
  if (!$.fn.DataTable.isDataTable("table[id^=dttb-]")) {
    $("table[id^=dttb-]").DataTable();
  }
});

// turbolinks cache fix
$(document).on('turbolinks:before-cache', function() {
  var dataTable = $($.fn.dataTable.tables(true)).DataTable();
  if (dataTable !== null) {
    dataTable.clear();
    dataTable.destroy();
    return dataTable = null;
  }
});

// (function() {
//
// /*
//  * Natural Sort algorithm for Javascript - Version 0.7 - Released under MIT license
//  * Author: Jim Palmer (based on chunking idea from Dave Koelle)
//  * Contributors: Mike Grier (mgrier.com), Clint Priest, Kyle Adams, guillermo
//  * See: http://js-naturalsort.googlecode.com/svn/trunk/naturalSort.js
//  */
// function naturalSort (a, b, html) {
//     var re = /(^-?[0-9]+(\.?[0-9]*)[df]?e?[0-9]?%?$|^0x[0-9a-f]+$|[0-9]+)/gi,
//         sre = /(^[ ]*|[ ]*$)/g,
//         dre = /(^([\w ]+,?[\w ]+)?[\w ]+,?[\w ]+\d+:\d+(:\d+)?[\w ]?|^\d{1,4}[\/\-]\d{1,4}[\/\-]\d{1,4}|^\w+, \w+ \d+, \d{4})/,
//         hre = /^0x[0-9a-f]+$/i,
//         ore = /^0/,
//         htmre = /(<([^>]+)>)/ig,
//         // convert all to strings and trim()
//         x = a.toString().replace(sre, '') || '',
//         y = b.toString().replace(sre, '') || '';
//         // remove html from strings if desired
//         if (!html) {
//             x = x.replace(htmre, '');
//             y = y.replace(htmre, '');
//         }
//         // chunk/tokenize
//     var xN = x.replace(re, '\0$1\0').replace(/\0$/,'').replace(/^\0/,'').split('\0'),
//         yN = y.replace(re, '\0$1\0').replace(/\0$/,'').replace(/^\0/,'').split('\0'),
//         // numeric, hex or date detection
//         xD = parseInt(x.match(hre), 10) || (xN.length !== 1 && x.match(dre) && Date.parse(x)),
//         yD = parseInt(y.match(hre), 10) || xD && y.match(dre) && Date.parse(y) || null;
//
//     // first try and sort Hex codes or Dates
//     if (yD) {
//         if ( xD < yD ) {
//             return -1;
//         }
//         else if ( xD > yD ) {
//             return 1;
//         }
//     }
//
//     // natural sorting through split numeric strings and default strings
//     for(var cLoc=0, numS=Math.max(xN.length, yN.length); cLoc < numS; cLoc++) {
//         // find floats not starting with '0', string or 0 if not defined (Clint Priest)
//         var oFxNcL = !(xN[cLoc] || '').match(ore) && parseFloat(xN[cLoc], 10) || xN[cLoc] || 0;
//         var oFyNcL = !(yN[cLoc] || '').match(ore) && parseFloat(yN[cLoc], 10) || yN[cLoc] || 0;
//         // handle numeric vs string comparison - number < string - (Kyle Adams)
//         if (isNaN(oFxNcL) !== isNaN(oFyNcL)) {
//             return (isNaN(oFxNcL)) ? 1 : -1;
//         }
//         // rely on string comparison if different types - i.e. '02' < 2 != '02' < '2'
//         else if (typeof oFxNcL !== typeof oFyNcL) {
//             oFxNcL += '';
//             oFyNcL += '';
//         }
//         if (oFxNcL < oFyNcL) {
//             return -1;
//         }
//         if (oFxNcL > oFyNcL) {
//             return 1;
//         }
//     }
//     return 0;
// }
//
// jQuery.extend( jQuery.fn.dataTableExt.oSort, {
//     "natural-asc": function ( a, b ) {
//         return naturalSort(a,b,true);
//     },
//
//     "natural-desc": function ( a, b ) {
//         return naturalSort(a,b,true) * -1;
//     },
//
//     "natural-nohtml-asc": function( a, b ) {
//         return naturalSort(a,b,false);
//     },
//
//     "natural-nohtml-desc": function( a, b ) {
//         return naturalSort(a,b,false) * -1;
//     },
//
//     "natural-ci-asc": function( a, b ) {
//         a = a.toString().toLowerCase();
//         b = b.toString().toLowerCase();
//
//         return naturalSort(a,b,true);
//     },
//
//     "natural-ci-desc": function( a, b ) {
//         a = a.toString().toLowerCase();
//         b = b.toString().toLowerCase();
//
//         return naturalSort(a,b,true) * -1;
//     }
// } );
//
// }());
//
// // Ultimate Date Time sort
//
// (function (factory) {
//     if (typeof define === "function" && define.amd) {
//         define(["jquery", "moment", "datatables.net"], factory);
//     } else {
//         factory(jQuery, moment);
//     }
// }(function ($, moment) {
//
// $.fn.dataTable.moment = function ( format, locale ) {
//     var types = $.fn.dataTable.ext.type;
//
//     // Add type detection
//     types.detect.unshift( function ( d ) {
//         if ( d ) {
//             // Strip HTML tags and newline characters if possible
//             if ( d.replace ) {
//                 d = d.replace(/(<.*?>)|(\r?\n|\r)/g, '');
//             }
//
//             // Strip out surrounding white space
//             d = $.trim( d );
//         }
//
//         // Null and empty values are acceptable
//         if ( d === '' || d === null ) {
//             return 'moment-'+format;
//         }
//
//         return moment( d, format, locale, true ).isValid() ?
//             'moment-'+format :
//             null;
//     } );
//
//     // Add sorting method - use an integer for the sorting
//     types.order[ 'moment-'+format+'-pre' ] = function ( d ) {
//         if ( d ) {
//             // Strip HTML tags and newline characters if possible
//             if ( d.replace ) {
//                 d = d.replace(/(<.*?>)|(\r?\n|\r)/g, '');
//             }
//
//             // Strip out surrounding white space
//             d = $.trim( d );
//         }
//
//         return !moment(d, format, locale, true).isValid() ?
//             Infinity :
//             parseInt( moment( d, format, locale, true ).format( 'x' ), 10 );
//     };
// };
//
// }));
