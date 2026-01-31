local v_u_1 = {}
local v_u_2 = -(Vector3.new(0, -23.833334, 0)).Y
v_u_1.Constants = {
    ["SOURCE_TO_STUDS"] = 0.0763888888888889,
    ["SV_GRAVITY"] = 800,
    ["GRENADE_GRAVITY_SCALE"] = 0.39,
    ["GRENADE_ELASTICITY"] = 0.4,
    ["JUMP_THROW_ELASTICITY"] = 0.32,
    ["PLAYER_ELASTICITY"] = 0.3,
    ["MIN_ELASTICITY"] = 0,
    ["MAX_ELASTICITY"] = 0.9,
    ["MAX_THROW_VELOCITY_SOURCE"] = 750,
    ["PLAYER_VELOCITY_SCALE"] = 1.5,
    ["SLEEP_VELOCITY_SOURCE"] = 20,
    ["STOP_EPSILON_SOURCE"] = 0.1,
    ["FLOOR_NORMAL_THRESHOLD"] = 0.7,
    ["OVERBOUNCE"] = 2,
    ["FIXED_TIMESTEP"] = 0.0078125,
    ["MAX_BOUNCES"] = 20,
    ["THROW_POWER_SCALE"] = 0.7,
    ["THROW_POWER_BASE"] = 0.3,
    ["VELOCITY_SCALE"] = 0.58,
    ["GRAVITY"] = Vector3.new(0, -23.833334, 0),
    ["MAX_THROW_VELOCITY"] = 57.29166666666667,
    ["SLEEP_VELOCITY"] = 1.527777777777778,
    ["STOP_EPSILON"] = 0.0076388888888888895,
    ["THROW_UPWARD_BIAS_FAR"] = 0.06,
    ["THROW_UPWARD_BIAS_NEAR"] = 0.04,
    ["THROW_FORWARD_OFFSET"] = 1.35,
    ["THROW_HEIGHT_OFFSET"] = 2.4,
    ["PLAYER_VELOCITY_INHERITANCE"] = 1.5,
    ["PLAYER_VERTICAL_VELOCITY_SCALE"] = 2,
    ["GROUND_CHECK_DISTANCE"] = 0.2,
    ["MAX_SIMULATION_TIME"] = 10,
    ["JUMP_THROW_DETECTION_THRESHOLD"] = 5,
    ["JUMP_THROW_HORIZONTAL_DAMPENING"] = 1,
    ["JUMP_THROW_FIXED_VERTICAL"] = 20,
    ["JUMP_THROW_HEIGHT_BONUS"] = 0,
    ["MAX_THROW_SPEED"] = 50,
    ["MAX_JUMP_THROW_SPEED"] = 62,
    ["MAX_ACCUMULATED_TIME"] = 0.1,
    ["MAX_ITERATIONS_PER_FRAME"] = 16
}
function v_u_1.createInitialState(p3, p4, p5, p6, p7, p8)
    local v9 = ((p5 == "Far" and 1 or 0) * 0.7 + 0.3) * 57.29166666666667 * p7 * 0.58
    local v10 = p6.Y > 5
    local v11 = 1
    if v10 then
        p3 = p3 + Vector3.new(0, 0, 0)
    end
    local v12
    if v10 then
        v12 = Vector3.new(0, 20, 0)
    else
        local v13 = p6.Y * 2 * 0.58
        v12 = Vector3.new(0, v13, 0)
    end
    local v14
    if v10 then
        local v15 = p4.X * v11
        local v16 = p4.Y
        local v17 = p4.Z * v11
        v14 = Vector3.new(v15, v16, v17).Unit
    else
        v14 = p4
    end
    local v18 = v14 * v9 + v12
    local v19 = not v10 and 1 or v11
    local v20 = p4.X * v19
    local v21 = p4.Y
    local v22 = p4.Z * v19
    local v23 = Vector3.new(v20, v21, v22).Unit * v9 * 0.15
    local v24 = p7 * 6.5 * 0.58
    local v25 = v18 + (v23 + Vector3.new(0, v24, 0))
    local v26 = not v10 and 50 or (p4.Y - 0.4) * 20 + 62
    local v27 = v25.Magnitude
    if v26 < v25.Magnitude then
        v25 = v25.Unit * v26
    end
    local v28 = p6.X
    local v29 = p6.Z
    local v30 = v25 + Vector3.new(v28, 0, v29) * 1.5 * v11
    print(string.format("[SIMULATOR] throwSpeed=%.2f | uncapped=%.2f | capped=%.2f | throwDir.Y=%.3f | isJump=%s", v9, v27, v30.Magnitude, p4.Y, (tostring(v10))))
    local v31 = p8 * 1000
    local v32 = math.floor(v31) % 1000
    local v33 = v32 % 11 - 5
    local v34 = v32 / 11
    local v35 = math.floor(v34) % 13 - 6
    local v36 = v32 / 143
    local v37 = math.floor(v36) % 11 - 5
    return {
        ["position"] = p3,
        ["velocity"] = v30,
        ["angularVelocity"] = Vector3.new(v33, v35, v37),
        ["timestamp"] = p8,
        ["simulationTime"] = 0,
        ["bounceCount"] = 0,
        ["isGrounded"] = false,
        ["isAtRest"] = false,
        ["hasTouched"] = false,
        ["accumulatedTime"] = 0,
        ["isJumpThrow"] = v10
    }
