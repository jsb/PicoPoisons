function PicoPoisons_Init()
    -- modify enchant icons to add a counter label
    for i = 1, 2 do
        local enchantButton = getglobal("TempEnchant" .. i)
        local label = enchantButton:CreateFontString(enchantButton:GetName() .. "ChargesLabel", "ARTWORK", "NumberFontNormal")
        label:SetPoint("BOTTOMLEFT", enchantButton, "BOTTOMLEFT", 1, 1)
        label:Hide()
    end
    
    -- hook BuffFrame_Enchant functions
    PicoPoisons_Old_BuffFrame_Enchant_OnUpdate = BuffFrame_Enchant_OnUpdate
    BuffFrame_Enchant_OnUpdate = PicoPoisons_BuffFrame_Enchant_OnUpdate
end

function PicoPoisons_BuffFrame_Enchant_OnUpdate(elapsed)
    -- original functionality
    PicoPoisons_Old_BuffFrame_Enchant_OnUpdate(elapsed)
    
    local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo()
    local buttonIndex = 1
    if hasOffHandEnchant then
        local chargesLabel = getglobal("TempEnchant" .. buttonIndex .. "ChargesLabel")
        chargesLabel:SetText(offHandCharges)
        if offHandCharges > 0 then
            chargesLabel:Show()
        else
            chargesLabel:Hide()
        end
        buttonIndex = buttonIndex + 1
    end
    if hasMainHandEnchant then
        local chargesLabel = getglobal("TempEnchant" .. buttonIndex .. "ChargesLabel")
        chargesLabel:SetText(mainHandCharges)
        if mainHandCharges > 0 then
            chargesLabel:Show()
        else
            chargesLabel:Hide()
        end
        buttonIndex = buttonIndex + 1
    end
end

PicoPoisons_Init()
