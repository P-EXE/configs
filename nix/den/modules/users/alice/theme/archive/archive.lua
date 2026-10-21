hl.config({
  general = {
    layout = "dwindle",
    border_size = 0,
    gaps_in = 0,
    gaps_out = 0,
  },
	decoration = {
    rounding = 0,
    active_opacity = 1,
    inactive_opacity = 1,
    dim_inactive = true,
    dim_strength = 0.6,
    blur = {
      enabled = false,
      size = 100,
      passes = 3,
      noise = 0.1,
      contrast = 1.0,
      brightness = 1.0,
      vibrancy = 1.0,
      vibrancy_darkness = 1.0,
      popups = true,
      popups_ignorealpha = 0.2,
      input_methods = true,
      input_methods_ignorealpha = 0.2,
      new_optimizations = true,
    },
		shadow = {
    	enabled = false,
    	range = 16,
    	render_power = 3,
    	sharp = false,
    	--ignore_window = true,
    	color = "0xff252525",
    	color_inactive = "0xff1b1b1b",
    	scale = 1.0,
  	}
	},
	animations = {
  	enabled = false
  }
})

hl.animation(
  {leaf = "fade", enabled = false, bezier = "default", speed = 0.1},
  {leaf = "workspaces", enabled = false, bezier = "default", speed = 0.1, style = "slide"},
  {leaf = "layersIn", enabled = false, bezier = "default", speed = 0.1, style = "slide"},
  {leaf = "layersOut", enabled = false, bezier = "default", speed = 0.1, style = "slide"},
  {leaf = "windows", enabled = false, bezier = "default", speed = 0.1, style = "slide"}
)

hl.window_rule(
  {	match = { 
			class = "firefox|chromium|vesktop"
		},
		no_dim = true
	}
	--{	match = { 
	--		initial_title = { "Hyprland Polkit Agent" }
	--	},
	--	opacity = 0.9,
		-- move = { "(monitor_w)", 16 }
	--}
)