end
function v_u_1.createConfig(p38, p39, p40, p41, p42, p43)
    return {
        ["radius"] = p38,
        ["restitution"] = 0.4,
        ["maxBounces"] = 20,
        ["fuseTime"] = p41,
        ["minimumFuseTime"] = p42,
        ["explodeOnFloorImpact"] = p43,
        ["rangeScale"] = p39,
        ["isNearThrow"] = p40
    }
end
function v_u_1.detectCollision(p44, p45, p46, p47)
    local v48 = p45 - p44
    local v49 = v48.Magnitude
    if v49 < 0.001 then
        return nil
    end
    local v50 = p46 * 0.01
    local v51 = {}
    local v52 = Vector3.new(v50, 0, 0)
    local v53 = -v50
    local v54 = Vector3.new(v53, 0, 0)
    local v55 = Vector3.new(0, v50, 0)
    local v56 = -v50
    local v57 = Vector3.new(0, v56, 0)
    local v58 = Vector3.new(0, 0, v50)
    local v59 = -v50
    __set_list(v51, 1, {v52, v54, v55, v57, v58, (Vector3.new(0, 0, v59))})
    local v60 = (1 / 0)
    local v61 = workspace:Raycast(p44, v48, p47)
    local v62
    if v61 and v61.Distance < v60 then
        v60 = v61.Distance
        v62 = Vector3.new(0, 0, 0)
    else
        v61 = nil
        v62 = Vector3.new(0, 0, 0)
    end
    for _, v63 in v51 do
        local v64 = p44 + v63
        local v65 = workspace:Raycast(v64, v48, p47)
        if v65 and v65.Distance < v60 then
            v60 = v65.Distance
            v62 = v63
            v61 = v65
        end
    end
    if not v61 then
        return nil
    end
    local v66 = v61.Position - v62
    local v67 = (v66 - p44).Magnitude
    if v49 + v50 + 0.1 < v67 then
        return nil
    end
    local v68 = v61.Instance
    local v69 = v68.Parent
    local v70
    if v69 then
        v70 = v69:FindFirstChildOfClass("Humanoid") ~= nil
    else
        v70 = v69
    end
    local v71 = v69 and v69:HasTag("BreakableGlass") or v68:HasTag("BreakableGlass")
    return {
        ["hit"] = true,
        ["position"] = v66,
        ["normal"] = v61.Normal,
        ["distance"] = v67,
        ["instance"] = v68,
        ["isPlayer"] = v70,
        ["isGlass"] = v71
    }
end
function v_u_1.checkGrounded(p72, p73)
    local v74 = workspace:Raycast(p72, Vector3.new(0, -0.2, 0), p73)
    if v74 then
        return true, v74.Normal
    else
        return false, nil
    end
end
function v_u_1.checkSurfaceContact(p75, p76, p77)
    local v78 = p76 + 0.1
    for _, v79 in {
        Vector3.new(0, -1, 0),
        Vector3.new(0, 1, 0),
        Vector3.new(1, 0, 0),
        Vector3.new(-1, 0, 0),
        Vector3.new(0, 0, 1),
        Vector3.new(0, 0, -1)
    } do
        local v80 = workspace:Raycast(p75, v79 * v78, p77)
        if v80 and v80.Distance < v78 then
            return true, v80.Normal
        end
    end
    return false, nil
