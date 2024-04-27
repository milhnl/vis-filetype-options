# vis-filetype-options - filetype based options

A plugin for [vis](https://github.com/martanne/vis) which uses the built-in
`ftdetect` functionality to apply options.

### Installation

Clone this repository to where you install your plugins. (If this is your first
plugin, running `git clone https://github.com/milhnl/vis-filetype-options` in
`~/.config/vis/` will probably work).

Then, add `require('vis-filetype-options')` to your `visrc`. Also see Usage.

A note if you have also installed
[vis-editorconfig-options](https://github.com/milhnl/vis-options-backport): The
order matters. You probably want the options from the `.editorconfig` file to
override the ones you set in your editor. For example, most of your C projects
use tabs, so you set those using this plugin. There are some other projects
that use spaces, which is specified in their `.editorconfig`. The later plugin
overrides the options set by the one before. That's why I'd advise you have the
line `require('vis-filetype-options')` before
`require('vis-editorconfig-options')`.

#### Note on vis versions before 0.9

This plugin uses the `options` table, introduced in version 0.9. This version
is, as of December 2023, not released yet. If you use an older version, you
will also need
[vis-options-backport](https://github.com/milhnl/vis-options-backport). This
will 'polyfill' the `options` table for older versions.

### Usage

    local options = require('vis-filetype-options')
    options:clear() -- Not recommended, clears all default options
    options.html = {
      tabwidth = 2,
    }

`require` will return a table. This table is prefilled with some default
options. For example, a `Makefile` should not have `expandtab` set. If you
don't want those, you can override them per type, or just replace the whole
table as shown. The keys for the options table are the same as the vis
`syntax`, and the values are either:

- options objects, also like those `vis.win` has natively;
- functions, which are executed with the `win` as argument.

### Alternatives

There is also
[vis-filetype-settings](https://github.com/jocap/vis-filetype-settings), which
does mostly the same thing, but does not have the vis >= 0.9 syntax. Rather
than break compatibility with a pull request, I decided to create a new one, as
this isn't a complex plugin.
