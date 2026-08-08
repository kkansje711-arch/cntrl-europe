getgenv().AutoRefreshEnabled = true
local Library = (function()
if getgenv().Library then
    getgenv().Library:Unload()
end

local Library do 
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera
    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new
    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local UDim2FromOffset = UDim2.fromOffset
    local Vector2New = Vector2.new
    local Vector3New = Vector3.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower
    local StringLen = string.len

    local InstanceNew = Instance.new

    local RectNew = Rect.new

    local IsMobile = UserInputService.TouchEnabled or false

    Library = {
        Theme =  { },

        MenuKeybind = tostring(Enum.KeyCode.RightControl), 

        Flags = { },

        Tween = {
            Time = 0.22,
            Style = Enum.EasingStyle.Quart,
            Direction = Enum.EasingDirection.Out
        },

        FadeSpeed = 0.08,

        Folders = {
            Directory = "lds13",
            Configs = "lds13/Configs",
            Assets = "lds13/Assets",
        },

        
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        OpenFrames = { },

        SetFlags = { },

        SearchItems = { },
        CurrentPage = nil,

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        UnusedHolder = nil,

        Font = nil
    }

    Library.__index = Library
    Library.Sections.__index = Library.Sections
    Library.Pages.__index = Library.Pages

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    local Themes = {
        ["Preset"] = {
            ["Background"] = FromRGB(13, 15, 18),
            ["Inline"] = FromRGB(22, 25, 30),
            ["Outline"] = FromRGB(26, 30, 36),
            ["Text"] = FromRGB(200, 200, 200),
            ["Dark Text"] = FromRGB(100, 100, 100),
            ["Element"] = FromRGB(28, 32, 38),
            ["Accent"] = FromRGB(255, 140, 0)
        }
    }

    Library.Theme = TableClone(Themes["Preset"])

    
    local Folders = {
        Directory = "lds13",
        Configs = "lds13/Configs",
        Assets = "lds13/Assets",
    }
    
    for Index, Value in Folders do 
        if not isfolder(Value) then
            makefolder(Value)
        end
    end

    
    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end

        Tween.GetProperty = function(self, Item)
            Item = Item or self.Item 

            if Item:IsA("Frame") then
                return { "BackgroundTransparency" }
            elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif Item:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif Item:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif Item:IsA("UIStroke") then 
                return { "Transparency" }
            end
        end

        Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
            local Item = Item or self.Item 

            local OldTransparency = Item[Property]
            Item[Property] = Visibility and 1 or OldTransparency

            local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
                [Property] = Visibility and OldTransparency or 1
            }, true)

            Library:Connect(NewTween.Tween.Completed, function()
                if not Visibility then 
                    task.wait()
                    Item[Property] = OldTransparency
                end
            end)

            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    
    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.FadeItem = function(self, Visibility, Speed)
            local Item = self.Instance

            if Visibility == true then 
                Item.Visible = true
            end

            local Descendants = Item:GetDescendants()
            TableInsert(Descendants, Item)

            local NewTween

            for Index, Value in Descendants do 
                local TransparencyProperty = Tween:GetProperty(Value)

                if TransparencyProperty then

                if type(TransparencyProperty) == "table" then 
                    for _, Property in TransparencyProperty do 
                        NewTween = Tween:FadeItem(Value, Property, not Visibility, Speed)
                    end
                else
                    NewTween = Tween:FadeItem(Value, TransparencyProperty, not Visibility, Speed)
                end
                end
            end
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            if IsMobile then
                
                
                
                if Event == "MouseButton1Down" or Event == "MouseButton1Click" then
                    if self.Instance:IsA("GuiButton") then
                        Event = "Activated"
                    else
                        Event = "InputBegan"
                    end
                elseif Event == "MouseButton2Down" or Event == "MouseButton2Click" then
                    Event = "TouchLongPress"
                end
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end
        
            local Gui = self.Instance
            local Dragging = false 
            local DragStart
            local StartPosition 
        
            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                local NewX = StartPosition.X.Offset + DragDelta.X
                local NewY = StartPosition.Y.Offset + DragDelta.Y

                local ScreenSize = Gui.Parent.AbsoluteSize
                local GuiSize = Gui.AbsoluteSize
        
                NewX = MathClamp(NewX, 0, ScreenSize.X - GuiSize.X)
                NewY = MathClamp(NewY, 0, ScreenSize.Y - GuiSize.Y)
        
                self:Tween(TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, NewX, 0, NewY)})
            end
        
            local InputChanged
        
            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    DragStart = Input.Position
                    StartPosition = Gui.Position
        
                    if InputChanged then 
                        return
                    end
        
                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)
        
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end)
        
            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local CurrentSide = nil

            local StartMouse = nil 
            local StartPosition = nil 
            local StartSize = nil
            
            local EdgeThickness = 2

            local MakeEdge = function(Name, Position, Size)
                local Button = Instances:Create("TextButton", {
                    Name = "\0",
                    Size = Size,
                    Position = Position,
                    BackgroundColor3 = FromRGB(166, 147, 243),
                    BackgroundTransparency = 1,
                    Text = "",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    Parent = Gui,
                    ZIndex = 99999,
                })  Button:AddToTheme({BackgroundColor3 = "Accent"})

                return Button
            end

            local Edges = {
                {Button = MakeEdge(
                    "Left", 
                    UDim2New(0, 0, 0, 0), 
                    UDim2New(0, EdgeThickness, 1, 0)), 
                    Side = "L"
                },

                {Button = MakeEdge(
                    "Right", 
                    UDim2New(1, -EdgeThickness, 0, 0), 
                    UDim2New(0, EdgeThickness, 1, 0)), 
                    Side = "R"
                },

                {Button = MakeEdge(
                    "Top", UDim2New(0, 0, 0, 0), 
                    UDim2New(1, 0, 0, EdgeThickness)), 
                    Side = "T"
                },

                {Button = MakeEdge(
                    "Bottom", 
                    UDim2New(0, 0, 1, -EdgeThickness), 
                    UDim2New(1, 0, 0, EdgeThickness)), 
                    Side = "B"
                },
            }

            local BeginResizing = function(Side)
                Resizing = true 
                CurrentSide = Side 

                StartMouse = UserInputService:GetMouseLocation()

                
                StartPosition = Vector2New(Gui.Position.X.Offset, Gui.Position.Y.Offset)
                StartSize = Vector2New(Gui.Size.X.Offset, Gui.Size.Y.Offset)
                
                for Index, Value in Edges do 
                    Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
                end
            end

            local EndResizing = function()
                Resizing = false 
                CurrentSide = nil

                for Index, Value in Edges do 
                    Value.Button.Instance.BackgroundTransparency = 1
                end
            end

            for Index, Value in Edges do 
                Value.Button:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        BeginResizing(Value.Side)
                    end
                end)
            end

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Resizing then
                        EndResizing()
                    end
                end
            end)

            Library:Connect(RunService.RenderStepped, function()
                if not Resizing or not CurrentSide then 
                    return 
                end

                local MouseLocation = UserInputService:GetMouseLocation()
                local dx = MouseLocation.X - StartMouse.X
                local dy = MouseLocation.Y - StartMouse.Y
            
                local x, y = StartPosition.X, StartPosition.Y
                local w, h = StartSize.X, StartSize.Y

                if CurrentSide == "L" then
                    x = StartPosition.X + dx
                    w = StartSize.X - dx
                elseif CurrentSide == "R" then
                    w = StartSize.X + dx
                elseif CurrentSide == "T" then
                    y = StartPosition.Y + dy
                    h = StartSize.Y - dy
                elseif CurrentSide == "B" then
                    h = StartSize.Y + dy
                end
            
                if w < Minimum.X then
                    if CurrentSide == "L" then
                        x = x - (Minimum.X - w)
                    end
                    w = Minimum.X
                end
                if h < Minimum.Y then
                    if CurrentSide == "T" then
                        y = y - (Minimum.Y - h)
                    end
                    h = Minimum.Y
                end
            
                self:Tween(TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2FromOffset(x, y)})
                self:Tween(TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2FromOffset(w, h)})
            end)
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if not isfile(Data.Id) then 
                writefile(Data.Id, game:HttpGet(Data.Url))
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = Name,
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Data.Id)
                    }
                }
            }

            writefile(`{Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
            return Font.new(getcustomasset(`{Library.Folders.Assets}/{Name}.font`))
        end

        Library.Font = CustomFont:New("InterSemiBold", 400, "Regular", {
            Id = "InterSemiBold",
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterSemibold.ttf"
        })
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        DisplayOrder = 2,
        ResetOnSpawn = false
    })

    Library.UnusedHolder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        Enabled = false,
        ResetOnSpawn = false
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Size = UDim2New(0, 0, 1, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    })
    
    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        Padding = UDimNew(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Instances:Create("UIPadding", {
        Parent = Library.NotifHolder.Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 12),
        PaddingBottom = UDimNew(0, 12),
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 12)
    })

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            Value.Connection:Disconnect()
        end

        for Index, Value in self.Threads do 
            coroutine.close(Value)
        end

        if self.Holder then 
            self.Holder:Clean()
        end

        Library = nil 
        getgenv().Library = nil
    end

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)
        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("connection_number_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("flag_number_%s_%s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value()
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

	Library.ToRich = function(self, Text, Color)
		return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
	end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = "#" .. Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if SetFunction then

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
                end
            end
        end)

        return Success, Result
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then 
            delfile(Library.Folders.Configs .. "/" .. Config)
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local List = { }
        local ReturnList = { }

        List = listfiles(Library.Folders.Configs)

        for Index = 1, #List do 
            local File = List[Index]

            if File:sub(-5) == ".json" then
                local Position = File:find(".json", 1, true)
                local StartPosition = Position

                local Character = File:sub(Position, Position)
                while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                    Position = Position - 1
                    Character = File:sub(Position, Position)
                end

                if Character == "/" or Character == "\\" then
                    TableInsert(ReturnList, File:sub(Position + 1, StartPosition - 1))
                end
            end
        end

        Element:Refresh(ReturnList)
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                local target
                if type(Value) == "string" and Value == Theme then
                    target = Color
                elseif type(Value) == "function" then
                    target = Value()
                end
                if target ~= nil then
                    local animated = false
                    if typeof(target) == "Color3" then
                        animated = pcall(function()
                            TweenService:Create(Item.Item, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {[Property] = target}):Play()
                        end)
                    end
                    if not animated then Item.Item[Property] = target end
                end
            end
        end
    end

    Library.IsMouseOverFrame = function(self, Frame)
        Frame = Frame.Instance

        local MousePosition = Vector2New(Mouse.X, Mouse.Y)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.Lerp = function(self, Start, Finish, Time)
        return Start + (Finish - Start) * Time
    end

    Library.CompareVectors = function(self, PointA, PointB)
        return (PointA.X < PointB.X) or (PointA.Y < PointB.Y)
    end

    Library.IsClipped = function(self, Object, Column)
        local Parent = Column
        
        local BoundryTop = Parent.AbsolutePosition
        local BoundryBottom = BoundryTop + Parent.AbsoluteSize

        local Top = Object.AbsolutePosition
        local Bottom = Top + Object.AbsoluteSize 

        return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
    end

    do
        Library.CreateColorpicker = function(self, Data)
            local Colorpicker = {
                Flag = Data.Flag, 

                Hue = 0,
                Saturation = 0,
                Value = 0,

                Color = Color3.fromRGB(0, 0, 0),
                HexValue = "",

                IsOpen = false
            }

            local Items = { } do 
                Items["ColorpickerButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 193, 249)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["ColorpickerButton"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(209, 209, 209))}
                })                

                Items["ColorpickerWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 44, 0, 169),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 180, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["ColorpickerWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UIStroke", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    Color = FromRGB(26, 30, 36),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Items["Palette"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2New(0, 8, 0, 8),
                    Size = UDim2New(1, -36, 1, -16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 193, 249)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Saturation"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Saturation"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Value"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 1, 1, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(0, 0, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    Rotation = 90,
                    Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Value"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["PaletteDragger"] = Instances:Create("Frame", {
                    Parent = Items["Palette"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 15, 0, 15),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 8, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(255, 255, 255),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["PaletteDragger"].Instance,
                    Name = "\0"
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Hue"] = Instances:Create("TextButton", {
                    Parent = Items["ColorpickerWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, -8, 0, 8),
                    Size = UDim2New(0, 12, 1, -16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 4)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
                })
                
                Items["HueDragger"] = Instances:Create("Frame", {
                    Parent = Items["Hue"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 12, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0",
                    Color = FromRGB(255, 255, 255),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["HueDragger"].Instance,
                    Name = "\0"
                })
            end

            function Colorpicker:Get()
                return Colorpicker.Color
            end

            function Colorpicker:Update(IsFromAlpha)
                local Hue, Saturation, Value = Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value
                Colorpicker.Color = FromHSV(Hue, Saturation, Value)
                Colorpicker.HexValue = Colorpicker.Color:ToHex()

                Library.Flags[Colorpicker.Flag] = {
                    Color = Colorpicker.Color,
                    HexValue = Colorpicker.HexValue
                }

                Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
                Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Hue, 1, 1)})

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Colorpicker.Color)
                end
            end

            local SlidingPalette = false
            local PaletteChanged
            
            function Colorpicker:SlidePalette(Input)
                if not Input or not SlidingPalette then
                    return
                end

                local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Saturation = ValueX
                Colorpicker.Value = ValueY

                local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.955)
                local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.955)

                Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
                Colorpicker:Update()
            end
            
            local SlidingHue = false
            local HueChanged

            function Colorpicker:SlideHue(Input)
                if not Input or not SlidingHue then
                    return
                end
                
                local ValueY = MathClamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 1)

                Colorpicker.Hue = ValueY

                local SlideY = MathClamp((Input.Position.Y - Items["Hue"].Instance.AbsolutePosition.Y) / Items["Hue"].Instance.AbsoluteSize.Y, 0, 0.955)

                Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, SlideY, 0)})
                Colorpicker:Update()
            end

            local Debounce = false
            local RenderStepped  

            function Colorpicker:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Colorpicker.IsOpen = Bool

                Debounce = true 

                if Colorpicker.IsOpen then 
                    Items["ColorpickerWindow"].Instance.Visible = true
                    Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["ColorpickerWindow"].Instance.Position = UDim2New(
                            0, 
                            Items["ColorpickerButton"].Instance.AbsolutePosition.X, 
                            0, 
                            Items["ColorpickerButton"].Instance.AbsolutePosition.Y + Items["ColorpickerButton"].Instance.AbsoluteSize.Y + 5
                        )
                    end)

                    Items["ColorpickerWindow"]:Tween(nil, {Size = UDim2New(0, 180, 0, 179)})

                    if not Data.Section.IsSettings then
                        for Index, Value in Library.OpenFrames do 
                            if Value ~= Colorpicker then
                                Value:SetOpen(false)
                            end
                        end
                    end

                    Library.OpenFrames[Colorpicker] = Colorpicker 
                else
                    if not Data.Section.IsSettings then
                        if Library.OpenFrames[Colorpicker] then 
                            Library.OpenFrames[Colorpicker] = nil
                        end
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end

                    Items["ColorpickerWindow"]:Tween(nil, {Size = UDim2New(0, 180, 0, 0)})
                end

                local Descendants = Items["ColorpickerWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["ColorpickerWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if TransparencyProperty then

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = (Colorpicker.IsOpen and Data.Section.IsSettings and 9) or (Colorpicker.IsOpen and not Data.Section.IsSettings and 3) or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["ColorpickerWindow"].Instance.Visible = Colorpicker.IsOpen
                    task.wait(0.2)
                    Items["ColorpickerWindow"].Instance.Parent = not Colorpicker.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Colorpicker:Set(Color)
                if type(Color) == "table" then
                    Color = FromRGB(Color[1], Color[2], Color[3])
                elseif type(Color) == "string" then
                    Color = FromHex(Color)
                end 

                Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()

                local PaletteValueX = MathClamp(1 - Colorpicker.Saturation, 0, 0.955)
                local PaletteValueY = MathClamp(1 - Colorpicker.Value, 0, 0.955)
                    
                local HuePositionY = MathClamp(Colorpicker.Hue, 0, 0.955)

                Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PaletteValueX, 0, PaletteValueY, 0)})
                Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, HuePositionY, 0)})
                Colorpicker:Update()
            end

            Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
                Colorpicker:SetOpen(not Colorpicker.IsOpen)
            end)

            Items["Palette"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingPalette = true 

                    Colorpicker:SlidePalette(Input)

                    if PaletteChanged then
                        return
                    end

                    PaletteChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingPalette = false

                            PaletteChanged:Disconnect()
                            PaletteChanged = nil
                        end
                    end)
                end
            end)

            Items["Hue"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    SlidingHue = true 

                    Colorpicker:SlideHue(Input)

                    if HueChanged then
                        return
                    end

                    HueChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            SlidingHue = false

                            HueChanged:Disconnect()
                            HueChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if SlidingPalette then 
                        Colorpicker:SlidePalette(Input)
                    end

                    if SlidingHue then
                        Colorpicker:SlideHue(Input)
                    end
                end
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if not Colorpicker.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) then
                        return
                    end

                    Colorpicker:SetOpen(false)
                end
            end)

            if Data.Default then
                Colorpicker:Set(Data.Default)
            end

            Library.SetFlags[Colorpicker.Flag] = function(Value)
                Colorpicker:Set(Value)
            end

            return Colorpicker, Items 
        end

        Library.CreateKeybind = function(self, Data)
            local Keybind = {
                Flag = Data.Flag,

                Mode = "",
                Value = "",
                Key = "",

                Picking = false,
                Toggled = false,
                IsOpen = false
            }

            local Items = { } do
                Items["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "mb2",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["KeyButton"]:AddToTheme({TextColor3 = "Dark Text"})           
                
                Items["KeybindWindow"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 904, 0, 179),
                    ClipsDescendants = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 67, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["KeybindWindow"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    Color = FromRGB(26, 30, 36),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Instances:Create("UIListLayout", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 3),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Toggle",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Toggle"]:AddToTheme({TextColor3 = "Dark Text"})     
                
                Instances:Create("UIPadding", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 6),
                    PaddingLeft = UDimNew(0, 8)
                })
                
                Items["Hold"] = Instances:Create("TextButton", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Hold",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Hold"]:AddToTheme({TextColor3 = "Dark Text"})     
                
                Items["Always"] = Instances:Create("TextButton", {
                    Parent = Items["KeybindWindow"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "Always",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Always"]:AddToTheme({TextColor3 = "Dark Text"})                
            end

            local Modes = {
                Toggle = Items["Toggle"],
                Hold = Items["Hold"],
                Always = Items["Always"]
            }

            local Debounce = false
            local RenderStepped  

            function Keybind:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Keybind.IsOpen = Bool

                Debounce = true 

                if Keybind.IsOpen then 
                    Items["KeybindWindow"].Instance.Visible = true
                    Items["KeybindWindow"].Instance.Parent = Library.Holder.Instance
                    
                    RenderStepped = RunService.RenderStepped:Connect(function()
                        Items["KeybindWindow"].Instance.Position = UDim2New(
                            0, 
                            Items["KeyButton"].Instance.AbsolutePosition.X, 
                            0, 
                            Items["KeyButton"].Instance.AbsolutePosition.Y + Items["KeyButton"].Instance.AbsoluteSize.Y + 5
                        )
                    end)

                    Items["KeybindWindow"]:Tween(nil, {Size = UDim2New(0, 67, 0, 80)})

                    if not Data.Section.IsSettings then
                        for Index, Value in Library.OpenFrames do 
                            if Value ~= Keybind then
                                Value:SetOpen(false)
                            end
                        end
                    end

                    Library.OpenFrames[Keybind] = Keybind 
                else
                    if not Data.Section.IsSettings then
                        if Library.OpenFrames[Keybind] then 
                            Library.OpenFrames[Keybind] = nil
                        end
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end

                    Items["KeybindWindow"]:Tween(nil, {Size = UDim2New(0, 67, 0, 0)})
                end

                local Descendants = Items["KeybindWindow"].Instance:GetDescendants()
                TableInsert(Descendants, Items["KeybindWindow"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if TransparencyProperty then

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = Keybind.IsOpen and 4 or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["KeybindWindow"].Instance.Visible = Keybind.IsOpen
                    task.wait(0.2)
                    Items["KeybindWindow"].Instance.Parent = not Keybind.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
                end)
            end

            function Keybind:SetMode(Mode)
                for Index, Value in Modes do 
                    if Index == Mode then
                        Value:ChangeItemTheme({TextColor3 = "Text"})
                        Value:Tween(nil, {TextColor3 = Library.Theme.Text})
                    else
                        Value:ChangeItemTheme({TextColor3 = "Dark Text"})
                        Value:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    end
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            function Keybind:Press(Bool)
                if Keybind.Mode == "Toggle" then 
                    Keybind.Toggled = not Keybind.Toggled
                elseif Keybind.Mode == "Hold" then 
                    Keybind.Toggled = Bool
                elseif Keybind.Mode == "Always" then 
                    Keybind.Toggled = true
                end

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            end

            function Keybind:Get()
                return Keybind.Key, Keybind.Mode, Keybind.Toggled
            end

            function Keybind:Set(Key)
                if StringFind(tostring(Key), "Enum") then 
                    Keybind.Key = tostring(Key)

                    Key = Key.Name == "Backspace" and "None" or Key.Name

                    local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                    local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif type(Key) == "table" then
                    local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                    Keybind.Key = tostring(Key.Key)

                    if Key.Mode then
                        Keybind.Mode = Key.Mode
                        Keybind:SetMode(Key.Mode)
                    else
                        Keybind.Mode = "Toggle"
                        Keybind:SetMode("Toggle")
                    end

                    local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                    local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                    TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                    Keybind.Value = TextToDisplay
                    Items["KeyButton"].Instance.Text = TextToDisplay

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                elseif TableFind({"Toggle", "Hold", "Always"}, Key) then
                    Keybind.Mode = Key
                    Keybind:SetMode(Key)

                    if Data.Callback then 
                        Library:SafeCall(Data.Callback, Keybind.Toggled)
                    end
                end

                
                Keybind.Picking = false
            end

            Items["KeyButton"]:Connect("MouseButton1Click", function()
                Keybind.Picking = true 

                Items["KeyButton"].Instance.Text = "Press a key"

                local InputBegan
                InputBegan = UserInputService.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard then 
                        Keybind:Set(Input.KeyCode)
                    else
                        Keybind:Set(Input.UserInputType)
                    end

                    InputBegan:Disconnect()
                    InputBegan = nil
                end)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.Mode == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Toggle" then 
                        Keybind:Press()
                    elseif Keybind.Mode == "Hold" then 
                        Keybind:Press(true)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end

                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Keybind.IsOpen then
                        return
                    end

                    if Library:IsMouseOverFrame(Items["KeybindWindow"]) then
                        return
                    end

                    Keybind:SetOpen(false)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Keybind.Value == "None" then
                    return
                end

                if tostring(Input.KeyCode) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                elseif tostring(Input.UserInputType) == Keybind.Key then
                    if Keybind.Mode == "Hold" then 
                        Keybind:Press(false)
                    elseif Keybind.Mode == "Always" then 
                        Keybind:Press(true)
                    end
                end
            end)

            Items["KeyButton"]:Connect("MouseButton2Down", function()
                Keybind:SetOpen(not Keybind.IsOpen)
            end)

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Toggle"
                Keybind:SetMode("Toggle")
            end)

            Items["Hold"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Hold"
                Keybind:SetMode("Hold")
            end)

            Items["Always"]:Connect("MouseButton1Down", function()
                Keybind.Mode = "Always"
                Keybind:SetMode("Always")
            end)

            if Data.Default then 
                Keybind:Set({
                    Mode = Data.Mode or "Toggle",
                    Key = Data.Default,
                })
            end

            Library.SetFlags[Keybind.Flag] = function(Value)
                Keybind:Set(Value)
            end

            return Keybind, Items 
        end

        Library.Notification = function(self, Name, Icon, Duration)
            Icon = Icon or "90449909165261"
            Name = Name or "Notification"
            Duration = Duration or 5

            
                local Items = { } do
                    Items["Notification"] = Instances:Create("Frame", {
                        Parent = Library.NotifHolder.Instance,
                        Name = "\0",
                        Size = UDim2New(0, 0, 0, 32),
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = FromRGB(13, 15, 18)
                    })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Instances:Create("UICorner", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })
                    
                    Items["Stroke"] = Instances:Create("UIStroke", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        Color = FromRGB(26, 30, 36),
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    })  Items["Stroke"]:AddToTheme({Color = "Outline"})
                    
                    Items["Text"] = Instances:Create("TextLabel", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(200, 200, 200),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = Name,
                        AnchorPoint = Vector2New(0, 0.5),
                        Size = UDim2New(0, 0, 0, 15),
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 24, 0.5, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                    
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        ImageColor3 = FromRGB(200, 200, 200),
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0, 0.5),
                        Image = "rbxassetid://"..Icon,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, 0, 0.5, 0),
                        Size = UDim2New(0, 16, 0, 16),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})
                    
                    Instances:Create("UIPadding", {
                        Parent = Items["Notification"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 8),
                        PaddingBottom = UDimNew(0, 8),
                        PaddingRight = UDimNew(0, 8),
                        PaddingLeft = UDimNew(0, 8)
                    })                
                end

                local Size = Items["Notification"].Instance.AbsoluteSize
                Items["Notification"].Instance.Size = UDim2New(0, 0, 0, 0)
    
                for Index, Value in Items do 
                    if Value.Instance:IsA("Frame") then
                        Value.Instance.BackgroundTransparency = 1
                    elseif Value.Instance:IsA("TextLabel") then 
                        Value.Instance.TextTransparency = 1
                    elseif Value.Instance:IsA("ImageLabel") then 
                        Value.Instance.ImageTransparency = 1
                    elseif Value.Instance:IsA("UIStroke") then
                        Value.Instance.Transparency = 1
                    end
                end 
    
                Items["Notification"].Instance.AutomaticSize = Enum.AutomaticSize.Y
                local Info = TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0)
    
                Library:Thread(function()
                    for Index, Value in Items do 
                        if Value.Instance:IsA("Frame") then
                            Value:Tween(Info, {BackgroundTransparency = 0})
                        elseif Value.Instance:IsA("TextLabel") then 
                            Value:Tween(Info, {TextTransparency = 0})
                        elseif Value.Instance:IsA("ImageLabel") then 
                            Value:Tween(Info, {ImageTransparency = 0})
                        elseif Value.Instance:IsA("UIStroke") then 
                            Value:Tween(Info, {Transparency = 0})
                        end
                    end
    
                    Items["Notification"]:Tween(Info, {Size = UDim2New(0, Size.X, 0, Size.Y)})
    
                    task.delay(Duration + 0.15, function()
                        for Index, Value in Items do 
                            if Value.Instance:IsA("Frame") then
                                Value:Tween(nil, {BackgroundTransparency = 1})
                            elseif Value.Instance:IsA("TextLabel") then 
                                Value:Tween(nil, {TextTransparency = 1})
                            elseif Value.Instance:IsA("ImageLabel") then 
                                Value:Tween(nil, {ImageTransparency = 1})
                            elseif Value.Instance:IsA("UIStroke") then 
                                Value:Tween(nil, {Transparency = 1})
                            end
                        end
    
                        Items["Notification"]:Tween(Info, {Size = UDim2New(0, 0, 0, 32)})
                        task.wait(0.5)
                        Items["Notification"]:Clean()
                    end)
                end)
            
        end
        
        Library.Window = function(self, Data)
            Data = Data or { }

            local Window = {
                Name = Data.Name or Data.name or "Window",
                TimeRemaining = Data.TimeRemaining or 0,
                SubTitle = Data.SubTitle or Data.subtitle or "LDS13",
                
                Pages = { },
                Items = { },
                IsOpen = false
            }

            local Items = { } do
                if IsMobile then 
                    Instances:Create("UIScale", {
                        Parent = Library.Holder.Instance,
                        Name = "\0",
                        Scale = 0.7
                    })
                end                    
                
                Items["MainFrame"] = Instances:Create("Frame", {
                    Parent = Library.Holder.Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 650, 0, 500),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

                Items["MainFrame"]:MakeDraggable()
                Items["MainFrame"]:MakeResizeable(Vector2New(Items["MainFrame"].Instance.AbsoluteSize.X, Items["MainFrame"].Instance.AbsoluteSize.Y), Vector2New(9999, 9999))

                Items["Shadow"] = Instances:Create("ImageLabel", {
                    Name = "\0",
                    Parent = Items["MainFrame"].Instance,
                    ImageColor3 = Color3.fromRGB(255, 255, 255),
                    ScaleType = Enum.ScaleType.Slice,
                    ImageTransparency = 0.34,
                    Size = UDim2.new(1, 25, 1, 25),
                    ZIndex = -1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Image = "http://www.roblox.com/asset/?id=18245826428",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    BackgroundColor3 = Library.Theme["Accent"],
                    BorderSizePixel = 0,
                    SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79))
                })

                
                local SplitGlow = Instances:Create("UIGradient", {
                    Parent = Items["Shadow"].Instance,
                    Name = "Miami_SplitGlow",
                    Rotation = 0,
                    Color = RGBSequence{
                        RGBSequenceKeypoint(0, FromRGB(61, 255, 138)),
                        RGBSequenceKeypoint(0.47, FromRGB(61, 255, 138)),
                        RGBSequenceKeypoint(0.53, FromRGB(255, 140, 0)),
                        RGBSequenceKeypoint(1, FromRGB(255, 140, 0))
                    }
                })

                task.spawn(function()
                    local Pulse = 0
                    while Items["Shadow"] and Items["Shadow"].Instance and Items["Shadow"].Instance.Parent do
                        Pulse = (Pulse + 0.025) % 1
                        SplitGlow.Instance.Offset = Vector2New(math.sin(Pulse * math.pi * 2) * 0.08, 0)
                        Items["Shadow"].Instance.ImageTransparency = 0.36 - (math.sin(Pulse * math.pi * 2) * 0.06)
                        task.wait(0.04)
                    end
                end)

                Instances:Create("UICorner", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Top"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                })  Items["Top"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                }):AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("Frame", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 30, 36)
                }):AddToTheme({BackgroundColor3 = "Outline"})
                
                Instances:Create("UIGradient", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    Rotation = -90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(223, 223, 223))}
                })

                local Content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                
                Items["AvatarIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0.5),
                    Image = Content,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0.5, 0),
                    Size = UDim2New(0, 30, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["AvatarIcon"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["AvatarIcon"].Instance,
                    Name = "\0",
                    Color = FromRGB(26, 30, 36),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Items["Username"] = Instances:Create("TextLabel", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = LocalPlayer.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 52, 0, 10),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Username"]:AddToTheme({TextColor3 = "Text"})
                
                Items["TimeRemaining"] = Instances:Create("TextLabel", {
                    Parent = Items["Top"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = "Time remaining: "..Window.TimeRemaining,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 52, 0, 25),
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["TimeRemaining"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Sidebar"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 50, 1, -100),
                    Position = UDim2New(0, 0, 0, 50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                })  Items["Sidebar"]:AddToTheme({BackgroundColor3 = "Inline"})

                
                Instances:Create("Frame", {
                    Parent = Items["Sidebar"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0),
                    Position = UDim2New(1, 0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 1, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 30, 36)
                }):AddToTheme({BackgroundColor3 = "Outline"})

                Items["Pages"] = Instances:Create("Frame", {
                    Parent = Items["Sidebar"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 10),
                    PaddingBottom = UDimNew(0, 10),
                    PaddingRight = UDimNew(0, 10),
                    PaddingLeft = UDimNew(0, 10)
                })                

                Instances:Create("UIListLayout", {
                    Parent = Items["Pages"].Instance,
                    Name = "\0",
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    FillDirection = Enum.FillDirection.Vertical,
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Bottom"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                })  Items["Bottom"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("Frame", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                }):AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("Frame", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(26, 30, 36)
                }):AddToTheme({BackgroundColor3 = "Outline"})
                
                Instances:Create("UIGradient", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(223, 223, 223))}
                })
                
                Items["Title"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Window.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 10),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Title"]:AddToTheme({TextColor3 = "Text"})
                
                Items["GameName"] = Instances:Create("TextLabel", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    Text = Window.SubTitle,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 25),
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["GameName"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Search"] = Instances:Create("Frame", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -48, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 33, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["Search"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["SearchIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://108790783092951",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -8, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SearchIcon"]:AddToTheme({ImageColor3 = "Text"})
                
                Items["Settings"] = Instances:Create("Frame", {
                    Parent = Items["Bottom"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -8, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 30, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["Settings"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Settings"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["SettingsIcon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Settings"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://75058048389410",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["SettingsIcon"]:AddToTheme({ImageColor3 = "Text"})
                                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["MainFrame"].Instance,
                    Name = "\0",
                    ClipsDescendants = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 50, 0, 50),
                    Size = UDim2New(1, -50, 1, -100),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Page"] = Instances:Create("Frame", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDimNew(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })

                Items["Settings"]:OnHover(function()
                    Items["SettingsIcon"]:Tween(nil, {ImageTransparency = 0})
                end)

                Items["Settings"]:OnHoverLeave(function()
                    Items["SettingsIcon"]:Tween(nil, {ImageTransparency = 0.5})
                end)

                Items["Search"]:OnHover(function()
                    Items["SearchIcon"]:Tween(nil, {ImageTransparency = 0})
                end)

                Items["Search"]:OnHoverLeave(function()
                    Items["SearchIcon"]:Tween(nil, {ImageTransparency = 0.5})
                end)

                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Search"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2New(0, 0, 0, 15),
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, -32, 0.5, 0),
                    BackgroundTransparency = 1,
                    PlaceholderColor3 = FromRGB(185, 185, 185),
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Dark Text"})

                local IsSearching = false

                Items["SearchIcon"]:Connect("InputBegan", function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                        IsSearching = not IsSearching
                        
                        if IsSearching then
                            Items["Input"].Instance.PlaceholderText = "Search..."
                            Items["Input"].Instance.Text = ""
                            Items["Input"].Instance:CaptureFocus()
                            Items["Search"]:Tween(nil, {
                                Size = UDim2New(0, Items["Input"].Instance.TextBounds.X + 42, 0, 30)
                            })
                        else
                            Items["Search"]:Tween(nil, {Size = UDim2New(0, 33, 0, 30)})
                            Items["Input"].Instance.PlaceholderText = ""
                            Items["Input"].Instance.Text = ""
                            Items["Input"].Instance:ReleaseFocus()
                        end
                    end
                end)

                local SearchStepped 

                Items["Input"]:Connect("FocusLost", function()
                    Items["Search"]:Tween(nil, {Size = UDim2New(0, 33, 0, 30)})
                    Items["Input"].Instance.PlaceholderText = ""
                    Items["Input"].Instance.Text = ""
                    Items["Input"].Instance:ReleaseFocus()

                    if SearchStepped then
                        SearchStepped:Disconnect()
                        SearchStepped = nil
                    end
                end)

                Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                    Items["Search"]:Tween(nil, {
                        Size = UDim2New(0, Items["Input"].Instance.TextBounds.X + 42, 0, 30)
                    })

                    local PageSearchData = Library.SearchItems[Library.CurrentPage]

                    if not PageSearchData then
                        return 
                    end
        
                    SearchStepped = RunService.RenderStepped:Connect(function()
                        for Index, Value in PageSearchData do 
                            local Name = Value.Name
                            local Element = Value.Element
        
                            if StringFind(StringLower(Name), StringLower(Items["Input"].Instance.Text)) then
                                if Items["Input"].Instance.Text ~= "" then 
                                    Element.Instance.Visible  = true 
                                else
                                    Element.Instance.Visible  = true 
                                end
                            else
                                Element.Instance.Visible = false
                            end
                        end
                    end)
                end)

                local Settings = {
                    IsOpen = false,
                    Name = ""..#Library.Sections,
                    Items = { },
                    IsSettings = true,
                    Elements = { }
                }
    
                local SettingsItems = { }
                do
                    SettingsItems["Settings"] = Instances:Create("TextButton", {
                        Parent = Library.UnusedHolder.Instance,
                        Text = "",
                        AutoButtonColor = false,
                        Name = "\0",
                        BorderColor3 = FromRGB(0, 0, 0),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BorderSizePixel = 0,
                        Position = UDim2New(0.8949604630470276, 0, 0.2945185601711273, 0),
                        Size = UDim2New(0, 325, 0, 159),
                        ZIndex = 2,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        BackgroundColor3 = FromRGB(21, 21, 24)
                    }) SettingsItems["Settings"]:AddToTheme({BackgroundColor3 = "Background"})
                    
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 6)
                    })
                    
                    SettingsItems["CloseButton"] = Instances:Create("TextButton", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(0, 0, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2New(0, 1),
                        BorderSizePixel = 0,
                        Position = UDim2New(0, 8, 1, -8),
                        Size = UDim2New(1, -16, 0, 22),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(27, 26, 29)
                    }) SettingsItems["CloseButton"]:AddToTheme({BackgroundColor3 = "Element"})
                
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
                    
                    SettingsItems["Text"] = Instances:Create("TextLabel", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        FontFace = Library.Font,
                        TextColor3 = FromRGB(100, 100, 100),
                        TextTransparency = 0,
                        Text = "Exit",
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2New(0, 0, 0, 15),
                        AnchorPoint = Vector2New(0.5, 0.5),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        BorderColor3 = FromRGB(0, 0, 0),
                        ZIndex = 2,
                        TextSize = 14,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  SettingsItems["Text"]:AddToTheme({TextColor3 = "Dark Text"})
                    
                    SettingsItems["CloseButton"]:OnHover(function()
                        SettingsItems["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                        SettingsItems["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    end)

                    SettingsItems["CloseButton"]:OnHoverLeave(function()
                        SettingsItems["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                        SettingsItems["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    end)

                    SettingsItems["Content"] = Instances:Create("ScrollingFrame", {
                        Parent = SettingsItems["Settings"].Instance,
                        Name = "\0",
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        Selectable = false,
                        Size = UDim2New(1, -8, 1, -46),
                        Position = UDim2New(0, 4, 0, 4),
                        ScrollBarThickness = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                        BackgroundTransparency = 1,
                        BorderColor3 = FromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        CanvasSize = UDim2New(0, 0, 0, 0)
                    })
                    
                    Instances:Create("UIListLayout", {
                        Parent = SettingsItems["Content"].Instance,
                        Name = "\0",
                        Padding = UDimNew(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })                    
                    
                    Instances:Create("UIPadding", {
                        Parent = SettingsItems["Content"].Instance,
                        Name = "\0",
                        PaddingTop = UDimNew(0, 4),
                        PaddingBottom = UDimNew(0, 4),
                        PaddingRight = UDimNew(0, 4),
                        PaddingLeft = UDimNew(0, 4)
                    })
    
                    Instances:Create("UICorner", {
                        Parent = SettingsItems["CloseButton"].Instance,
                        Name = "\0",
                        CornerRadius = UDimNew(0, 4)
                    })
    
                    local RenderStepped 
                    local Debounce = false
    
                    function Settings:SetOpen(Bool)
                        if Debounce then 
                            return
                        end
        
                        Settings.IsOpen = Bool
        
                        Debounce = true 
        
                        if Settings.IsOpen then 
                            for Index, Value in Settings.Elements do
                                Value:RefreshPosition(true)
                                task.wait(0.03)
                            end
    
                            SettingsItems["Settings"].Instance.Visible = true
                            SettingsItems["Settings"].Instance.Parent = Library.Holder.Instance

                            SettingsItems["Settings"].Instance.Position = UDim2New(
                                0, Items["SettingsIcon"].Instance.AbsolutePosition.X + 18, 
                                0, 
                                Items["SettingsIcon"].Instance.AbsolutePosition.Y + Items["SettingsIcon"].Instance.AbsoluteSize.Y * 3 
                            )
                            SettingsItems["Settings"]:Tween(nil, {Size = UDim2New(0, 325, 0, 185)})
        
                            for Index, Value in Library.OpenFrames do 
                                if Value ~= Settings then 
                                    Value:SetOpen(false)
                                end
                            end
        
                            Library.OpenFrames[Settings] = Settings 
                        else
                            if Library.OpenFrames[Settings] then 
                                Library.OpenFrames[Settings] = nil
                            end

                            SettingsItems["Settings"]:Tween(nil, {Size = UDim2New(0, 325, 0, 0)})
                        end
        
                        local Descendants = SettingsItems["Settings"].Instance:GetDescendants()
                        TableInsert(Descendants, SettingsItems["Settings"].Instance)
        
                        local NewTween
        
                        for Index, Value in Descendants do 
                            local TransparencyProperty = Tween:GetProperty(Value)
        
                            if TransparencyProperty then
        
                            if not Value.ClassName:find("UI") then 
                                Value.ZIndex = Settings.IsOpen and 7 or 1
                                SettingsItems["Text"].Instance.ZIndex = 8
                            end
        
                            if type(TransparencyProperty) == "table" then 
                                for _, Property in TransparencyProperty do 
                                    NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                                end
                            else
                                NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                            end
                            end
                        end
                        
                        NewTween.Tween.Completed:Connect(function()
                            Debounce = false 
                            SettingsItems["Settings"].Instance.Visible = Settings.IsOpen
                            task.wait(0.2)
                            SettingsItems["Settings"].Instance.Parent = not Settings.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance

                            if Settings.IsOpen then 
                                RenderStepped = RunService.RenderStepped:Connect(function()
                                    SettingsItems["Settings"].Instance.Position = UDim2New(
                                        0, Items["SettingsIcon"].Instance.AbsolutePosition.X + 18, 
                                        0, 
                                        Items["SettingsIcon"].Instance.AbsolutePosition.Y + Items["SettingsIcon"].Instance.AbsoluteSize.Y * 3 
                                    )
                                    SettingsItems["Settings"].Instance.Size = UDim2New(0, 325, 0, 185)
                                end)
                            else
                                if RenderStepped then 
                                    RenderStepped:Disconnect()
                                    RenderStepped = nil
                                end
                            end
                        end)
                    end
    
                    SettingsItems["CloseButton"]:Connect("MouseButton1Down", function()
                        Settings:SetOpen(false)
                    end)
    
                    Items["SettingsIcon"]:Connect("InputBegan", function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                            Settings:SetOpen(not Settings.IsOpen)
                        end
                    end)
    
                    Settings.Items = SettingsItems
                    setmetatable(Settings, Library.Sections)
    
                    for Index, Value in Library.Theme do 
                        Settings:Label(Index):Colorpicker({
                            Flag = Index,
                            Default = Library.Theme[Index],
                            Callback = function(Value)
                                Library.Theme[Index] = Value
                                Library:ChangeTheme(Index, Value)
                            end
                        })
                    end
                end

                if IsMobile then 
                    Items["FloatingButton"] = Instances:Create("TextButton", {
                        Parent = Library.Holder.Instance,
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2New(0.5, 0),
                        Name = "\0",
                        Position = UDim2New(0.5, 0, 0, 25),
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = UDim2New(0, 50, 0, 50),
                        BorderSizePixel = 0,
                        ZIndex = 127,
                        BackgroundColor3 = Library.Theme.Background
                    })  Items["FloatingButton"]:AddToTheme({BackgroundColor3 = "Background"})
        
                    Items["FloatingButton"]:MakeDraggable()
        
                    Items["Textsss"] = Instances:Create("TextLabel", {
                        Parent = Items["FloatingButton"].Instance,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Name = "\0",
                        Text = "Close",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        ZIndex = 127,
                        Size = UDim2New(1, -10, 1, -10),
                        BorderSizePixel = 0,
                        TextSize = 14,
                        FontFace = Library.Font,
                        BackgroundColor3 = FromRGB(255, 255, 255),
                    })  Items["Textsss"]:AddToTheme({TextColor3 = "Text"})
         
                    Instances:Create("UICorner", {
                        Parent = Items["FloatingButton"].Instance,
                        CornerRadius = UDimNew(1, 0)
                    }) 
        
                    Items["FloatingButton"]:Connect("InputBegan", function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            Window:SetOpen(not Window.IsOpen)
                            Items["Textsss"].Instance.Text = Window.IsOpen and "Close" or "Open"
                        end
                    end)

                    local CenterPosition = Items["FloatingButton"].Instance.AbsolutePosition
                    task.wait()
                    Items["FloatingButton"].Instance.AnchorPoint = Vector2New(0, 0)
        
                    Items["FloatingButton"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
                end

                Window.Items = Items
            end
            
            local Debounce = false
            local MainMenuFrame = Items["MainFrame"].Instance

            function Window:SetCenter()
                local CenterPosition = Items["MainFrame"].Instance.AbsolutePosition
                task.wait()
                Items["MainFrame"].Instance.AnchorPoint = Vector2New(0, 0)

                Items["MainFrame"].Instance.Position = UDim2New(0, CenterPosition.X, 0, CenterPosition.Y)
            end

            local MenuRestingPosition = MainMenuFrame.Position

            local function GetLeftOffscreenPosition(position)
                local width = MainMenuFrame.AbsoluteSize.X
                if width <= 0 then width = 700 end
                return UDim2New(0, -width - 80, position.Y.Scale, position.Y.Offset)
            end

            function Window:SetOpen(Bool)
                if Debounce then return end
                Window.IsOpen = Bool
                Debounce = true

                if Bool then
                    if MainMenuFrame.Visible then
                        MenuRestingPosition = MainMenuFrame.Position
                    end
                    MainMenuFrame.Position = GetLeftOffscreenPosition(MenuRestingPosition)
                    MainMenuFrame.Visible = true
                    local slideIn = TweenService:Create(MainMenuFrame, TweenInfo.new(0.36, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = MenuRestingPosition})
                    slideIn:Play()
                    slideIn.Completed:Connect(function()
                        Debounce = false
                    end)
                else
                    for _, openFrame in pairs(Library.OpenFrames) do
                        if openFrame and openFrame.SetOpen then
                            pcall(function() openFrame:SetOpen(false) end)
                        end
                    end
                    MenuRestingPosition = MainMenuFrame.Position
                    local slideOut = TweenService:Create(MainMenuFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = GetLeftOffscreenPosition(MenuRestingPosition)})
                    slideOut:Play()
                    slideOut.Completed:Connect(function()
                        MainMenuFrame.Visible = false
                        Debounce = false
                    end)
                end
            end

            Library:Connect(UserInputService.InputBegan, function(Input)
                if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                    Window:SetOpen(not Window.IsOpen)
                end
            end)

            Window:SetCenter()
            task.wait()
            Window:SetOpen(true)
            return setmetatable(Window, Library)
        end

        Library.Page = function(self, Data)
            Data = Data or { }

            local Page = {
                Window = self,

                Icon = Data.Icon or Data.icon or "131145598162617",
                Columns = Data.Columns or Data.columns or 2,

                Items = { },
                ColumnsData = { },
                Active = false
            }

            local Items = { } do
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Page.Window.Items["Pages"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(0, 30, 0, 30),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://"..Page.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})     
                
                Items["Inactive"]:OnHover(function()
                    if Page.Active then return end
                    Items["Icon"]:Tween(nil, {ImageTransparency = 0})
                end)

                Items["Inactive"]:OnHoverLeave(function()
                    if Page.Active then return end
                    Items["Icon"]:Tween(nil, {ImageTransparency = 0.5})
                end)

                Items["Page"] = Instances:Create("Frame", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    Visible = false,
                    Position = UDim2New(0, 0, 0, 67), 
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = UDimNew(0, 0),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })                

                Items["LeftColumn"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    ScrollBarImageColor3 = FromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 100, 0, 100),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["LeftColumn"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 12),
                    PaddingBottom = UDimNew(0, 12),
                    PaddingRight = UDimNew(0, 1),
                    PaddingLeft = UDimNew(0, 12)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["LeftColumn"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })        
                
                Items["RightColumn"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["Page"].Instance,
                    Name = "\0",
                    ScrollBarImageColor3 = FromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 100, 0, 100),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["RightColumn"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 12),
                    PaddingBottom = UDimNew(0, 1),
                    PaddingRight = UDimNew(0, 12),
                    PaddingLeft = UDimNew(0, 12)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["RightColumn"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 12),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })        

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Inactive"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 0),
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })

                Items["Gradient"] = Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Enabled = false,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(170, 170, 170))}
                })    

                Page.ColumnsData[1] = Items["LeftColumn"]
                Page.ColumnsData[2] = Items["RightColumn"]
                
                Page.Items = Items
            end

            local Debounce = false

            Library.SearchItems[Page] = { }

            function Page:Turn(Bool)
                if Debounce then 
                    return 
                end

                Page.Active = Bool 
                
                Debounce = true
                Items["Page"].Instance.Visible = Bool 
                Items["Page"].Instance.Parent = Bool and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance

                if Page.Active then
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = function()
                        return FromRGB(0, 0, 0)
                    end})

                    Items["Accent"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(1, 0, 1, 0), BackgroundTransparency = 0})
                    Items["Icon"]:Tween(nil, {ImageColor3 = FromRGB(0, 0, 0), ImageTransparency = 0})
                    Items["Page"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 0)})
                    Items["Gradient"].Instance.Enabled = true

                    Library.CurrentPage = Page
                else
                    Items["Icon"]:ChangeItemTheme({ImageColor3 = "Text"})

                    Items["Accent"]:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 0, 0), BackgroundTransparency = 1})
                    Items["Icon"]:Tween(nil, {ImageColor3 = Library.Theme.Text, ImageTransparency = 0.5})
                    Items["Page"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, 0, 0, 67)})
                    Items["Gradient"].Instance.Enabled = false
                end

                Debounce = false
            end

            local PageSearchData = Library.SearchItems[Page]

            function Page:InsertElement(Name, Element)
                local SearchData = {
                    Element = Element,
                    Name = Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Page.Window.Pages do 
                    if Value == Page and Page.Active then
                        return
                    end

                    Value:Turn(Value == Page)
                end
            end)

            if #Page.Window.Pages == 0 then 
                Page:Turn(true)
            end

            TableInsert(Page.Window.Pages, Page)
            return setmetatable(Page, Library.Pages)
        end

        Library.Pages.Section = function(self, Data)
            Data = Data or { }

            local Section = {
                Window = self.Window,
                Page = self,

                Name = Data.Name or Data.name or "Section",
                Icon = Data.Icon or Data.icon or "131145598162617",
                Side = Data.Side or Data.side or 1,

                Items = { }
            }

            local Items = { } do
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Section.Page.ColumnsData[Section.Side].Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 45),
                    Position = UDim2New(0.29109588265419006, 0, -0.1190476194024086, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(22, 25, 30)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Inline"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Section"].Instance,
                    Name = "\0"
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    Color = FromRGB(26, 30, 36),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Items["IconBackground"] = Instances:Create("TextButton", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0, 8),
                    Size = UDim2New(0, 25, 0, 25),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })
                
                Instances:Create("UICorner", {
                    Parent = Items["IconBackground"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["IconBackground"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://"..Section.Icon,
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Section.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 38, 0, 12),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
                
                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 10, 0, 40),
                    Size = UDim2New(1, -20, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Instances:Create("UIPadding", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    PaddingBottom = UDimNew(0, 10)
                })                
                
                Section.Items = Items
            end

            return setmetatable(Section, Library.Sections)
        end

        Library.Sections.Toggle = function(self, Data)
            Data = Data or { }

            local Toggle = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Toggle",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or false,
                Callback = Data.Callback or Data.callback or function() end,

                Value = false
            }

            local Items = { } do 
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Toggle.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 16),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(28, 32, 38)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Indicator"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(209, 209, 209))}
                })
                
                Items["CheckImage"] = Instances:Create("ImageLabel", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    ImageColor3 = FromRGB(0, 0, 0),
                    ImageTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Image = "rbxassetid://74979969250992",
                    BackgroundTransparency = 1,
                    Rotation = 85,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = UDim2New(0, 8, 0, 8),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Toggle.Name,
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 24, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Dark Text"})
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })                

                Items["Toggle"]:OnHover(function()
                    if Toggle.Value then return end
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end)

                Items["Toggle"]:OnHoverLeave(function()
                    if Toggle.Value then return end
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                end)
            end

            function Toggle:Get()
                return Toggle.Value 
            end

            function Toggle:Set(Value)
                Toggle.Value = Value 
                Library.Flags[Toggle.Flag] = Value 

                if Toggle.Value then 
                    Items["Accent"]:Tween(TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2New(1, 0, 1, 0)})
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["CheckImage"]:Tween(nil, {Rotation = 0, ImageTransparency = 0})
                else
                    Items["Accent"]:Tween(TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    Items["CheckImage"]:Tween(nil, {Rotation = 85, ImageTransparency = 1})
                end

                if Toggle.Callback then 
                    Library:SafeCall(Toggle.Callback, Toggle.Value)
                end
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool 
            end

            function Toggle:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or false
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Toggle:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Toggle.Window,
                    Page = Toggle.Page,
                    Section = Toggle.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            local PageSearchData = Library.SearchItems[Toggle.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Toggle"],
                    Name = Toggle.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            Items["Toggle"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Toggle:Set(not Toggle.Value)
                end
            end)

            Toggle:Set(Toggle.Default)

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return Toggle 
        end

        Library.Sections.Button = function(self, Data)
            Data = Data or { }

            local Button = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Button",
                Callback = Data.Callback or Data.callback or function() end
            }

            local Items = { } do 
                Items["Button"] = Instances:Create("TextButton", {
                    Parent = Button.Section.Items["Content"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = UDim2New(1, 0, 0, 22),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(28, 32, 38)
                })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Button.Name,
                    ZIndex = 2,
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Dark Text"})

                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["Button"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    AnchorPoint = Vector2New(0.5, 0.5),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(209, 209, 209))}
                })

                Items["Button"]:OnHover(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end)

                Items["Button"]:OnHoverLeave(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                end)
            end 

            function Button:SetVisibility(Bool)
                Items["Button"].Instance.Visible = Bool
            end

            function Button:Press()
                Items["Text"]:ChangeItemTheme({TextColor3 = function()
                    return FromRGB(0, 0, 0)
                end})
                Items["Text"]:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                Items["Accent"]:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2New(1, 0, 1, 0)})
                Library:SafeCall(Button.Callback)
                task.wait(0.12)
                Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                Items["Accent"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})
            end

            local PageSearchData = Library.SearchItems[Button.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Button"],
                    Name = Button.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            Items["Button"]:Connect("MouseButton1Down", function()
                Button:Press()
            end)

            return Button
        end

        Library.Sections.Slider = function(self, Data)
            Data = Data or { }

            local Slider = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Slider",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Min = Data.Min or Data.min or 0,
                Default = Data.Default or Data.default or 0,
                Max = Data.Max or Data.max or 100,
                Suffix = Data.Suffix or Data.suffix or "",
                Decimals = Data.Decimals or Data.decimals or 1,
                Callback = Data.Callback or Data.callback or function() end,

                Value = 0,
                Sliding = false
            }

            local Items = { } do 
                Items["Slider"] = Instances:Create("Frame", {
                    Parent = Slider.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 36),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Slider.Name,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Dark Text"})
                
                Items["RealSlider"] = Instances:Create("TextButton", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 10),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(28, 32, 38)
                })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Accent"] = Instances:Create("Frame", {
                    Parent = Items["RealSlider"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0.6000000238418579, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Items["Dragger"] = Instances:Create("Frame", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 0.5),
                    Position = UDim2New(1, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  
                
                Instances:Create("UICorner", {
                    Parent = Items["Dragger"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(1, 0)
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Dragger"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(170, 170, 170))}
                })
                
                Instances:Create("UIGradient", {
                    Parent = Items["Accent"].Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(170, 170, 170))}
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["Slider"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "60%",
                    AnchorPoint = Vector2New(1, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Dark Text"})       
                
                Items["RealSlider"]:OnHover(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Value"]:ChangeItemTheme({TextColor3 = "Text"})

                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Value"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end)

                Items["RealSlider"]:OnHoverLeave(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Value"]:ChangeItemTheme({TextColor3 = "Dark Text"})

                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    Items["Value"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                end)
            end

            function Slider:Get()
                return Slider.Value 
            end

            function Slider:SetVisibility(Bool)
                Items["Slider"].Instance.Visible = Bool
            end

            function Slider:Set(Value)
                Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
                Library.Flags[Slider.Flag] = Slider.Value

                Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)})
                Items["Value"].Instance.Text = StringFormat("%s%s", Slider.Value, Slider.Suffix)

                if Slider.Value <= Slider.Min then
                    Items["Dragger"].Instance.Position = UDim2New(1, 10, 0.5, 0)
                else
                    Items["Dragger"].Instance.Position = UDim2New(1, 0, 0.5, 0)
                end

                if Slider.Callback then 
                    Library:SafeCall(Slider.Callback, Slider.Value)
                end
            end

            local PageSearchData = Library.SearchItems[Slider.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Slider"],
                    Name = Slider.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            local InputChanged 
            
            Items["RealSlider"]:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Slider.Sliding = true

                    local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                    Slider:Set(Value)

                    if InputChanged then
                        return
                    end

                    InputChanged = Input.Changed:Connect(function()
                        if Input.UserInputState == Enum.UserInputState.End then
                            Slider.Sliding = false

                            InputChanged:Disconnect()
                            InputChanged = nil
                        end
                    end)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Slider.Sliding then
                        local SizeX = (Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                        local Value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min

                        Slider:Set(Value)
                    end
                end
            end)

            if Slider.Default then
                Slider:Set(Slider.Default)
            end

            Library.SetFlags[Slider.Flag] = function(Value)
                Slider:Set(Value)
            end

            return Slider 
        end

        Library.Sections.Dropdown = function(self, Data)
            Data = Data or { }

            local Dropdown = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Dropdown",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Items = Data.Items or Data.items or { "One", "Two", "Three" },
                Default = Data.Default or Data.default or nil,
                MaxSize = Data.MaxSize or Data.maxsize or 145,
                Callback = Data.Callback or Data.callback or function() end,
                Multi = Data.Multi or Data.multi or false,

                Value = { },
                Options = { },
                IsOpen = false
            }

            local Items = { } do 
                Items["Dropdown"] = Instances:Create("Frame", {
                    Parent = Dropdown.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 48),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Dropdown.Name,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Dark Text"})
                
                Items["RealDropdown"] = Instances:Create("TextButton", {
                    Parent = Items["Dropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 24),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(28, 32, 38)
                })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Value"] = Instances:Create("TextLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "...",
                    Size = UDim2New(1, -35, 0, 15),
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 10, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Value"]:AddToTheme({TextColor3 = "Dark Text"})
                
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["RealDropdown"].Instance,
                    Name = "\0",
                    ImageTransparency = 0.5,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0.5),
                    Image = "rbxassetid://134676997516408",
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, -4, 0.5, 0),
                    Size = UDim2New(0, 16, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Text"})       
                
                Items["OptionHolder"] = Instances:Create("TextButton", {
                    Parent = Library.UnusedHolder.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    Visible = false,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Position = UDim2New(0, 31, 0, 170),
                    Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 127),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(13, 15, 18)
                })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Background"})
                
                Instances:Create("UICorner", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                Instances:Create("UIStroke", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    Color = FromRGB(26, 30, 36),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Outline"})
                
                Items["Holder"] = Instances:Create("ScrollingFrame", {
                    Parent = Items["OptionHolder"].Instance,
                    Name = "\0",
                    ScrollBarImageColor3 = FromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    Size = UDim2New(1, -14, 1, -14),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 7, 0, 7),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    Padding = UDimNew(0, 8),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                Instances:Create("UIPadding", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    PaddingTop = UDimNew(0, 1),
                    PaddingBottom = UDimNew(0, 1),
                    PaddingRight = UDimNew(0, 1),
                    PaddingLeft = UDimNew(0, 1)
                })

                Items["RealDropdown"]:OnHover(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Value"]:ChangeItemTheme({TextColor3 = "Text"})

                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Value"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end)

                Items["RealDropdown"]:OnHoverLeave(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Value"]:ChangeItemTheme({TextColor3 = "Dark Text"})

                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    Items["Value"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                end)
            end

            function Dropdown:Get()
                return Dropdown.Value
            end

            function Dropdown:SetVisibility(Bool)
                Items["Dropdown"].Instance.Visible = Bool
            end

            local Debounce = false 
            local RenderStepped 

            function Dropdown:SetOpen(Bool)
                if Debounce then 
                    return
                end

                Dropdown.IsOpen = Bool

                Debounce = true 

                if Dropdown.IsOpen then 
                    Items["OptionHolder"].Instance.Visible = true
                    Items["OptionHolder"].Instance.Parent = Library.Holder.Instance
                    Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)

                    Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y + Items["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                    Items["OptionHolder"]:Tween(nil, {Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Dropdown.MaxSize)})

                    for Index, Value in Library.OpenFrames do 
                        if Value ~= Dropdown and not Dropdown.Section.IsSettings then 
                            Value:SetOpen(false)
                        end
                    end

                    Library.OpenFrames[Dropdown] = Dropdown 
                else
                    if Library.OpenFrames[Dropdown] then 
                        Library.OpenFrames[Dropdown] = nil
                    end

                    if RenderStepped then 
                        RenderStepped:Disconnect()
                        RenderStepped = nil
                    end

                    Items["OptionHolder"]:Tween(nil, {Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)})
                end

                local Descendants = Items["OptionHolder"].Instance:GetDescendants()
                TableInsert(Descendants, Items["OptionHolder"].Instance)

                local NewTween

                for Index, Value in Descendants do 
                    local TransparencyProperty = Tween:GetProperty(Value)

                    if TransparencyProperty then

                    if not Value.ClassName:find("UI") then 
                        Value.ZIndex = Dropdown.IsOpen and 3 or 1
                    end

                    if type(TransparencyProperty) == "table" then 
                        for _, Property in TransparencyProperty do 
                            NewTween = Tween:FadeItem(Value, Property, Bool, Library.FadeSpeed)
                        end
                    else
                        NewTween = Tween:FadeItem(Value, TransparencyProperty, Bool, Library.FadeSpeed)
                    end
                    end
                end
                
                NewTween.Tween.Completed:Connect(function()
                    Debounce = false 
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                    task.wait(0.2)
                    Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance

                    task.wait(0.1)
                    if Dropdown.IsOpen then 
                        RenderStepped = RunService.RenderStepped:Connect(function()
                            Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y + Items["RealDropdown"].Instance.AbsoluteSize.Y + 5)
                            Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, Dropdown.MaxSize)
                        end)
                    else
                        if RenderStepped then 
                            RenderStepped:Disconnect()
                            RenderStepped = nil
                        end

                        Items["OptionHolder"]:Tween(nil, {Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X, 0, 0)})
                    end
                end)
            end

            function Dropdown:Set(Option)
                if Dropdown.Multi then 
                    if type(Option) ~= "table" then 
                        return
                    end

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Option do
                        local OptionData = Dropdown.Options[Value]
                         
                        if OptionData then

                        OptionData.Selected = true 
                        OptionData:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = TableConcat(Option, ", ")
                else
                    if not Dropdown.Options[Option] then
                        return
                    end

                    local OptionData = Dropdown.Options[Option]

                    Dropdown.Value = Option
                    Library.Flags[Dropdown.Flag] = Option

                    for Index, Value in Dropdown.Options do
                        if Value ~= OptionData then
                            Value.Selected = false 
                            Value:Toggle("Inactive")
                        else
                            Value.Selected = true 
                            Value:Toggle("Active")
                        end
                    end

                    Items["Value"].Instance.Text = Option
                end

                if Dropdown.Callback then   
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end

            function Dropdown:Add(Option)
                local OptionButton = Instances:Create("TextButton", {
                    Parent = Items["Holder"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 0, 20),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(184, 212, 255)
                })  OptionButton:AddToTheme({BackgroundColor3 = "Accent"})
                
                Instances:Create("UIGradient", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(170, 170, 170))}
                })
                
                Instances:Create("UICorner", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 6)
                })
                
                local OptionText = Instances:Create("TextLabel", {
                    Parent = OptionButton.Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Option,
                    AnchorPoint = Vector2New(0, 0.5),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 8, 0.5, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  OptionText:AddToTheme({TextColor3 = "Dark Text"})      
                
                local OptionData = {
                    Text = OptionText,
                    Button = OptionButton,
                    Name = Option,
                    Selected = false
                }
                
                function OptionData:Toggle(Value)
                    if Value == "Active" then
                        OptionData.Text:ChangeItemTheme({TextColor3 = function()
                            return FromRGB(0, 0, 0)
                        end})

                        OptionData.Button:Tween(nil, {BackgroundTransparency = 0})
                        OptionData.Text:Tween(nil, {TextColor3 = FromRGB(0, 0, 0)})
                    else
                        OptionData.Text:ChangeItemTheme({TextColor3 = "Dark Text"})

                        OptionData.Button:Tween(nil, {BackgroundTransparency = 1})
                        OptionData.Text:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                    end
                end

                function OptionData:Set()
                    OptionData.Selected = not OptionData.Selected

                    if Dropdown.Multi then 
                        local Index = TableFind(Dropdown.Value, OptionData.Name)

                        if Index then 
                            TableRemove(Dropdown.Value, Index)
                        else
                            TableInsert(Dropdown.Value, OptionData.Name)
                        end

                        OptionData:Toggle(Index and "Inactive" or "Active")

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                        Items["Value"].Instance.Text = TextFormat
                    else
                        if OptionData.Selected then 
                            Dropdown.Value = OptionData.Name
                            Library.Flags[Dropdown.Flag] = OptionData.Name

                            OptionData.Selected = true
                            OptionData:Toggle("Active")

                            for Index, Value in Dropdown.Options do 
                                if Value ~= OptionData then
                                    Value.Selected = false 
                                    Value:Toggle("Inactive")
                                end
                            end

                            Items["Value"].Instance.Text = OptionData.Name
                        else
                            Dropdown.Value = nil
                            Library.Flags[Dropdown.Flag] = nil

                            OptionData.Selected = false
                            OptionData:Toggle("Inactive")

                            Items["Value"].Instance.Text = "..."
                        end
                    end

                    if Dropdown.Callback then
                        Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                    end
                end

                OptionData.Button:Connect("MouseButton1Down", function()
                    OptionData:Set()
                end)

                Dropdown.Options[OptionData.Name] = OptionData
                return OptionData
            end

            function Dropdown:Remove(Option)
                if Dropdown.Options[Option] then
                    Dropdown.Options[Option].Button:Clean()
                    Dropdown.Options[Option] = nil
                end
            end

            function Dropdown:Refresh(List)
                for Index, Value in Dropdown.Options do 
                    Dropdown:Remove(Value.Name)
                end

                for Index, Value in List do 
                    Dropdown:Add(Value)
                end
            end

            local PageSearchData = Library.SearchItems[Dropdown.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Dropdown"],
                    Name = Dropdown.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            Items["RealDropdown"]:Connect("MouseButton1Down", function()
                Dropdown:SetOpen(not Dropdown.IsOpen)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dropdown.IsOpen then
                        if Library:IsMouseOverFrame(Items["OptionHolder"]) then
                            return
                        end

                        Dropdown:SetOpen(false)
                    end
                end
            end)

            Items["RealDropdown"]:Connect("Changed", function(Property)
                if Property == "AbsolutePosition" and Dropdown.IsOpen then
                    Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
                    Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
                end
            end)

            for Index, Value in Dropdown.Items do 
                Dropdown:Add(Value)
            end

            if Dropdown.Default then 
                Dropdown:Set(Dropdown.Default)
            end

            Library.SetFlags[Dropdown.Flag] = function(Value)
                Dropdown:Set(Value)
            end

            return Dropdown
        end

        Library.Sections.Label = function(self, Name)
            local Label = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Name or "Label"
            }

            local Items = { } do 
                Items["Label"] = Instances:Create("Frame", {
                    Parent = Label.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 16),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(100, 100, 100),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Label.Name,
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 0, 0, 15),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Dark Text"})
                
                Items["SubElements"] = Instances:Create("Frame", {
                    Parent = Items["Label"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0, 0, 1, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Instances:Create("UIListLayout", {
                    Parent = Items["SubElements"].Instance,
                    Name = "\0",
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                    Padding = UDimNew(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })

                Items["Label"]:OnHover(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end)

                Items["Label"]:OnHoverLeave(function()
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Dark Text"})
                    Items["Text"]:Tween(nil, {TextColor3 = Library.Theme["Dark Text"]})
                end)
            end

            function Label:SetText(Text)
                Text = tostring(Text)
                Items["Text"].Instance.Text = Text
            end

            function Label:SetVisibility(Bool)
                Items["Label"].Instance.Visible = Bool
            end

            function Label:Colorpicker(Data)
                Data = Data or { }

                local Colorpicker = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                    Callback = Data.Callback or Data.callback or function() end,
                    Alpha = Data.Alpha or Data.alpha or false
                }

                local NewColorpicker, ColorpickerItems = Library:CreateColorpicker({
                    Parent = Items["SubElements"],
                    Page = Colorpicker.Page,
                    Section = Colorpicker.Section,
                    Flag = Colorpicker.Flag,
                    Default = Colorpicker.Default,
                    Callback = Colorpicker.Callback,
                    Alpha = Colorpicker.Alpha
                })

                return NewColorpicker
            end

            function Label:Keybind(Data)
                Data = Data or { }

                local Keybind = {
                    Window = Label.Window,
                    Page = Label.Page,
                    Section = Label.Section,

                    Flag = Data.Flag or Data.flag or Library:NextFlag(),
                    Default = Data.Default or Data.default or Enum.KeyCode.E,
                    Callback = Data.Callback or Data.callback or function() end,
                    Mode = Data.Mode or Data.mode or "Toggle"
                }

                local NewKeybind, KeybindItems = Library:CreateKeybind({
                    Parent = Items["SubElements"],
                    Page = Keybind.Page,
                    Section = Keybind.Section,
                    Flag = Keybind.Flag,
                    Default = Keybind.Default,
                    Mode = Keybind.Mode,
                    Callback = Keybind.Callback
                })

                return NewKeybind
            end

            local PageSearchData = Library.SearchItems[Label.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Label"],
                    Name = Label.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            return Label
        end

        Library.Sections.Textbox = function(self, Data)
            Data = Data or { }

            local Textbox = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Textbox",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or "",
                Callback = Data.Callback or Data.callback or function() end,
                Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
                Numeric = Data.Numeric or Data.numeric or false,
                Finished = Data.Finished or Data.finished or false,

                Value = ""
            }

            local Items = { } do 
                Items["Textbox"] = Instances:Create("Frame", {
                    Parent = Textbox.Section.Items["Content"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 24),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })
                
                Items["Background"] = Instances:Create("Frame", {
                    Parent = Items["Textbox"].Instance,
                    Name = "\0",
                    ClipsDescendants = true,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0, 1),
                    Size = UDim2New(1, 0, 0, 24),
                    Position = UDim2New(0, 0, 1, 0),
                    Selectable = true,
                    Active = true,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(28, 32, 38)
                })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})
                
                Instances:Create("UICorner", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    CornerRadius = UDimNew(0, 5)
                })
                
                Items["Input"] = Instances:Create("TextBox", {
                    Parent = Items["Background"].Instance,
                    Name = "\0",
                    FontFace = Library.Font,
                    Active = false,
                    Selectable = false,
                    AnchorPoint = Vector2New(0, 0.5),
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    PlaceholderText = Textbox.Placeholder,
                    TextSize = 14,
                    Size = UDim2New(1, -20, 0, 15),
                    TextColor3 = FromRGB(200, 200, 200),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    Position = UDim2New(0, 10, 0.5, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    CursorPosition = -1,
                    BorderSizePixel = 0,
                    PlaceholderColor3 = FromRGB(100, 100, 100),
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Input"]:AddToTheme({TextColor3 = "Text", PlaceholderColor3 = "Dark Text"})              
            end
            
            function Textbox:Get()
                return Textbox.Value
            end

            function Textbox:SetVisibility(Bool)
                Items["Textbox"].Instance.Visible = Bool
            end

            function Textbox:Set(Value)
                if Textbox.Numeric then
                    if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                        Value = Textbox.Value
                    end
                end

                Textbox.Value = Value
                Items["Input"].Instance.Text = Value
                Library.Flags[Textbox.Flag] = Value

                if Textbox.Callback then
                    Library:SafeCall(Textbox.Callback, Value)
                end
            end

            local PageSearchData = Library.SearchItems[Textbox.Page]

            if PageSearchData then
                local SearchData = {
                    Element = Items["Textbox"],
                    Name = Textbox.Name,
                }

                TableInsert(PageSearchData, SearchData)
            end

            if Textbox.Finished then 
                Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
                    if PressedEnterQuestionMark then
                        Textbox:Set(Items["Input"].Instance.Text)
                    end
                end)
            else
                Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
                    Textbox:Set(Items["Input"].Instance.Text)
                end)
            end

            if Textbox.Default then
                Textbox:Set(Textbox.Default)
            end

            Library.SetFlags[Textbox.Flag] = function(Value)
                Textbox:Set(Value)
            end

            return Textbox
        end
    end

    Library.CreateSettingsPage = function(self, Window)
        local SettingsPage = Window:Page({Name = "Settings", Icon = "77861834748434"})

        local ConfigsSection = SettingsPage:Section({Name = "Configs", Side = 2}) do 
            local ConfigName
            local ConfigSelected

            local ConfigsDropdown = ConfigsSection:Dropdown({
                Name = "Configs", 
                Flag = "Configs",
                Items = { }, 
                Multi = false,
                MaxSize = 120,
                Callback = function(Value)
                    ConfigSelected = Value
                end
            })

            ConfigsSection:Textbox({
                Name = "Config name",
                Placeholder = "Config name",
                Flag = "ConfigName",
                Callback = function(Value)
                    ConfigName = Value
                end
            })

            ConfigsSection:Button({
                Name = "Create",
                Callback = function()
                    if ConfigName and ConfigName ~= "" then
                        if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
                            writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
                            Library:RefreshConfigsList(ConfigsDropdown)
                        end
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Load",
                Callback = function()
                    if ConfigSelected and ConfigSelected ~= "" then
                        Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. ConfigSelected..".json"))
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Save",
                Callback = function()
                    if ConfigSelected and ConfigSelected ~= "" then
                        writefile(Library.Folders.Configs .. "/" .. ConfigSelected..".json", Library:GetConfig())
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Delete",
                Callback = function()
                    if ConfigSelected and ConfigSelected ~= "" then
                        delfile(Library.Folders.Configs .. "/" .. ConfigSelected..".json")
                        Library:RefreshConfigsList(ConfigsDropdown)
                    end
                end
            })

            ConfigsSection:Button({
                Name = "Refresh",
                Callback = function()
                    Library:RefreshConfigsList(ConfigsDropdown)
                end
            })

            Library:RefreshConfigsList(ConfigsDropdown)
        end
        
        local SettingsSection = SettingsPage:Section({Name = "Settings", Side = 1}) do 
            SettingsSection:Label("Menu Keybind"):Keybind({Name = "Menu Keybind", Flag = "Menu Keybind", Default = Enum.KeyCode.RightControl, Mode = "Toggle", Callback = function(Value)
                Library.MenuKeybind = Library.Flags["Menu Keybind"].Key
            end})

            SettingsSection:Slider({
                Name = "Fade Time",
                Default = Library.FadeSpeed,
                Min = 0,
                Max = 1,
                Suffix = "s",
                Decimals = 0.01,
                Callback = function(Value)
                    Library.FadeSpeed = Value
                end
            })

            SettingsSection:Slider({
                Name = "Animation Speed",
                Default = Library.Tween.Time,
                Min = 0,
                Max = 1,
                Suffix = "s",
                Decimals = 0.01,
                Callback = function(Value)
                    Library.Tween.Time = Value
                end
            })
        end
    end
end

getgenv().Library = Library
return Library

end)()


do
local __SamentLibrary = Library

Options = getgenv().Options or {}
Toggles = getgenv().Toggles or {}
getgenv().Options = Options
getgenv().Toggles = Toggles


getgenv().MiamiSuppressNotifications = true

local function __stripRichText(text)
    text = tostring(text or "Miami")
    text = text:gsub("<br%s*/>", " ")
    text = text:gsub("<[^>]->", "")
    text = text:gsub("%s+", " ")
    return text
end

local function __parseKey(key)
    if typeof and typeof(key) == "EnumItem" then
        return key
    end

    local text = tostring(key or "RightShift")
    text = text:gsub("Enum%.KeyCode%.", "")
    text = text:gsub("Enum%.UserInputType%.", "")

    if Enum.KeyCode[text] then
        return Enum.KeyCode[text]
    end

    if Enum.UserInputType[text] then
        return Enum.UserInputType[text]
    end

    return Enum.KeyCode.RightShift
end

local function __createControl(flag, default)
    flag = tostring(flag or ("CompatFlag_" .. tostring(math.random(100000, 999999))))
    local control = Options[flag] or {}
    control.Flag = flag
    control.Value = default
    control._callbacks = control._callbacks or {}

    function control:OnChanged(callback)
        if type(callback) == "function" then
            table.insert(self._callbacks, callback)
        end
        return self
    end

    function control:_fire(value)
        self.Value = value
        for _, callback in ipairs(self._callbacks) do
            pcall(callback, value)
        end
    end

    Options[flag] = control
    Toggles[flag] = control
    return control
end

local function __roundingToStep(rounding)
    if rounding == nil then
        return 1
    end
    rounding = tonumber(rounding) or 0
    if rounding <= 0 then
        return 1
    end
    return 1 / (10 ^ rounding)
end

local function __wrapLabel(realLabel)
    local label = { _label = realLabel }

    function label:SetText(text)
        if self._label and self._label.SetText then
            self._label:SetText(tostring(text or ""))
        end
    end

    function label:AddKeyPicker(flag, data)
        data = data or {}
        local defaultKey = __parseKey(data.Default or data.DefaultValue or Enum.KeyCode.RightShift)
        local control = __createControl(flag, tostring(defaultKey.Name or defaultKey))
        control.Value = tostring(defaultKey.Name or defaultKey)

        local keybind
        if self._label and self._label.Keybind then
            keybind = self._label:Keybind({
                Flag = flag,
                Default = defaultKey,
                Mode = data.Mode or "Toggle",
                Callback = function(value)
                    control:_fire(control.Value)
                    if type(data.Callback) == "function" then
                        pcall(data.Callback, value)
                    end
                end
            })
        end

        control.Instance = keybind
        function control:SetValue(value)
            local parsed = __parseKey(value)
            self.Value = tostring(parsed.Name or parsed)
            if keybind and keybind.Set then
                keybind:Set(parsed)
            end
            self:_fire(self.Value)
        end

        return control
    end

    return label
end

local function __wrapGroupbox(realSection)
    local group = { _section = realSection }

    function group:AddLabel(text)
        return __wrapLabel(self._section:Label(tostring(text or "")))
    end

    function group:AddDivider()
        return self:AddLabel("────────────────────────")
    end

    function group:AddButton(textOrData, callback)
        local text = textOrData
        local func = callback
        if type(textOrData) == "table" then
            text = textOrData.Text or textOrData.Name or textOrData[1] or "Button"
            func = textOrData.Func or textOrData.Callback or callback
        end
        return self._section:Button({
            Name = tostring(text or "Button"),
            Callback = function()
                if type(func) == "function" then
                    local ok, err = pcall(func)
                    if not ok then
                        warn("[Miami/Sament Button Error] " .. tostring(text) .. ": " .. tostring(err))
                    end
                end
            end
        })
    end

    function group:AddToggle(flag, data)
        data = data or {}
        local control = __createControl(flag, data.Default == true)
        local realToggle
        local building = true
        realToggle = self._section:Toggle({
            Name = data.Text or data.Name or tostring(flag),
            Flag = flag,
            Default = data.Default == true,
            Callback = function(value)
                control:_fire(value)
                if not building and type(data.Callback) == "function" then
                    local ok, err = pcall(data.Callback, value)
                    if not ok then warn("[Miami/Sament Toggle Error] " .. tostring(flag) .. ": " .. tostring(err)) end
                end
            end
        })
        building = false
        control.Instance = realToggle
        function control:SetValue(value)
            if realToggle and realToggle.Set then
                realToggle:Set(value == true)
            else
                self:_fire(value == true)
            end
        end
        return control
    end

    function group:AddDropdown(flag, data)
        data = data or {}
        local values = data.Values or data.Items or {}
        local default = data.Default
        local control = __createControl(flag, default)
        control.Values = values
        local realDropdown
        realDropdown = self._section:Dropdown({
            Name = data.Text or data.Name or tostring(flag),
            Flag = flag,
            Items = values,
            Default = default,
            Multi = data.Multi == true,
            MaxSize = data.MaxSize or data.Max or 145,
            Callback = function(value)
                control:_fire(value)
                if type(data.Callback) == "function" then
                    pcall(data.Callback, value)
                end
            end
        })
        control.Instance = realDropdown
        function control:SetValues(newValues)
            newValues = newValues or {}
            self.Values = newValues
            if realDropdown and realDropdown.Refresh then
                realDropdown:Refresh(newValues)
            end
            if #newValues > 0 then
                self.Value = newValues[1]
            end
        end
        control.Refresh = control.SetValues
        function control:SetValue(value)
            if realDropdown and realDropdown.Set then
                realDropdown:Set(value)
            else
                self:_fire(value)
            end
        end
        return control
    end

    function group:AddSlider(flag, data)
        data = data or {}
        local default = data.Default or data.Min or 0
        local control = __createControl(flag, default)
        local realSlider
        realSlider = self._section:Slider({
            Name = data.Text or data.Name or tostring(flag),
            Flag = flag,
            Min = data.Min or 0,
            Max = data.Max or 100,
            Default = default,
            Suffix = data.Suffix or "",
            Decimals = __roundingToStep(data.Rounding),
            Callback = function(value)
                control:_fire(value)
                if type(data.Callback) == "function" then
                    pcall(data.Callback, value)
                end
            end
        })
        control.Instance = realSlider
        function control:SetValue(value)
            if realSlider and realSlider.Set then
                realSlider:Set(value)
            else
                self:_fire(value)
            end
        end
        return control
    end

    function group:AddInput(flag, data)
        data = data or {}
        local default = data.Default or ""
        local control = __createControl(flag, default)
        local realTextbox
        realTextbox = self._section:Textbox({
            Name = data.Text or data.Name or tostring(flag),
            Flag = flag,
            Default = default,
            Placeholder = data.Placeholder or "",
            Numeric = data.Numeric == true,
            Finished = data.Finished == true,
            Callback = function(value)
                control:_fire(value)
                if type(data.Callback) == "function" then
                    pcall(data.Callback, value)
                end
            end
        })
        control.Instance = realTextbox
        function control:SetValue(value)
            if realTextbox and realTextbox.Set then
                realTextbox:Set(value)
            else
                self:_fire(value)
            end
        end
        return control
    end

    return group
end

local function __wrapTab(realPage)
    local tab = { _page = realPage }
    function tab:AddLeftGroupbox(name)
        return __wrapGroupbox(self._page:Section({ Name = tostring(name or "Group"), Side = 1, Icon = "131145598162617" }))
    end
    function tab:AddRightGroupbox(name)
        return __wrapGroupbox(self._page:Section({ Name = tostring(name or "Group"), Side = 2, Icon = "131145598162617" }))
    end
    return tab
end

function Library:Notify(message, duration)
    if getgenv().MiamiSuppressNotifications then
        return
    end
    return self:Notification(tostring(message or "Notification"), "90449909165261", tonumber(duration) or 5)
end

local __compatUnloadCallbacks = {}
local __originalUnload = Library.Unload
function Library:OnUnload(callback)
    if type(callback) == "function" then
        table.insert(__compatUnloadCallbacks, callback)
    end
end

function Library:Unload()
    for _, callback in ipairs(__compatUnloadCallbacks) do
        pcall(callback)
    end
    if __originalUnload then
        return __originalUnload(self)
    end
end

function Library:CreateWindow(data)
    data = data or {}
    local cleanTitle = __stripRichText(data.Title or data.Name or "Miami")
    local realWindow = self:Window({
        Name = cleanTitle,
        SubTitle = "Miami | Control Europe",
        TimeRemaining = ""
    })

    
    if realWindow.Items and realWindow.Items["TimeRemaining"] then
        realWindow.Items["TimeRemaining"].Instance.Visible = false
    end

    
    if realWindow.Items then
        if realWindow.Items["Title"] then
            realWindow.Items["Title"].Instance.Text = "🌍 MIAMI | CONTROL EUROPE"
        end
        if realWindow.Items["GameName"] then
            realWindow.Items["GameName"].Instance.Text = "CONTROL EUROPE • MIAMI"
        end
    end

    local __tabEmojis = {
        Army = "🛡️",
        Cities = "🏙️",
        Misc = "🎁",
        Player = "👤",
        Main = "🏠",
        ["Gun Mods"] = "🔫",
        Farm = "💰",
        Autofarm = "💰",
        Visuals = "👁️",
        Safe = "🔐",
        ["Safe/Dupe"] = "🔐",
        Settings = "⚙️",
        ["🎯"] = "🎯",
    }

    local window = {
        _window = realWindow,
        Holder = realWindow.Items and realWindow.Items["MainFrame"] and realWindow.Items["MainFrame"].Instance,
        Tabs = {},
        TabLabels = {},
        NativeTabs = {},
        TabsExpanded = false,
    }

    local tabDisplayNames = {
        Army = "Army",
        Cities = "Cities",
        Misc = "Misc",
        Player = "Player",
        Main = "Main",
        ["Gun Mods"] = "Gun Mods",
        Farm = "Farm",
        Autofarm = "Farm",
        Visuals = "Visuals",
        Safe = "Safe / Dupe",
        ["Safe/Dupe"] = "Safe / Dupe",
        Settings = "Settings",
        ["🎯"] = "Combat",
    }

    local nativeItems = realWindow.Items or {}
    local nativeSidebar = nativeItems["Sidebar"] and nativeItems["Sidebar"].Instance
    local nativeContent = nativeItems["Content"] and nativeItems["Content"].Instance
    local nativePages = nativeItems["Pages"] and nativeItems["Pages"].Instance
    local tabsToggleButton

    function window:SetTabsOpen(open)
        self.TabsExpanded = open == true
        if not nativeSidebar or not nativeContent then return end
        local touch = game:GetService("UserInputService").TouchEnabled
        local width = self.TabsExpanded and (touch and 150 or 180) or 50
        local tweenService = game:GetService("TweenService")
        tweenService:Create(nativeSidebar, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, width, 1, -100),
        }):Play()
        tweenService:Create(nativeContent, TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, width, 0, 50),
            Size = UDim2.new(1, -width, 1, -100),
        }):Play()
        if tabsToggleButton then
            tabsToggleButton.Text = self.TabsExpanded and "CLOSE TABS" or "»"
            tabsToggleButton.TextSize = self.TabsExpanded and 9 or 18
            tweenService:Create(tabsToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = self.TabsExpanded and UDim2.new(1, -16, 0, 28) or UDim2.fromOffset(30, 28),
                Position = self.TabsExpanded and UDim2.new(0, 8, 1, -36) or UDim2.new(0.5, 0, 1, -36),
                AnchorPoint = self.TabsExpanded and Vector2.new(0, 0) or Vector2.new(0.5, 0),
            }):Play()
        end
        for tabName, page in pairs(self.NativeTabs) do
            local button = page.Items and page.Items["Inactive"] and page.Items["Inactive"].Instance
            local emojiLabel = button and button:FindFirstChild("Miami_TabEmoji")
            local textLabel = self.TabLabels[tabName]
            if button then
                tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = self.TabsExpanded and UDim2.new(1, -16, 0, 32) or UDim2.fromOffset(30, 30),
                }):Play()
            end
            if emojiLabel then
                tweenService:Create(emojiLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Size = self.TabsExpanded and UDim2.fromOffset(38, 32) or UDim2.fromScale(1, 1),
                    Position = UDim2.fromOffset(0, 0),
                }):Play()
            end
            if textLabel then
                textLabel.Visible = self.TabsExpanded
                textLabel.TextTransparency = self.TabsExpanded and 1 or 0
                if self.TabsExpanded then
                    tweenService:Create(textLabel, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                end
            end
        end
    end

    if nativeSidebar then
        tabsToggleButton = Instance.new("TextButton")
        tabsToggleButton.Name = "MiamiTabsToggle"
        tabsToggleButton.AnchorPoint = Vector2.new(0.5, 0)
        tabsToggleButton.Position = UDim2.new(0.5, 0, 1, -36)
        tabsToggleButton.Size = UDim2.fromOffset(30, 28)
        tabsToggleButton.BackgroundColor3 = Color3.fromRGB(28, 32, 38)
        tabsToggleButton.BorderSizePixel = 0
        tabsToggleButton.Text = "»"
        tabsToggleButton.TextColor3 = Color3.fromRGB(61, 255, 138)
        tabsToggleButton.Font = Enum.Font.GothamBold
        tabsToggleButton.TextSize = 18
        tabsToggleButton.AutoButtonColor = false
        tabsToggleButton.ZIndex = 50
        tabsToggleButton.Parent = nativeSidebar
        local tabsCorner = Instance.new("UICorner")
        tabsCorner.CornerRadius = UDim.new(0, 7)
        tabsCorner.Parent = tabsToggleButton
        local tabsStroke = Instance.new("UIStroke")
        tabsStroke.Color = Color3.fromRGB(255, 140, 0)
        tabsStroke.Transparency = 0.35
        tabsStroke.Parent = tabsToggleButton
        tabsToggleButton.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(tabsToggleButton, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(35, 42, 48),
                TextColor3 = Color3.fromRGB(255, 140, 0),
            }):Play()
        end)
        tabsToggleButton.MouseLeave:Connect(function()
            game:GetService("TweenService"):Create(tabsToggleButton, TweenInfo.new(0.15), {
                BackgroundColor3 = Color3.fromRGB(28, 32, 38),
                TextColor3 = Color3.fromRGB(61, 255, 138),
            }):Play()
        end)
        tabsToggleButton.Activated:Connect(function()
            window:SetTabsOpen(not window.TabsExpanded)
        end)
    end

    function window:AddTab(name)
        local tabName = tostring(name or "Tab")
        local page = realWindow:Page({ Icon = "131145598162617", Columns = 2 })

        
        local emoji = __tabEmojis[tabName] or "•"
        if page.Items and page.Items["Inactive"] then
            if page.Items["Icon"] then
                page.Items["Icon"].Instance.Visible = false
            end

            local emojiLabel = Instance.new("TextLabel")
            emojiLabel.Name = "Miami_TabEmoji"
            emojiLabel.BackgroundTransparency = 1
            emojiLabel.Size = UDim2.new(1, 0, 1, 0)
            emojiLabel.Position = UDim2.new(0, 0, 0, 0)
            emojiLabel.Font = Enum.Font.GothamBold
            emojiLabel.Text = emoji
            emojiLabel.TextSize = 17
            emojiLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            emojiLabel.TextStrokeTransparency = 1
            emojiLabel.ZIndex = 5
            emojiLabel.Parent = page.Items["Inactive"].Instance

            local emojiStroke = Instance.new("UIStroke")
            emojiStroke.Color = Color3.fromRGB(255, 140, 0)
            emojiStroke.Thickness = 0.7
            emojiStroke.Transparency = 0.65
            emojiStroke.Parent = emojiLabel

            local tabText = Instance.new("TextLabel")
            tabText.Name = "Miami_TabName"
            tabText.Position = UDim2.fromOffset(39, 0)
            tabText.Size = UDim2.new(1, -45, 1, 0)
            tabText.BackgroundTransparency = 1
            tabText.Text = tabDisplayNames[tabName] or tabName
            tabText.TextColor3 = Color3.fromRGB(235, 240, 238)
            tabText.Font = Enum.Font.GothamMedium
            tabText.TextSize = 11
            tabText.TextXAlignment = Enum.TextXAlignment.Left
            tabText.TextTruncate = Enum.TextTruncate.AtEnd
            tabText.Visible = false
            tabText.ZIndex = 5
            tabText.Parent = page.Items["Inactive"].Instance
            self.TabLabels[tabName] = tabText

            local tweenService = game:GetService("TweenService")
            page.Items["Inactive"].Instance.MouseEnter:Connect(function()
                tweenService:Create(emojiLabel, TweenInfo.new(0.15), {TextSize = 20, TextColor3 = Color3.fromRGB(61, 255, 138)}):Play()
                tweenService:Create(emojiStroke, TweenInfo.new(0.15), {Transparency = 0.1, Color = Color3.fromRGB(61, 255, 138)}):Play()
            end)
            page.Items["Inactive"].Instance.MouseLeave:Connect(function()
                tweenService:Create(emojiLabel, TweenInfo.new(0.15), {TextSize = 17, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                tweenService:Create(emojiStroke, TweenInfo.new(0.15), {Transparency = 0.65, Color = Color3.fromRGB(255, 140, 0)}):Play()
            end)
            page.Items["Inactive"].Instance.Activated:Connect(function()
                if game:GetService("UserInputService").TouchEnabled and self.TabsExpanded then
                    task.defer(function() self:SetTabsOpen(false) end)
                end
            end)
        end

        self.NativeTabs[tabName] = page
        local wrapped = __wrapTab(page)
        self.Tabs[tabName] = wrapped
        return wrapped
    end

    function window:SetOpen(value)
        if realWindow and realWindow.SetOpen then
            realWindow:SetOpen(value)
        elseif self.Holder then
            self.Holder.Visible = value
        end
    end

    Library.__CompatActiveWindow = window
    return window
end

function Library.Toggle()
    local win = Library.__CompatActiveWindow
    if win then
        local holder = win.Holder
        local isOpen = holder and holder.Visible
        if win.SetOpen then
            win:SetOpen(not isOpen)
        elseif holder then
            holder.Visible = not holder.Visible
        end
    end
end


ThemeManager = {
    BuiltInThemes = {},
    SetLibrary = function() end,
    ApplyTheme = function() end,
    SetFolder = function() end,
    ApplyToGroupbox = function() end,
}
SaveManager = {
    SetLibrary = function() end,
    IgnoreThemeSettings = function() end,
    SetIgnoreIndexes = function() end,
    SetFolder = function() end,
    SetSubFolder = function() end,
    BuildConfigSection = function() end,
}
end





getgenv().MiamiSuppressNotifications = false
getgenv().ControlEuropeMiamiAlive = true

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Window = Library:CreateWindow({
    Title = "MIAMI | CONTROL EUROPE",
    Center = true,
    AutoShow = true,
    TabPadding = 6,
    MenuFadeTime = 0.15,
})

local Tabs = {
    Army = Window:AddTab("Army"),
    Cities = Window:AddTab("Cities"),
    Misc = Window:AddTab("Misc"),
    Settings = Window:AddTab("Settings"),
}

local MyCountry = nil
local AutoCaptureEnabled = false
local AutoSantaEnabled = false

local ReduceNotifications = true
local NextNotificationAt = 0
local HiddenNotificationStates = setmetatable({}, { __mode = "k" })
local NotificationWatcher = nil

local function isUpgradePopup(object)
    if not object:IsA("TextLabel") then return false end
    local text = string.lower(object.Text or "")
    return (string.find(text, "maximum", 1, true) and string.find(text, "upgrade", 1, true))
        or (string.find(text, "max", 1, true) and string.find(text, "upgrade", 1, true))
end

local function hideUpgradePopup(object)
    if not ReduceNotifications or not isUpgradePopup(object) then return end
    local container = object.Parent
    if container and container:IsA("GuiObject") then
        if HiddenNotificationStates[container] == nil then HiddenNotificationStates[container] = container.Visible end
        container.Visible = false
    else
        if HiddenNotificationStates[object] == nil then HiddenNotificationStates[object] = object.Visible end
        object.Visible = false
    end
end

local function setReduceNotifications(value)
    ReduceNotifications = value == true
    NextNotificationAt = 0
    getgenv().MiamiSuppressNotifications = ReduceNotifications
    if NotificationWatcher then
        NotificationWatcher:Disconnect()
        NotificationWatcher = nil
    end
    local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if ReduceNotifications and playerGui then
        for _, object in ipairs(playerGui:GetDescendants()) do
            hideUpgradePopup(object)
            if object:IsA("TextLabel") then
                object:GetPropertyChangedSignal("Text"):Connect(function()
                    hideUpgradePopup(object)
                end)
            end
        end
        NotificationWatcher = playerGui.DescendantAdded:Connect(function(object)
            task.defer(function()
                hideUpgradePopup(object)
                if object:IsA("TextLabel") then
                    object:GetPropertyChangedSignal("Text"):Connect(function()
                        hideUpgradePopup(object)
                    end)
                end
            end)
        end)
    elseif not ReduceNotifications then
        for object, visible in pairs(HiddenNotificationStates) do
            if object and object.Parent then object.Visible = visible end
        end
        table.clear(HiddenNotificationStates)
    end
end

local function notify(title, text, duration)
    if ReduceNotifications then
        if os.clock() < NextNotificationAt then return end
        NextNotificationAt = os.clock() + 6
    end
    Library:Notify(tostring(title) .. "\n" .. tostring(text), duration or 4)
end

local function getRegions()
    return Workspace:FindFirstChild("Regions")
end

local function getSoldiers()
    return Workspace:FindFirstChild("SoldiersFolder")
end

local function GetMyCountry()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats") or LocalPlayer:WaitForChild("leaderstats", 5)
    local countryValue = leaderstats and leaderstats:FindFirstChild("Country")
    if countryValue then
        MyCountry = tostring(countryValue.Value)
        if string.find(MyCountry, "Russian") then MyCountry = "Russia" end
        notify("Country", MyCountry, 4)
        return MyCountry
    end
    notify("Country", "Country was not detected.", 4)
    return nil
end

local function TryFireAll(possibleNames, args)
    for _, name in ipairs(possibleNames) do
        for index = 1, 6 do
            local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_" .. index)
            if remote and remote:IsA("RemoteEvent") then
                pcall(function()
                    remote:FireServer(name, table.unpack(args))
                end)
            end
        end
    end
end

local function isMyCountry(value)
    return value and tostring(value.Value) == tostring(MyCountry)
end

local UnitSpawnRegionCursor = {}

local function createArmyUnitInNextOwnedRegion(remoteName, unitName, amount)
    if not MyCountry then GetMyCountry() end
    local regions = getRegions()
    local remote = ReplicatedStorage:FindFirstChild(remoteName)
    if not regions or not MyCountry then
        notify("Units", "Country or Regions folder was not found.", 3)
        return false, nil
    end
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Units", remoteName .. " was not found.", 3)
        return false, nil
    end
    local ownedRegions = {}
    for _, region in ipairs(regions:GetChildren()) do
        if isMyCountry(region:FindFirstChild("Country")) then
            table.insert(ownedRegions, region)
        end
    end
    table.sort(ownedRegions, function(a, b) return a.Name < b.Name end)
    if #ownedRegions == 0 then
        notify("Units", "No owned regions were found.", 3)
        return false, nil
    end
    local key = tostring(MyCountry) .. "|" .. remoteName .. "|" .. unitName
    local index = UnitSpawnRegionCursor[key] or 1
    if index > #ownedRegions then index = 1 end
    local region = ownedRegions[index]
    local ok = pcall(function()
        remote:FireServer("CreateArmyOnTile", region, unitName, amount)
    end)
    if ok then
        UnitSpawnRegionCursor[key] = index + 1
    end
    return ok, region
end

local function isSoldierUnit(unit)
    local text = string.lower(unit.Name or "")
    for _, valueName in ipairs({ "UnitType", "Type", "ArmyType", "Class" }) do
        local value = unit:FindFirstChild(valueName, true)
        if value and value:IsA("ValueBase") then
            text = text .. " " .. string.lower(tostring(value.Value))
        end
    end
    return string.find(text, "soldier", 1, true) ~= nil or string.find(text, "infantry", 1, true) ~= nil
end

local ArmyGroup = Tabs.Army:AddLeftGroupbox("🛡️ Army")
ArmyGroup:AddButton("🔄 Refresh Country", function()
    GetMyCountry()
end)
local CustomSoldierAmount = 5000

local function spawnSoldiersNextRegion(amount)
    local ok, region = createArmyUnitInNextOwnedRegion("RemoteEvent_1", "Soldier", amount)
    if ok and region then
        notify("Soldiers", "Sent " .. tostring(amount) .. " to " .. region.Name .. ".", 3)
    end
end

ArmyGroup:AddButton("Spawn 5k Soldiers", function() spawnSoldiersNextRegion(5000) end)
ArmyGroup:AddButton("Spawn 100k Soldiers", function() spawnSoldiersNextRegion(100000) end)
ArmyGroup:AddButton("Spawn 200k Soldiers", function() spawnSoldiersNextRegion(200000) end)
ArmyGroup:AddButton("Spawn 300k Soldiers", function() spawnSoldiersNextRegion(300000) end)
ArmyGroup:AddButton("Spawn 500k Soldiers", function() spawnSoldiersNextRegion(500000) end)
ArmyGroup:AddButton("Spawn 1M Soldiers", function() spawnSoldiersNextRegion(1000000) end)
ArmyGroup:AddSlider("ControlEuropeCustomSoldiers", {
    Text = "Custom Soldier Amount",
    Min = 1000,
    Max = 1000000,
    Default = CustomSoldierAmount,
    Rounding = 0,
    Callback = function(value) CustomSoldierAmount = value end,
})
ArmyGroup:AddButton("Spawn Custom Soldiers", function()
    spawnSoldiersNextRegion(CustomSoldierAmount)
end)
ArmyGroup:AddButton("Add 25k to All Troops", function()
    if not MyCountry then GetMyCountry() end
    local soldiers = getSoldiers()
    if not MyCountry or not soldiers then
        notify("Army", "Country or Soldiers folder was not found.", 4)
        return
    end
    local count = 0
    local names = { "CreateArmyOnTile", "AddToArmy", "AddUnits", "Reinforce", "SpawnSoldiers" }
    for _, soldier in ipairs(soldiers:GetChildren()) do
        local country = soldier:FindFirstChild("Country")
        if isMyCountry(country) then
            local total = soldier:FindFirstChild("TotalAmount")
            local amount = (total and tonumber(total.Value)) or 1000
            TryFireAll(names, { soldier, "Soldier", amount + 25000 })
            count = count + 1
            task.wait(0.2)
        end
    end
    notify("Army", "Sent reinforcement requests to " .. count .. " troop stacks.", 5)
end)

ArmyGroup:AddToggle("ControlEuropeAutoCapture", {
    Text = "AUTO Capture + Attack",
    Default = false,
    Callback = function(value)
        AutoCaptureEnabled = value == true
        if not AutoCaptureEnabled and MyCountry then
            local soldiers = getSoldiers()
            if soldiers then
                local names = { "ToggleAutoCapture", "SetAutoCapture", "AutoCapture", "ToggleAuto" }
                for _, unit in ipairs(soldiers:GetChildren()) do
                    if isMyCountry(unit:FindFirstChild("Country")) then
                        TryFireAll(names, { unit, false })
                    end
                end
            end
            notify("Auto Capture", "Disabled on your troops.", 3)
        end
    end,
})

local UnitsGroup = Tabs.Army:AddRightGroupbox("✈️ Planes / Ships")
UnitsGroup:AddLabel("Each click sends one request to the next owned region.")

local function spawnUnitNextRegion(remoteName, unitName, amount, title)
    local ok, region = createArmyUnitInNextOwnedRegion(remoteName, unitName, amount)
    if ok and region then
        notify(title, "Sent " .. tostring(amount) .. " to " .. region.Name .. ".", 3)
    end
end

UnitsGroup:AddButton("Spawn 1k Planes", function() spawnUnitNextRegion("RemoteEvent_1", "Plane", 1000, "Planes") end)
UnitsGroup:AddButton("Spawn 5k Planes", function() spawnUnitNextRegion("RemoteEvent_1", "Plane", 5000, "Planes") end)
UnitsGroup:AddButton("Spawn 10k Planes", function() spawnUnitNextRegion("RemoteEvent_1", "Plane", 10000, "Planes") end)
UnitsGroup:AddButton("Spawn 30k Planes", function() spawnUnitNextRegion("RemoteEvent_1", "Plane", 30000, "Planes") end)
UnitsGroup:AddButton("Spawn 1k Battleships", function() spawnUnitNextRegion("RemoteEvent_1", "Battleship", 1000, "Battleships") end)
UnitsGroup:AddButton("Spawn 3k Battleships", function() spawnUnitNextRegion("RemoteEvent_1", "Battleship", 3000, "Battleships") end)
UnitsGroup:AddButton("Spawn 5k Artillery", function() spawnUnitNextRegion("RemoteEvent_4", "Artillery", 5000, "Artillery") end)
UnitsGroup:AddButton("Spawn 10k Artillery", function() spawnUnitNextRegion("RemoteEvent_4", "Artillery", 10000, "Artillery") end)
UnitsGroup:AddButton("Spawn 50k Artillery", function() spawnUnitNextRegion("RemoteEvent_4", "Artillery", 50000, "Artillery") end)
UnitsGroup:AddButton("Spawn 100 Tanks", function() spawnUnitNextRegion("RemoteEvent_4", "Tank", 100, "Tanks") end)
UnitsGroup:AddButton("Spawn 1k Tanks", function() spawnUnitNextRegion("RemoteEvent_4", "Tank", 1000, "Tanks") end)
UnitsGroup:AddButton("Spawn 5k Tanks", function() spawnUnitNextRegion("RemoteEvent_4", "Tank", 5000, "Tanks") end)
UnitsGroup:AddButton("Spawn 10k Tanks", function() spawnUnitNextRegion("RemoteEvent_4", "Tank", 10000, "Tanks") end)
UnitsGroup:AddButton("Spawn 1k Anti Aircraft", function() spawnUnitNextRegion("RemoteEvent_4", "AntiAircraft", 1000, "Anti Aircraft") end)
UnitsGroup:AddButton("Spawn 30k Anti Aircraft", function() spawnUnitNextRegion("RemoteEvent_4", "AntiAircraft", 30000, "Anti Aircraft") end)

local SelectedDiplomacyCountry = ""
local JustifiedCountries = {}
local DiplomacyDropdown = nil

local function getDiplomacyCountries()
    local countries = {}
    local seen = {}
    local regions = getRegions()
    if regions then
        for _, region in ipairs(regions:GetChildren()) do
            local country = region:FindFirstChild("Country")
            local name = country and tostring(country.Value) or ""
            if name ~= "" and name ~= tostring(MyCountry) and not seen[name] then
                seen[name] = true
                table.insert(countries, name)
            end
        end
    end
    table.sort(countries)
    if #countries == 0 then table.insert(countries, "No countries") end
    return countries
end

local DiplomacyGroup = Tabs.Army:AddRightGroupbox("⚔️ Diplomacy")
local DiplomacyStatus = DiplomacyGroup:AddLabel("Select a country, justify, then declare war.")
DiplomacyDropdown = DiplomacyGroup:AddDropdown("ControlEuropeDiplomacyCountry", {
    Text = "Select Country",
    Values = getDiplomacyCountries(),
    Default = "",
    Callback = function(value)
        if value ~= "No countries" then SelectedDiplomacyCountry = tostring(value) end
    end,
})
DiplomacyGroup:AddButton("🔄 Refresh Countries", function()
    if DiplomacyDropdown then DiplomacyDropdown:SetValues(getDiplomacyCountries()) end
end)
DiplomacyGroup:AddButton("📜 Justify Against Selected Country", function()
    local country = SelectedDiplomacyCountry
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_2")
    if country == "" or country == "No countries" then
        notify("Diplomacy", "Select a country first.", 3)
        return
    end
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Diplomacy", "RemoteEvent_2 was not found.", 3)
        return
    end
    pcall(function()
        remote:FireServer("JustifyWar", country)
    end)
    JustifiedCountries[country] = true
    DiplomacyStatus:SetText("Justified against " .. country)
    notify("Diplomacy", "Justification sent for " .. country .. ".", 3)
end)
DiplomacyGroup:AddButton("📜 Justify War Against All Countries", function()
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_2")
    local countries = getDiplomacyCountries()
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Diplomacy", "RemoteEvent_2 was not found.", 3)
        return
    end
    if #countries == 0 or countries[1] == "No countries" then
        notify("Diplomacy", "No countries were found.", 3)
        return
    end
    task.spawn(function()
        local count = 0
        for _, country in ipairs(countries) do
            pcall(function()
                remote:FireServer("JustifyWar", country)
            end)
            JustifiedCountries[country] = true
            count = count + 1
            task.wait(0.25)
        end
        DiplomacyStatus:SetText("Justified against " .. count .. " countries")
        notify("Diplomacy", "Justification sent for " .. count .. " countries.", 5)
    end)
end)
DiplomacyGroup:AddButton("⚔️ Declare War Against Justified Country", function()
    local country = SelectedDiplomacyCountry
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_4")
    if country == "" or country == "No countries" then
        notify("Diplomacy", "Select a country first.", 3)
        return
    end
    if not JustifiedCountries[country] then
        notify("Diplomacy", "Justify against " .. country .. " first.", 3)
        return
    end
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Diplomacy", "RemoteEvent_4 was not found.", 3)
        return
    end
    pcall(function()
        remote:FireServer("DeclareWar", country)
    end)
    DiplomacyStatus:SetText("Declared war on " .. country)
    notify("Diplomacy", "War declaration sent for " .. country .. ".", 4)
end)

local SelectedCedeCity = ""
local SelectedSupportCountry = ""
local AutoSupportEnabled = false
local AutoSupportWorker = false
local AutoSupportCededCities = {}
local CedeCityDropdown = nil
local SupportCountryDropdown = nil

local function getOwnedCities()
    local cities = {}
    local regions = getRegions()
    if regions then
        for _, region in ipairs(regions:GetChildren()) do
            if isMyCountry(region:FindFirstChild("Country")) then
                table.insert(cities, region.Name)
            end
        end
    end
    table.sort(cities)
    if #cities == 0 then table.insert(cities, "No owned cities") end
    return cities
end

local function getSupportCountries()
    local countries = {}
    local seen = {}
    local regions = getRegions()
    if regions then
        for _, region in ipairs(regions:GetChildren()) do
            local country = region:FindFirstChild("Country")
            local name = country and tostring(country.Value) or ""
            if name ~= "" and name ~= tostring(MyCountry) and not seen[name] then
                seen[name] = true
                table.insert(countries, name)
            end
        end
    end
    table.sort(countries)
    if #countries == 0 then table.insert(countries, "No countries") end
    return countries
end

local function getPlayerCountries()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then table.insert(names, player.Name) end
    end
    table.sort(names)
    if #names == 0 then table.insert(names, "No players") end
    return names
end

local function getPlayerCountry(playerName)
    local player = Players:FindFirstChild(playerName)
    local leaderstats = player and player:FindFirstChild("leaderstats")
    local country = leaderstats and leaderstats:FindFirstChild("Country")
    return country and tostring(country.Value) or nil
end

local function normalizeCountryName(country)
    country = tostring(country or "")
    if string.find(country, "Russian") then return "Russia" end
    return country
end

local function refreshCurrentCountrySilently()
    local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    local country = leaderstats and leaderstats:FindFirstChild("Country")
    if country then
        MyCountry = normalizeCountryName(country.Value)
    end
    return MyCountry
end

local function getAvailableSwitchCountry()
    local occupied = {}
    for _, player in ipairs(Players:GetPlayers()) do
        local country = normalizeCountryName(getPlayerCountry(player.Name))
        if country ~= "" then occupied[country] = true end
    end
    local currentCountry = normalizeCountryName(MyCountry)
    local recipientCountry = normalizeCountryName(SelectedSupportCountry)
    local countries = {}
    local seen = {}
    local regions = getRegions()
    if regions then
        for _, region in ipairs(regions:GetChildren()) do
            local countryValue = region:FindFirstChild("Country")
            local country = normalizeCountryName(countryValue and countryValue.Value)
            local lowerCountry = string.lower(country)
            if country ~= ""
                and country ~= currentCountry
                and country ~= recipientCountry
                and lowerCountry ~= "none"
                and lowerCountry ~= "no country"
                and lowerCountry ~= "unclaimed"
                and not occupied[country]
                and not seen[country] then
                seen[country] = true
                table.insert(countries, country)
            end
        end
    end
    table.sort(countries)
    return countries[1]
end

local function switchCountryForAutoSupport()
    local country = getAvailableSwitchCountry()
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_1")
    if not country or not remote or not remote:IsA("RemoteEvent") then return false end
    local ok = pcall(function()
        remote:FireServer("SelectCountry", country)
    end)
    if not ok then return false end
    local deadline = os.clock() + 6
    while AutoSupportEnabled and os.clock() < deadline do
        if normalizeCountryName(refreshCurrentCountrySilently()) == country then
            return true
        end
        task.wait(0.25)
    end
    return false
end

local SupportMoneyOverride = 0
local SupportManpowerOverride = 0

local function parseResourceNumber(value)
    if type(value) == "number" then return math.max(0, math.floor(value)) end
    local text = string.lower(tostring(value or "")):gsub(",", "")
    local number, suffix = text:match("([%d%.]+)%s*([kmbt]?)")
    local amount = tonumber(number)
    if not amount then return 0 end
    local multiplier = ({ k = 1e3, m = 1e6, b = 1e9, t = 1e12 })[suffix] or 1
    return math.max(0, math.floor(amount * multiplier))
end

local function resourceNameMatches(name, names)
    name = string.lower(tostring(name or ""))
    for _, wanted in ipairs(names) do
        if name == wanted or string.find(name, wanted, 1, true) then return true end
    end
    return false
end

local function getResourceAmount(names)
    local best = 0
    local roots = {
        LocalPlayer:FindFirstChild("leaderstats"),
        LocalPlayer,
        LocalPlayer:FindFirstChildOfClass("PlayerGui"),
    }
    local regions = getRegions()
    if regions then
        for _, region in ipairs(regions:GetChildren()) do
            if isMyCountry(region:FindFirstChild("Country")) then table.insert(roots, region) end
        end
    end
    for _, root in ipairs(roots) do
        if root then
            for _, object in ipairs(root:GetDescendants()) do
                if resourceNameMatches(object.Name, names) then
                    local amount = 0
                    if object:IsA("IntValue") or object:IsA("NumberValue") or object:IsA("StringValue") then
                        amount = parseResourceNumber(object.Value)
                    elseif object:IsA("TextLabel") then
                        amount = parseResourceNumber(object.Text)
                    end
                    if amount > best then best = amount end
                elseif object:IsA("TextLabel") then
                    local text = string.lower(object.Text or "")
                    for _, wanted in ipairs(names) do
                        if string.find(text, wanted, 1, true) then
                            best = math.max(best, parseResourceNumber(text))
                            break
                        end
                    end
                end
            end
        end
    end
    return best
end

local function getSupportAmounts()
    local money = SupportMoneyOverride > 0 and SupportMoneyOverride or getResourceAmount({ "money", "cash", "treasury", "fund", "gold", "balance" })
    local manpower = SupportManpowerOverride > 0 and SupportManpowerOverride or getResourceAmount({ "manpower", "population", "recruit", "soldier", "troop" })
    return money, manpower
end

local function sendSupportToCountry(country)
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_1")
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Support", "RemoteEvent_1 was not found.", 3)
        return false
    end
    if country == "" or country == "No countries" then
        notify("Support", "Select a country first.", 3)
        return false
    end
    local money, manpower = getSupportAmounts()
    if money <= 0 and manpower <= 0 then
        notify("Support", "No money or manpower was detected. Use the support amount boxes.", 3)
        return false
    end
    pcall(function()
        remote:FireServer("SendSupport", country, money, manpower)
    end)
    return true
end

local function cedeOwnedCitiesForAutoSupport(country)
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_4")
    if not remote or not remote:IsA("RemoteEvent") then return 0 end
    if country == "" or country == "No countries" then return 0 end
    local cities = getOwnedCities()
    if #cities == 0 or cities[1] == "No owned cities" then return 0 end
    local count = 0
    for _, city in ipairs(cities) do
        if not AutoSupportEnabled then break end
        if AutoSupportCededCities[city] ~= country then
            local ok = pcall(function()
                remote:FireServer("CedeCity", city, country)
            end)
            if ok then
                AutoSupportCededCities[city] = country
                count = count + 1
            end
            task.wait(0.8)
        end
    end
    return count
end

local CedeSupportGroup = Tabs.Army:AddRightGroupbox("🤝 Cede / Support")
local SupportStatus = CedeSupportGroup:AddLabel("Money: 0 | Manpower: 0")
CedeSupportGroup:AddButton("🔄 Refresh Support Amounts", function()
    local money, manpower = getSupportAmounts()
    SupportStatus:SetText("Money: " .. tostring(money) .. " | Manpower: " .. tostring(manpower))
end)
CedeSupportGroup:AddInput("ControlEuropeSupportMoney", {
    Text = "Support Money Override (0 = Auto)",
    Default = "0",
    Numeric = true,
    Finished = true,
    Callback = function(value) SupportMoneyOverride = tonumber(value) or 0 end,
})
CedeSupportGroup:AddInput("ControlEuropeSupportManpower", {
    Text = "Support Manpower Override (0 = Auto)",
    Default = "0",
    Numeric = true,
    Finished = true,
    Callback = function(value) SupportManpowerOverride = tonumber(value) or 0 end,
})
CedeCityDropdown = CedeSupportGroup:AddDropdown("ControlEuropeCedeCity", {
    Text = "Select Owned City",
    Values = getOwnedCities(),
    Default = "",
    Callback = function(value)
        if value ~= "No owned cities" then SelectedCedeCity = tostring(value) end
    end,
})
SupportCountryDropdown = CedeSupportGroup:AddDropdown("ControlEuropeSupportCountry", {
    Text = "Select Recipient Country",
    Values = getSupportCountries(),
    Default = "",
    Callback = function(value)
        if value ~= "No countries" then SelectedSupportCountry = tostring(value) end
    end,
})
CedeSupportGroup:AddDropdown("ControlEuropeSupportPlayer", {
    Text = "Select Recipient Player",
    Values = getPlayerCountries(),
    Default = "",
    Callback = function(value)
        local country = getPlayerCountry(tostring(value))
        if country then
            SelectedSupportCountry = country
            if SupportCountryDropdown then SupportCountryDropdown:SetValue(country) end
        else
            notify("Support", "That player has no detected country.", 3)
        end
    end,
})
CedeSupportGroup:AddButton("🔄 Refresh Cities / Countries", function()
    if CedeCityDropdown then CedeCityDropdown:SetValues(getOwnedCities()) end
    if SupportCountryDropdown then SupportCountryDropdown:SetValues(getSupportCountries()) end
end)
CedeSupportGroup:AddButton("🏳️ Cede Selected City", function()
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_4")
    if SelectedCedeCity == "" or SelectedSupportCountry == "" then
        notify("Cede Land", "Select an owned city and recipient country first.", 3)
        return
    end
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Cede Land", "RemoteEvent_4 was not found.", 3)
        return
    end
    pcall(function()
        remote:FireServer("CedeCity", SelectedCedeCity, SelectedSupportCountry)
    end)
    notify("Cede Land", "Cede request sent for " .. SelectedCedeCity .. ".", 4)
end)
CedeSupportGroup:AddButton("🏳️ Cede All Owned Cities", function()
    local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_4")
    local cities = getOwnedCities()
    if SelectedSupportCountry == "" or #cities == 0 or cities[1] == "No owned cities" then
        notify("Cede Land", "Select a recipient country first.", 3)
        return
    end
    if not remote or not remote:IsA("RemoteEvent") then
        notify("Cede Land", "RemoteEvent_4 was not found.", 3)
        return
    end
    task.spawn(function()
        local count = 0
        for _, city in ipairs(cities) do
            pcall(function()
                remote:FireServer("CedeCity", city, SelectedSupportCountry)
            end)
            count = count + 1
            task.wait(0.8)
        end
        notify("Cede Land", "Cede requests sent for " .. count .. " cities.", 5)
    end)
end)
CedeSupportGroup:AddButton("🤝 Send All Money / Manpower Once", function()
    if sendSupportToCountry(SelectedSupportCountry) then
        notify("Support", "Support sent to " .. SelectedSupportCountry .. ".", 4)
    end
end)
CedeSupportGroup:AddToggle("ControlEuropeAutoSupport", {
    Text = "Auto Cede + Support + Switch",
    Default = false,
    Callback = function(value)
        AutoSupportEnabled = value == true
        if AutoSupportEnabled then
            AutoSupportCededCities = {}
        end
        if AutoSupportEnabled and not AutoSupportWorker then
            AutoSupportWorker = true
            task.spawn(function()
                while AutoSupportEnabled do
                    refreshCurrentCountrySilently()
                    local country = SelectedSupportCountry
                    if country ~= "" and country ~= "No countries" then
                        cedeOwnedCitiesForAutoSupport(country)
                        if AutoSupportEnabled then
                            task.wait(1)
                            sendSupportToCountry(country)
                        end
                        if AutoSupportEnabled then
                            task.wait(1)
                            if switchCountryForAutoSupport() then
                                AutoSupportCededCities = {}
                                task.wait(2)
                            else
                                task.wait(5)
                            end
                        end
                    else
                        task.wait(1)
                    end
                end
                AutoSupportWorker = false
            end)
        end
    end,
})

local CityGroup = Tabs.Cities:AddLeftGroupbox("🏙️ Cities")
local CityUpgradeMode = "Both"
local CityUpgradeDelay = 0.1
local CityUpgradeActive = false
local AutoCityUpgradeEnabled = false
local CityUpgradeToken = 0
local SelectedCapitalCity = ""
local CapitalCityDropdown = nil
local CapitalStatus = nil
local AutoCapitalTierEnabled = false
local CapitalTierWorker = false

local function stopCityUpgrades(showNotice)
    CityUpgradeActive = false
    AutoCityUpgradeEnabled = false
    CityUpgradeToken = CityUpgradeToken + 1
    if showNotice then notify("Cities", "City upgrades stopped.", 3) end
end

local function fireCityUpgrade(region, upgradeType)
    local names = { "DevelopTile", "Upgrade", "UpgradeCity", "LevelUp", "Develop" }
    TryFireAll(names, { region, upgradeType })
end

local function getOwnedRegionByName(name)
    local regions = getRegions()
    if not regions then return nil end
    for _, region in ipairs(regions:GetChildren()) do
        if region.Name == tostring(name) and isMyCountry(region:FindFirstChild("Country")) then
            return region
        end
    end
    return nil
end

local function isCapitalValue(value)
    if value == true or value == 1 then return true end
    local text = string.lower(tostring(value or ""))
    return text == "true" or text == "yes" or text == "capital" or text == "1"
end

local function getCapitalRegion()
    if not MyCountry then GetMyCountry() end
    if SelectedCapitalCity ~= "" then
        local selected = getOwnedRegionByName(SelectedCapitalCity)
        if selected then return selected end
    end
    local regions = getRegions()
    if not regions then return nil end
    local ownedByName = {}
    local ownedRegions = {}
    for _, region in ipairs(regions:GetChildren()) do
        if isMyCountry(region:FindFirstChild("Country")) then
            ownedByName[region.Name] = region
            table.insert(ownedRegions, region)
        end
    end
    for _, region in ipairs(ownedRegions) do
        if string.find(string.lower(region.Name), "capital", 1, true) then
            return region
        end
        for _, object in ipairs(region:GetDescendants()) do
            local name = string.lower(object.Name)
            if name == "capital" or name == "iscapital" or name == "capitalcity" or name == "capitalregion" then
                if object:IsA("BoolValue") and object.Value then return region end
                if object:IsA("IntValue") or object:IsA("NumberValue") or object:IsA("StringValue") then
                    if isCapitalValue(object.Value) or tostring(object.Value) == region.Name then return region end
                end
            end
        end
    end
    local roots = { LocalPlayer:FindFirstChild("leaderstats"), LocalPlayer, LocalPlayer:FindFirstChildOfClass("PlayerGui") }
    for _, root in ipairs(roots) do
        if root then
            for _, object in ipairs(root:GetDescendants()) do
                local name = string.lower(object.Name)
                if name == "capital" or name == "capitalcity" or name == "capitalregion" then
                    local value = nil
                    if object:IsA("StringValue") or object:IsA("IntValue") or object:IsA("NumberValue") then
                        value = tostring(object.Value)
                    elseif object:IsA("TextLabel") then
                        value = object.Text
                    end
                    if value and ownedByName[value] then return ownedByName[value] end
                end
            end
        end
    end
    return nil
end

local function updateCapitalStatus(region)
    if not CapitalStatus then return end
    if region then
        CapitalStatus:SetText("Capital: " .. region.Name)
    else
        CapitalStatus:SetText("Capital: select your owned capital")
    end
end

local function startCapitalTierWorker()
    if CapitalTierWorker then return end
    CapitalTierWorker = true
    task.spawn(function()
        while AutoCapitalTierEnabled do
            local capital = getCapitalRegion()
            updateCapitalStatus(capital)
            if capital then
                fireCityUpgrade(capital, "Tier")
                task.wait(math.max(CityUpgradeDelay, 0.1))
            else
                task.wait(1)
            end
        end
        CapitalTierWorker = false
    end)
end

local function runCityUpgradeWorker(autoMode)
    if CityUpgradeActive then return end
    if not MyCountry then GetMyCountry() end
    local regions = getRegions()
    if not MyCountry or not regions then
        notify("Cities", "Country or Regions folder was not found.", 4)
        return
    end

    CityUpgradeActive = true
    CityUpgradeToken = CityUpgradeToken + 1
    local token = CityUpgradeToken
    task.spawn(function()
        local total = 0
        repeat
            for _, region in ipairs(regions:GetChildren()) do
                if not CityUpgradeActive or token ~= CityUpgradeToken then break end
                if isMyCountry(region:FindFirstChild("Country")) then
                    if CityUpgradeMode == "Tier" or CityUpgradeMode == "Both" then
                        fireCityUpgrade(region, "Tier")
                        total = total + 1
                        task.wait(CityUpgradeDelay)
                    end
                    if not CityUpgradeActive or token ~= CityUpgradeToken then break end
                    if CityUpgradeMode == "Defense" or CityUpgradeMode == "Both" then
                        fireCityUpgrade(region, "Def")
                        total = total + 1
                        task.wait(CityUpgradeDelay)
                    end
                end
            end
            if autoMode and AutoCityUpgradeEnabled and CityUpgradeActive and token == CityUpgradeToken then
                task.wait(math.max(CityUpgradeDelay, 0.05))
            else
                break
            end
        until false
        if token == CityUpgradeToken then
            CityUpgradeActive = false
            if not autoMode then notify("Cities", "Sent " .. total .. " upgrade requests.", 4) end
        end
    end)
end

CapitalStatus = CityGroup:AddLabel("Capital: select your owned capital")
CapitalCityDropdown = CityGroup:AddDropdown("ControlEuropeCapitalCity", {
    Text = "Select Capital City",
    Values = getOwnedCities(),
    Default = "",
    Callback = function(value)
        if value ~= "No owned cities" then
            SelectedCapitalCity = tostring(value)
            updateCapitalStatus(getCapitalRegion())
        end
    end,
})
CityGroup:AddButton("🔄 Refresh Capital Cities", function()
    if CapitalCityDropdown then CapitalCityDropdown:SetValues(getOwnedCities()) end
    local capital = getCapitalRegion()
    if capital and SelectedCapitalCity == "" then
        SelectedCapitalCity = capital.Name
        if CapitalCityDropdown then CapitalCityDropdown:SetValue(capital.Name) end
    end
    updateCapitalStatus(capital)
end)
CityGroup:AddButton("Upgrade Capital Tier Once", function()
    local capital = getCapitalRegion()
    updateCapitalStatus(capital)
    if not capital then
        notify("Cities", "Select your capital city first.", 3)
        return
    end
    fireCityUpgrade(capital, "Tier")
    notify("Cities", "Tier upgrade sent for " .. capital.Name .. ".", 3)
end)
CityGroup:AddToggle("ControlEuropeAutoCapitalTier", {
    Text = "Auto Upgrade Capital Tier",
    Default = false,
    Callback = function(value)
        AutoCapitalTierEnabled = value == true
        if AutoCapitalTierEnabled then startCapitalTierWorker() end
    end,
})

CityGroup:AddDropdown("ControlEuropeCityUpgradeMode", {
    Text = "City Upgrade Type",
    Values = { "Tier", "Defense", "Both" },
    Default = CityUpgradeMode,
    Callback = function(value) CityUpgradeMode = tostring(value) end,
})
CityGroup:AddSlider("ControlEuropeCityUpgradeDelay", {
    Text = "City Upgrade Delay",
    Min = 0.05,
    Max = 2,
    Default = CityUpgradeDelay,
    Rounding = 2,
    Callback = function(value) CityUpgradeDelay = value end,
})
CityGroup:AddButton("Upgrade Selected Type Once", function()
    runCityUpgradeWorker(false)
end)
CityGroup:AddToggle("ControlEuropeAutoCityUpgrades", {
    Text = "Auto Upgrade Cities",
    Default = false,
    Callback = function(value)
        AutoCityUpgradeEnabled = value == true
        if AutoCityUpgradeEnabled then
            runCityUpgradeWorker(true)
        else
            stopCityUpgrades(false)
        end
    end,
})
CityGroup:AddButton("⏹ Stop City Upgrades", function()
    stopCityUpgrades(true)
    AutoCapitalTierEnabled = false
end)

local AutoTechnologyEnabled = false
local AutoTechnologyWorker = false
local TechnologyDelay = 4
local TechnologyQueue = {
    { Remote = "RemoteEvent_1", Upgrade = 1 },
    { Remote = "RemoteEvent_2", Upgrade = 1 },
    { Remote = "RemoteEvent_3", Upgrade = 2 },
    { Remote = "RemoteEvent_1", Upgrade = 3 },
    { Remote = "RemoteEvent_2", Upgrade = 3 },
    { Remote = "RemoteEvent_3", Upgrade = 9 },
    { Remote = "RemoteEvent_4", Upgrade = 9 },
    { Remote = "RemoteEvent_2", Upgrade = 10 },
    { Remote = "RemoteEvent_2", Upgrade = 11 },
    { Remote = "RemoteEvent_3", Upgrade = 11 },
    { Remote = "RemoteEvent_4", Upgrade = 11 },
    { Remote = "RemoteEvent_2", Upgrade = 13 },
    { Remote = "RemoteEvent_1", Upgrade = 14 },
    { Remote = "RemoteEvent_3", Upgrade = 15 },
    { Remote = "RemoteEvent_3", Upgrade = 21 },
    { Remote = "RemoteEvent_1", Upgrade = 22 },
    { Remote = "RemoteEvent_4", Upgrade = 22 },
    { Remote = "RemoteEvent_4", Upgrade = 23 },
    { Remote = "RemoteEvent_1", Upgrade = 29 },
    { Remote = "RemoteEvent_2", Upgrade = 29 },
    { Remote = "RemoteEvent_1", Upgrade = 30 },
    { Remote = "RemoteEvent_3", Upgrade = 30 },
    { Remote = "RemoteEvent_4", Upgrade = 30 },
    { Remote = "RemoteEvent_3", Upgrade = 31 },
    { Remote = "RemoteEvent_4", Upgrade = 35 },
    { Remote = "RemoteEvent_2", Upgrade = 37 },
    { Remote = "RemoteEvent_2", Upgrade = 38 },
    { Remote = "RemoteEvent_3", Upgrade = 41 },
    { Remote = "RemoteEvent_4", Upgrade = 41 },
    { Remote = "RemoteEvent_3", Upgrade = 42 },
    { Remote = "RemoteEvent_3", Upgrade = 53 },
}

local function buyTechnology(entry)
    local remote = ReplicatedStorage:FindFirstChild(entry.Remote)
    if remote and remote:IsA("RemoteEvent") then
        pcall(function()
            remote:FireServer("BuyUpgrade", entry.Upgrade)
        end)
    end
end

local TechnologyGroup = Tabs.Cities:AddRightGroupbox("🧪 Technology")
TechnologyGroup:AddToggle("ControlEuropeAutoTechnology", {
    Text = "Auto Technology",
    Default = false,
    Callback = function(value)
        AutoTechnologyEnabled = value == true
        if AutoTechnologyEnabled and not AutoTechnologyWorker then
            AutoTechnologyWorker = true
            task.spawn(function()
                while AutoTechnologyEnabled do
                    local index = 1
                    while index <= #TechnologyQueue and AutoTechnologyEnabled do
                        local sent = 0
                        while sent < 2 and index <= #TechnologyQueue and AutoTechnologyEnabled do
                            buyTechnology(TechnologyQueue[index])
                            index = index + 1
                            sent = sent + 1
                            task.wait(0.2)
                        end
                        if AutoTechnologyEnabled then
                            task.wait(12)
                        end
                    end
                    if AutoTechnologyEnabled then
                        task.wait(1)
                    end
                end
                AutoTechnologyWorker = false
            end)
        end
    end,
})
TechnologyGroup:AddLabel("Keeps retrying all supplied upgrades in batches of three.")

local MiscGroup = Tabs.Misc:AddLeftGroupbox("🎁 Misc")
MiscGroup:AddToggle("ControlEuropeSantaGifts", {
    Text = "Auto Collect Santa Gifts",
    Default = false,
    Callback = function(value)
        AutoSantaEnabled = value == true
    end,
})

local SettingsGroup = Tabs.Settings:AddLeftGroupbox("⚙️ Menu")
SettingsGroup:AddLabel("MIAMI | CONTROL EUROPE")
SettingsGroup:AddToggle("ControlEuropeReduceNotifications", {
    Text = "Reduce Notifications",
    Default = true,
    Callback = function(value)
        setReduceNotifications(value)
    end,
})
setReduceNotifications(true)
SettingsGroup:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })
SettingsGroup:AddButton("Unload", function()
    Library:Unload()
end)

local controlWorker = task.spawn(function()
    task.wait(2)
    GetMyCountry()
    while getgenv().ControlEuropeMiamiAlive do
        if AutoCaptureEnabled and MyCountry then
            local soldiers = getSoldiers()
            if soldiers then
                local names = { "ToggleAutoCapture", "SetAutoCapture", "AutoCapture", "ToggleAuto" }
                for _, unit in ipairs(soldiers:GetChildren()) do
                    if isMyCountry(unit:FindFirstChild("Country")) then
                        TryFireAll(names, { unit, true })
                        TryFireAll(names, { unit, true, "Attack" })
                    end
                end
            end
        end
        if AutoSantaEnabled then
            for index = 1, 5 do
                local remote = ReplicatedStorage:FindFirstChild("RemoteEvent_" .. index)
                if remote and remote:IsA("RemoteEvent") then
                    pcall(function() remote:FireServer("PickedUpSantaGift") end)
                end
            end
        end
        task.wait(AutoSantaEnabled and 0.15 or 0.6)
    end
end)

Library:OnUnload(function()
    getgenv().ControlEuropeMiamiAlive = false
    AutoCaptureEnabled = false
    AutoSantaEnabled = false
    AutoTechnologyEnabled = false
    AutoSupportEnabled = false
    AutoCityUpgradeEnabled = false
    AutoCapitalTierEnabled = false
    CityUpgradeActive = false
    if NotificationWatcher then NotificationWatcher:Disconnect() end
    if controlWorker then pcall(function() task.cancel(controlWorker) end) end
end)
