let color;
let rgba;
let centerSpeed;
let r;
let g;
let b;
let stup = false;
let cruiseKey;
let seatBeltKey;

document.addEventListener("DOMContentLoaded", () => {
  $("#flexbox").hide();
  $.post(`https://${GetParentResourceName()}/getConfig`, JSON.stringify({}));
});

window.addEventListener("message", function (event) {
  if (event.data.script == "car_hud" && event.data.func == "configVars") {
    color = `rgb(${event.data.r}, ${event.data.g}, ${event.data.b})`;
    rgba = `rgba(${event.data.r}, ${event.data.g}, ${event.data.b}, 0.6)`;
    $("#rpm-counter").css("background-color", `${color}`);
    $("#rpm-counter").css("box-shadow", `0 0 5px ${color}`);
    $("#fuel-bar").css("background-color", `${color}`);
    $("#fuel-background").css("box-shadow", `0 0 5px ${rgba})`);
    $("#unit").html(event.data.unit);
    centerSpeed = event.data.centerSpeed;
    r = event.data.r;
    g = event.data.g;
    b = event.data.b;
    $(".cruise-bind").html(event.data.cruiseBind);
    $(".seatbelt-bind").html(event.data.beltBind);
    cruiseKey = event.data.cruiseBind;
    seatBeltKey = event.data.beltBind;
    if (event.data.showKeyBinds == true) {
      $(".bind-flexbox").show();
    } else {
      $(".bind-flexbox").hide();
    }
    if (event.data.cruiseControl == true) {
      $(".cruise-flexbox").show();
    } else {
      $(".cruise-flexbox").hide();
    }
    if (event.data.seatBelt == true) {
      $(".seatbelt-flexbox").show();
    } else {
      $(".seatbelt-flexbox").hide();
    }
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "car_hud" &&
    event.data.func == "cruiseControl" &&
    event.data.enabled == true
  ) {
    if (r == 124 && g == 237 && b == 255) {
      $(".cruise-icon").attr("src", "images/cruise-control-default.png");
    } else {
      $(".cruise-icon").attr("src", "images/cruise-control-red.png");
      $(".cruise-icon").css("filter", `hue-rotate(${rgb2hsv(r, g, b)}deg)`);
    }
  }
  if (
    event.data.script == "car_hud" &&
    event.data.func == "cruiseControl" &&
    event.data.enabled == false
  ) {
    $(".cruise-icon").attr("src", "images/cruise-control.png");
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "car_hud" &&
    event.data.func == "seatbelt" &&
    event.data.active == true
  ) {
    if ($(".seatbelt-icon").css("opacity") != "0" && !stup) {
      $(".seatbelt-icon").css("opacity", "0");
    } else if ($(".seatbelt-icon").css("opacity") == "0" && !stup) {
      $(".seatbelt-icon").attr("src", "images/seatbelt.png");
      $(".seatbelt-icon").css("opacity", "1");
      stup = true;
    }
  } else if (
    event.data.script == "car_hud" &&
    event.data.func == "seatbelt" &&
    event.data.active == false
  ) {
    stup = false;
    $(".seatbelt-icon").attr("src", "images/seatbelt-red.png");
    if ($(".seatbelt-icon").css("opacity") == "1") {
      $(".seatbelt-icon").css("opacity", "0");
    } else if ($(".seatbelt-icon").css("opacity") == "0") {
      $(".seatbelt-icon").css("opacity", "1");
    }
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "fuel_hud" &&
    event.data.func == "hideRpm" &&
    event.data.enabled == false
  ) {
    $("#background").show();
    $("#divide-line").css("bottom", "128px");
    $("#unit").css("bottom", "131px");
    $("#speed").css("margin-bottom", "145px");
    $("#speed-underlay").css("margin-bottom", "145px");
  } else if (
    event.data.script == "fuel_hud" &&
    event.data.func == "hideRpm" &&
    event.data.enabled == true
  ) {
    $("#background").hide();
    $("#divide-line").css("bottom", "60px");
    $("#unit").css("bottom", "63px");
    $("#speed").css("margin-bottom", "77px");
    $("#speed-underlay").css("margin-bottom", "77px");
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "car_hud" &&
    event.data.func == "cruise-glow" &&
    event.data.enabled == true
  ) {
    $(".cruise-bind-box").css("border-color", color);
  } else if (
    event.data.script == "car_hud" &&
    event.data.func == "cruise-glow" &&
    event.data.enabled == false
  ) {
    $(".cruise-bind-box").css("border-color", "rgba(255, 255, 255, 0)");
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "car_hud" &&
    event.data.func == "seatbelt-glow" &&
    event.data.enabled == true
  ) {
    $(".seatbelt-bind-box").css("border-color", color);
  } else if (
    event.data.script == "car_hud" &&
    event.data.func == "seatbelt-glow" &&
    event.data.enabled == false
  ) {
    $(".seatbelt-bind-box").css("border-color", "rgba(255, 255, 255, 0)");
  }
});

