function GridContentManager(contents) {
  var allTimeUsedProducts = {};

  function shuffleContents(contents, maxCount, categoryBudgets) {
    categoryBudgets = categoryBudgets || {};
    function sortByOrder(a, b) {
      if (a.order < b.order) {
        return -1;
      }
      if (a.order > b.order) {
        return 1;
      }
      return 0;
    }

    var services = contents.filter(function(content) {
      return content.type == "service";
    });
    services.sort(sortByOrder);
    var products = contents.filter(function(content) {
      return content.type == "product";
    });
    for (var i = 0; i < products.length; i++) {
      products[i].order = Math.ceil(Math.random() * 100);
    }
    products.sort(sortByOrder);

    var usedCategories = {};
    var lastUsedCategory = null;

    function getProductSortValue(item) {
      var used = 0;
      if (item.id in allTimeUsedProducts) {
        used = allTimeUsedProducts[item.id];
      }
      var score = used * 1000000;

      //Penalty for last used category
      if (lastUsedCategory == item.category) {
        score += 100000000;
      }

      //Penalty for over budget
      if (item.category in categoryBudgets) {
        var categoryUses = 0;
        if (item.category in usedCategories) {
          categoryUses = usedCategories[item.category];
        }
        if (categoryUses >= categoryBudgets[item.category]) {
          score += 100000000;
        }
      }

      if (item.category in usedCategories) {
        score += usedCategories[item.category] * 1000 + Math.random();
      }
      return score;
    }

    var fillers = contents.filter(function(content) {
      return content.type == "filler";
    });
    var shuffledContents = [];
    var remaining = Math.min(maxCount - services.length, products.length);
    var perService = remaining / (services.length + 1);
    var fraction = 0;
    function addProductToShuffledContents() {
      while (fraction + 0.001 >= 1 && shuffleContents.length < maxCount) {
        fraction -= 1;
        if (products.length > 0) {
          products.sort(function(a, b) {
            return getProductSortValue(a) - getProductSortValue(b);
          });
          var product = products.shift();

          if (product.id in allTimeUsedProducts) {
            allTimeUsedProducts[product.id] += 1;
          } else {
            allTimeUsedProducts[product.id] = 1;
          }

          lastUsedCategory = product.category;
          if (product.category in usedCategories) {
            usedCategories[product.category] += 1;
          } else {
            usedCategories[product.category] = 1;
          }
          shuffledContents.push(product);
        }
      }
    }
    fraction += perService / 2;
    addProductToShuffledContents();
    for (var i = 0; i < services.length; i++) {
      shuffledContents.push(services[i]);
      fraction += perService;
      addProductToShuffledContents();
    }
    fraction += perService / 2;
    addProductToShuffledContents();

    for (var i = 0; i < fillers.length; i++) {
      shuffledContents.push(fillers[i]);
    }
    return shuffledContents;
  }
  function prepareContents(contents, factor) {
    var preparedContents = contents.map(function(content) {
      return new GridContent(content, factor);
    });
    return preparedContents;
  }
  this.getGridContents = function(maxCount, categoryBudgets, factor) {
    var viableContents = contents.filter(function(content) {
      return content.type != "filler";
    });
    var shuffledContents = shuffleContents(
      viableContents,
      maxCount,
      categoryBudgets
    );
    var gridContents = prepareContents(shuffledContents, factor);
    return gridContents;
  };
  this.getFillerContents = function() {
    var fillerContents = contents.filter(function(content) {
      return content.type == "filler";
    });
    var preparedContents = prepareContents(fillerContents);
    return preparedContents;
  };
}
function GridContent(content, factor) {
  factor = factor || 1.0;
  this.getInfo = function() {
    return {
      id: content.id,
      title: content.title,
      type: content.type,
      category: content.category,
      width: content.bounds.width,
      height: content.bounds.height,
      minScale: (content.bounds.minScale / 100) * factor,
      maxScale: (content.bounds.maxScale / 100) * factor,
      marginTop: content.margins.top,
      marginBottom: content.margins.bottom,
      marginLeft: content.margins.left,
      marginRight: content.margins.right,
      backgroundColor: content.colors.background,
      foregroundColor: content.colors.foreground,
      borderColor: content.colors.border
    };
  };
  this.getHtml = function() {
    return content.body;
  };
}
function GridArea(width, height, x, y) {
  this.getInfo = function() {
    return { x: x || 0, y: y || 0, width: width, height: height };
  };
  this.resizeTo = function(newWidth, newHeight) {
    width = newWidth;
    height = newHeight;
  };
  this.translateTo = function(newX, newY) {
    x = newX;
    y = newY;
  };
  this.translateBy = function(deltaX, deltaY) {
    x += deltaX;
    y += deltaY;
  };
}
function GridPlacement(content, x, y, scale) {
  var contentInfo = content.getInfo();
  if (scale < contentInfo.minScale || scale > contentInfo.maxScale) {
    throw "Scale " +
      scale +
      " is out of bounds (" +
      contentInfo.minScale +
      ", " +
      contentInfo.maxScale +
      ")";
  }
  var area = new GridArea(
    contentInfo.width * scale,
    contentInfo.height * scale,
    x,
    y
  );
  this.getInfo = function() {
    return { area: area, content: content, scale: scale };
  };
  this.resizeTo = function(newWidth, newHeight) {
    scale = newWidth / contentInfo.width;
    area.resizeTo(newWidth, newHeight);
  };
  this.translateTo = function(newX, newY) {
    area.translateTo(newX, newY);
  };
  this.translateBy = function(deltaX, deltaY) {
    area.translateBy(deltaX, deltaY);
  };
}
GridPlacement.prototype.getInflatableInfo = function() {
  var contentInfo = this.getInfo().content.getInfo();
  var areaInfo = this.getInfo().area.getInfo();
  var maxWidth = contentInfo.width * contentInfo.maxScale;
  var maxHeight = contentInfo.height * contentInfo.maxScale;
  var x = maxWidth - areaInfo.width;
  var y = maxHeight - areaInfo.height;
  return { x: x, y: y };
};
GridPlacement.prototype.canBeInflated = function() {
  var inflatableInfo = this.getInflatableInfo();
  return inflatableInfo.x > 0 && inflatableInfo.y > 0;
};
GridPlacement.prototype.inflateByWidth = function(amount) {
  var areaInfo = this.getInfo().area.getInfo();
  var contentInfo = this.getInfo().content.getInfo();
  var newWidth = areaInfo.width + amount;
  var factor = Math.min(
    contentInfo.maxScale,
    Math.max(contentInfo.minScale, newWidth / contentInfo.width)
  );
  newWidth = contentInfo.width * factor;
  newHeight = contentInfo.height * factor;

  this.resizeTo(newWidth, newHeight);

  var amountX = newWidth - areaInfo.width;
  var amountY = newHeight - areaInfo.height;
  return { x: amountX, y: amountY };
};

