let identifier = 0;
let notiIdentifier = 0;
let announceIdentifier = 0;
let accentColor;
let currency;
let noticount = 0;
let maxNotifyCount = 0;
let fromTop = false;
let keyBindAnimation = true;
let hideKeyBinds = false;
let hideStatBars = false;
let hideServerInfo = false;
let hideStreetInfo = false;
let overrideAnnouncement = false;
let announcementActive = false;
var format = new Intl.NumberFormat("en-US", {
  minimumFractionDigits: 0,
});
document.addEventListener("DOMContentLoaded", () => {
  $.post(`https://${GetParentResourceName()}/getConfig`, JSON.stringify({}));
  $.post(`https://${GetParentResourceName()}/getKeyBinds`, JSON.stringify({}));
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "infoData") {
    setVisibility(".pingBox", event.data.enabled);
    setVisibility(".playersBox", event.data.enabled);
    setVisibility(".playerBox", event.data.enabled);
    setVisibility(".jobBox", event.data.enabled);
    $(".playerPing").html(`${event.data.ping}ms`);
    $(".playerID").html(event.data.id);
    $(".players").html(event.data.players);
    if (event.data.jobName == "unemployed") {
      $(".playerJobName").hide();
      $(".split").hide();
      $(".playerJobRank").html(capitalizeFirstLetter(event.data.jobName));
    } else {
      $(".playerJobName").show();
      $(".split").show();
      $(".playerJobName").html(capitalizeFirstLetter(event.data.jobName));
      $(".playerJobRank").html(capitalizeFirstLetter(event.data.jobRank));
    }
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "basicNeeds") {
    setVisibility(".foodBarFlexBox", event.data.enabled);
    setVisibility(".waterBarFlexBox", event.data.enabled);
    setBasicValue(event.data.hunger, "foodBar");
    setBasicValue(event.data.thirst, "waterBar");
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "optionalNeeds") {
    setVisibility(".healthBarFlexBox", event.data.enabled);
    setVisibility(".armorBarFlexBox", event.data.enabled);
    setOptionalValue(event.data.health, "healthBar");
    setBasicValue(event.data.armor, "armorBar");
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "stamina") {
    if (event.data.enabled == true) {
      if ($(".staminaBarFlexBox").hasClass("animation-left-rightElements")) {
        $(".staminaBarFlexBox").removeClass("animation-left-rightElements");
      }
      $(".staminaBarFlexBox").css("position", "relative");
      $(".staminaBarFlexBox").addClass("animation-right-rightElements");
    } else {
      if ($(".staminaBarFlexBox").hasClass("animation-right-rightElements")) {
        $(".staminaBarFlexBox").removeClass("animation-right-rightElements");
      }
      $(".staminaBarFlexBox").addClass("animation-left-rightElements");
      setTimeout(() => {
        $(".staminaBarFlexBox").css("position", "absolute");
      }, 300);
    }
    setStaminaValue(event.data.stamina, "staminaBar");
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "oxygen") {
    if (event.data.enabled == true) {
      if ($(".oxygenBarFlexBox").hasClass("animation-left-rightElements")) {
        $(".oxygenBarFlexBox").removeClass("animation-left-rightElements");
      }
      $(".oxygenBarFlexBox").css("position", "relative");
      $(".oxygenBarFlexBox").addClass("animation-right-rightElements");
    } else {
      if ($(".oxygenBarFlexBox").hasClass("animation-right-rightElements")) {
        $(".oxygenBarFlexBox").removeClass("animation-right-rightElements");
      }
      $(".oxygenBarFlexBox").addClass("animation-left-rightElements");
      setTimeout(() => {
        $(".oxygenBarFlexBox").css("position", "absolute");
      }, 300);
    }
    setOxygenValue(event.data.oxygen, "oxygenBar");
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "moneyData") {
    setVisibility(".blackMoneyBox", event.data.enabled);
    setVisibility(".moneyBox", event.data.enabled);
    setVisibility(".bankMoneyBox", event.data.enabled);
    $(".blackMoney").html(
      `${format.format(event.data.blackMoney)} ${currency}`
    );
    $(".money").html(`${format.format(event.data.cash)} ${currency}`);
    $(".bankMoney").html(`${format.format(event.data.bankMoney)} ${currency}`);
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "keyBindings") {
    setVisibility(".keyBinds", event.data.enabled);
    setVisibility(".keyBinds", event.data.enabled);
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "location") {
    setVisibility(".streetIndicator", event.data.enabled);
    setVisibility(".streetIndicator", event.data.enabled);
    if (event.data.streetName != undefined)
      $(".streetName").html(event.data.streetName.toUpperCase());
    if (event.data.regionName != undefined)
      $(".regionName").html(event.data.regionName.toUpperCase());
  }
});
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "confVars") {
    if (event.data.basicIndicators == false) {
      $(".basicIndicators").css("opacity", "0");
    } else $(".basicIndicators").css("opacity", "1");
    $(".serverNameColored").html(event.data.serverName1);
    $(".serverName").html(event.data.serverName2);
    maxNotifyCount = event.data.maxNotifyCount;
    currency = event.data.currency;
    accentColor = `rgb(${event.data.r}, ${event.data.g}, ${event.data.b})`;
    setColor(accentColor);
    if (event.data.notificationTop) {
      $(".notificationFlexbox").css({
        top: `${event.data.notificationMarginTop}`,
        "flex-direction": "column",
      });
    } else {
      $(".notificationFlexbox").css({
        top: `${event.data.notificationMarginTop}`,
        "flex-direction": "column-reverse",
      });
    }
    keyBindAnimation = event.data.keyBindAnimation;
    hideKeyBinds = event.data.hideKeys;
    hideStatBars = event.data.hideStats;
    hideServerInfo = event.data.hideTopRight;
    hideStreetInfo = event.data.hideStreetInfo;
    overrideAnnouncement = event.data.overrideAnnouncement;
  }
});
function setColor(color) {
  $(".serverNameColored").css({
    color: color,
    "text-shadow": `0 0 10px ${color}`,
  });
  $(".underline").css({
    "background-color": color,
    "box-shadow": `0 0 5px ${color}`,
  });
}
window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "notification") {
    notiIdentifier++;
    noticount++;
    if (noticount >= 3) {
      $(`#bg${notiIdentifier - maxNotifyCount}`).remove();
      $(`#box${notiIdentifier - maxNotifyCount}`).remove();
      $(`#desc${notiIdentifier - maxNotifyCount}`).remove();
      $(`#time${notiIdentifier - maxNotifyCount}`).remove();
      $(`#title${notiIdentifier - maxNotifyCount}`).remove();
      $(`#underline${notiIdentifier - maxNotifyCount}`).remove();
      if (maxNotifyCount > 2) {
        if (keyBindAnimation) {
          if ($(".keybinds").hasClass("animation-right")) {
            $(".keybinds").removeClass("animation-right");
          }
          $(".keybinds").addClass("animation-left");
        } else {
          $(".keybinds").hide();
        }
      }
    }
    let notifyBG = $(
      `<div class="notificationBackground" id="bg${notiIdentifier}">`
    );
    $(".notificationFlexbox").append(notifyBG);
    let titleFlex = $(
      `<div class="notificationTitleBox" id="box${notiIdentifier}">`
    );
    let desc = $(
      `<div class="notificationDescription" id="desc${notiIdentifier}"></div>`
    );
    let time = $(
      `<div class="timeIndicator" id="time${notiIdentifier}"></div>`
    );
    $(`#bg${notiIdentifier}`).append(titleFlex, desc, time);
    let title = $(
      `<div class="notificationTitle" id="title${notiIdentifier}"></div>`
    );
    let underline = $(
      `<div class="notificationUnderline" id="underline${notiIdentifier}"></div>`
    );
    $(`#box${notiIdentifier}`).append(title, underline);
    $(`#title${notiIdentifier}`).html(event.data.title);
    $(`#desc${notiIdentifier}`).html(event.data.message);
    $(`#underline${notiIdentifier}`).css({
      "background-color": event.data.color,
      "box-shadow": `0 0 5px ${event.data.color}`,
    });
    $(`#bg${notiIdentifier}`).css({
      animation: `slideright 0.6s ease forwards, appear 0.3s linear forwards, slideleft 0.6s ease forwards ${
        (parseInt(event.data.time) + 300) / 1000
      }s, disappear 0.3s linear forwards ${
        (parseInt(event.data.time) + 300) / 1000
      }s`,
    });
    $(`#time${notiIdentifier}`).css({
      animation: `countdown ${
        parseInt(event.data.time) / 1000
      }s linear forwards`,
      "animation-delay": "0.3s",
      "background-color": event.data.color,
      "box-shadow": `0 0 5px ${event.data.color}`,
    });
    setTimeout(() => {
      noticount--;
      notifyBG.remove();
      titleFlex.remove();
      desc.remove();
      time.remove();
      title.remove();
      underline.remove();
      if (noticount <= 2) {
        if (keyBindAnimation) {
          if ($(".keybinds").hasClass("animation-left")) {
            $(".keybinds").removeClass("animation-left");
          }
          $(".keybinds").addClass("animation-right");
        } else {
          if ($(".keybinds").hasClass("animation-right")) {
            $(".keybinds").removeClass("animation-right");
          }
          $(".keybinds").show();
        }
      }
    }, parseInt(event.data.time) + 600);
  }
});

