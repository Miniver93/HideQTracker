local AceGUI = LibStub("AceGUI-3.0")

-- Initialize settings if they don't exist
if not HideQTrackerSettings then
    HideQTrackerSettings = {
        inBattleground = false,
        inRaid = false,
        inParty = false,
        inArena = false,
        inScenario = false,
        isOutdoor = false
    }
end

local frame = AceGUI:Create("Frame")
frame:SetTitle("HideQTracker")
frame:SetStatusText("Settings")
frame:SetWidth(230)
frame:SetHeight(250)
frame:EnableResize(false)
frame:SetLayout("List")
frame:Hide()

-- Table to hold checkboxes
local checkBoxes = {}

-- Function to create CheckBox linked directly to HideQTrackerSettings
local function CreateCheckBox(label, settingKey)
    local checkBox = AceGUI:Create("CheckBox")
    checkBox:SetLabel(label)
    checkBox:SetCallback("OnValueChanged", function(_, _, value)
        HideQTrackerSettings[settingKey] = value
        UpdateObjectiveTrackerVisibility()
    end)
    checkBoxes[settingKey] = checkBox  -- Store checkbox for later updates
    return checkBox
end

-- Create checkboxes without setting their initial values yet
frame:AddChild(CreateCheckBox("Battleground", "inBattleground"))
frame:AddChild(CreateCheckBox("Raid", "inRaid"))
frame:AddChild(CreateCheckBox("Party", "inParty"))
frame:AddChild(CreateCheckBox("Arena", "inArena"))
frame:AddChild(CreateCheckBox("Scenario", "inScenario"))
frame:AddChild(CreateCheckBox("Outdoor", "isOutdoor"))

-- Function to update checkboxes from saved settings
local function UpdateCheckboxesFromSettings()
    for settingKey, checkBox in pairs(checkBoxes) do
        checkBox:SetValue(HideQTrackerSettings[settingKey])
    end
end

-- Slash command for showing the options frame
SLASH_TRACKER1 = '/hideqtracker'
SlashCmdList['TRACKER'] = function ()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

-- Event Frame Setup
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_LOGIN")  -- Ensures settings load on login
EventFrame:RegisterEvent("VARIABLES_LOADED")
EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
EventFrame:RegisterEvent("PLAYER_STARTED_MOVING")

-- Event Handler for updating visibility and syncing UI on login
EventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" or event == "VARIABLES_LOADED" then
        UpdateCheckboxesFromSettings()
    end
    UpdateObjectiveTrackerVisibility()
end)

-- UpdateObjectiveTrackerVisibility function
function UpdateObjectiveTrackerVisibility()
    local watchedQuestsAreVisible = QuestObjectiveTracker.ContentsFrame:IsShown()
    local watchedWorldQuestsAreVisible = WorldQuestObjectiveTracker.ContentsFrame:IsShown()
    local watchedProfessionsAreVisible = ProfessionsRecipeTracker.ContentsFrame:IsShown()
    local inInstance, instanceType = IsInInstance()
    local isOutdoor = IsOutdoors()

    if inInstance and instanceType == "raid" and HideQTrackerSettings.inRaid then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end

    if inInstance and instanceType == "party" and HideQTrackerSettings.inParty then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end

    if inInstance and instanceType == "arena" and HideQTrackerSettings.inArena then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end

    if inInstance and instanceType == "scenario" and HideQTrackerSettings.inScenario then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end

    if inInstance and instanceType == "pvp" and HideQTrackerSettings.inBattleground then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end

    if isOutdoor and HideQTrackerSettings.isOutdoor then
        if watchedQuestsAreVisible then QuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedWorldQuestsAreVisible then WorldQuestObjectiveTracker.Header.MinimizeButton:Click() end
        if watchedProfessionsAreVisible then ProfessionsRecipeTracker.Header.MinimizeButton:Click() end
    end
end
