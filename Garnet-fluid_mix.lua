local tank = peripheral.wrap("front")
local MACHINE = "back"
local SIDE = "bottom"

local FLUID1 = "tfg:cr_y_pregnant_liquor"
local FLUID2 = "tfg:lean_organic"

if not tank then
    error("未找到前方流体储罐")
end

-- 启动时先声明本机尚未就绪
rs.setOutput(SIDE, true)

while true do
    local ok, err = pcall(function()

        -- 每轮重新计算运行阶段
        local ticks = math.floor(os.epoch("ingame") / 3600)
        local runtime = ticks % 2

        if runtime == 0 then
            -- 阶段0：检查本机流体条件
            local fluids = tank.tanks()
            local fluid1 = fluids and fluids[1]
            local fluid2 = fluids and fluids[2]

            local ready =
                fluid1 ~= nil and
                fluid2 ~= nil and
                fluid1.amount == 1000 and
                fluid2.amount == 1000

            -- 高电平：未就绪
            -- 低电平：已就绪
            rs.setOutput(SIDE, not ready)

        else
            -- 阶段1：检查所有计算机是否就绪
            if rs.getAnalogInput(SIDE) == 0 then
                tank.pushFluid(MACHINE, 1000, FLUID1)
                tank.pushFluid(MACHINE, 1000, FLUID2)
            end
        end

        sleep(0)
    end)

    if not ok then
        -- 出错时撤销就绪信号，避免错误地允许投料
        rs.setOutput(SIDE, true)
        printError("执行出错: " .. tostring(err))
        sleep(0.5)
    end
end
