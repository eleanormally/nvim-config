return {
    "cormacrelf/dark-notify",
    config = function()
      local dn = require("dark_notify")
      dn.run({
        schemes = {
          light = {
            background = "light",
          }
        }
      })
    end,
    lazy = false
}
