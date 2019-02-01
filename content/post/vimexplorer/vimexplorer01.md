---
title: "vim方式操作windows的explorer"
date: 2019-02-01T15:49:09+08:00
draft: false
---
## 本节核心特性
1. 获取已经打开的窗口列表
2. 激活某个需要的窗口

## 下一节核心特性
1. 通过webbrowser渲染界面
2. c#和webBrowser交互

## 通过SHDocVw.ShellWindows 获取打开的explorer 窗口信息
1. c#中需要通过project的add reference 引入Microsoft Internaet controls 1.1
    因为我们需要通过SHDocVw.ShellWindows 来获得已经打开的exploer窗口
    SHDocVw.ShellWindows shellWindows = new SHDocVw.ShellWindowsClass();
2. 在references 种找到SHDocVw 关闭属性 embed interop Types 否则 SHDocVw.ShellWindowsClass 会编译不通过。

## 激活windows应用的窗口(SetForegroundWindow是不够的)
```c#
public void ActiveWindow(IntPtr hWnd) {

    if (hWnd == GetForegroundWindow())
        return;

    IntPtr ThreadID1 = GetWindowThreadProcessId(GetForegroundWindow(), IntPtr.Zero);
    IntPtr ThreadID2 = GetWindowThreadProcessId(hWnd, IntPtr.Zero);

    if (ThreadID1 != ThreadID2)
    {
        AttachThreadInput(ThreadID1, ThreadID2, 1);
        SetForegroundWindow(hWnd);
        AttachThreadInput(ThreadID1, ThreadID2, 0);
    }
    else
    {
        SetForegroundWindow(hWnd);
    }

    if (IsIconic(hWnd))
    {
        ShowWindowAsync(hWnd, SW_RESTORE);
    }
    else
    {
        ShowWindowAsync(hWnd, SW_SHOWNORMAL);
    }
}

```