function GridAttachmentPoint(x, y) {
  var priority = 4 * y + x;
  this.getInfo = function() {
    return { x: x, y: y, priority: priority };
  };
}

function GridExclusion(gridArea, isFull) {
  this.getInfo = function() {
    return gridArea.getInfo();
  };
  this.isFull = function() {
    return isFull;
  };
  this.setFull = function(value) {
    isFull = value;
  };
}

function GridAreaManager(mainGridArea) {
  var gridArea = mainGridArea;

  var exclusions = [];

  function pullUp(point) {
    return point;
  }
  function pullLeft(point) {
    var pointInfo = point.getInfo();
    var exclusionInfo, isFull;
    var xWall = Number.NEGATIVE_INFINITY;
    for (var i = 0; i < exclusions.length; i++) {
      exclusionInfo = exclusions[i].getInfo();
      isFull = exclusions[i].isFull();
      if (pointInfo.x < exclusionInfo.x || !isFull) {
        continue;
      }
      if (
        pointInfo.y >= exclusionInfo.y &&
        pointInfo.y < exclusionInfo.y + exclusionInfo.height
      ) {
        xWall = Math.max(xWall, exclusionInfo.x + exclusionInfo.width);
      }
    }
    xWall = Math.min(Math.max(xWall, 0), pointInfo.x);
    return new GridAttachmentPoint(xWall, pointInfo.y);
  }
  function getAttachmentPoints() {
    var areaInfo = gridArea.getInfo();
    var attachmentPoints = [new GridAttachmentPoint(areaInfo.x, areaInfo.y)];

    var exclusionInfo = null;
    for (var i = 0; i < exclusions.length; i++) {
      isFull = exclusions[i].isFull();
      if (!isFull) {
        continue;
      }
      exclusionInfo = exclusions[i].getInfo();
      attachmentPoints.push(
        pullUp(
          new GridAttachmentPoint(
            exclusionInfo.x + exclusionInfo.width,
            exclusionInfo.y
          )
        )
      );
      attachmentPoints.push(
        pullLeft(
          new GridAttachmentPoint(
            exclusionInfo.x,
            exclusionInfo.y + exclusionInfo.height
          )
        )
      );
    }
    attachmentPoints.sort(function(a, b) {
      return a.getInfo().priority - b.getInfo().priority;
    });
    return attachmentPoints;
  }

  this.getEmptyExclusions = function() {
    return exclusions.filter(function(exclusion) {
      return !exclusion.isFull();
    });
  };

  this.addExclusion = function(gridArea, isFull) {
    //Clamp height of empty exclusions
    var exclusionInfo, areaInfo, newHeight;
    areaInfo = gridArea.getInfo();
    for (var i = 0; i < exclusions.length; i++) {
      if (exclusions[i].isFull()) {
        continue;
      }
      exclusionInfo = exclusions[i].getInfo();
      if (exclusionInfo.y > areaInfo.y) {
        continue;
      }

      if (
        exclusionInfo.x + exclusionInfo.width > areaInfo.x &&
        exclusionInfo.x < areaInfo.x + areaInfo.width
      ) {
        newHeight = Math.min(
          exclusionInfo.height,
          areaInfo.y - exclusionInfo.y
        );
        if (newHeight < exclusionInfo.height) {
          exclusions[i] = new GridExclusion(
            new GridArea(
              exclusionInfo.width,
              newHeight,
              exclusionInfo.x,
              exclusionInfo.y
            ),
            false
          );
        }
      }
    }

    exclusions.push(new GridExclusion(gridArea, isFull));
  };
  this.getNextArea = function() {
    var attachmentPoints = getAttachmentPoints();
    var mainInfo = gridArea.getInfo();
    var pointInfo = null;
    var exclusionInfo = null;
    var isFull = null;
    var width = null;
    var height = null;
    for (var i = 0; i < attachmentPoints.length; i++) {
      pointInfo = attachmentPoints[i].getInfo();
      width = mainInfo.width - pointInfo.x;
      height = mainInfo.height - pointInfo.y;

      if (width < 1 || height < 1) {
        continue;
      }

      //Let's see if there are exclusions that are in the way
      for (var e = 0; e < exclusions.length; e++) {
        isFull = exclusions[e].isFull();
        exclusionInfo = exclusions[e].getInfo();
        if (!isFull || exclusionInfo.x < pointInfo.x) {
          continue;
        }
        if (
          pointInfo.y < exclusionInfo.y + exclusionInfo.height &&
          pointInfo.y >= exclusionInfo.y
        ) {
          width = Math.min(width, exclusionInfo.x - pointInfo.x);
        }
      }

      if (width < 1) {
        continue;
      }

      for (var e = 0; e < exclusions.length; e++) {
        exclusionInfo = exclusions[e].getInfo();
        if (exclusionInfo.y < pointInfo.y) {
          continue;
        }
        if (
          pointInfo.x < exclusionInfo.x + exclusionInfo.width &&
          pointInfo.x + width > exclusionInfo.x
        ) {
          height = Math.min(height, exclusionInfo.y - pointInfo.y);
        }
      }

      if (height < 1) {
        continue;
      }
      return new GridArea(width, height, pointInfo.x, pointInfo.y);
    }
    return null;
  };
}

