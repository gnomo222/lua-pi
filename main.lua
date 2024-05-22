package.path = sys.currentdir .. "\\?.lua"
package.cpath = sys.currentdir .. "\\?.dll"

function os.capture(cmd, raw)
    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))
    handle:close()
    if raw then return output end
    output = string.gsub(string.gsub(string.gsub(output, '^%s+', ''), '%s+$',''), '[\n\r]+',' ')
    return output
end

local osver = {os.capture("ver", true):gmatch("(%d%d).%d.(%d%d%d%d%d)")()}
osver[1], osver[2] = tonumber(osver[1]), tonumber(osver[2])
local colors = (osver[1] == 10 and osver[2] >= 16257) or osver[1] > 10

print(colors)

if colors then os.execute 'color F0' end

local cmd = os.execute
local socket = require 'socket.core'
local cls = function() 
    os.execute('cls')
end

local file = sys.File("pi"):open("read", "utf8")

local pi, score = file:read():gmatch("(%g+)%s(%d+)")()
file:close()

--[[ local function redden(toCompare, compareTo)
    local text = ""
    local actually2C = string.gsub(toCompare, "[., ]*", "~")
    for i=1, string.len(toCompare) do
        local char = string.sub(actually2C, i, i)
        if not (char == "~") and (not char == string.sub(compareTo, i, i)) then
            text = text .. '\27[1m\27[31m'.. char ..'\27[47m30m'
        elseif char == "~" then
            text = text .. string.sub(toCompare, i, i)
        else
            text = text .. char
        end
    end
    return text
end ]]

local function printchars(text)
    local len = string.len(text)

    local j
    local n = 25

    local function getSleepTime(i)
        local increment = 0.008
        local n_speed = 0.16
        local fast_speed = 0.032

        if (len-i) > n then
            return fast_speed
        end
        if not j then
            j = n_speed/fast_speed
        end
        if j < (n_speed/increment) then
            j=j+1
            return j*increment
        end
        return n_speed
    end

    for i=1, string.len(text) do
        if i>n then 
            cls()
            io.write(string.sub(pi, i-25, i-1))
        end
        io.write(string.sub(pi, i,i))

        socket.sleep(getSleepTime(i))
    end
end

local function defaultize(str)
    return string.gsub(str, "[ ,.]*", "")
end

cls()
while true do
    local _p = string.sub(pi, 1, score)

    printchars(_p)
    socket.sleep(0.32)
    cls()

    local score_printable = score
    if colors then
        if (score_printable)%10 == 0 then
            score_printable = "\27[4;94m"..score
        end
        io.write('Type \27[4;30m' .. score_printable .. '\27[0;30m\27[107m digits of π: ')
    else
        io.write('Type ' .. score_printable .. ' digits of pi: ')
    end

    local input = io.read()
    if input == 'exit' then
        if colors then os.execute 'color 07' end
        os.exit()
    end
    if defaultize(input):sub(1, score-1) == defaultize(_p) then
        score = score+1
    else
        score = math.max(score-1, 4)
    end
    file:open("write")
    file:write(pi .. "\n" .. score)
    file:flush()
    file:close()

    cls()
end