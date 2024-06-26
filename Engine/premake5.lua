workspace "Hazel"
    architecture "x86_64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

outputdir="%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir={}
IncludeDir["GLFW"]= "Hazel/vendor/GLFW/include"
IncludeDir["Glad"]= "Hazel/vendor/Glad/include"
IncludeDir["ImGui"]= "Hazel/vendor/imgui"
IncludeDir["glm"]= "Hazel/vendor/glm"

include "Hazel/vendor/GLFW"
include "Hazel/vendor/Glad"
include "Hazel/vendor/imgui"

project "Hazel"
    location "Hazel"
    kind "SharedLib"
    language "C++"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "hzpch.h"
    pchsource "Hazel/src/hzpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{IncludeDir.GLFW}",
        "%{IncludeDir.Glad}",
        "%{IncludeDir.ImGui}",
        "%{IncludeDir.glm}"
    }

    links
    {
        "GLFW",
        "Glad",
        "ImGui",
        "OpenGL32.lib"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "HZ_BUILD_DLL",
            "GLFW_INCLUDE_NONE"
            -- "_WINDLL"
        }
    
        postbuildcommands
        { 
            "{RMDIR} ../bin/" .. outputdir .. "/Sandbox",
            "{MKDIR} ../bin/" .. outputdir .. "/Sandbox",    
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }
            
    filter  "configurations:Debug"
        defines "HZ_DEBUG"
        buildoptions "/MDd"
        symbols "On"

    filter  "configurations:Release"
        defines "HZ_RELEASE"
        buildoptions "/MD"
        optimize "On"

    filter  "configurations:Dist"
        defines "HZ_DIST"
        buildoptions "/MD"
        optimize "On"

    -- filters {"system:windows","configuration:Release"}
    --     buildoptions "/MT"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "Hazel/vendor/spdlog/include",
        "Hazel/src",		
        "Hazel/vendor",
        "%{IncludeDir.glm}",
        "%{IncludeDir.ImGui}"
    }

    links
    {
        "Hazel"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
        }
    
        -- postbuildcommands
        -- {
        --     "{RMDIR} ../bin/" .. outputdir .. "/Sandbox",
        --     "{MKDIR} ../bin/" .. outputdir .. "/Sandbox",    
        --     ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        -- }
    
    filter  "configurations:Debug"
        defines "HZ_DEBUG"
        buildoptions "/MDd"
        symbols "On"

    filter  "configurations:Release"
        defines "HZ_RELEASE"
        buildoptions "/MD"
        optimize "On"

    filter  "configurations:Dist"
        defines "HZ_DIST"
        buildoptions "/MD"
        optimize "On"