function GridAreaFiller(logger) {
  this.log = function() {
    if (logger) logger(arguments);
  };
}
GridAreaFiller.prototype.fillArea = function(
  gridArea,
  gridContents,
  maxCount,
  fillerContents
) {
  function filterOutContentsTooBig(gridContents, gridArea) {
    var areaInfo = gridArea.getInfo();
    return gridContents.filter(function(content) {
      var contentInfo = content.getInfo();
      return (
        contentInfo.width * contentInfo.minScale < areaInfo.width &&
        contentInfo.height * contentInfo.minScale < areaInfo.height
      );
    });
  }

  function inflateAndSpacePlacements(placements, area) {
    var residualGap = inflatePlacements(placements, area);
    spacePlacements(placements, residualGap);
  }

  function inflatePlacements(placements, area) {
    if (!placements || !placements.length) {
      return 0;
    }
    var areaInfo = area.getInfo();
    var gap = areaInfo.width;
    for (var i = 0; i < placements.length; i++) {
      gap -= placements[i].getInfo().area.getInfo().width;
    }
    var maxIterations = 20;
    while (gap > 0.01 && maxIterations-- > 0) {
      var inflatablePlacements = placements.filter(function(placement) {
        return placement.canBeInflated();
      });
      if (!inflatablePlacements.length) {
        break;
      }

      var inflateAmount = gap / inflatablePlacements.length;
      for (var i = 0; i < inflatablePlacements.length; i++) {
        var actualInflateAmount = inflatablePlacements[i].inflateByWidth(
          inflateAmount
        );
        if (actualInflateAmount.x > 0) {
          for (var j = 0; j < placements.length; j++) {
            if (
              placements[j].getInfo().area.getInfo().x >
              inflatablePlacements[i].getInfo().area.getInfo().x
            ) {
              placements[j].translateBy(actualInflateAmount.x, 0);
            }
            if (
              placements[j].getInfo().area.getInfo().y >
              inflatablePlacements[i].getInfo().area.getInfo().y
            ) {
              placements[j].translateBy(0, actualInflateAmount.y);
            }
          }
          gap -= actualInflateAmount.x;
        }
      }
    }
    return gap;
  }

  function spacePlacements(placements, gap) {
    if (gap <= 0 || !placements || !placements.length) {
      return;
    }
    var gapPerSpace = gap / (placements.length - 1);
    for (i = 1; i < placements.length; i++) {
      placements[i].translateBy(i * gapPerSpace, 0);
    }
  }

  function fillRow(manager, gridArea, gridContents, maxCount) {
    var placements = [];
    var count = Math.min(maxCount, gridContents.length);
    if (count <= 0) {
      return placements;
    }
    var containerInfo = gridArea.getInfo();

    var content, contentInfo, areaWidth, currentPlacement;
    var currentLeft = 0;

    for (var i = 0; i < count; i++) {
      content = gridContents[i];
      contentInfo = content.getInfo();

      areaWidth = contentInfo.width * contentInfo.minScale;
      areaHeight = contentInfo.height * contentInfo.minScale;

      if (containerInfo.width - currentLeft < areaWidth) {
        break;
      }
      if (containerInfo.height < areaHeight) {
        break;
      }
      currentPlacement = new GridPlacement(
        content,
        containerInfo.x + currentLeft,
        containerInfo.y,
        contentInfo.minScale
      );
      currentLeft += areaWidth;
      placements.push(currentPlacement);
      manager.addExclusion(currentPlacement.getInfo().area, true);
    }
    inflateAndSpacePlacements(
      placements,
      new GridArea(containerInfo.width, containerInfo.height)
    );
    if (!placements.length) {
      manager.addExclusion(gridArea, false);
    }
    return placements;
  }

  function fillEmptyExclusions(manager, fillerContents) {
    var placements = [];
    if (!fillerContents || !fillerContents.length) {
      return placements;
    }

    var placementsPerExclusion = 1;
    var emptyExclusions = manager.getEmptyExclusions();
    var exclusion, subPlacements;
    for (var i = 0; i < emptyExclusions.length; i++) {
      exclusion = emptyExclusions[i];
      for (var j = 0; j < fillerContents.length; j++) {
        subPlacements = fillRow(
          manager,
          exclusion,
          [fillerContents[j]],
          placementsPerExclusion
        );
        if (subPlacements.length) {
          for (var z = 0; z < subPlacements.length; z++) {
            placements.push(subPlacements[z]);
          }
          exclusion.setFull(true);
          break;
        }
      }
    }
    return placements;
  }

  //Fill
  gridContents = filterOutContentsTooBig(gridContents, gridArea);
  var manager = new GridAreaManager(gridArea);
  var count = Math.min(maxCount, gridContents.length);
  var placements = [];
  var subPlacements, nextArea, subIndex;
  while (count > 0 && gridContents.length > 0) {
    nextArea = manager.getNextArea();

    if (nextArea == null) {
      break;
    }
    subPlacements = fillRow(manager, nextArea, gridContents, count);
    count -= subPlacements.length;

    for (var i = 0; i < subPlacements.length; i++) {
      subIndex = gridContents.indexOf(subPlacements[i].getInfo().content);
      if (subIndex < 0) {
        //throw "An unknown content was used for placement";
      } else {
        gridContents.splice(subIndex, 1);
      }
      placements.push(subPlacements[i]);
    }
  }

  //Fillers
  var fillers = fillEmptyExclusions(manager, fillerContents);
  placements = placements.concat(fillers);

  return placements;
};

