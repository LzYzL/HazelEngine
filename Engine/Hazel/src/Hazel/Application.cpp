#include "hzpch.h"
#include "Application.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "Hazel/log.h"

namespace Hazel 
{
	Application::Application()
	{

	}

	Application::~Application()
	{

	}

	void Application::run()
	{
		WindowResizeEvent e(1200, 720);
		// HZ_TRACE(e); in game engine series
		// don't know why failed to build
		HZ_TRACE(e.ToString());
		while (1);
	}
}