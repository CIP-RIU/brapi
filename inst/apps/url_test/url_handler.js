<script>

  Shiny.addCustomMessageHandler('setNavbar',
                                function(data) {
                                  // create a reference to the desired navbar tab. page is the
                                  // id of the navbarPage. a:contains says look for
                                  // the subelement that contains the contents of data.nav
                                  var nav_ref = '#page a:contains(\"' + data.page + '\")';
                                  $(nav_ref).tab('show');
                                }
  );

Shiny.addCustomMessageHandler('setTab',
                              function(data) {
                                // pick the right tabpanel ID based on the value of data.nav
                                if (data.page == 'Alfa Bravo') {
                                  var tabpanel_id = 'alfa_bravo_tabs';
                                } else {
                                  var tabpanel_id = 'delta_foxtrot_tabs';
                                }
                                // combine this with a reference to the desired tab itself.
                                var tab_ref = '#' + tabpanel_id + ' a:contains(\"' + data[tabpanel_id] + '\")';
                                $(tab_ref).tab('show');
                              }
);

Shiny.addCustomMessageHandler('setURL',
                              function(data) {
                                // make each key and value URL safe (replacing spaces, etc.), then join
                                // them and put them in the URL
                                var search_terms = [];
                                for (var key in data) {
                                  search_terms.push(encodeURIComponent(key) + '=' + encodeURIComponent(data[key]));
                                }
                                window.history.pushState('object or string', 'Title', '/?' + search_terms.join('&'));
                              }
);

</script>
