#include "hzpch.h"
#include "Application.h"
#include "Hazel/log.h"

#include <GLFW/glfw3.h>

namespace Hazel 
{

#define BIND_EVENT_FN(x) std::bind(&Application::x,this,std::placeholders::_1)

	Application::Application()
	{
		m_Window = std::unique_ptr<Window>(Window::Create());
		m_Window->SetEventCallback(BIND_EVENT_FN(OnEvent));
	}

	Application::~Application()
	{

	}

	void Application::OnEvent(Event& e)
	{

		EventDispatcher dispatcher(e);
		dispatcher.Dispatch<WindowCloseEvent>(BIND_EVENT_FN(OnWindowClose));

		HZ_CORE_TRACE(e.ToString());
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

	bool Application::OnWindowClose(WindowCloseEvent& e)
	{
		m_Running = false;
		return true;
	}
}