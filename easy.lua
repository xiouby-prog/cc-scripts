local tank = peripheral.wrap("front")
local machine = peripheral.wrap("back")

while true do
    local signal = rs.getInput("bottom")
    local fluids = tank.tanks()
    local fluid1 = fluids[1]
    local fluid2 = fluids[2]
    if signal and (fluid1 and fluid2) then
        print("ok")
        if (fluid1 == 1000) and (fluid2 == 1000) then
            tank.pushFluid("back", 1000, "tfg:cr_y_pregnant_liquor")
            tank.pushFluid("back", 1000, "tfg:lean_organic")
        else
            print("nope")
        end
    end
end
