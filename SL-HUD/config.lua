Config = {}

Config.debug = false    -- If you want to change stuff in the config, enable this option and disable it afterwards when youre done (Prevents errors when only restarting the script without reconnecting)

Config.accentColor = {r=124, g=237, b= 255}

-- Enable/Disbale HUD Functions
--{
Config.enableInfoHUD = true -- When enabled, shows the HUD with Server Info in the top right corner

Config.enableMoneyHUD = true    -- When enabled, shows the Money HUD in the top right corner

Config.enableBasicNeedsHUD = true   -- When enabled, shows the Food and Water bars on the right side

Config.enableOptionalNeedsHUD = true    -- When enabled, shows the Health and Armor bars on the right side

Config.enableStaminaOxygenHUD = true --When enabled, shows a Stamina Bar when running and a Oxygen Bar when diving

Config.enableStreetNameHUD = true   -- When enabled, shows the Street Info on the bottom left

Config.enableKeyBinds = true    -- When enabled, shows the keybinds, set in the config, on the left of the screen
--}

-- HUD Refresh rates. Lower refresh means slower but also less resource consuming
--{
Config.infoHUDRefresh = 2000

Config.moneyHUDRefresh = 500

Config.basicNeedsHUDRefresh = 1000

Config.optionalNeedsHUDRefresh = 200

Config.staminaOxygenHUDRefresh = 200

Config.streetNameHUDRefresh = 1000

--}

Config.serverName1 = "SUNSHINE" -- Colored in the accnent Color set in the config

Config.serverName2 = "ROLEPLAY" -- Colored white

Config.maxNotificationCount = 6 -- When this limit is reached, the newer notification pushes down one of the older ones

Config.notificationFromTop = false  -- When set to true, lets the notifications stack from top to bottom instead of the other way around

Config.notiMarginTop = "40%"   -- If you want the Notification to stack from the top 6% is recommended || default 40%

Config.announcementGroups = {"admin", "mod"}    -- The groups which are able to send announcements

Config.overrideAnnouncement = false -- when enabled, overrides the ongoing announcement with the newly sent one

Config.hideBinds = true -- when enabled, hides the keybinds on the left side when dead and pausemenu open

Config.hideStatsBars = true -- when enabled, hides the health and food bars when dead and pausemenu open

Config.hideTopRightInfo = true  -- when enabled, hides the top right info exept the server name when dead and pausemenu open

Config.hideStreetInfoHUD = true  -- when enabled, hides the top right info exept the server name when dead and pausemenu open

Config.enableAnimation = true  -- When enabled, animates the Hud stuff when, for example, opening the Pausemenu

Config.noPermissionTitle = "Error"  -- Title of the Notification which is sent when the player has no Permission to use a command e.g.

Config.noPermissionMessage = "You dont have permission to use that!"    -- Message of the before mentioned Notification

Config.ZoneAlreadyRestricted = "LSPD has already restricted a Zone!"    -- Message of the before mentioned Notification

Config.enableCommansForPlayers = true   -- When enabled, Lets players use the commands listed below. If not, only through the config

Config.keybindToggleCommand = "toggleKeyBinds"  -- Toggles the keybinds, set in the config, on the left of the screen

Config.infoHUDToggleCommand = "toggleServerInfo"    -- Toggles the HUD with Server Info in the top right corner

Config.moneyHUDToggleCommand = "toggleMoneyHUD" -- Toggles the Money HUD in the top right corner

Config.basicNeedsHUDToggleCommand = "toggleBasicNeeds"  -- Toggles the Food and Water bars on the right side

Config.staminaOxygenHUDToggleCommand = "toggleStaminaOxygen"  -- Toggles the Stamina Bar when running and the Oxygen Bar when diving

Config.optionalNeedsHUDToggleCommand = "toggleOptionalNeeds"    -- Toggles the Health and Armor bars on the right side

Config.streetNameHUDToggleCommand = "toggleStreetName"  -- Toggles the Street Info on the bottom left

Config.currency = "$"   -- sets the Currency displayed in the money HUD

-- Command suggestions
--{
Config.addRestrictionCommandSuggestion = "Syntax: Command  Radius eg. 150 | Creates a restricted zone at your current Position"

Config.removeRestrictionCommandSuggestion = "Removes the restricted Zone"

Config.announceCommandSuggestion = "Syntax: Time(ms)  Title  Message | Creates a announcement with the set parameters"
--}

Config.restrictedAreas = {
    LSPD = {
        blipSettings = {
            sprite = 188,
            scale = 2.0,
            color = 26,
            blipRadius = "",
            blip = "",
            name = "LSPD Restricted Zone",
        },
        addRestrictionCommand = "addLSPDRestrictedZone",    -- Command to add a Zone
        removeRestrictionCommand = "removeLSPDRestrictedZone",  -- Command to remove a Zone
        -- Only Jobs that can use these commands
        jobName = "police", -- (Case sensitive!)
        jobRank = {"lieutenant", "boss"},   -- Case sensitive!

        -- Announcement when Zone gets added
        activeannouceTime = 8000,
        activeannounceTitle = "Announcement",
        activeannounceMessage = "The LSPD Restricted the zone around /streetName/ in a radius of /radius/m! Do not enter or you will be penalized!", -- use /areaName/ instead of /streetName/ to display the area in the announcement

        -- Announcement when Zone gets removed
        inactiveannouceTime = 8000,
        inactiveannounceTitle = "Announcement",
        inactiveannounceMessage = "The LSPD removed the Restriction around /streetName/!",
    },
}

-- Icons: https://fontawesome.com
-- https://uploadi.ng/AR7lpJ8a
-- put the class name like in the screnshot in icon = ""
-- example: icon = "fa-solid fa-car"
Config.keyBinds = {
    phone = {
        keyBind = "F1",
        fontSize = "16px",
        icon = "fa-solid fa-phone",
        iconSize = "23px",
        marginLeft = "0px"
    },
    inventory = {
        keyBind = "F2",
        fontSize = "16px",
        icon = "fa-solid fa-box-open",
        iconSize = "23px",
        marginLeft = "-2px"
    },
    lockVehicle = {
        keyBind = "U",
        fontSize = "16px",
        icon = "fa-solid fa-key",
        iconSize = "23px",
        marginLeft = "0px"
    },
    talk = {
        keyBind = "N",
        fontSize = "16px",
        icon = "fa-solid fa-microphone",
        iconSize = "23px",
        marginLeft = "3px"
    },
    style = {
        keyBind = "K",
        fontSize = "16px",
        icon = "fa-solid fa-shirt",
        iconSize = "23px",
        marginLeft = "-2px"
    },
    medicMenu = {
        keyBind = "Z",
        fontSize = "16px",
        icon = "fa-solid fa-briefcase-medical",
        iconSize = "23px",
        marginLeft = "0px"
    },
}