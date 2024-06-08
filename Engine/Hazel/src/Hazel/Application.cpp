#include "hzpch.h"
#include "Application.h"
#include "Hazel/Events/ApplicationEvent.h"
#include "Hazel/log.h"

#include <GLFW/glfw3.h>

namespace Hazel 
{
	Application::Application()
	{
		m_Window = std::unique_ptr<Window>(Window::Create());
	}

	Application::~Application()
	{

	}

	void Application::run()
	{
		if (0)
		{
			WindowResizeEvent e(1200, 720);
			// HZ_TRACE(e); in game engine series
			// don't know why failed to build
			HZ_TRACE(e.ToString());
		}

		while (m_Running)
		{
			glClearColor(1, 0, 1, 1);
			glClear(GL_COLOR_BUFFER_BIT);
			m_Window->OnUpdate();
		}
		
	}
}