end
local function v_u_91(p81, p82, p83)
    local v84 = p81:Dot(p82) * p83
    local v85 = p81.X - p82.X * v84
    local v86 = p81.Y - p82.Y * v84
    local v87 = p81.Z - p82.Z * v84
    local v88 = math.abs(v85) < 0.0076388888888888895 and 0 or v85
    local v89 = math.abs(v86) < 0.0076388888888888895 and 0 or v86
    local v90 = math.abs(v87) < 0.0076388888888888895 and 0 or v87
    return Vector3.new(v88, v89, v90)
end
function v_u_1.integrate(p92, p93, p94, p95)
    if p95 then
        return p92 + p93 * p94, p93
    end
    local v96 = p93.Y - v_u_2 * p94
    local v97 = (p93.Y + v96) / 2
    local v98 = p93.X * p94
    local v99 = v97 * p94
    local v100 = p93.Z * p94
    local v101 = Vector3.new(v98, v99, v100)
    local v102 = p93.X
    local v103 = p93.Z
    local v104 = Vector3.new(v102, v96, v103)
    return p92 + v101, v104
end
function v_u_1.calculateBounce(p105, p106, p107, p108)
    local v109 = table.clone(p107)
    local v110 = (p107.isJumpThrow and 0.32 or 0.4) * (p108 and 0.3 or 1)
    local v111 = math.clamp(v110, 0, 0.9)
    local v112 = v_u_91(p105, p106, 2) * v111
    if p106.Y > 0.7 and v112:Dot(v112) < 2.3341049382716053 then
        v109.bounceCount = p107.bounceCount + 1
        v109.hasTouched = true
        return Vector3.new(0, 0, 0), v109
    else
        v109.bounceCount = p107.bounceCount + 1
        v109.hasTouched = true
        return v112, v109
    end
end
function v_u_1.shouldStop(p113, p114, p115)
    if p114 and p115 then
        return p113:Dot(p113) < 2.3341049382716053
    else
        return false
    end
end
function v_u_1.step(p116, p117, p118, p119)
    local v120 = table.clone(p116)
    v120.simulationTime = p116.simulationTime + p119
    local v121 = nil
    if v120.simulationTime >= 10 then
        v120.isAtRest = true
        return v120, {
            ["type"] = "timeout",
            ["timestamp"] = p116.timestamp + v120.simulationTime,
            ["position"] = v120.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = v120.velocity,
            ["bounceCount"] = v120.bounceCount
        }
    end
    if p117.fuseTime and v120.simulationTime >= p117.fuseTime then
        v120.isAtRest = true
        return v120, {
            ["type"] = "fuse",
            ["timestamp"] = p116.timestamp + v120.simulationTime,
            ["position"] = v120.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = v120.velocity,
            ["bounceCount"] = v120.bounceCount
        }
    end
    if p116.bounceCount >= p117.maxBounces then
        v120.isAtRest = true
        v120.velocity = Vector3.new(0, 0, 0)
        return v120, {
            ["type"] = "rest",
            ["timestamp"] = p116.timestamp + v120.simulationTime,
            ["position"] = v120.position,
            ["normal"] = Vector3.new(0, 1, 0),
            ["velocity"] = Vector3.new(0, 0, 0),
            ["bounceCount"] = v120.bounceCount
        }
    end
    local v122 = v120.position
    local v123, v124 = v_u_1.integrate(v120.position, v120.velocity, p119, v120.isGrounded)
    local v125 = v_u_1.detectCollision(v122, v123, p117.radius, p118)
    if v125 then
        local v126
        v126, v120 = v_u_1.calculateBounce(v124, v125.normal, v120, v125.isPlayer)
        v120.position = v125.position + v125.normal * 0.05
        v120.velocity = v126
        local v127 = v125.normal.Y > 0.7
        if p117.explodeOnFloorImpact and v127 and (not p117.minimumFuseTime or v120.simulationTime >= p117.minimumFuseTime) then
            v120.isAtRest = true
            return v120, {
                ["type"] = "floor_impact",
                ["timestamp"] = p116.timestamp + v120.simulationTime,
                ["position"] = v120.position,
                ["normal"] = v125.normal,
                ["velocity"] = v120.velocity,
                ["bounceCount"] = v120.bounceCount
            }
        end
        v121 = {
            ["type"] = "bounce",
            ["timestamp"] = p116.timestamp + v120.simulationTime,
            ["position"] = v120.position,
            ["normal"] = v125.normal,
            ["velocity"] = v120.velocity,
            ["bounceCount"] = v120.bounceCount
        }
    else
        v120.position = v123
        v120.velocity = v124
    end
    local v128, v129 = v_u_1.checkGrounded(v120.position, p118)
    v120.isGrounded = v128
    if not v_u_1.shouldStop(v120.velocity, v128, v120.hasTouched) or (p117.minimumFuseTime and v120.simulationTime < p117.minimumFuseTime or p117.fuseTime) then
        return v120, v121
    end
    v120.isAtRest = true
    v120.velocity = Vector3.new(0, 0, 0)
    v120.angularVelocity = Vector3.new(0, 0, 0)
    return v120, {
        ["type"] = "rest",
        ["timestamp"] = p116.timestamp + v120.simulationTime,
        ["position"] = v120.position,
        ["normal"] = v129 or Vector3.new(0, 1, 0),
        ["velocity"] = Vector3.new(0, 0, 0),
        ["bounceCount"] = v120.bounceCount
    }
