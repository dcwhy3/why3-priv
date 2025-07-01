local correctPin = "1234" -- set your PIN here
local lp = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", gui)
local box = Instance.new("TextBox", frame)
local btn = Instance.new("TextButton", frame)
local status = Instance.new("TextLabel", frame)

gui.ResetOnSpawn = false
gui.Name = "PinGui"

frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

box.PlaceholderText = "Enter PIN"
box.Size = UDim2.new(1, -20, 0, 30)
box.Position = UDim2.new(0, 10, 0, 10)
box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.ClearTextOnFocus = false
box.Parent = frame

btn.Text = "Unlock"
btn.Size = UDim2.new(1, -20, 0, 30)
btn.Position = UDim2.new(0, 10, 0, 50)
btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = frame

status.Text = ""
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 90)
status.TextColor3 = Color3.fromRGB(255, 0, 0)
status.TextScaled = true
status.Parent = frame

btn.MouseButton1Click:Connect(function()
    if box.Text == correctPin then
        status.Text = "✅ correct pin, loading..."
        wait(1)
        gui:Destroy()

        -- 🔓 unlocked section: your full exploit GUI goes here

        local sgui = Instance.new("ScreenGui", lp:WaitForChild("PlayerGui"))
        local input = Instance.new("TextBox", sgui)
        local tp = Instance.new("TextButton", sgui)
        local bring = Instance.new("TextButton", sgui)
        local fling = Instance.new("TextButton", sgui)
        local fly = Instance.new("TextButton", sgui)

        sgui.ResetOnSpawn = false
        input.Size = UDim2.new(0, 200, 0, 30)
        input.Position = UDim2.new(0, 10, 0, 10)
        input.PlaceholderText = "player name"

        local function mkbtn(btn, txt, y)
            btn.Text = txt
            btn.Size = UDim2.new(0, 200, 0, 30)
            btn.Position = UDim2.new(0, 10, 0, y)
        end

        mkbtn(tp, "TP To", 0.1)
        mkbtn(bring, "Bring", 0.18)
        mkbtn(fling, "Fling", 0.26)
        mkbtn(fly, "Fly [F]", 0.34)

        tp.MouseButton1Click:Connect(function()
            local p = game.Players:FindFirstChild(input.Text)
            if p and p.Character and lp.Character then
                lp.Character:MoveTo(p.Character:WaitForChild("HumanoidRootPart").Position + Vector3.new(0,5,0))
            end
        end)

        bring.MouseButton1Click:Connect(function()
            local p = game.Players:FindFirstChild(input.Text)
            if p and p.Character and lp.Character then
                p.Character:MoveTo(lp.Character:WaitForChild("HumanoidRootPart").Position + Vector3.new(0,5,0))
            end
        end)

        fling.MouseButton1Click:Connect(function()
            local p = game.Players:FindFirstChild(input.Text)
            if p and p.Character then
                local bv = Instance.new("BodyVelocity", p.Character:WaitForChild("HumanoidRootPart"))
                bv.Velocity = Vector3.new(9999,9999,9999)
                bv.MaxForce = Vector3.new(1e9,1e9,1e9)
                game.Debris:AddItem(bv, 0.2)
            end
        end)

        local flying = false
        local UIS = game:GetService("UserInputService")
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e9,1e9,1e9)
        bv.Velocity = Vector3.zero

        UIS.InputBegan:Connect(function(k)
            if k.KeyCode == Enum.KeyCode.F then
                if flying then
                    bv:Destroy()
                else
                    bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
                    bv.Velocity = Vector3.zero
                    bv.Parent = lp.Character:WaitForChild("HumanoidRootPart")
                end
                flying = not flying
            end
        end)

        game:GetService("RunService").RenderStepped:Connect(function()
            if flying and lp.Character then
                local dir = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir += lp.Character.HumanoidRootPart.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= lp.Character.HumanoidRootPart.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= lp.Character.HumanoidRootPart.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir += lp.Character.HumanoidRootPart.CFrame.RightVector end
                bv.Velocity = dir.Unit * 50
            end
        end)
    else
        status.Text = "❌ wrong pin dumbass"
    end
end)
