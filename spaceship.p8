pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-------------------
-- data
-------------------

-- game state
local state = 0

-- player
local player = {
	x = 0,
	y = 0,
	speed = 0
}

-- aux
local shooting = false
local blinking = false
local blink_count = 0

-- bullets
local bullets = {}
local enemy_bullets = {}
local bullet_speed = 4

-- enemies
local enemies = {}
local count_col = 3
local count_row = 11

-- game state
local score = 0
local high = 0
local lives = 3
local kills = 0

-- background
local stars = {}
local star_count = 64
local star_speed = 3

-------------------
-- game lifetime
-------------------
function _init()
	init_title()
end

function _update()
	if state == 0 then -- title
		update_title()
		update_background()
	elseif state == 1 then -- game
		update_player()
		update_enemies()
		update_bullets()
		update_background()
		
		if #enemies == 0 then
			state = 0
		end
	end
end

function _draw()
	cls()
	
	if state == 0 then -- title
		draw_background()
		draw_title()
	elseif state == 1 then -- game
		draw_background()
		draw_bullets()
		draw_enemies()
		draw_player()
		
		draw_ui()
	end
end

-------------------
-- init methods
-------------------
function init_title()
	-- bgm
	music(0)
	-- init background
	stars = {}
	for i=1,star_count do
		add(stars, {x=rnd(128),y=rnd(128)})
	end
end

function init_game()
	-- init player
	player.x = 64
	player.y = 118
	player.speed = 2
	
	-- game state
	kills = 0
	score = 0
		
	-- init enemies
	enemies = {}
	
	for i=1,count_row do
		for j=1,count_col do
			create_enemy(i*10,20+j*12,15+j,j*100) 
		end
	end
end

-------------------
-- update methods
-------------------
function update_player()
	if btn(0) and player.x > 2 then
		player.x -= player.speed
	end
	
	if btn(1) and player.x < 118 then
		player.x += player.speed
	end
	
	if btn(2) and player.y > 18 then
		player.y -= player.speed
	end
	
	if btn(3) and player.y < 118 then
		player.y += player.speed
	end		
	
	if btn(4) then
		if not shooting then
			sfx(0)
			create_bullet()
			shooting = true
		end
	else
		shooting = false
	end
end

function update_enemies()
	for enemy in all(enemies) do
		for bullet in all(bullets) do
			if intersect(enemy.x,enemy.y,8,8,bullet.x,bullet.y,8,8) then
				score += enemy.score
				kills += 1
				del(enemies,enemy)
				del(bullets,bullet)
				sfx(1)
			end
		end
	end
end

function update_background()
	for star in all(stars) do
		star.y += star_speed
		
		if star.y > 128 then
			star.y = 0
			star.x = rnd(128)
		end
	end
end

function update_bullets()	
	for bullet in all(bullets) do
		bullet.y -= bullet_speed
		
		if bullet.y < 0 then
			del(bullets, bullet)
		end
	end
end

function update_title()
	if btn(4) or btn(5) then
		init_game()
		sfx(2)
		state = 1
	end
	
	blink_count += 1
	
	if blink_count > 10 then
		blinking = not blinking
		blink_count = 0
	end
end

-------------------
-- draw methods
-------------------
function draw_player()
	spr(1, player.x, player.y)
end

function draw_enemies()
	for enemy in all(enemies) do
		spr(enemy.type,enemy.x,enemy.y)
	end
end

function draw_background()
	for star in all(stars) do
		pset(star.x, star.y,13)
	end
end

function draw_bullets()
	for bullet in all(bullets) do
		spr(2, bullet.x, bullet.y)
	end
end

function draw_ui()
	-- top ui
	rectfill(0,0,127,15,1)
	print('score: '..score, 3, 3, 6)
	print('high : '..high, 3, 10, 6)
	
	print('lives: '..lives, 94, 3, 6)
	print('kills: '..kills, 94,10, 6)
	
	-- border
	rect(0,16,127,127,1)
end

function draw_title()
	map(0,0)
	
	if not blinking then 
		print('press X or O to start',20,80,8)
	end
	
	print('2019 diogo muller',28,120,6)
end

-------------------
-- builder methods
-------------------
function create_bullet()
	add(bullets, {x = player.x, y = player.y})
end

function create_enemy(pos_x,pos_y,enemy_type,enemy_score)
	add(enemies, {x=pos_x, y=pos_y,type=enemy_type,score=enemy_score})
end

-------------------
-- helper methods
-------------------
function intersect(x1,y1,w1,h1,x2,y2,w2,h2)
	return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

__gfx__
00000000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007777000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009007700900099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770007077770700099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777cc7770000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777cc7770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000079779700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0ee0e0055555504440044400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeecceee005005004444444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeecceee50555505444cc44400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0eeee0e555cc555044cc44000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
800ee008505cc5054444444400088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000ee00050555505404cc40400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000ee00080055008804cc40800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088000000880000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00777777777777000077777777777700000077777777000000007777777777000007777777776000076000000000076007777777777777700000000000000000
07766666666666600776666666666700007776666667770000076666666666000007666666666000076000000000076006666667666666600000000000000000
07600000000000000760000000000760077760000006776000760000000000000076000000000000076000000000076000000007600000000000000000000000
07600000000000000760000000000760076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
07600000000000000760000000000760076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
07600000000000000760000000000760076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
07600000000000000760000000000760076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
07766666666666000760000000000760076000000000076000760000000000000077777777760000077777777777776000000007600000000000000000000000
00777777777777600777777777777700076000000000076000760000000000000077777777760000076666666666676000000007600000000000000000000000
00000000000007600776666666666600076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
00000000000007600760000000000000077777777777776000760000000000000076000000000000076000000000076000000007600000000000000000000000
00000000000007600760000000000000077777777777776000760000000000000076000000000000076000000000076000000007600000000000000000000000
00000000000007600760000000000000076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
00000000000007600760000000000000076000000000076000760000000000000076000000000000076000000000076000000007600000000000000000000000
00777777777777600760000000000000076000000000076000077777777777000007777777776000076000000000076007777777777777700000000000000000
06666666666666000760000000000000076000000000076000006666666666000006666666666000076000000000076006666666666666600000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000004041424344454647484900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000005051525354555657585900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000040414a4b4c4d42430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000050515a5b5c5d52530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000c35010350143501b3502a350203501635014350113500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000021450284502f4502c450274501e4501b450274502c4502845017450164501845020450314502e4502045018450194501d4503645033450144501445015450174502f4502a45013450124501345026450
000100001875018750197501a7501b7501c7501e7501f7502175023750277502d75034750377502f7502875023750207501e7501b750187501775015750147501275011750107500f7500f7500f7500f75010750