window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "announcement") {
    let title = event.data.title;
    let message = event.data.message;
    if (announcementActive) {
      if (overrideAnnouncement) {
        $(`#title${announceIdentifier}`).html(title);
        $(`#desc${announceIdentifier}`).html(message);
      }
    } else {
      announcementActive = true;
      announceIdentifier++;
      let announcementBackground = $(
        `<div class="announcementBackground" id="bg${announceIdentifier}">`
      );
      $(".announcementFlexbox").append(announcementBackground);
      let titleBox = $(
        `<div class="announcementTitleBox" id="box${announceIdentifier}">`
      );
      let description = $(
        `<div class="announcementDescription" id="desc${announceIdentifier}">`
      );
      let timer = $(
        `<div class="announcementTimer" id="timer${announceIdentifier}">`
      );
      $(`#bg${announceIdentifier}`).append(titleBox, description, timer);
      let title = $(
        `<div class="announcementTitle" id="title${announceIdentifier}">`
      );
      let underline = $(
        `<div class="announcementUnderline" id="line${announceIdentifier}">`
      );
      $(`#box${announceIdentifier}`).append(title, underline);
      $(`#title${announceIdentifier}`).html(event.data.title);
      $(`#desc${announceIdentifier}`).html(event.data.message);
      $(`#line${announceIdentifier}`).css({
        "background-color": event.data.color,
        "box-shadow": `0 0 5px ${event.data.color}`,
      });
      $(`#bg${announceIdentifier}`).css({
        animation: `slidedown 0.6s ease forwards, appear 0.3s linear forwards, slideup 0.6s ease forwards ${
          (parseInt(event.data.time) + 300) / 1000
        }s, disappear 0.3s linear forwards ${
          (parseInt(event.data.time) + 300) / 1000
        }s`,
      });
      $(`#line${announceIdentifier}`).css({
        "background-color": accentColor,
        "box-shadow": `0 0 5px ${accentColor}`,
      });
      $(`#timer${announceIdentifier}`).css({
        animation: `countdown ${
          parseInt(event.data.time) / 1000
        }s linear forwards`,
        "animation-delay": "0.3s",
        "background-color": accentColor,
        "box-shadow": `0 0 5px ${accentColor}`,
      });
      setTimeout(() => {
        noticount--;
        announcementActive = false;
        announcementBackground.remove();
        titleBox.remove();
        description.remove();
        timer.remove();
        title.remove();
        underline.remove();
      }, parseInt(event.data.time) + 600);
    }
  }
});