String.prototype.hashCode = function() {
  var hash = 0,
    i,
    chr;
  if (this.length === 0) return hash;
  for (i = 0; i < this.length; i++) {
    chr = this.charCodeAt(i);
    hash = (hash << 5) - hash + chr;
    hash |= 0; // Convert to 32bit integer
  }
  return hash;
};

$.fn.gridify = function(contents, maxCount, categoryBudgets) {
  var grid = this;

  var preloaded = grid.data("gridify-preloaded");
  if (!preloaded) {
    preloaded = [];
    grid.data("gridify-preloaded", preloaded);
  }

  var preloadPromise = grid.data("gridify-preload-promise");
  if (!preloadPromise) {
    preloadPromise = $.Deferred()
      .resolve()
      .promise();
    grid.data("gridify-preload-promise", preloadPromise);
  }

  grid.css("position", "relative");
  var width = grid.width();
  if (width <= 0) {
    throw "Width of the grid must be positive but was: " + width;
  }
  var height = grid.height();
  if (height <= 0) {
    height = Number.POSITIVE_INFINITY;
  }
  if (typeof maxCount == "function") {
    maxCount = maxCount(width);
  }
  var factor = Math.max(width / 1600, 1.0);
  var area = new GridArea(width, height);
  var previousContents = grid.data("gridify-contents");
  var actualContents = JSON.stringify(
    contents.map(function(c) {
      return c.id;
    })
  ).hashCode();
  var contentManager = null;
  if (previousContents == actualContents) {
    contentManager = grid.data("gridify-content-manager");
  }
  if (!contentManager) {
    contentManager = new GridContentManager(contents);
    grid.data("gridify-contents", actualContents);
    grid.data("gridify-content-manager", contentManager);
  }
  var gridContents = contentManager.getGridContents(
    maxCount,
    categoryBudgets,
    factor
  );
  var fillerContents = contentManager.getFillerContents();
  var areaFiller = new GridAreaFiller(console.log);
  var placements = areaFiller.fillArea(
    area,
    gridContents,
    maxCount,
    fillerContents
  );
  var areaElement, contentElement, info, areaInfo, contentInfo;
  var maxHeight = 0;
  var preloadImmagini = [];
  for (var i = 0; i < placements.length; i++) {
    info = placements[i].getInfo();
    contentInfo = info.content.getInfo();
    areaInfo = info.area.getInfo();
    maxHeight = Math.max(maxHeight, areaInfo.y + areaInfo.height);
    areaElement = $("<div></div>");
    areaElement.css({
      boxSizing: "border-box",
      position: "absolute",
      border: contentInfo.borderColor
        ? "2px solid " + contentInfo.borderColor
        : "none",
      width: areaInfo.width + "px",
      height: areaInfo.height + "px",
      left: areaInfo.x + "px",
      top: areaInfo.y + "px",
      background: contentInfo.backgroundColor
        ? contentInfo.backgroundColor
        : "transparent",
      color: contentInfo.foregroundColor ? contentInfo.foregroundColor : "black"
    });

    contentElement = $("<div></div>");
    contentElement.css({
      position: "absolute",
      top: contentInfo.marginTop + "px",
      bottom: contentInfo.marginBottom + "px",
      left: contentInfo.marginLeft + "px",
      right: contentInfo.marginRight + "px",
      zoom: info.scale
    });
    contentElement.addClass("zoom" + Math.ceil(info.scale * 10));
    var bodyHtml = info.content.getHtml();
    if (typeof bodyHtml == "string") {
      var sostituzione = sostituisciImmagini(bodyHtml);
      preloadImmagini = preloadImmagini.concat(sostituzione.immagini);
      contentElement.html(sostituzione.html);
    } else if (bodyHtml) {
      console.log(bodyHtml);
      if (bodyHtml.parentNode) {
        bodyHtml.parentNode.removeChild(bodyHtml);
      }
      contentElement[0].appendChild(bodyHtml);
    }

    areaElement.append(contentElement);
    grid.append(areaElement);
  }
  grid.css("height", maxHeight + 30 + "px");

  precaricaImmagini(preloadImmagini);

  function sostituisciImmagini(html) {
    var immagini = [];
    var regex = RegExp('<img.*?src="(.*?)"', "g");
    var result;
    while ((result = regex.exec(html)) !== null) {
      immagini.push(result[1]);
    }
    for (var i = 0; i < immagini.length; i++) {
      html = html.replace(
        immagini[i],
        "/assets/graphics/blank.php?path=" + encodeURIComponent(immagini[i])
      );
    }
    return { html: html, immagini: immagini };
  }

  function precaricaImmagini(immagini) {
    immagini = immagini.sort(function(a, b) {
      var extA = a.substr(-3).toLowerCase();
      var extB = b.substr(-3).toLowerCase();
      if (extA == "gif" && extB == "gif") {
        return 0;
      } else if (extA == "gif") {
        return 1;
      } else if (extB == "gif") {
        return -1;
      }
      return 0;
    });

    var percorso;
    for (var j = 0; j < immagini.length; j++) {
      percorso = immagini[j];
      if (preloaded.indexOf(percorso) > -1) {
        var immagine = $(
          "img[src='/blank.php?path=" +
            encodeURIComponent(percorso) +
            "']"
        );
        immagine.attr("src", percorso);
        continue;
      }
      var chainedPromise = preloadPromise.then(
        (function(path) {
          return function() {
            var deferred = $.Deferred();
            var img = new Image();
            function completePromise(src) {
              preloaded.push(src);
              deferred.resolve(src);
            }
            img.onload = function() {
              var immagine = $(
                "img[src='/assets/graphics/blank.php?path=" +
                  encodeURIComponent(path) +
                  "']"
              );
              immagine.attr("src", path);
              completePromise(path);
            };
            img.onerror = function() {
              console.log();
              completePromise(path);
            };
            img.src = path;
            return deferred.promise();
          };
        })(percorso)
      );
      grid.data("gridify-preload-promise", chainedPromise);
    }
  }
};
