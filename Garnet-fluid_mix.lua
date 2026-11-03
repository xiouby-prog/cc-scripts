local tank = peripheral.wrap("front")
local machine = peripheral.wrap("back")
local ticks = math.floor(os.epoch("ingame") / 3600)
local runtime = ticks % 2
rs.setOutput("bottom", true)

while true do
    local ok, err = pcall(function()
        if runtime == 0 then
            rs.setOutput("bottom", true)
            local fluids = tank.tanks()
            local fluid1 = fluids[1]
            local fluid2 = fluids[2]
            if fluid1 and fluid2 then
                if (fluid1.amount == 1000) and (fluid2.amount == 1000) then
                    rs.setOutput("bottom", false)
                print(rs.getAnalogInput("bottom"))
                end
            end
        end
        if runtime == 1 then
            if rs.getAnalogInput("bottom") == 0 then
                tank.pushFluid("back", 1000, "tfg:cr_y_pregnant_liquor")
                tank.pushFluid("back", 1000, "tfg:lean_organic")
            end
        end
    end)
    if not ok then
        printError("执行出错: " .. tostring(err))
        sleep(0.5)
    end
end