end
function v_u_1.simulate(p130, p131, p132, p133)
    if p130.isAtRest then
        if not p131.fuseTime then
            return {
                ["state"] = p130,
                ["events"] = {}
            }
        end
        local v134 = table.clone(p130)
        v134.simulationTime = p130.simulationTime + p133
        return v134.simulationTime >= p131.fuseTime and {
            ["state"] = v134,
            ["events"] = {
                {
                    ["type"] = "fuse",
                    ["timestamp"] = p130.timestamp + v134.simulationTime,
                    ["position"] = v134.position,
                    ["normal"] = Vector3.new(0, 1, 0),
                    ["velocity"] = v134.velocity,
                    ["bounceCount"] = v134.bounceCount
                }
            }
        } or {
            ["state"] = v134,
            ["events"] = {}
        }
    end
    local v135 = table.clone(p130)
    v135.accumulatedTime = p130.accumulatedTime + p133
    local v136, v137
    if v135.accumulatedTime > 0.1 then
        v135.accumulatedTime = 0.1
        v136 = 0
        v137 = {}
    else
        v136 = 0
        v137 = {}
    end
    while v135.accumulatedTime >= 0.0078125 and v136 < 16 do
        v136 = v136 + 1
        v135.accumulatedTime = v135.accumulatedTime - 0.0078125
        local v138
        v135, v138 = v_u_1.step(v135, p131, p132, 0.0078125)
        if v138 then
            table.insert(v137, v138)
        end
        if v135.isAtRest then
            break
        end
    end
    return {
        ["state"] = v135,
        ["events"] = v137
    }
end
function v_u_1.calculateThrowParameters(p139, p140, p141, p142)
    local v143 = p141 == "Near"
    local v144 = (v143 and 0.04 or 0.06) * math.clamp(p142, 0.8, 1.2)
    local v145 = 1.35
    local v146 = 2.4
    local v147
    if v143 then
        v145 = v145 * 0.55
        v147 = v146 * 0.8
        v144 = v144 + 0.08
    else
        v147 = v146 + 0.1
    end
    local v148 = (p140 + Vector3.new(0, v144, 0)).Unit
    local v149 = p140.X
    local v150 = p140.Z
    local v151 = Vector3.new(v149, 0, v150)
    return p139 + (v151.Magnitude < 0.01 and Vector3.new(0, 0, -1) or v151).Unit * v145 + Vector3.new(0, v147, 0), v148
end
function v_u_1.interpolateState(p152, p153, p154)
    local v155 = table.clone(p153)
    v155.position = p152.position:Lerp(p153.position, p154)
    v155.velocity = p152.velocity:Lerp(p153.velocity, p154)
    v155.angularVelocity = p152.angularVelocity:Lerp(p153.angularVelocity, p154)
    return v155
end
return v_u_1