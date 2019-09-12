pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- main character
local p_x		-- mc x position
local p_y		-- mc y position
local p_flip_x 	-- mc flipped
local p_frame 	-- mc current frame
local p_walking -- mc currently walking
local p_speed	-- mc speed
local p_size	-- mc size

-- map
local m_x
local m_y
local tile_x
local tile_y
local s_x
local s_y

function _init()
	p_x = 64
	p_y = 64
	p_flip_x = false
	p_walking = false
	p_frame = 1
	p_speed = 2
	p_size = 8
	
	m_x = 0
	m_y = 0
end

function _update()
	-- update values
	tile_x = (p_x/8)
	tile_y = (p_y/8)
	
	-- character controller
	p_walking = true
	
	if (btn(0)) then 
		p_x -= p_speed
		p_flip_x = true
		
		if(check_collision(p_x,p_y,p_size,p_size)) p_x += p_speed
	elseif (btn(1)) then
		p_x += p_speed
		p_flip_x = false
		
		if(check_collision(p_x,p_y,p_size,p_size)) p_x -= p_speed
	elseif(btn(2)) then
		p_y -= p_speed
		
		if(check_collision(p_x,p_y,p_size,p_size)) p_y += p_speed
	elseif(btn(3)) then
		p_y += p_speed
		
		if(check_collision(p_x,p_y,p_size,p_size)) p_y -= p_speed
	else
		p_walking = false
	end
	
	-- character animation
	if p_walking then
		if( p_frame == 2 ) then
			p_frame = 3
		else 
			p_frame = 2
		end
	else
		p_frame = 1
	end
	
	-- map	
	if tile_x > 15 then
		m_x += 16
		s_x += 1
	elseif tile_x < 0 then
		m_x -= 16
		s_x -= 1
	end
	
	if tile_y > 15 then
		m_y += 16
		s_y += 1
	elseif tile_y < 0 then
		m_y -= 16
		s_y -= 1
	end
end

function _draw()
	cls()
	map(m_x,m_y)
	spr(p_frame,p_x - (s_x*8),p_y - (s_y*8),1,1,p_flip_x,false)		
	rect(0,0,127,127,8)
end


-- helper methods
function check_collision(x,y,w,h)
	collide=false
	for i=x,x+w,w do
		if (fget(mget(i/8,y/8))>0) or (fget(mget(i/8,(y+h)/8))>0) then
			  collide=true
		end
	end

	for i=y,y+h,h do
		if (fget(mget(x/8,i/8))>0) or (fget(mget((x+w)/8,i/8))>0) then
			  collide=true
		end
	end

	return collide
end
__gfx__
00000000008888800088888000888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008cfc00008cfc00008cfc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070000ffff0000ffff0000ffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000055115500551155005511550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000015555100155551001555510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000f5555f00f5555f00f5555f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001001000010010000100100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000004004000040400004000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbcccccccc99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbb3b3cccccccc44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbb3bcccccccc99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbcccccccc44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbb3b3bbbcccccccc99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbb3bbbbcccccccc44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbcccccccc99999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbcccccccc44444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbb6f6f6f6f4f4f4f4f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb8bbbbbbbbbb7bbf6f6f6f6f4f4f4f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b8a8bbbbbbbb7a7b6f6f6f6f4f4f4f4f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb8bbbbbbbbbb7bbf6f6f6f6f4f4f4f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbb8bbbbbbbbbb6f6f6f6f4f4f4f4f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb8a8bbb7bbbbbf6f6f6f6f4f4f4f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbb8bbb7a7bbbb6f6f6f6f4f4f4f4f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbb7bbbbbf6f6f6f6f4f4f4f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55d55d55666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5d5555d5556555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d5d55d5d556555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55d55d55556555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
555dd555666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d5d55d5d555556550011110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5d5555d5555556550111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55d55d55555556551111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44544544000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
45444454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54544545000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44544544000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44455444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
54544545000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
45444454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44544544000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252507070725252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525250707070707252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525250707260707252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06252525252525252525252525252516000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24242424242424242424242424242424000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070707070707070707070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07353535353535353535353535353507000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070707070707262607070707070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101020000000000000000000000000001000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
6060606060606060606060606060606060606060606060606060606060606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040404040404040404040404040404040404060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406161616161616161616161616161616161000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6040404040404040404040404040406100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000003650046500565006650076500965009650096500665005650056500565005650046500265001650056500565005650086500a6500b6500a6500a6500a6500a650066500865005650066500765007650
