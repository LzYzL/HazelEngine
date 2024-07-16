# HazelEngine

### 2024-6-26
imgui部分数次因为版本不同出现bug，应注意用git与教程所用版本保持同步  

### 2024-7-15 OpenGL
向显卡传入vertex array (VAO)和Shader  
  
VAO包含对vertex attribute, vertex buffer, index buffer的设置  
Shader包含vertex shader和fragment shader  
  
设置view matrix， projection matrix，并将它们通过uniform矩阵传入shader程序
在shader中用viewProjectionMatrix对vertex的坐标进行运算，达到摄像机的效果
  
  

在onUpdate中判断按键操作，可使每秒响应次数与帧数一致  