window.addEventListener("message", function (event) {
  if (event.data.script == "car_hud" && event.data.enabled == "true") {
    $("#flexbox").show();
  } else if (event.data.script == "car_hud" && event.data.enabled == "false") {
    $("#fuel-bar").css("width", "0px");
    $("#fuel-background").css("width", "0px");
    $("#rpm-counter").css("width", "0px");
    setTimeout(() => {
      $("#flexbox").hide();
    }, 300);
  }
});

window.addEventListener("message", function (event) {
  if (event.data.script == "car_hud" && event.data.func == "fuellevel") {
    $("#fuel-bar").css("width", event.data.fuellevel + "px");
    $("#fuel-background").css("width", event.data.fuellevel - 12 + "px");

    if (event.data.fuellevel < "100") {
      if ($("#fuel-img").css("opacity") == "1") {
        $("#fuel-img").css("opacity", "0");
      } else if ($("#fuel-img").css("opacity") == "0") {
        $("#fuel-img").css("opacity", "1");
      }
    } else {
      $("#fuel-img").css("opacity", "1");
    }

    if (event.data.fuellevel < "50") {
      if ($("#fuel-bar").css("opacity") == $("#fuel-img").css("opacity")) {
        $("#fuel-bar").css("background-color", "rgb(255, 0, 0)");
        if ($("#fuel-bar").css("opacity") == "1") {
          $("#fuel-bar").css("opacity", "0");
          $("#fuel-background").css(
            "box-shadow",
            "0 0 10px 0 rgba(255, 0, 0, 0)"
          );
        } else if ($("#fuel-bar").css("opacity") == "0") {
          $("#fuel-bar").css("opacity", "1");
          $("#fuel-background").css("box-shadow", "0 0 10px 0 rgb(255, 0, 0)");
        }
      }
    } else {
      $("#fuel-bar").css("opacity", "1");
      $("#fuel-bar").css("background-color", color);
      $("#fuel-background").css("box-shadow", `0 0 5px ${rgba}`);
    }
  }
});

window.addEventListener("message", function (event) {
  if (event.data.script == "car_hud" && event.data.func == "data") {
    $("#speed").html(event.data.speed);
    if (centerSpeed) {
      $("#speed-underlay").html("");
    } else {
      if (event.data.speed < 10) {
        $("#speed-underlay").html("00");
      } else if (event.data.speed < 100) {
        $("#speed-underlay").html("0");
      } else if (event.data.speed < 1000) {
        $("#speed-underlay").html("");
      }
    }

    if (event.data.engine) {
      $("#rpm-counter").css("width", event.data.rpm + "px");
    } else {
      $("#rpm-counter").css("width", "0px");
    }
  }
});

