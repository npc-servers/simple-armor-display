if SERVER then
	print( "Simple Armor Display loaded" )
end

if CLIENT then
	hook.Add( "HUDDrawTargetID", "SimpleArmorDisplay", function()
   	 return false
	end)

	hook.Add( "HUDPaint", "SimpleArmorDisplay", function()
    
--[[    local tr = util.GetPlayerTrace( LocalPlayer() )
		local trace = util.TraceLine( tr )
		if ( !trace.Hit ) then return end
		if ( !trace.HitNonWorld ) then return end ]]--
		local z = LocalPlayer():GetEyeTrace().Entity
		if z:IsValid() and z:IsPlayer() and z:Alive() and z:GetRenderMode() != RENDERMODE_TRANSALPHA then
      
		local text = "ERROR"
		local font = "TargetID"
	
		if ( z:IsPlayer() ) then
			text = z:Nick()
		else
			return
			--text = trace.Entity:GetClass()
		end
	
		surface.SetFont( font )
		local w, h = surface.GetTextSize( text )
	
		local MouseX, MouseY = gui.MousePos()
	
		if ( MouseX == 0 && MouseY == 0 ) then
	
			MouseX = ScrW() / 2
			MouseY = ScrH() / 2
	
		end
	
		local x = MouseX
		local y = MouseY
	
		x = x - w / 2
		y = y + 30

		-- The fonts internal drop shadow looks lousy with AA on
		draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, team.GetColor(z:Team()) )
	
		y = y + h + 5
	
		local text = z:Health() .. "%    " .. z:Armor() .. "%"
		local font = "TargetIDSmall"
	
		surface.SetFont( font )
		local w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
	
		draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, team.GetColor(z:Team()) )

		end
	end )
end