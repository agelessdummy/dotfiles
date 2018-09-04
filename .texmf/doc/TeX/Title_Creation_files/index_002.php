 //<nowiki> List of additional buttons to add to the edit toolbar
 
 if (mwCustomEditButtons) {
   mwCustomEditButtons[mwCustomEditButtons.length] = {
    "imageFile": "http://upload.wikimedia.org/wikipedia/en/c/c8/Button_redirect.png",
    "speedTip": "Redirect",
    "tagOpen": "#REDIRECT [[",
    "tagClose": "]]",
    "sampleText": "Insert text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
    "imageFile": "http://upload.wikimedia.org/wikipedia/commons/b/b4/Button_category03.png",
    "speedTip": "Category",
    "tagOpen": "[[Category:{{BASEPAGENAME}}|",
    "tagClose": "]]",
    "sampleText": "{{SUBPAGENAME}}"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
    "imageFile": "http://upload.wikimedia.org/wikipedia/commons/f/fd/Button_underline.png",
    "speedTip": "Underline",
    "tagOpen": "<u>",
    "tagClose": "</u>",
    "sampleText": "underline text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
     "imageFile": "http://upload.wikimedia.org/wikipedia/en/c/c9/Button_strike.png",
     "speedTip": "Strike",
     "tagOpen": "<s>",
     "tagClose": "</s>",
     "sampleText": "strikeout text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
     "imageFile": "http://upload.wikimedia.org/wikipedia/en/8/80/Button_upper_letter.png",
     "speedTip": "Superscript",
     "tagOpen": "<sup>",
     "tagClose": "</sup>",
     "sampleText": "Superscript text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
     "imageFile": "http://upload.wikimedia.org/wikipedia/en/7/70/Button_lower_letter.png",
     "speedTip": "Subscript",
     "tagOpen": "<sub>",
     "tagClose": "</sub>",
     "sampleText": "Subscript text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
     "imageFile": "http://upload.wikimedia.org/wikipedia/en/5/58/Button_small.png",
     "speedTip": "Small",
     "tagOpen": "<small>",
     "tagClose": "</small>",
     "sampleText": "Small Text"
   };
   mwCustomEditButtons[mwCustomEditButtons.length] = {
     "imageFile": " http://upload.wikimedia.org/wikipedia/commons/5/56/Button_big.png",
     "speedTip": "Big",
     "tagOpen": "<big>",
     "tagClose": "</big>",
     "sampleText": "big"
   };
 }
 
 //</nowiki> End of MediaWiki:EditToolbar.js