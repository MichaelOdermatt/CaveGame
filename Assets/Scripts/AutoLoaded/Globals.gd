extends Node

## The current setting values. Or the default values if the settings have not 
## been changed.
var setting_values: SettingsData = SettingsData.new(
	Vector2(1280, 720),
	WINDOW_MODES['Windowed'],
	ANTI_ALIASING_OPTIONS['Disabled'],
	1,
	0.013,
	75,
	1,
);

## A list of all available resolution options.
const SUPPORTED_RESOLUTIONS: Dictionary = {
	'3840 x 2160' : Vector2i(3840, 2160),
	'2560 x 1440' : Vector2i(2560, 1440),
	'1920 x 1080' : Vector2i(1920, 1080),
	'1366 x 768' : Vector2i(1366, 768),
	'1536 x 864' : Vector2i(1536, 864),
	'1280 x 720' : Vector2i(1280, 720),
	'1440 x 900' : Vector2i(1440, 900),
	'1600 x 900' : Vector2i(1600, 900),
	'1024 x 600' : Vector2i(1024, 600),
	'800 x 600' : Vector2i(800, 600),
}

## A list of all available anti aliasing modes. The Key is the name of the mode
## and the Value is it's enum value as an int.
const ANTI_ALIASING_OPTIONS: Dictionary = {
	'Disabled' : 0,
	'MSAA 3D 2x' : 1,
	'MSAA 3D 4x' : 2,
	'MSAA 3D 8x' : 3,
}

## A list of all available window mode options. The Key is the name of the mode
## and the Value is it's enum value as an int.
const WINDOW_MODES: Dictionary = {
	'Windowed' : 0,
	'Fullscreen' : 3,
}

## A list of all audio buses. The Key is the name of the audio bus
## and the Value is it's bus index.
const AUDIO_BUSES: Dictionary = {
	'Master' : 0,
}
