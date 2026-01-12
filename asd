local HttpService = game:GetService("HttpService")

local function fakeRequest(options)

    

    local bodyData = {
        ["user-agent"] = options.Headers and options.Headers["User-Agent"] or "vxqs/Atlantis"
    }

    return {
        Body = HttpService:JSONEncode(bodyData), -- Puts it inside the body
        StatusCode = 200,
        StatusMessage = "OK",
        Success = true,
        Headers = {
            ["Content-Type"] = "application/json",
            ["user-agent"] = bodyData["user-agent"]
        }
    }
end


local genv = getgenv()
genv.request = fakeRequest
genv.http_request = fakeRequest
genv.http = { request = fakeRequest }


if syn then genv.syn.request = fakeRequest end


getgenv().identifyexecutor = function()
return "vxqs/Atlantis","1.0.5"
end
getgenv().getexecutorname = function()
return "vxqs/Atlantis"
end
local common = game:GetService("CoreGui").RobloxGui.Modules.Common
local commonutil = common.CommonUtil
local constants = commonutil:Clone()
constants.Name = "Constants"
constants.Parent = common
--task.wait(1)
--print(identifyexecutor(),getexecutorname())
