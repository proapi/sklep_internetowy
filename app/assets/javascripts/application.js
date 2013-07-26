// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./application_js
//= require_tree ./shared_js

//$(function cookiesDirectiveScriptWrapper() {
    // this block of code was initially before closing body tag
    // Cookie creating scripts etc here....
    // cdScriptAppend('google.js', 'head');
//});

$(function () {
// The position of the disclosure ('top' or 'bottom')
// Number of times to display disclosure. Enter 0 to show it forever!!!!
// The URI of your privacy policy
    cookiesDirective('bottom', 10, 'polityka-prywatnosci');
});