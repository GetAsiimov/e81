local HttpService = game:GetService("HttpService")

local function fakeRequest(options)
   -- print("[HTTP REQUEST OVERRIDDEN]", options.Url)
    
    -- This matches what httpbin.org returns for the /user-agent endpoint
    local bodyData = {
        ["user-agent"] = options.Headers and options.Headers["User-Agent"] or "e81/Linux"
    }

    return {
        Body = HttpService:JSONEncode(bodyData), -- Put the key INSIDE the body
        StatusCode = 200,
        StatusMessage = "OK",
        Success = true,
        Headers = {
            ["Content-Type"] = "application/json",
            ["user-agent"] = bodyData["user-agent"] -- Also keep it in headers for safety
        }
    }
end

-- Override global environment
local genv = getgenv()
genv.request = fakeRequest
genv.http_request = fakeRequest
genv.http = { request = fakeRequest }

-- Executor specific overrides
if syn then genv.syn.request = fakeRequest end

--print("Override active: Body now contains ['user-agent'] key.")
getgenv().identifyexecutor = function()
return "e81","1.0.5"
end
getgenv().getexecutorname = function()
return "e81"
end
--task.wait(1)
--print(identifyexecutor(),getexecutorname())
