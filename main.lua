package.cpath="./pi_libraries/bin/?.dll;"

local wait = require("waitFunction")
local supportsColor = require("supportsVTProcessing")
local pi = require("getPi")

local package = package
local system = os.execute
local w = io.write
local read = io.read
local flush = io.flush
local string = string

local function write(...)
    w(...)
    flush()
end

local function printf(fmt, ...)
    write(fmt:format(...))
    flush()
end

local function char(str, index)
    return str:sub(index, index)
end

local cls, typeFmt

if supportsColor then 
    cls = function()
        write("\27[H\27[J\27[H")
        flush()
    end
    write("\27[0;30;107m")
    typeFmt = 'Type \27[4;31;107m%d\27[0;30;107m digits of pi: '
else 
    cls = function() system("cls") end
    typeText = 'Type %d digits of pi: '
end


local saveFile = io.open("save")

local score = 4
if saveFile then
    local tempText
    tempNum = tonumber(saveFile:read("*a"))
    if tempNum == nil or tempNum == 0 then score = 4
    else score = tempNum+2 end
    saveFile:close()
end
saveFile=io.open("save", "w+")

local truncateAt = 25
local goFastAbove = 8
local defaultWaitTime = 1000/5

local function getWaitTime(distance)
    if distance>goFastAbove then
        return defaultWaitTime/6
    end
    return defaultWaitTime
end

local function printchars()
    if score-truncateAt>0 then goto __GREATER__ end
    for i=1, score do
        write(char(pi, i))
        wait(getWaitTime(score-i))
    end
    goto __END__
    ::__GREATER__::
    for i=1, score do
        if i>truncateAt then
            cls()
            write(pi:sub(i-truncateAt, i-1))
        end
        write(char(pi, i))
        wait(getWaitTime(score-i))
    end
    ::__END__::
    wait(defaultWaitTime*2.5)
end

local function defaultize(str)
    return str:gsub("[^%d]", "")
end

while true do
    cls()
    local piSubstring = pi:sub(1, score)
    printchars()
    cls()
    printf(typeFmt, score-2)
    local input
    while (input == "" or input == nil) do input=io.read() end
    if input == "exit" then
        if colors then system 'color 07' end
        goto EOF
    end
    if defaultize(input):sub(1, score-1) == defaultize(piSubstring) then
        score = score+1
    elseif score>4 then score=score-1 end
    saveFile = io.open("save", "w+")
    saveFile:write(score-2)
    saveFile:flush()
end

::EOF::
write("\27[0m")
cls()
saveFile = io.open("save", "w+")
saveFile:write(score-2)
saveFile:close()
