# i18n SubModule

This module adds i18n support for your Rising World scripts.


## Installation

This script is not standalone and must be used with your own script, as it doesn't have a `definition.xml` file.


### Direct installation (not recommended)

You only need to copy the file `i18n.lua` to your script's directory. Whenever the file needs updating, this manual step must be done. This is a non-desirable method as, if commited, it will create duplicate versions of this file across different repositories.


### Using as a Git Sub-Module (recommended)

At the script base folder, execute the two commands

```
$ git submodule add https://github.com/RisingWorld/i18n
$ git commit -am 'Added i18n sub-module'
```

This will create a directory called `i18n`, and clone this repository in it. However, the content of the directory will not be commited with the rest of your project, only the directory entry and a file called `.gitmodules` 

Whenever the project needs updating, perform this command, also at the script's base folder :

```
$ git submodule update --remote i18n
```

Refer to the [official Git documentation](http://www.git-scm.com/book/en/v2/Git-Tools-Submodules) for more information.


## Usage

The best way to initialize localization for your scripts is to, first, create an `lc_messages` directory. Your project should look like this

```
./awesome-script
  ./lc_messages
    ./de.locale
    ./en.locale
    ./fr.locale
  ./i18n
    ./i18n.lua
  ./config.properties
  ./definition.xml
  ./awesome.lua
```

The content of your configuration file should have a configuration such as

```
# Default locale. By default, i18n will use "en"
i18n.defaultLocale=fr

# Available locales, what files to load in lc_messages/*.locale
i18n.availableLocales=de,en,fr
```

Then, in your `awesome.lua` script, initialize it like this

```
include("i18n/i18n.lua");

function onEnable()
  local config = getProperty("config.properties");

  i18n.init(config);

  -- localization should already be available!
  print(i18n.t(nil, "script.ready", "0.0.1"));
end
```

**Note**: we did not specify a player, here, therefore the default locale will be used (i.e. `"fr"`)

The `.locale` files are simply properties. They are using the `.locale` extention as a convention and for semantics.

Each localized strings are sent through the `string.format` function. Therefore, the locale files may look like this :

```
# en.locale
script.ready=Script v%s ready!
```

```
# fr.locale
script.ready=Script v%s prêt!
```

```
# de.locale
script.ready=Skript v0.1 fertig!
```

**IMPORTANT!** All locale files declared via the `i18n.availableLocales` config property must exist! They may, however, be empty, or missing some properties.


## API Reference

* `i18n.init(config)`
  Initialize the localization module using the given config properties.
* `i18n.t(player, msg, ...)`
  Translate `msg` into the `player`'s language, or into the default language otherwise (ex: if `player == nil` or no other suitable locale was found). If the value cannot be translated anyway, it is formatted and
  returned as is. Returns a `string`.


## License

Copyright (c) 2015 Yanick Rochon

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.