function rgb2hsv(r, g, b) {
  let rabs, gabs, babs, rr, gg, bb, h, s, v, diff, diffc, percentRoundFn;
  rabs = r / 255;
  gabs = g / 255;
  babs = b / 255;
  (v = Math.max(rabs, gabs, babs)), (diff = v - Math.min(rabs, gabs, babs));
  diffc = (c) => (v - c) / 6 / diff + 1 / 2;
  percentRoundFn = (num) => Math.round(num * 100) / 100;
  if (diff == 0) {
    h = s = 0;
  } else {
    s = diff / v;
    rr = diffc(rabs);
    gg = diffc(gabs);
    bb = diffc(babs);

    if (rabs === v) {
      h = bb - gg;
    } else if (gabs === v) {
      h = 1 / 3 + rr - bb;
    } else if (babs === v) {
      h = 2 / 3 + gg - rr;
    }
    if (h < 0) {
      h += 1;
    } else if (h > 1) {
      h -= 1;
    }
  }
  return Math.round(h * 360);
}
/*function getKey(key) {
  let keyCode;
  switch (key) {
    case "F1":
      keyCode = 112;
      break;
    case "F2":
      keyCode = 113;
      break;
    case "F3":
      keyCode = 114;
      break;
    case "F4":
      keyCode = 115;
      break;
    case "F5":
      keyCode = 116;
      break;
    case "F6":
      keyCode = 117;
      break;
    case "F7":
      keyCode = 118;
      break;
    case "F8":
      keyCode = 119;
      break;
    case "F9":
      keyCode = 120;
      break;
    case "F10":
      keyCode = 121;
      break;
    case "~":
      keyCode = 112;
      break;
    case "1":
      keyCode = 49;
      break;
    case "2":
      keyCode = 50;
      break;
    case "3":
      keyCode = 51;
      break;
    case "4":
      keyCode = 52;
      break;
    case "5":
      keyCode = 53;
      break;
    case "6":
      keyCode = 54;
      break;
    case "7":
      keyCode = 55;
      break;
    case "8":
      keyCode = 56;
      break;
    case "9":
      keyCode = 57;
      break;
    case "R":
      keyCode = 82;
      break;
    case "T":
      keyCode = 84;
      break;
    case "Y":
      keyCode = 89;
      break;
    case "U":
      keyCode = 85;
      break;
    case "P":
      keyCode = 80;
      break;
    case "ENTER":
      keyCode = 13;
      break;
    case "CAPS":
      keyCode = 20;
      break;
    case "G":
      keyCode = 71;
      break;
    case "H":
      keyCode = 72;
      break;
    case "K":
      keyCode = 75;
      break;
    case "L":
      keyCode = 76;
      break;
    case "LEFTSHIFT":
      keyCode = 16;
      break;
    case "Z":
      keyCode = 90;
      break;
    case "X":
      keyCode = 88;
      break;
    case "C":
      keyCode = 67;
      break;
    case "V":
      keyCode = 86;
      break;
    case "B":
      keyCode = 66;
      break;
    case "N":
      keyCode = 78;
      break;
    case "M":
      keyCode = 77;
      break;
    case ",":
      keyCode = 188;
      break;
    case ".":
      keyCode = 190;
      break;
    case "LEFTCTRL":
      keyCode = 17;
      break;
    case "LEFTALT":
      keyCode = 18;
      break;
    case "SPACE":
      keyCode = 32;
      break;
    case "RIGHTCTRL":
      keyCode = 17;
      break;
    case "HOME":
      keyCode = 36;
      break;
    case "PAGEUP":
      keyCode = 33;
      break;
    case "PAGEDOWN":
      keyCode = 34;
      break;
    case "DELETE":
      keyCode = 46;
      break;
    case "LEFT":
      keyCode = 37;
      break;
    case "RIGHT":
      keyCode = 39;
      break;
    case "TOP":
      keyCode = 38;
      break;
    case "DOWN":
      keyCode = 40;
      break;
  }
  return keyCode;
}*/
