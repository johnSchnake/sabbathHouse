This static site folder is not part of the rails app. Instead it was effectively scrapped from the running app in my apcera cluster. All the static content was then uploaded via cPanel to the actual site.

A few tweaks to get things working on the static version:
 - Javascript for scrollnav edited to trim `index.html` from `index.html#anchor`
 - A bunch of smart quotes and such were changed which didn't render properly
 - fontAwesome was manually installed. This meant the fontawesome library was downloaded, moved into /assets, the FA code was removed from the precompiled CSS, and a CSS line was written into index.html to use the normal FA CSS.
 - Ensure links are to the proper host and not to the apcera-platform.io one.
 - Add the rewrite rule `RewriteRule ^([^.]*)$ $1 [type=text/html]` to the .htaccess file.

Each page of the site was pulled via:

wget --page-requisites --convert-links http://sabbathhouse.schnake.apcera-platform.io/lent2017
