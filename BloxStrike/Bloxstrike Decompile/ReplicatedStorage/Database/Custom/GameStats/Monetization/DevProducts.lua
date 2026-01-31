local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(v1.Database.Security.Router)
local v_u_4 = v2:IsServer()
local v37 = {
    ["+ 300 Credits"] = {
        ["DevProductId"] = 3470475421,
        ["OnPurchased"] = function(p5)
            local v6 = v_u_4
            assert(v6, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Credits Purchased", p5, 300)
        end
    },
    ["+ 945 Credits"] = {
        ["DevProductId"] = 3470475672,
        ["OnPurchased"] = function(p7)
            local v8 = v_u_4
            assert(v8, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Credits Purchased", p7, 945)
        end
    },
    ["+ 2,700 Credits"] = {
        ["DevProductId"] = 3470475956,
        ["OnPurchased"] = function(p9)
            local v10 = v_u_4
            assert(v10, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Credits Purchased", p9, 2700)
        end
    },
    ["+ 9,500 Credits"] = {
        ["DevProductId"] = 3470476338,
        ["OnPurchased"] = function(p11)
            local v12 = v_u_4
            assert(v12, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Credits Purchased", p11, 9500)
        end
    },
    ["Gift + 300 Credits"] = {
        ["DevProductId"] = 3471346119,
        ["OnPurchased"] = function(p13)
            local v14 = v_u_4
            assert(v14, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Credits", p13, 300)
        end
    },
    ["Gift + 945 Credits"] = {
        ["DevProductId"] = 3471346271,
        ["OnPurchased"] = function(p15)
            local v16 = v_u_4
            assert(v16, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Credits", p15, 945)
        end
    },
    ["Gift + 2,700 Credits"] = {
        ["DevProductId"] = 3471346363,
        ["OnPurchased"] = function(p17)
            local v18 = v_u_4
            assert(v18, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Credits", p17, 2700)
        end
    },
    ["Gift + 9,500 Credits"] = {
        ["DevProductId"] = 3471346492,
        ["OnPurchased"] = function(p19)
            local v20 = v_u_4
            assert(v20, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Credits", p19, 9500)
        end
    },
    ["Purchase Featured Bundle"] = {
        ["DevProductId"] = 3509675180,
        ["OnPurchased"] = function(p21)
            local v22 = v_u_4
            assert(v22, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Purchase Featured Bundle", p21)
        end
    },
    ["M4A1-S | Anodized Red"] = {
        ["DevProductId"] = 3509674752,
        ["OnPurchased"] = function(p23)
            local v24 = v_u_4
            assert(v24, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Purchase Featured Package", p23, "M4A1-S | Anodized Red")
        end
    },
    ["AUG | Anodized Red"] = {
        ["DevProductId"] = 3509674200,
        ["OnPurchased"] = function(p25)
            local v26 = v_u_4
            assert(v26, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Purchase Featured Package", p25, "AUG | Anodized Red")
        end
    },
    ["MP-9 | Anodized Red"] = {
        ["DevProductId"] = 3509673950,
        ["OnPurchased"] = function(p27)
            local v28 = v_u_4
            assert(v28, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Purchase Featured Package", p27, "MP-9 | Anodized Red")
        end
    },
    ["Gift Featured Bundle"] = {
        ["DevProductId"] = 3509675371,
        ["OnPurchased"] = function(p29)
            local v30 = v_u_4
            assert(v30, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Featured Bundle", p29)
        end
    },
    ["Gift M4A1-S | Anodized Red"] = {
        ["DevProductId"] = 3509675670,
        ["OnPurchased"] = function(p31)
            local v32 = v_u_4
            assert(v32, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Featured Package", p31, "M4A1-S | Anodized Red")
        end
    },
    ["Gift AUG | Anodized Red"] = {
        ["DevProductId"] = 3509675934,
        ["OnPurchased"] = function(p33)
            local v34 = v_u_4
            assert(v34, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Featured Package", p33, "AUG | Anodized Red")
        end
    },
    ["Gift MP-9 | Anodized Red"] = {
        ["DevProductId"] = 3509676191,
        ["OnPurchased"] = function(p35)
            local v36 = v_u_4
            assert(v36, "This function should only be called in studio.")
            return v_u_3.broadcastRouter("Gift Featured Package", p35, "MP-9 | Anodized Red")
        end
    }
}
return table.freeze(v37)