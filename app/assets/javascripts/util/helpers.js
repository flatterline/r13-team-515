(function() {
  "use strict";

  /**
   * @module app.util
   */

  // Register namespace for the class.
  app.namespace("util");

  /**
   *  A set of convenience methods that enable
   *  repetitive conversions and handle special
   *  events.
   *
   *  @class  app.util.Helpers
   */

  /**
   * Compiles the metrix for a given HTML
   * element.
   *
   * @method app.util.getMetrics
   * @param  {object} element  An HTML element.
   * @return {object}          An object containing the metrics
   *                           for a given element.
   */
  app.util.getMetrics = function(element) {
    var metrics,
        style;

    style = app.util.getStyle(element);

    metrics = {
      height: $(element).height(),
      width: $(element).width()
    };

    if (typeof style["margin-bottom"] !== "undefined") {
      metrics.margin = {
        bottom: app.util.pxToInt(style["margin-bottom"]),
        left: app.util.pxToInt(style["margin-left"]),
        right: app.util.pxToInt(style["margin-right"]),
        top: app.util.pxToInt(style["margin-top"])
      };

    } else if (typeof style["marginBottom"] !== "undefined") {
      metrics.margin = {
        bottom: app.util.pxToInt(style["marginBottom"]),
        left: app.util.pxToInt(style["marginLeft"]),
        right: app.util.pxToInt(style["marginRight"]),
        top: app.util.pxToInt(style["marginTop"])
      };
    }

    metrics.bounds = {
      height: metrics.height + metrics.margin.top + metrics.margin.bottom,
      width: metrics.width + metrics.margin.left + metrics.margin.right
    };

    metrics.coords = {
      left: $(element).attr("data-x"),
      top: $(element).attr("data-y")
    };

    return metrics;
  };

  /**
   * Returns a DOM style object for a specified HTML
   * element.
   *
   * @method getStyle
   * @param  {element} element The element to provide the style.
   * @return {object}          The computed style for a given node.
   */
  app.util.getStyle = function(element) {
    if (typeof element.currentStyle !== "undefined") {
      return element.currentStyle;
    }
    return window.getComputedStyle(element);
  };

  /**
   * Converts a string value px value to an int.
   * i.e. "12px" becomes 12.
   *
   * @method app.util.pxToInt
   * @param  {string} string Initial px value.
   * @return {int}           The converted int value.
   */
  app.util.pxToInt = function(string) {
    return parseInt(string.replace("px", ""));
  };

  /**
   * Performs a 2D or 3D transform on a specified
   * HTML element.
   *
   * @method  app.util.transform
   * @param  {object} element An HTML element to be transformed
   * @param  {float}  x       The X position for the transform
   * @param  {float}  y       The Y position for the transform
   */
  app.util.transform = function(element, x, y) {

    if (Modernizr.csstransforms3d) {
      element.style[Modernizr.prefixed('transform')] = "translate3d(" + x + "px," + y + "px,0)";

    } else {
      element.style[Modernizr.prefixed('transform')] = "translate(" + x + "px," + y + "px)";
    }

    $(element).attr("data-x", x);
    $(element).attr("data-y", y);
  };

  /**
   * Returns the TransitionEnd event for the oppropriate
   * browser.
   * @method app.util.getEndTransitionEvent
   * @static
   * @return {string} The string identifier for the supported
   *                  end transistion event.
   */
  app.util.getEndTransitionEvent = function() {
    var transEndEventNames;
    transEndEventNames = {
      'WebkitTransition': 'webkitTransitionEnd',
      'MozTransition': 'transitionend',
      'OTransition': 'oTransitionEnd',
      'msTransition': 'MSTransitionEnd',
      'transition': 'transitionend'
    };
    return transEndEventNames[Modernizr.prefixed('transition')];
  };

  /**
   * @method app.util.afterTransition
   * @param {element} element An element to listen to.
   * @param {closure} action  An action to execute.
   */
  app.util.afterTransition = function(element,action) {
    var eventName = app.util.getEndTransitionEvent(),
        handler;

    handler = function(){
      element.removeEventListener(eventName, handler);
      action();
    };

    element.addEventListener(eventName, handler);
  };

})();