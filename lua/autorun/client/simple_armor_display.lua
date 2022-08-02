local IsValid = IsValid
local nameFont = "TargetID"
local healthFont = "TargetIDSmall"
local draw_SimpleText = draw.SimpleText

local shadow1 = Color( 0, 0, 0, 120 )
local shadow2 = Color( 0, 0, 0, 50 )

hook.Add( "HUDDrawTargetID", "SimpleArmorDisplay", function()
    return false
end )

hook.Add( "HUDPaint", "SimpleArmorDisplay", function()
    local aimEnt = LocalPlayer():GetEyeTrace().Entity
    if not IsValid( aimEnt ) then return end
    if not aimEnt:IsPlayer() then return end
    if not aimEnt:Alive() then return end
    if aimEnt:GetRenderMode() == RENDERMODE_TRANSALPHA then return end

    local nameText = aimEnt:GetName()

    surface.SetFont( nameFont )
    local nameW, nameH = surface.GetTextSize( nameText )
    local mouseX, mouseY = gui.MousePos()

    if mouseX == 0 and mouseY == 0 then
        mouseX = ScrW() / 2
        mouseY = ScrH() / 2
    end

    local nameX = mouseX - nameW / 2
    local nameY = mouseY + 30

    draw_SimpleText( nameText, nameFont, nameX + 1, nameY + 1, shadow1 )
    draw_SimpleText( nameText, nameFont, nameX + 2, nameY + 2, shadow2 )
    draw_SimpleText( nameText, nameFont, nameX, nameY, team.GetColor( aimEnt:Team() ) )

    local healthPosY = nameY + nameH + 5
    local healthText = aimEnt:Health() .. "%  " .. aimEnt:Armor() .. "%"

    surface.SetFont( healthFont )
    local armorW = surface.GetTextSize( healthText )
    local healthPosX = mouseX - armorW / 2

    draw_SimpleText( healthText, healthFont, healthPosX + 1, healthPosY + 1, shadow1 )
    draw_SimpleText( healthText, healthFont, healthPosX + 2, healthPosY + 2, shadow2 )
    draw_SimpleText( healthText, healthFont, healthPosX, healthPosY, team.GetColor( aimEnt:Team() ) )
end )
