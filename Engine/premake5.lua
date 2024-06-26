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
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

    targetdir("bin/" .. outputdir .. "/%{prj.name}")
    objdir("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "hzpch.h"
    pchsource "Hazel/src/hzpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    defines
    {
        "_CRT_SECURE_NO_WARNINGS"
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
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "HZ_PLATFORM_WINDOWS",
            "HZ_BUILD_DLL",
            "GLFW_INCLUDE_NONE",
            -- "_WINDLL"
        }
            
    filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "on"

    -- filters {"system:windows","configuration:Release"}
    --     buildoptions "/MT"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++17"
    staticruntime "on"

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
        staticruntime "on"
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
    
    filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "on"