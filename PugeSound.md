PugeSound
========================================================
author: 
date: 

第一张第一张第一张第一张第一张第一张第一张
========================================================



<link rel="stylesheet" href="http://vis.supstat.com//assets/themes/dinky/css/scianimator.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="http://vis.supstat.com/assets/themes/dinky/js/jquery.scianimator.min.js"></script>

<div class="scianimator">
<div id="test" style="display: inline-block;">
</div>
</div>
<script type="text/javascript">
  (function($) {
    $(document).ready(function() {
      var imgs = Array(50);
      for (i=0; ; i++) {
        if (i == imgs.length) break;
        imgs[i] = "PugeSound-figure/test" + (i + 1) + ".png";
      }
      $("#test").scianimator({
          "images": imgs,
          "delay": 100,
          "controls": ["first", "previous", "play", "next", "last", "loop", "speed"],
      });
      $("#test").scianimator("play");
    });
  })(jQuery);
</script>

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist    
 Min.   : 4.0   Min.   :  2  
 1st Qu.:12.0   1st Qu.: 26  
 Median :15.0   Median : 36  
 Mean   :15.4   Mean   : 43  
 3rd Qu.:19.0   3rd Qu.: 56  
 Max.   :25.0   Max.   :120  
```


Slide With Plot
========================================================

![plot of chunk unnamed-chunk-2](PugeSound-figure/unnamed-chunk-2.png) 

