local v_u_1 = game:GetService("CollectionService")
function observeTag(p_u_2, p_u_3, p_u_4)
    local v_u_5 = {}
    local v_u_6 = {}
    local v_u_7 = nil
    local function v_u_32(p_u_8)
        if not v_u_7.Connected then
            return
        end
        if v_u_5[p_u_8] ~= nil then
            return
        end
        v_u_5[p_u_8] = "__dead__"
        v_u_6[p_u_8] = p_u_8.AncestryChanged:Connect(function()
            local v_u_9 = p_u_8
            local v10
            if p_u_4 == nil then
                v10 = true
                ::l3::
                if v10 then
                    if v_u_5[v_u_9] == "__dead__" then
                        v_u_5[v_u_9] = "__inflight__"
                        task.defer(function()
                            if v_u_5[v_u_9] == "__inflight__" then
                                local v14, v15 = xpcall(function(p11)
                                    local v12 = p_u_3(p11)
                                    if v12 ~= nil then
                                        local v13 = typeof(v12) == "function"
                                        assert(v13, "callback must return a function or nil")
                                    end
                                    return v12
                                end, debug.traceback, v_u_9)
                                if v14 then
                                    if v_u_5[v_u_9] == "__inflight__" then
                                        v_u_5[v_u_9] = v15
                                    elseif v15 ~= nil then
                                        task.spawn(v15)
                                        return
                                    end
                                else
                                    local v16 = string.split(v15, "\n")[1]
                                    local v17 = string.find(v16, ": ")
                                    local v18 = not v17 and "" or v16:sub(v17 + 1)
                                    warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(p_u_2, v18, v15)))
                                end
                            else
                                return
                            end
                        end)
                        return
                    end
                else
                    local v19 = v_u_5[v_u_9]
                    v_u_5[v_u_9] = "__dead__"
                    if typeof(v19) == "function" then
                        task.spawn(v19)
                    end
                end
                return
            else
                for _, v20 in p_u_4 do
                    if v_u_9:IsDescendantOf(v20) then
                        v10 = true
                        goto l3
                    end
                end
                v10 = false
                goto l3
            end
        end)
        local v21
        if p_u_4 == nil then
            v21 = true
            ::l7::
            if v21 then
                if v_u_5[p_u_8] == "__dead__" then
                    v_u_5[p_u_8] = "__inflight__"
                    task.defer(function()
                        if v_u_5[p_u_8] == "__inflight__" then
                            local v25, v26 = xpcall(function(p22)
                                local v23 = p_u_3(p22)
                                if v23 ~= nil then
                                    local v24 = typeof(v23) == "function"
                                    assert(v24, "callback must return a function or nil")
                                end
                                return v23
                            end, debug.traceback, p_u_8)
                            if v25 then
                                if v_u_5[p_u_8] == "__inflight__" then
                                    v_u_5[p_u_8] = v26
                                elseif v26 ~= nil then
                                    task.spawn(v26)
                                    return
                                end
                            else
                                local v27 = string.split(v26, "\n")[1]
                                local v28 = string.find(v27, ": ")
                                local v29 = not v28 and "" or v27:sub(v28 + 1)
                                warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(p_u_2, v29, v26)))
                            end
                        else
                            return
                        end
                    end)
                    return
                end
            else
                local v30 = v_u_5[p_u_8]
                v_u_5[p_u_8] = "__dead__"
                if typeof(v30) == "function" then
                    task.spawn(v30)
                end
            end
            return
        else
            for _, v31 in p_u_4 do
                if p_u_8:IsDescendantOf(v31) then
                    v21 = true
                    goto l7
                end
            end
            v21 = false
            goto l7
        end
    end
    v_u_7 = v_u_1:GetInstanceAddedSignal(p_u_2):Connect(v_u_32)
    local v_u_36 = v_u_1:GetInstanceRemovedSignal(p_u_2):Connect(function(p33)
        local v34 = v_u_5[p33]
        v_u_5[p33] = "__dead__"
        if typeof(v34) == "function" then
            task.spawn(v34)
        end
        local v35 = v_u_6[p33]
        if v35 then
            v35:Disconnect()
            v_u_6[p33] = nil
        end
        v_u_5[p33] = nil
    end)
    task.defer(function()
        if v_u_7.Connected then
            for _, v37 in v_u_1:GetTagged(p_u_2) do
                task.spawn(v_u_32, v37)
            end
        end
    end)
    return function()
        v_u_7:Disconnect()
        v_u_36:Disconnect()
        local v38 = next(v_u_5)
        while v38 do
            local v39 = v_u_5[v38]
            v_u_5[v38] = "__dead__"
            if typeof(v39) == "function" then
                task.spawn(v39)
            end
            local v40 = v_u_6[v38]
            if v40 then
                v40:Disconnect()
                v_u_6[v38] = nil
            end
            v_u_5[v38] = nil
            v38 = next(v_u_5)
        end
    end
end
return observeTag