window.addEventListener("message", function (event) {
  if (event.data.script == "SL-HUD" && event.data.func == "saveZone") {
    if (event.data.enabled) {
      if ($(".safeZoneBox").hasClass("animation-left-rightElements")) {
        $(".safeZoneBox").removeClass("animation-left-rightElements");
      }
      $(".safeZoneBox").addClass("animation-right-rightElements");
    } else if (event.data.enabled == false) {
      if ($(".safeZoneBox").hasClass("animation-right-rightElements")) {
        $(".safeZoneBox").removeClass("animation-right-rightElements");
      }
      $(".safeZoneBox").addClass("animation-left-rightElements");
    }
  }
});
window.addEventListener("message", function (event) {
  if (
    event.data.script == "SL-KEYBINDS" &&
    event.data.func == "createElements"
  ) {
    identifier++;
    let bindClass = $(`<div class="binds" id="bind${identifier}">`);
    $(".keyBinds").append(bindClass);
    let bindIcon = $(`<i class="${event.data.icon}"></i>`).css({
      position: "relative",
      color: event.data.color,
      "font-size": event.data.iconSize,
      "margin-left": event.data.marginLeft,
    });
    let bindBox = $(`<div class="bindBox" id="bindBox${identifier}">`);
    $(`#bind${identifier}`).append(bindIcon, bindBox);
    let bind = $(`<div class="bind">${event.data.keyBind}</div>`).css(
      "font-size",
      event.data.fontSize
    );
    $(`#bindBox${identifier}`).append(bind);
  }
});

