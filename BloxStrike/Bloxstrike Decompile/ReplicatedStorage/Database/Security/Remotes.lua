local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.ByteNet)
local v_u_3 = require(script.DefinePacket)
return table.freeze({
    ["Collaborations"] = v_u_2.DefineNamespace("Collaborations", function()
        local v4 = {
            ["ClaimExclusiveMedalReward"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RefreshMedalStatus"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }), {
                ["maximum_requests_per_second"] = 0.2
            })
        }
        return v4
    end),
    ["PlayerData"] = v_u_2.DefineNamespace("PlayerData", function()
        local v5 = {
            ["RetrieveAllPlayerData"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }))
        }
        local v6 = v_u_3
        local v7 = v_u_2.DefinePacket
        local v8 = {
            ["Value"] = v_u_2.Struct({
                ["Player"] = v_u_2.Instance,
                ["Data"] = v_u_2.Unknown
            })
        }
        v5.PlayerDataEvent = v6(v7(v8))
        local v9 = v_u_3
        local v10 = v_u_2.DefinePacket
        local v11 = {
            ["Value"] = v_u_2.Struct({
                ["Player"] = v_u_2.Instance,
                ["Data"] = v_u_2.Map(v_u_2.String, v_u_2.Unknown)
            })
        }
        v5.PlayerDataChanged = v9(v10(v11))
        return v5
    end),
    ["Player"] = v_u_2.DefineNamespace("Player", function()
        local v12 = {}
        local v13 = v_u_3
        local v14 = v_u_2.DefinePacket
        local v15 = {
            ["Value"] = v_u_2.Struct({
                ["Path"] = v_u_2.String,
                ["Value"] = v_u_2.Unknown
            })
        }
        v12.UpdatePlayerSettings = v13(v14(v15), {
            ["maximum_requests_per_second"] = 3
        })
        v12.UpdateMobileButtons = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Map(v_u_2.String, v_u_2.Unknown)
        }), {
            ["maximum_requests_per_second"] = 3
        })
        v12.BlankRequest = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Float64
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v12.ReportPlayerConnect = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v12.SubmitUserPlatformAnalytics = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v12.AFKTeleport = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        })
        return v12
    end),
    ["VoteKick"] = v_u_2.DefineNamespace("VoteKick", function()
        local v16 = {}
        local v17 = v_u_3
        local v18 = v_u_2.DefinePacket
        local v19 = {
            ["Value"] = v_u_2.Struct({
                ["Amount"] = v_u_2.Uint8,
                ["Voter"] = v_u_2.String
            })
        }
        v16.VoteNo = v17(v18(v19), {
            ["maximum_requests_per_second"] = 1
        })
        local v20 = v_u_3
        local v21 = v_u_2.DefinePacket
        local v22 = {
            ["Value"] = v_u_2.Struct({
                ["Amount"] = v_u_2.Uint8,
                ["Voter"] = v_u_2.String
            })
        }
        v16.VoteYes = v20(v21(v22), {
            ["maximum_requests_per_second"] = 1
        })
        local v23 = v_u_3
        local v24 = v_u_2.DefinePacket
        local v25 = {
            ["Value"] = v_u_2.Struct({
                ["TargetUserId"] = v_u_2.String,
                ["VoterUserId"] = v_u_2.String
            })
        }
        v16.StartVote = v23(v24(v25), {
            ["maximum_requests_per_second"] = 1
        })
        v16.EndVote = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Nothing
        }), {
            ["maximum_requests_per_second"] = 1
        })
        v16.CallVote = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        return v16
    end),
    ["Character"] = v_u_2.DefineNamespace("Character", function()
        local v26 = {
            ["CharacterDamaged"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["CharacterDied"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }))
        }
        local v27 = v_u_3
        local v28 = v_u_2.DefinePacket
        local v29 = {
            ["Value"] = v_u_2.Struct({
                ["Headshot"] = v_u_2.Bool,
                ["Damage"] = v_u_2.Float32
            })
        }
        v26.CharacterFlinch = v27(v28(v29))
        v26.UpdateWalkState = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Bool
        }))
        v26.UpdateCrouchState = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Bool
        }))
        v26.FallDamage = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Float32
        }))
        local v30 = v_u_3
        local v31 = v_u_2.DefinePacket
        local v32 = {
            ["ReliabilityType"] = "Unreliable",
            ["Value"] = v_u_2.Struct({
                ["HorizontalAngle"] = v_u_2.Float32,
                ["VerticalLook"] = v_u_2.Float32
            })
        }
        v26.UpdateLookAngle = v30(v31(v32), {
            ["maximum_requests_per_second"] = 30
        })
        local v33 = v_u_3
        local v34 = v_u_2.DefinePacket
        local v35 = {
            ["ReliabilityType"] = "Unreliable",
            ["Value"] = v_u_2.Struct({
                ["Player"] = v_u_2.Instance,
                ["HorizontalAngle"] = v_u_2.Float32,
                ["VerticalLook"] = v_u_2.Float32
            })
        }
        v26.ReplicateLookAngle = v33(v34(v35))
        return v26
    end),
    ["Sound"] = v_u_2.DefineNamespace("Sound", function()
        local v36 = {}
        local v37 = v_u_3
        local v38 = v_u_2.DefinePacket
        local v39 = {
            ["Value"] = v_u_2.Struct({
                ["Position"] = v_u_2.Optional(v_u_2.Vec3),
                ["Parent"] = v_u_2.Optional(v_u_2.Instance),
                ["Duration"] = v_u_2.Optional(v_u_2.String),
                ["Path"] = v_u_2.Optional(v_u_2.String),
                ["Class"] = v_u_2.String,
                ["Name"] = v_u_2.String
            })
        }
        v36.ReplicateSound = v37(v38(v39), {
            ["maximum_requests_per_second"] = 25
        })
        local v40 = v_u_3
        local v41 = v_u_2.DefinePacket
        local v42 = {
            ["Value"] = v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["Radius"] = v_u_2.Float32
            })
        }
        v36.StopSoundAtPosition = v40(v41(v42))
        return v36
    end),
    ["Store"] = v_u_2.DefineNamespace("Store", function()
        local v43 = {}
        local v44 = v_u_3
        local v45 = v_u_2.DefinePacket
        local v46 = {
            ["Value"] = v_u_2.Struct({
                ["InventoryItem"] = v_u_2.Map(v_u_2.String, v_u_2.Unknown),
                ["CaseId"] = v_u_2.String,
                ["CaseIdentifier"] = v_u_2.String,
                ["DeletedCaseId"] = v_u_2.Optional(v_u_2.String)
            })
        }
        v43.CaseOpened = v44(v45(v46), {
            ["maximum_requests_per_second"] = 1
        })
        v43.CaseOpenDenied = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Struct({})
        }), {
            ["maximum_requests_per_second"] = 1
        })
        local v47 = v_u_3
        local v48 = v_u_2.DefinePacket
        local v49 = {
            ["Value"] = v_u_2.Struct({
                ["CaseIdentifier"] = v_u_2.String,
                ["OpenType"] = v_u_2.String,
                ["CaseId"] = v_u_2.String
            })
        }
        v43.OpenCase = v47(v48(v49), {
            ["maximum_requests_per_second"] = 1
        })
        local v50 = v_u_3
        local v51 = v_u_2.DefinePacket
        local v52 = {
            ["Value"] = v_u_2.Struct({
                ["CaseIdentifier"] = v_u_2.String
            })
        }
        v43.CaseOpenSequenceFinished = v50(v51(v52), {
            ["maximum_requests_per_second"] = 2
        })
        local v53 = v_u_3
        local v54 = v_u_2.DefinePacket
        local v55 = {}
        local v56 = v_u_2.Struct
        local v57 = {}
        local v58 = v_u_2.Array
        local v59 = v_u_2.Struct
        local v60 = {
            ["_id"] = v_u_2.String,
            ["Type"] = v_u_2.String,
            ["Serial"] = v_u_2.Optional(v_u_2.Uint32),
            ["Name"] = v_u_2.String,
            ["Skin"] = v_u_2.String,
            ["Rarity"] = v_u_2.Optional(v_u_2.String),
            ["Float"] = v_u_2.Optional(v_u_2.Float32),
            ["StatTrack"] = v_u_2.Unknown,
            ["IsTradeable"] = v_u_2.Optional(v_u_2.Bool),
            ["NameTag"] = v_u_2.Unknown,
            ["OriginalOwner"] = v_u_2.Optional(v_u_2.String),
            ["Charm"] = v_u_2.Unknown,
            ["Pattern"] = v_u_2.Optional(v_u_2.Uint16)
        }
        local v61 = v_u_2.Optional
        local v62 = v_u_2.Array
        local v63 = v_u_2.Struct
        local v64 = {
            ["Sticker"] = v_u_2.String,
            ["Position"] = v_u_2.Struct({
                ["Rotation"] = v_u_2.Float32,
                ["X"] = v_u_2.Float32,
                ["Y"] = v_u_2.Float32
            })
        }
        v60.Stickers = v61(v62(v63(v64)))
        v60.MetaData = v_u_2.Optional(v_u_2.Struct({
            ["LastTradeAt"] = v_u_2.Optional(v_u_2.String),
            ["CreatedAt"] = v_u_2.Optional(v_u_2.String),
            ["TradeHistory"] = v_u_2.Optional(v_u_2.Array(v_u_2.String)),
            ["OriginalOwner"] = v_u_2.Optional(v_u_2.String),
            ["Owner"] = v_u_2.Optional(v_u_2.String),
            ["Origin"] = v_u_2.Optional(v_u_2.String)
        }))
        v60.__v = v_u_2.Optional(v_u_2.Uint32)
        v57.Items = v58(v59(v60))
        v57.Player = v_u_2.String
        v57.DeletedItemIds = v_u_2.Optional(v_u_2.Array(v_u_2.String))
        v55.Value = v56(v57)
        v43.NewInventoryItem = v53(v54(v55), {
            ["maximum_requests_per_second"] = 8
        })
        local v65 = v_u_3
        local v66 = v_u_2.DefinePacket
        local v67 = {
            ["Value"] = v_u_2.Struct({
                ["RecipientUserId"] = v_u_2.String,
                ["CaseId"] = v_u_2.String
            })
        }
        v43.GiftCase = v65(v66(v67), {
            ["maximum_requests_per_second"] = 1
        })
        local v68 = v_u_3
        local v69 = v_u_2.DefinePacket
        local v70 = {
            ["Value"] = v_u_2.Struct({
                ["CaseId"] = v_u_2.String,
                ["Amount"] = v_u_2.Uint8
            })
        }
        v43.PurchaseCase = v68(v69(v70), {
            ["maximum_requests_per_second"] = 3
        })
        local v71 = v_u_3
        local v72 = v_u_2.DefinePacket
        local v73 = {
            ["Value"] = v_u_2.Struct({
                ["RecipientUserId"] = v_u_2.String,
                ["ProductName"] = v_u_2.String,
                ["ProductType"] = v_u_2.String
            })
        }
        v43.CreateGift = v71(v72(v73), {
            ["maximum_requests_per_second"] = 1
        })
        return v43
    end),
    ["Spectate"] = v_u_2.DefineNamespace("Spectate", function()
        local v74 = {
            ["UpdateCameraCFrame"] = v_u_3(v_u_2.DefinePacket({
                ["ReliabilityType"] = "Unreliable",
                ["Value"] = v_u_2.CFrame
            }), {
                ["maximum_requests_per_second"] = 60
            }),
            ["SetSpectatePerspective"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["SpectatePlayer"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["StartSpectating"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["StopSpectating"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["ReplicateSpectateEvent"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }))
        }
        return v74
    end),
    ["Dashboard"] = v_u_2.DefineNamespace("Dashboard", function()
        local v75 = {
            ["MissionCompleted"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RedeemCode"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }), {
                ["maximum_requests_per_second"] = 1
            }),
            ["RedeemLikeAndFavoriteReward"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }), {
                ["maximum_requests_per_second"] = 1
            })
        }
        return v75
    end),
    ["Map"] = v_u_2.DefineNamespace("Map", function()
        local v76 = {
            ["SubmitMapVote"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["StartMapVote"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Array(v_u_2.String)
            })),
            ["UpdateMapVote"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Map(v_u_2.String, v_u_2.Uint8)
            })),
            ["EndMapVote"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["RequestMapVote"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }))
        }
        return v76
    end),
    ["Match"] = v_u_2.DefineNamespace("Match", function()
        local v77 = {}
        local v78 = v_u_3
        local v79 = v_u_2.DefinePacket
        local v80 = {}
        local v81 = v_u_2.Struct
        local v82 = {
            ["WinningTeam"] = v_u_2.String,
            ["CTScore"] = v_u_2.Uint16,
            ["TScore"] = v_u_2.Uint16
        }
        local v83 = v_u_2.Map
        local v84 = v_u_2.String
        local v85 = v_u_2.Struct
        local v86 = {
            ["Team"] = v_u_2.String,
            ["ADR"] = v_u_2.Float32,
            ["Kills"] = v_u_2.Uint16,
            ["Deaths"] = v_u_2.Uint16,
            ["Assists"] = v_u_2.Uint16,
            ["Score"] = v_u_2.Uint16,
            ["Headshots"] = v_u_2.Uint16,
            ["Accolade"] = v_u_2.String,
            ["ExperienceEarned"] = v_u_2.Optional(v_u_2.Uint32),
            ["Weapon"] = v_u_2.Optional(v_u_2.Struct({
                ["Name"] = v_u_2.String,
                ["Skin"] = v_u_2.String,
                ["Float"] = v_u_2.Float32,
                ["StatTrack"] = v_u_2.Unknown,
                ["NameTag"] = v_u_2.Unknown
            })),
            ["Gloves"] = v_u_2.Optional(v_u_2.Struct({
                ["Name"] = v_u_2.String,
                ["Skin"] = v_u_2.String,
                ["Float"] = v_u_2.Float32
            }))
        }
        local v87 = v_u_2.Optional
        local v88 = v_u_2.Array
        local v89 = v_u_2.Struct
        local v90 = {
            ["type"] = v_u_2.String,
            ["amount"] = v_u_2.Optional(v_u_2.Uint32),
            ["inventoryItem"] = v_u_2.Optional(v_u_2.Struct({
                ["_id"] = v_u_2.String,
                ["Name"] = v_u_2.String,
                ["Skin"] = v_u_2.Optional(v_u_2.String),
                ["Rarity"] = v_u_2.String,
                ["Type"] = v_u_2.String,
                ["Float"] = v_u_2.Optional(v_u_2.Float32),
                ["Serial"] = v_u_2.Optional(v_u_2.Uint32),
                ["Pattern"] = v_u_2.Optional(v_u_2.Uint16),
                ["StatTrack"] = v_u_2.Unknown,
                ["NameTag"] = v_u_2.Unknown,
                ["Charm"] = v_u_2.Unknown,
                ["IsTradeable"] = v_u_2.Optional(v_u_2.Bool),
                ["Stickers"] = v_u_2.Optional(v_u_2.Unknown),
                ["MetaData"] = v_u_2.Optional(v_u_2.Unknown)
            }))
        }
        v86.LevelRewards = v87(v88(v89(v90)))
        v82.Players = v83(v84, v85(v86))
        v80.Value = v81(v82)
        v77.EndScreen = v78(v79(v80))
        return v77
    end),
    ["Inventory"] = v_u_2.DefineNamespace("Inventory", function()
        local v91 = {
            ["RemoveInventoryItem"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }))
        }
        local v92 = v_u_3
        local v93 = v_u_2.DefinePacket
        local v94 = {}
        local v95 = v_u_2.Struct
        local v96 = {
            ["customProperties"] = v_u_2.Optional(v_u_2.Map(v_u_2.String, v_u_2.Unknown)),
            ["OriginalOwner"] = v_u_2.Optional(v_u_2.String),
            ["StatTrack"] = v_u_2.Unknown,
            ["NameTag"] = v_u_2.Unknown,
            ["Charm"] = v_u_2.Unknown,
            ["Float"] = v_u_2.Float32,
            ["identifier"] = v_u_2.String,
            ["shouldEquip"] = v_u_2.Optional(v_u_2.Bool),
            ["weapon"] = v_u_2.String,
            ["skin"] = v_u_2.String,
            ["slot"] = v_u_2.Uint8,
            ["_id"] = v_u_2.String
        }
        local v97 = v_u_2.Array
        local v98 = v_u_2.Struct
        local v99 = {
            ["Sticker"] = v_u_2.String,
            ["Position"] = v_u_2.Struct({
                ["X"] = v_u_2.Float32,
                ["Y"] = v_u_2.Float32,
                ["Rotation"] = v_u_2.Float32
            })
        }
        v96.Stickers = v97(v98(v99))
        v94.Value = v95(v96)
        v91.NewInventoryItem = v92(v93(v94))
        local v100 = v_u_3
        local v101 = v_u_2.DefinePacket
        local v102 = {
            ["Value"] = v_u_2.Struct({
                ["Player"] = v_u_2.Instance,
                ["Identifier"] = v_u_2.String,
                ["StatTrack"] = v_u_2.Uint32
            })
        }
        v91.UpdateStatTrack = v100(v101(v102))
        v91.CleanupGameLoadout = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Nothing
        }))
        local v103 = v_u_3
        local v104 = v_u_2.DefinePacket
        local v105 = {}
        local v106 = v_u_2.Array
        local v107 = v_u_2.Struct
        local v108 = {
            ["_items"] = v_u_2.Array(v_u_2.Struct({
                ["Identifier"] = v_u_2.String
            })),
            ["_settings"] = v_u_2.Struct({
                ["_strict_slot_space"] = v_u_2.Uint8,
                ["_strict_type"] = v_u_2.String
            })
        }
        v105.Value = v106(v107(v108))
        v91.CreateGameLoadout = v103(v104(v105))
        v91.RequestSpectatedPlayerInventory = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Instance
        }))
        local v109 = v_u_3
        local v110 = v_u_2.DefinePacket
        local v111 = {}
        local v112 = v_u_2.Struct
        local v113 = {
            ["Player"] = v_u_2.Instance
        }
        local v114 = v_u_2.Array
        local v115 = v_u_2.Struct
        local v116 = {}
        local v117 = v_u_2.Array
        local v118 = v_u_2.Struct
        local v119 = {
            ["Identifier"] = v_u_2.String,
            ["Name"] = v_u_2.String,
            ["Slot"] = v_u_2.Uint8,
            ["Properties"] = v_u_2.Struct({
                ["Class"] = v_u_2.String,
                ["Icon"] = v_u_2.String,
                ["Slot"] = v_u_2.String
            })
        }
        v116._items = v117(v118(v119))
        v116._settings = v_u_2.Struct({
            ["_strict_slot_space"] = v_u_2.Uint8,
            ["_strict_type"] = v_u_2.String
        })
        v113.Inventory = v114(v115(v116))
        v113.EquippedSlot = v_u_2.Uint8
        v113.EquippedSlotSpace = v_u_2.Uint8
        v111.Value = v112(v113)
        v91.SpectatedPlayerInventory = v109(v110(v111))
        local v120 = v_u_3
        local v121 = v_u_2.DefinePacket
        local v122 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["PreviousIdentifier"] = v_u_2.Optional(v_u_2.String)
            })
        }
        v91.WeaponEquipped = v120(v121(v122), {
            ["maximum_requests_per_second"] = 0
        })
        local v123 = v_u_3
        local v124 = v_u_2.DefinePacket
        local v125 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["Equipment"] = v_u_2.Bool
            })
        }
        v91.ReturnBuyMenuPurchase = v123(v124(v125))
        local v126 = v_u_3
        local v127 = v_u_2.DefinePacket
        local v128 = {
            ["Value"] = v_u_2.Struct({
                ["Name"] = v_u_2.String,
                ["Equipment"] = v_u_2.Bool,
                ["Path"] = v_u_2.String
            })
        }
        v91.BuyMenuPurchase = v126(v127(v128), {
            ["maximum_requests_per_second"] = 3
        })
        local v129 = v_u_3
        local v130 = v_u_2.DefinePacket
        local v131 = {
            ["Value"] = v_u_2.Struct({
                ["Identity"] = v_u_2.String
            })
        }
        v91.PickupWeapon = v129(v130(v131), {
            ["maximum_requests_per_second"] = 3
        })
        local v132 = v_u_3
        local v133 = v_u_2.DefinePacket
        local v134 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["Direction"] = v_u_2.Vec3
            })
        }
        v91.DropWeapon = v132(v133(v134), {
            ["maximum_requests_per_second"] = 5
        })
        v91.UpdateScopeIncrement = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Uint8
        }), {
            ["maximum_requests_per_second"] = 10
        })
        local v135 = v_u_3
        local v136 = v_u_2.DefinePacket
        local v137 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["State"] = v_u_2.Bool
            })
        }
        v91.UpdateWeaponSuppressor = v135(v136(v137))
        local v138 = v_u_3
        local v139 = v_u_2.DefinePacket
        local v140 = {
            ["Value"] = v_u_2.Struct({
                ["WeaponId"] = v_u_2.String,
                ["CharmId"] = v_u_2.String,
                ["Position"] = v_u_2.String
            })
        }
        v91.UpdateWeaponCharm = v138(v139(v140))
        local v141 = v_u_3
        local v142 = v_u_2.DefinePacket
        local v143 = {
            ["Value"] = v_u_2.Struct({
                ["WeaponId"] = v_u_2.String
            })
        }
        v91.RemoveWeaponCharm = v141(v142(v143))
        local v144 = v_u_3
        local v145 = v_u_2.DefinePacket
        local v146 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["Rounds"] = v_u_2.Uint16,
                ["Capacity"] = v_u_2.Uint16
            })
        }
        v91.ReloadWeapon = v144(v145(v146))
        local v147 = v_u_3
        local v148 = v_u_2.DefinePacket
        local v149 = {}
        local v150 = v_u_2.Struct
        local v151 = {
            ["ShootingHand"] = v_u_2.String,
            ["Identifier"] = v_u_2.String,
            ["Rounds"] = v_u_2.Uint16,
            ["Capacity"] = v_u_2.Uint16,
            ["IsSniperScoped"] = v_u_2.Bool
        }
        local v152 = v_u_2.Array
        local v153 = v_u_2.Struct
        local v154 = {
            ["Direction"] = v_u_2.Vec3,
            ["Origin"] = v_u_2.Vec3,
            ["Hits"] = v_u_2.Array(v_u_2.Struct({
                ["Instance"] = v_u_2.Instance,
                ["Position"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3,
                ["Material"] = v_u_2.String,
                ["Distance"] = v_u_2.Float32,
                ["Exit"] = v_u_2.Bool
            }))
        }
        v151.Bullets = v152(v153(v154))
        v149.Value = v150(v151)
        v91.ShootWeapon = v147(v148(v149), {
            ["maximum_requests_per_second"] = 20
        })
        v91.CreateMagazine = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }), {
            ["maximum_requests_per_second"] = 1
        })
        local v155 = v_u_3
        local v156 = v_u_2.DefinePacket
        local v157 = {
            ["Value"] = v_u_2.Struct({
                ["Identifier"] = v_u_2.String,
                ["Direction"] = v_u_2.Vec3,
                ["Position"] = v_u_2.Vec3,
                ["Animation"] = v_u_2.String,
                ["CharacterVelocity"] = v_u_2.Vec3,
                ["IsCrouching"] = v_u_2.Bool
            })
        }
        v91.ThrowGrenade = v155(v156(v157), {
            ["maximum_requests_per_second"] = 1
        })
        local v158 = v_u_3
        local v159 = v_u_2.DefinePacket
        local v160 = {
            ["Value"] = v_u_2.Struct({
                ["Type"] = v_u_2.String,
                ["Slot"] = v_u_2.Uint8,
                ["Team"] = v_u_2.String,
                ["Identifier"] = v_u_2.String
            })
        }
        v91.EquipLoadoutSkin = v158(v159(v160), {
            ["maximum_requests_per_second"] = 5
        })
        local v161 = v_u_3
        local v162 = v_u_2.DefinePacket
        local v163 = {
            ["Value"] = v_u_2.Struct({
                ["Type"] = v_u_2.String,
                ["SlotOne"] = v_u_2.Uint8,
                ["SlotTwo"] = v_u_2.Uint8,
                ["Team"] = v_u_2.String
            })
        }
        v91.SwapLoadoutSkins = v161(v162(v163), {
            ["maximum_requests_per_second"] = 5
        })
        local v164 = v_u_3
        local v165 = v_u_2.DefinePacket
        local v166 = {
            ["Value"] = v_u_2.Struct({
                ["Path"] = v_u_2.String,
                ["Team"] = v_u_2.String,
                ["Identifier"] = v_u_2.String
            })
        }
        v91.EquipSpecialItem = v164(v165(v166), {
            ["maximum_requests_per_second"] = 5
        })
        v91.LoadoutResponse = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Bool
        }))
        return v91
    end),
    ["Projectile"] = v_u_2.DefineNamespace("Projectile", function()
        local v167 = {}
        local v168 = v_u_3
        local v169 = v_u_2.DefinePacket
        local v170 = {}
        local v171 = v_u_2.Struct
        local v172 = {
            ["Id"] = v_u_2.String,
            ["Weapon"] = v_u_2.String,
            ["Skin"] = v_u_2.String,
            ["Float"] = v_u_2.Float32,
            ["StatTrack"] = v_u_2.Unknown,
            ["NameTag"] = v_u_2.Unknown,
            ["Charm"] = v_u_2.Unknown
        }
        local v173 = v_u_2.Array
        local v174 = v_u_2.Struct
        local v175 = {
            ["Sticker"] = v_u_2.String,
            ["Position"] = v_u_2.Struct({
                ["X"] = v_u_2.Float32,
                ["Y"] = v_u_2.Float32,
                ["Rotation"] = v_u_2.Float32
            })
        }
        v172.Stickers = v173(v174(v175))
        v172.State = v_u_2.Struct({
            ["Position"] = v_u_2.Vec3,
            ["Velocity"] = v_u_2.Vec3,
            ["StartTime"] = v_u_2.Optional(v_u_2.Float64),
            ["IsJumpThrow"] = v_u_2.Bool
        })
        v172.Physics = v_u_2.Struct({
            ["Gravity"] = v_u_2.Vec3,
            ["Drag"] = v_u_2.Float32,
            ["Restitution"] = v_u_2.Float32,
            ["Radius"] = v_u_2.Float32,
            ["MaxBounces"] = v_u_2.Uint8,
            ["FuseTime"] = v_u_2.Float32,
            ["Step"] = v_u_2.Float32,
            ["RestVelocityThreshold"] = v_u_2.Float32,
            ["CollisionGroup"] = v_u_2.String
        })
        v170.Value = v171(v172)
        v167.Spawn = v168(v169(v170))
        local v176 = v_u_3
        local v177 = v_u_2.DefinePacket
        local v178 = {
            ["Value"] = v_u_2.Struct({
                ["Id"] = v_u_2.String,
                ["Grenade"] = v_u_2.String,
                ["Position"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3,
                ["Reason"] = v_u_2.String
            })
        }
        v167.Resolve = v176(v177(v178))
        local v179 = v_u_3
        local v180 = v_u_2.DefinePacket
        local v181 = {
            ["Value"] = v_u_2.Struct({
                ["Id"] = v_u_2.String,
                ["BounceIndex"] = v_u_2.Uint8,
                ["Position"] = v_u_2.Vec3,
                ["Velocity"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3,
                ["Timestamp"] = v_u_2.Float64
            })
        }
        v167.Bounce = v179(v180(v181))
        return v167
    end),
    ["VFX"] = v_u_2.DefineNamespace("VFX", function()
        local v182 = {}
        local v183 = v_u_3
        local v184 = v_u_2.DefinePacket
        local v185 = {
            ["Value"] = v_u_2.Struct({
                ["DirectionMultiplier"] = v_u_2.Float32,
                ["Character"] = v_u_2.Instance,
                ["Direction"] = v_u_2.Vec3,
                ["Weapon"] = v_u_2.String,
                ["Part"] = v_u_2.String
            })
        }
        v182.CreateRagdoll = v183(v184(v185), {
            ["maximum_requests_per_second"] = 5
        })
        local v186 = v_u_3
        local v187 = v_u_2.DefinePacket
        local v188 = {
            ["Value"] = v_u_2.Struct({
                ["Suppressor"] = v_u_2.Optional(v_u_2.String),
                ["ShootingHand"] = v_u_2.String,
                ["PlayerName"] = v_u_2.String,
                ["WeaponName"] = v_u_2.String
            })
        }
        v182.CreateCharacterMuzzleFlash = v186(v187(v188), {
            ["maximum_requests_per_second"] = 25
        })
        local v189 = v_u_3
        local v190 = v_u_2.DefinePacket
        local v191 = {
            ["Value"] = v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["Direction"] = v_u_2.Vec3
            })
        }
        v182.CreateBloodSplatter = v189(v190(v191), {
            ["maximum_requests_per_second"] = 0
        })
        local v192 = v_u_3
        local v193 = v_u_2.DefinePacket
        local v194 = {
            ["Value"] = v_u_2.Struct({
                ["Instance"] = v_u_2.Instance,
                ["Material"] = v_u_2.String,
                ["Position"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3,
                ["Exit"] = v_u_2.Bool,
                ["Ricochet"] = v_u_2.Bool,
                ["AttackerUserId"] = v_u_2.Optional(v_u_2.Int32)
            })
        }
        v182.CreateImpact = v192(v193(v194), {
            ["maximum_requests_per_second"] = 25
        })
        local v195 = v_u_3
        local v196 = v_u_2.DefinePacket
        local v197 = {
            ["Value"] = v_u_2.Struct({
                ["Instance"] = v_u_2.Instance,
                ["Type"] = v_u_2.String,
                ["Position"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3
            })
        }
        v182.CreateMarker = v195(v196(v197), {
            ["maximum_requests_per_second"] = 25
        })
        local v198 = v_u_3
        local v199 = v_u_2.DefinePacket
        local v200 = {
            ["Value"] = v_u_2.Struct({
                ["Distance"] = v_u_2.Float32,
                ["Origin"] = v_u_2.Vec3,
                ["Target"] = v_u_2.Vec3
            })
        }
        v182.CreateTracer = v198(v199(v200), {
            ["maximum_requests_per_second"] = 25
        })
        v182.CleanupDebris = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Nothing
        }))
        local v201 = v_u_3
        local v202 = v_u_2.DefinePacket
        local v203 = {
            ["Value"] = v_u_2.Struct({
                ["Instance"] = v_u_2.Instance,
                ["Position"] = v_u_2.Vec3,
                ["Direction"] = v_u_2.Vec3
            })
        }
        v182.BreakGlass = v201(v202(v203), {
            ["maximum_requests_per_second"] = 25
        })
        local v204 = v_u_3
        local v205 = v_u_2.DefinePacket
        local v206 = {}
        local v207 = v_u_2.Struct
        local v208 = {
            ["SmokeId"] = v_u_2.String,
            ["Duration"] = v_u_2.Float32,
            ["DeployTime"] = v_u_2.Float32,
            ["Voxels"] = v_u_2.Array(v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["Size"] = v_u_2.Float32
            })),
            ["Team"] = v_u_2.Optional(v_u_2.String)
        }
        v206.Value = v207(v208)
        v182.CreateVoxelSmoke = v204(v205(v206))
        v182.DestroyVoxelSmoke = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }))
        local v209 = v_u_3
        local v210 = v_u_2.DefinePacket
        local v211 = {
            ["Value"] = v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["Radius"] = v_u_2.Float32,
                ["Duration"] = v_u_2.Float32
            })
        }
        v182.DisruptVoxelSmoke = v209(v210(v211))
        local v212 = v_u_3
        local v213 = v_u_2.DefinePacket
        local v214 = {}
        local v215 = v_u_2.Struct
        local v216 = {
            ["FireId"] = v_u_2.String,
            ["Duration"] = v_u_2.Float32,
            ["Voxels"] = v_u_2.Array(v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["SizeX"] = v_u_2.Float32,
                ["SizeZ"] = v_u_2.Float32,
                ["Normal"] = v_u_2.Vec3
            }))
        }
        v214.Value = v215(v216)
        v182.CreateVoxelFire = v212(v213(v214))
        v182.DestroyVoxelFire = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }))
        local v217 = v_u_3
        local v218 = v_u_2.DefinePacket
        local v219 = {}
        local v220 = v_u_2.Struct
        local v221 = {
            ["FireId"] = v_u_2.String,
            ["Voxels"] = v_u_2.Array(v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["SizeX"] = v_u_2.Float32,
                ["SizeZ"] = v_u_2.Float32,
                ["Normal"] = v_u_2.Vec3
            }))
        }
        v219.Value = v220(v221)
        v182.UpdateVoxelFire = v217(v218(v219))
        local v222 = v_u_3
        local v223 = v_u_2.DefinePacket
        local v224 = {
            ["Value"] = v_u_2.Struct({
                ["Position"] = v_u_2.Vec3,
                ["AttackerUserId"] = v_u_2.Optional(v_u_2.Int32)
            })
        }
        v182.FlashPlayer = v222(v223(v224))
        return v182
    end),
    ["C4"] = v_u_2.DefineNamespace("C4", function()
        local v225 = {
            ["Defused"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["StartDefuse"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["CancelDefuse"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["Planted"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["Start"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["Cancel"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            })),
            ["ForceCancel"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }))
        }
        return v225
    end),
    ["Hostage"] = v_u_2.DefineNamespace("Hostage", function()
        local v226 = {
            ["StartRescue"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["CancelRescue"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            })),
            ["PickedUp"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.Nothing
            }))
        }
        return v226
    end),
    ["Melee"] = v_u_2.DefineNamespace("Melee", function()
        local v227 = {}
        local v228 = v_u_3
        local v229 = v_u_2.DefinePacket
        local v230 = {
            ["Value"] = v_u_2.Struct({
                ["Direction"] = v_u_2.Vec3,
                ["Material"] = v_u_2.String,
                ["Distance"] = v_u_2.Float32,
                ["Instance"] = v_u_2.Instance,
                ["Position"] = v_u_2.Vec3,
                ["Normal"] = v_u_2.Vec3,
                ["MeleeAttack"] = v_u_2.String,
                ["Identifier"] = v_u_2.String
            })
        }
        v227.MeleeAttack = v228(v229(v230), {
            ["maximum_requests_per_second"] = 5
        })
        return v227
    end),
    ["Chat"] = v_u_2.DefineNamespace("Chat", function()
        local v231 = {}
        local v232 = v_u_3
        local v233 = v_u_2.DefinePacket
        local v234 = {
            ["Value"] = v_u_2.Struct({
                ["displayName"] = v_u_2.String,
                ["team"] = v_u_2.String,
                ["message"] = v_u_2.String,
                ["alive"] = v_u_2.Bool,
                ["role"] = v_u_2.Uint8,
                ["verified"] = v_u_2.Bool
            })
        }
        v231.ServerChat = v232(v233(v234))
        local v235 = v_u_3
        local v236 = v_u_2.DefinePacket
        local v237 = {
            ["Value"] = v_u_2.Struct({
                ["displayName"] = v_u_2.String,
                ["team"] = v_u_2.String,
                ["message"] = v_u_2.String,
                ["alive"] = v_u_2.Bool,
                ["role"] = v_u_2.Uint8,
                ["verified"] = v_u_2.Bool
            })
        }
        v231.ServerTeamChat = v235(v236(v237))
        local v238 = v_u_3
        local v239 = v_u_2.DefinePacket
        local v240 = {
            ["Value"] = v_u_2.Struct({
                ["name"] = v_u_2.String,
                ["team"] = v_u_2.String
            })
        }
        v231.ChatTeamJoin = v238(v239(v240))
        local v241 = v_u_3
        local v242 = v_u_2.DefinePacket
        local v243 = {
            ["Value"] = v_u_2.Struct({
                ["params"] = v_u_2.Map(v_u_2.String, v_u_2.Unknown)
            })
        }
        v231.ChatPlayerKilled = v241(v242(v243))
        local v244 = v_u_3
        local v245 = v_u_2.DefinePacket
        local v246 = {
            ["Value"] = v_u_2.Struct({
                ["weaponName"] = v_u_2.Optional(v_u_2.String),
                ["amount"] = v_u_2.String,
                ["source"] = v_u_2.String
            })
        }
        v231.ChatMoneyReward = v244(v245(v246))
        local v247 = v_u_3
        local v248 = v_u_2.DefinePacket
        local v249 = {
            ["Value"] = v_u_2.Struct({
                ["displayName"] = v_u_2.String,
                ["team"] = v_u_2.String,
                ["weaponName"] = v_u_2.String,
                ["skinName"] = v_u_2.String,
                ["rarity"] = v_u_2.String,
                ["statTrak"] = v_u_2.Bool
            })
        }
        v231.ChatCaseOpened = v247(v248(v249))
        local v250 = v_u_3
        local v251 = v_u_2.DefinePacket
        local v252 = {
            ["Value"] = v_u_2.Struct({
                ["name"] = v_u_2.String
            })
        }
        v231.ChatPlayerLeave = v250(v251(v252))
        local v253 = v_u_3
        local v254 = v_u_2.DefinePacket
        local v255 = {
            ["Value"] = v_u_2.Struct({
                ["name"] = v_u_2.String
            })
        }
        v231.ChatPlayerBanned = v253(v254(v255))
        local v256 = v_u_3
        local v257 = v_u_2.DefinePacket
        local v258 = {
            ["Value"] = v_u_2.Struct({
                ["Text"] = v_u_2.String,
                ["Mode"] = v_u_2.Uint8
            })
        }
        v231.ClientChat = v256(v257(v258), {
            ["maximum_requests_per_second"] = 5
        })
        return v231
    end),
    ["UI"] = v_u_2.DefineNamespace("UI", function()
        local v259 = {}
        local v260 = v_u_3
        local v261 = v_u_2.DefinePacket
        local v262 = {
            ["Value"] = v_u_2.Struct({
                ["notificationType"] = v_u_2.String,
                ["text"] = v_u_2.String
            })
        }
        v259.CreateMenuNotification = v260(v261(v262))
        v259.RoundWinner = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.String
        }))
        local v263 = v_u_3
        local v264 = v_u_2.DefinePacket
        local v265 = {
            ["Value"] = v_u_2.Struct({
                ["PlayerName"] = v_u_2.String,
                ["Team"] = v_u_2.String,
                ["Reason"] = v_u_2.String
            })
        }
        v259.RoundMVP = v263(v264(v265))
        local v266 = v_u_3
        local v267 = v_u_2.DefinePacket
        local v268 = {
            ["Value"] = v_u_2.Struct({
                ["Assistor"] = v_u_2.Optional(v_u_2.String),
                ["Skin"] = v_u_2.Optional(v_u_2.String),
                ["Killer"] = v_u_2.String,
                ["Victim"] = v_u_2.String,
                ["Weapon"] = v_u_2.String,
                ["Headshot"] = v_u_2.Bool,
                ["NoScope"] = v_u_2.Optional(v_u_2.Bool),
                ["Smoke"] = v_u_2.Optional(v_u_2.Bool),
                ["Wallbang"] = v_u_2.Optional(v_u_2.Bool),
                ["Blind"] = v_u_2.Optional(v_u_2.Bool),
                ["Jump"] = v_u_2.Optional(v_u_2.Bool),
                ["FlashAssist"] = v_u_2.Optional(v_u_2.Bool),
                ["DeathPosition"] = v_u_2.Optional(v_u_2.Vec3)
            })
        }
        v259.UIPlayerKilled = v266(v267(v268))
        local v269 = v_u_3
        local v270 = v_u_2.DefinePacket
        local v271 = {
            ["Value"] = v_u_2.Struct({
                ["timeLength"] = v_u_2.Float32,
                ["message"] = v_u_2.String,
                ["header"] = v_u_2.String
            })
        }
        v259.ShowNotification = v269(v270(v271))
        v259.CreateDamageIndicator = v_u_3(v_u_2.DefinePacket({
            ["Value"] = v_u_2.Vec3
        }))
        local v272 = v_u_3
        local v273 = v_u_2.DefinePacket
        local v274 = {
            ["Value"] = v_u_2.Struct({
                ["KillerName"] = v_u_2.String,
                ["KillerTeam"] = v_u_2.String,
                ["Weapon"] = v_u_2.String,
                ["Headshot"] = v_u_2.Bool
            })
        }
        v259.ShowDeathCard = v272(v273(v274))
        return v259
    end),
    ["TeamSelection"] = v_u_2.DefineNamespace("TeamSelection", function()
        local v275 = {
            ["SelectTeam"] = v_u_3(v_u_2.DefinePacket({
                ["Value"] = v_u_2.String
            }), {
                ["maximum_requests_per_second"] = 1
            })
        }
        return v275
    end),
    ["Hints"] = v_u_2.DefineNamespace("Hints", function()
        local v276 = {}
        local v277 = v_u_3
        local v278 = v_u_2.DefinePacket
        local v279 = {
            ["Value"] = v_u_2.Struct({
                ["site"] = v_u_2.String,
                ["action"] = v_u_2.String
            })
        }
        v276.BombSiteEntered = v277(v278(v279))
        local v280 = v_u_3
        local v281 = v_u_2.DefinePacket
        local v282 = {
            ["Value"] = v_u_2.Struct({
                ["site"] = v_u_2.String,
                ["action"] = v_u_2.String
            })
        }
        v276.BombSiteExited = v280(v281(v282))
        local v283 = v_u_3
        local v284 = v_u_2.DefinePacket
        local v285 = {
            ["Value"] = v_u_2.Struct({
                ["hintType"] = v_u_2.String
            })
        }
        v276.ClearHint = v283(v284(v285))
        return v276
    end)
})