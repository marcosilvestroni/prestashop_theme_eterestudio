

<script>
$(function() {
  var contents = null;
  function regenerateGrid() {
    if (!contents) {
      return;
    }
     console.log('width',$("#product-info").width(),'height',$("#product-info").height(),'rapporto',($("#product-info").width()/$("#product-info").height()))
    var grid = $("#studio-grid");
    var placements = grid
      .empty()
      .css("height", 0)
      .gridify(contents, contents.length);

   
  }


  if (document.getElementById("product-info")) {
    contents = [
      {
        id: 1,
        type: "service",
        order: 0,
        title: "",
        category: "",
        body: document.getElementById("product-cover"),
        colors: {
          foreground: "#000000",
          background: "white"
        },
        bounds: {
          width: $("#product-cover img")[0].naturalWidth,
          height: $("#product-cover img")[0].naturalHeight,
          minScale:  300/$("#product-cover img")[0].naturalWidth*100,
          maxScale: 120
        },
        margins: { top: "0", left: "0", right: "0", bottom: "0" }
      },
      {
        id: 2,
        type: "service",
        order:1,
        title: "",
        category: "",
        body: document.getElementById("product-info"),
        colors: {
          foreground: "#000000",
          background: "white"
        },
        bounds: {
          width: $("#product-info").width(),
          height: $("#product-info").height(),
          minScale: 100,
          maxScale: 100
        },
        margins: { top: "0", left: "0", right: "0", bottom: "0" }
      }
    ];
    for (var i = 1; i <= 6; i++) {
      contents.push({
        id: i + 2,
        type: "service",
        order: i + 2,
        title: "",
        category: "",
        body: document.getElementById("product-image-" + i),
        colors: {
          foreground: "#000000",
          background: "white"
        },
        bounds: {
          width: $("#product-image-" + i + " img")[0].naturalWidth,
          height: $("#product-image-" + i + " img")[0].naturalHeight,
          minScale: 300/$("#product-image-" + i + " img")[0].naturalWidth*100,
          maxScale: 120
        },
        margins: { top: "0", left: "0", right: "0", bottom: "0" }
      });
    }

    regenerateGrid();

    var resizeTimeout;
    var lastWidth = null;

    $(window).on("resize", function() {
      if (lastWidth == document.body.clientWidth) {
        return;
      }

      contents[1].bounds.width = $("#product-info").width();
      contents[1].bounds.height = $("#product-info").height();
      
      lastWidth = document.body.clientWidth;
      if (resizeTimeout) {
        clearTimeout(resizeTimeout);
      }
      resizeTimeout = setTimeout(regenerateGrid, 1000);
    });
  }
});

</script>