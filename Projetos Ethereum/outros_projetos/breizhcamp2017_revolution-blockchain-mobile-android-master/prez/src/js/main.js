remark.macros.scale = function (percentage) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + percentage + '" />';
};
/**
 * For more information on using remark, please check out the wiki pages:
 * https://github.com/gnab/remark/wiki
 */
var slideShow = remark.create({
  // Set the slideshow display ratio
  // Default: '4:3'
  // Alternatives: '16:9', ...
  ratio: '4:3',

  // Navigation options
  navigation: {
    // Enable or disable navigating using scroll
    // Default: true
    // Alternatives: false
    scroll: true,

    // Enable or disable navigation using touch
    // Default: true
    // Alternatives: false
    touch: true,

    // Enable or disable navigation using click
    // Default: false
    // Alternatives: true
    click: false
  },

  // Customize slide number label, either using a format string..
//  slideNumberFormat: 'Slide %current% of %total%',
  slideNumberFormat: '',
  // .. or by using a format function
//  slideNumberFormat: function (current, total) {
//    return 'Slide ' + current + ' of ' + total;
//  },

  // Enable or disable counting of incremental slides in the slide counting
  countIncrementalSlides: true,

  // For more options see:
  // https://github.com/gnab/remark/wiki/Configuration#highlighting
  highlightLanguage: 'java',
  highlightStyle: 'monokai',
  highlightLines: true,
  highlightSpans: true
});
