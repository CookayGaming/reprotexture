-- Config
local SPRITE_DICTIONNARY	= "cooktestdict"
local sprites =
{
	"snail_superman",
	"snail_redm",
	"snail_bandit",
	"snail_happy",
}

local SPRITE_BASED_SIZE = 1024
local BASED_WIDTH = 1920
local BASED_HEIGHT = 1080
local SHOW_DURATION = 2000

--
Citizen.CreateThread(function()
	print("[cooktest] Verify if texture has already been loaded")
	if not HasStreamedTextureDictLoaded(SPRITE_DICTIONNARY) then
		print("[cooktest] Texture wasn't loaded, so let's request it")
		RequestStreamedTextureDict(SPRITE_DICTIONNARY)
		while not HasStreamedTextureDictLoaded(SPRITE_DICTIONNARY) do
			Citizen.Wait(50)
		end
		print("[cooktest] Texture loaded")
	else
		print("[cooktest] Texture was already loaded")
	end

	local width, height = GetActiveScreenResolution()
	print("[cooktest] width and height set")
	local widthScale = width / BASED_WIDTH
	print("[cooktest] defined width scale")
	local heightScale = height / BASED_HEIGHT
	print("[cooktest] defined height scale")
	local startingTime = GetGameTimer()
	print("[cooktest] defined starting time")


	print("[cooktest] Display sprite")
	local randomSprite = math.random(1, #sprites)
	while GetGameTimer() - startingTime < SHOW_DURATION do
		DrawSprite(SPRITE_DICTIONNARY, sprites[randomSprite], 0.5, 0.5, (SPRITE_BASED_SIZE / width) * widthScale, (SPRITE_BASED_SIZE / height) * heightScale, 0.0, 255, 255, 255, 255)
		Citizen.Wait(0)
	end

	SetStreamedTextureDictAsNoLongerNeeded(SPRITE_DICTIONNARY)
	print("[cooktest] Texture has been unloaded")
end)