window.addEventListener("message", function (event) {
  if (
    event.data.script == "SL-HUD" &&
    event.data.func == "hide" &&
    event.data.enabled == false
  ) {
    if (keyBindAnimation) {
      //animate keybinds
      if (hideKeyBinds) {
        if ($(".keybinds").hasClass("animation-right")) {
          $(".keybinds").removeClass("animation-right");
        }
        $(".keybinds").addClass("animation-left");
      }
      //animate stuff on the right side
      if (hideStatBars) {
        if ($(".basicIndicators").hasClass("animation-right-rightElements")) {
          $(".basicIndicators").removeClass("animation-right-rightElements");
        }
        $(".basicIndicators").addClass("animation-left-rightElements");
      }
      if (hideServerInfo) {
        if ($(".stats").hasClass("animation-right-rightElements")) {
          $(".stats").removeClass("animation-right-rightElements");
        }
        $(".stats").addClass("animation-left-rightElements");
      }
      if (hideStreetInfo) {
        if ($(".indicatorFlexbox").hasClass("slideup-animation")) {
          $(".indicatorFlexbox").removeClass("slideup-animation");
        }
        $(".indicatorFlexbox").addClass("slidedown-animation");
      }
    } else {
      if (hideKeyBinds) {
        if ($(".keybinds").hasClass("animation-left")) {
          $(".keybinds").removeClass("animation-left");
        }
        $(".keybinds").hide();
      }
      if (hideStatBars) {
        if ($(".basicIndicators").hasClass("animation-left-rightElements")) {
          $(".basicIndicators").removeClass("animation-left-rightElements");
        }
        $(".basicIndicators").hide();
      }
      if (hideServerInfo) {
        if ($(".stats").hasClass("animation-left-rightElements")) {
          $(".stats").removeClass("animation-left-rightElements");
        }
        $(".stats").hide();
      }
      if (hideStreetInfo) {
        if ($(".indicatorFlexbox").hasClass("slidedown-animation")) {
          $(".indicatorFlexbox").removeClass("slidedown-animation");
        }
        $(".indicatorFlexbox").hide();
      }
    }
  } else if (
    event.data.script == "SL-HUD" &&
    event.data.func == "hide" &&
    event.data.enabled == true
  ) {
    if (keyBindAnimation) {
      if (hideKeyBinds) {
        if ($(".keybinds").hasClass("animation-left")) {
          $(".keybinds").removeClass("animation-left");
        }
        $(".keybinds").addClass("animation-right");
      }
      if (hideStatBars) {
        if ($(".basicIndicators").hasClass("animation-left-rightElements")) {
          $(".basicIndicators").removeClass("animation-left-rightElements");
        }
        $(".basicIndicators").addClass("animation-right-rightElements");
      }
      if (hideServerInfo) {
        if ($(".stats").hasClass("animation-left-rightElements")) {
          $(".stats").removeClass("animation-left-rightElements");
        }
        $(".stats").addClass("animation-right-rightElements");
      }
      if (hideStreetInfo) {
        if ($(".indicatorFlexbox").hasClass("slidedown-animation")) {
          $(".indicatorFlexbox").removeClass("slidedown-animation");
        }
        $(".indicatorFlexbox").addClass("slideup-animation");
      }
    } else {
      if (hideKeyBinds) {
        if ($(".keybinds").hasClass("animation-right")) {
          $(".keybinds").removeClass("animation-right");
        }
        $(".keybinds").show();
      }
      if (hideStatBars) {
        if ($(".basicIndicators").hasClass("animation-right-rightElements")) {
          $(".basicIndicators").removeClass("animation-right-rightElements");
        }
        $(".basicIndicators").show();
      }
      if (hideServerInfo) {
        if ($(".keybinds").hasClass("animation-right-rightElements")) {
          $(".keybinds").removeClass("animation-right-rightElements");
        }
        $(".keybinds").show();
      }
      if (hideStreetInfo) {
        if ($(".indicatorFlexbox").hasClass("slideup-animation")) {
          $(".indicatorFlexbox").removeClass("slideup-animation");
        }
        $(".indicatorFlexbox").show();
      }
    }
  }
});

function capitalizeFirstLetter(string) {
  if (string != undefined) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
}

