---
--- Localization module
---
-- @author LordFoobar (lordfoobar@mind2soft.com)

-- Init
local locale_path = "lc_messages";
local default_locale = "en";
local locales = {};

-- Global object
i18n = {};


--- Init the specified locales with the given config.
--- The configuration Property may have either or both of these keys
---   * i18n.defaultLocale=XX             where XX is a 2-letter language code
---   * i18n.availableLocales=XX,YY,...   a comma-separated list of locales to load
---
--- Each available locale will be loaded from the "lc_messages" directory of the script.
-- @param config the configuration Property object
function i18n.init(config)
  if config:hasProperty("i18n.defaultLocale") then
    default_locale = config:getProperty("i18n.defaultLocale");
  end

  if config:hasProperty("i18n.availableLocales") then
    for locale in string.gmatch(config:getProperty("i18n.availableLocales"), "(%a+)%s*,*%s*") do
      print("Loading locale "..locale.."...");
      locales[locale] = getProperty(locale_path.."/"..locale..".locale");
    end
  end
end


--- Translate the given message using the player locale, if possible, or the default one, if possible.
-- @param player [optional] use the default locale if no player (nil), or if no player locale available
-- @param msg the message as string
-- @param ... any arguments to be formatted
-- @return the translated message
function i18n.t(player, msg, ...)
  -- TODO: can this function be improved?
  local localeMsg;
  if player ~= nil then
    if locales[player:getGameLanguage()] and locales[player:getGameLanguage()]:hasProperty(msg) then
      localeMsg = locales[player:getGameLanguage()]:getProperty(msg);
    end
    if localeMsg == nil and locales[player:getSystemLanguage()] and locales[player:getSystemLanguage()]:hasProperty(msg) then
      localeMsg = locales[player:getSystemLanguage()]:getProperty(msg);
    end
  end
  if localeMsg == nil and locales[default_locale] and locales[default_locale]:getProperty(msg) then
    localeMsg = locales[default_locale]:getProperty(msg);
  end

  if localeMsg ~= nil then
    return localeMsg:format(...);
  else
    return msg;
  end
end