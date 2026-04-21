-- ToggleSprint 4.1 (single-player)
--
-- Tap Shift mentre cammini   -> sprint latched ON
-- Release Shift mentre sprinti -> sprint OFF
-- Stop di movimento          -> sprint auto-cancellato
-- Hold Shift "lungo"         -> hold-to-sprint nativo (invariato)
--
-- Shift non e' bindabile via UE4SS RegisterKeyBind (ne' VK 16/160/161 ne'
-- come Key.* enum). Detection via MovementIntention.bWantSprint che il
-- gioco scrive sui press/release. In active mode overridiamo bit=true ogni
-- frame per mantenere lo sprint dopo il release dello Shift; ignoriamo i
-- rising edge (sarebbero falsi positivi del nostro override) e usiamo SOLO
-- il falling edge come "stop intent" (qualunque release di Shift mentre
-- sprinti = volonta' di togglare off).

local TAP_THRESHOLD = 0.3
local MIN_SPEED_SQ = 2500

local active = false
local pressTime = nil
local lastBit = false

RegisterHook("/Script/R5.R5MovementComponent:ServerSaveMoveInput",
    function(self, Forward, Right)
        local mv = self:get()
        local f = Forward:get()
        local r = Right:get()
        local int = mv.MovementIntention
        local bit = int.bWantSprint
        local v = mv.Velocity
        local speedSq = v.X * v.X + v.Y * v.Y
        local moving = (f ~= 0 or r ~= 0)
        local now = os.clock()

        if active then
            if (not bit) and lastBit then
                active = false
                int.bWantSprint = false
                pressTime = nil
            end
        else
            if bit and not lastBit then
                pressTime = now
            elseif (not bit) and lastBit then
                if pressTime then
                    local dur = now - pressTime
                    pressTime = nil
                    if dur < TAP_THRESHOLD and speedSq >= MIN_SPEED_SQ then
                        active = true
                        int.bWantSprint = true
                        int.bWantWalk = false
                    end
                end
            end
        end

        lastBit = int.bWantSprint

        if active then
            if not moving then
                active = false
                int.bWantSprint = false
                lastBit = false
            else
                int.bWantSprint = true
                lastBit = true
            end
        end
    end)

RegisterHook("/Script/Engine.PlayerController:ClientRestart", function()
    active = false
    pressTime = nil
    lastBit = false
end)

print("[ToggleSprint 4.1] loaded")