function setVisibility(element, enabled) {
  if (enabled == true) {
    $(element).show();
  } else {
    $(element).hide();
  }
}
function setOptionalValue(value, element) {
  if (value > 110) {
    $(`#${element}1`).show();
  } else $(`#${element}1`).hide();
  if (value > 115) {
    $(`#${element}2`).show();
  } else $(`#${element}2`).hide();
  if (value > 120) {
    $(`#${element}3`).show();
  } else $(`#${element}3`).hide();
  if (value > 130) {
    $(`#${element}4`).show();
  } else $(`#${element}4`).hide();
  if (value > 140) {
    $(`#${element}5`).show();
  } else $(`#${element}5`).hide();
  if (value > 150) {
    $(`#${element}6`).show();
  } else $(`#${element}6`).hide();
  if (value > 160) {
    $(`#${element}7`).show();
  } else $(`#${element}7`).hide();
  if (value > 170) {
    $(`#${element}8`).show();
  } else $(`#${element}8`).hide();
  if (value > 180) {
    $(`#${element}9`).show();
  } else $(`#${element}9`).hide();
  if (value > 190) {
    $(`#${element}10`).show();
  } else $(`#${element}10`).hide();
}
function setBasicValue(value, element) {
  if (value > 5) {
    $(`#${element}1`).show();
  } else $(`#${element}1`).hide();
  if (value > 10) {
    $(`#${element}2`).show();
  } else $(`#${element}2`).hide();
  if (value > 20) {
    $(`#${element}3`).show();
  } else $(`#${element}3`).hide();
  if (value > 30) {
    $(`#${element}4`).show();
  } else $(`#${element}4`).hide();
  if (value > 40) {
    $(`#${element}5`).show();
  } else $(`#${element}5`).hide();
  if (value > 50) {
    $(`#${element}6`).show();
  } else $(`#${element}6`).hide();
  if (value > 60) {
    $(`#${element}7`).show();
  } else $(`#${element}7`).hide();
  if (value > 70) {
    $(`#${element}8`).show();
  } else $(`#${element}8`).hide();
  if (value > 80) {
    $(`#${element}9`).show();
  } else $(`#${element}9`).hide();
  if (value > 90) {
    $(`#${element}10`).show();
  } else $(`#${element}10`).hide();
}
function setStaminaValue(value, element) {
  if (value > 90) {
    $(`#${element}1`).hide();
  } else $(`#${element}1`).show();
  if (value > 80) {
    $(`#${element}2`).hide();
  } else $(`#${element}2`).show();
  if (value > 70) {
    $(`#${element}3`).hide();
  } else $(`#${element}3`).show();
  if (value > 60) {
    $(`#${element}4`).hide();
  } else $(`#${element}4`).show();
  if (value > 50) {
    $(`#${element}5`).hide();
  } else $(`#${element}5`).show();
  if (value > 40) {
    $(`#${element}6`).hide();
  } else $(`#${element}6`).show();
  if (value > 30) {
    $(`#${element}7`).hide();
  } else $(`#${element}7`).show();
  if (value > 20) {
    $(`#${element}8`).hide();
  } else $(`#${element}8`).show();
  if (value > 10) {
    $(`#${element}9`).hide();
  } else $(`#${element}9`).show();
  if (value > 0) {
    $(`#${element}10`).hide();
  } else $(`#${element}10`).show();
}

function setOxygenValue(value, element) {
  if (value > 0) {
    $(`#${element}1`).show();
  } else $(`#${element}1`).hide();
  if (value > 1) {
    $(`#${element}2`).show();
  } else $(`#${element}2`).hide();
  if (value > 2) {
    $(`#${element}3`).show();
  } else $(`#${element}3`).hide();
  if (value > 3) {
    $(`#${element}4`).show();
  } else $(`#${element}4`).hide();
  if (value > 4) {
    $(`#${element}5`).show();
  } else $(`#${element}5`).hide();
  if (value > 5) {
    $(`#${element}6`).show();
  } else $(`#${element}6`).hide();
  if (value > 6) {
    $(`#${element}7`).show();
  } else $(`#${element}7`).hide();
  if (value > 7) {
    $(`#${element}8`).show();
  } else $(`#${element}8`).hide();
  if (value > 8) {
    $(`#${element}9`).show();
  } else $(`#${element}9`).hide();
  if (value > 9) {
    $(`#${element}10`).show();
  } else $(`#${element}10`).hide();
}
