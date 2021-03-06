# Debug Sample

Sample showing how to use .Net debugging on Windows, OSX, and Linux.

## Requirements

1. Ionide
2. C# extenison
3. `dotnet` CLI 1.0.4
4. Projects using Portable PDBs (`<DebugType>portable</DebugType>`)

## How to run samples

1. Clone repo
2. `build.cmd` / `build.sh`
3. `code .`
4. Open debug panel (`Ctrl + Shift + D` on windows)
5. Choose target (`CLR` vs `.Net Core`) in combobox
6. Press green arrow or `F5`

## Full Framework (4.6.1) - Windows

Tasks defined in `tasks.json`:

```
{
    "taskName": "restore CLR",
    "command": "dotnet",
    "type": "shell",
    "args": [
        "restore",
        "src/CLR/CLR.fsproj"
    ],
    "presentation": {
        "reveal": "silent"
    },
    "problemMatcher": "$msCompile"
},
{
    "taskName": "build CLR",
    "command": "dotnet",
    "type": "shell",
    "group": "build",
    "args": [
        "build",
        "src/CLR/CLR.fsproj"
    ],
    "dependsOn": "restore CLR",
    "presentation": {
        "reveal": "silent"
    },
    "problemMatcher": "$msCompile"
}
```

Debugger configuration in `launch.json`:
```
{
    "name": ".NET CLR Launch",
    "type": "clr",
    "request": "launch",
    "preLaunchTask": "build CLR",
    "program": "${workspaceRoot}/src/CLR/bin/Debug/net461/CLR.exe",
    "args": [],
    "cwd": "${workspaceRoot}",
    "stopAtEntry": false,
    "console": "internalConsole"
}
```

## Full Framework (4.6.1) - mono (Linux / OSX)

Mono version requires `mono-debugger` extenison and bit of magic.

Helper script `msbuild.sh`:
```
#!/usr/bin/env bash
DOTNET_CLI_PATH="$(dirname $(which dotnet))/sdk/$(dotnet --version)"
export MSBuildExtensionsPath="$DOTNET_CLI_PATH/"
export CscToolExe="$DOTNET_CLI_PATH/Roslyn/RunCsc.sh"
export MSBuildSDKsPath="$DOTNET_CLI_PATH/Sdks"

msbuild /nologo "$@"
```

Tasks defined in `tasks.json`:
```
{
    "taskName": "build Mono",
    "command": "./msbuild.sh",
    "type": "shell",
    "group": "build",
    "args": [
        "src/CLR/CLR.fsproj"
    ],
    "dependsOn": "restore CLR",
    "problemMatcher": "$msCompile"
},
```

Debugger configuration in `launch.json`:
```
{
    "name": ".NET CLR Launch",
    "linux": {
        "type": "mono",
        "preLaunchTask": "build Mono"
    },           
     "osx": {
        "type": "mono",
        "preLaunchTask": "build Mono"
    },
    "type": "clr",
    "request": "launch",
    "preLaunchTask": "build CLR",
    "program": "${workspaceRoot}/src/CLR/bin/Debug/net461/CLR.exe",
    "args": [],
    "cwd": "${workspaceRoot}",
    "stopAtEntry": false,
    "console": "internalConsole"
},
```

## .Net Core

Tasks defined in `tasks.json`:

```
{
    "taskName": "restore DotNetCore",
    "command": "dotnet",
    "type": "shell",
    "args": [
        "restore",
        "src/DotNetCore/DotNetCore.fsproj"
    ],
    "presentation": {
        "reveal": "silent"
    },
    "problemMatcher": "$msCompile"
},
{
    "taskName": "build DotNetCore",
    "command": "dotnet",
    "type": "shell",
    "group": "build",
    "args": [
        "build",
        "src/DotNetCore/DotNetCore.fsproj"
    ],
    "dependsOn": "restore DotNetCore",
    "presentation": {
        "reveal": "silent"
    },
    "problemMatcher": "$msCompile"
}
```

Debugger configuration in `launch.json`:
```
{
    "name": ".NET Core Launch",
    "type": "coreclr",
    "request": "launch",
    "preLaunchTask": "build DotNetCore",
    "program": "${workspaceRoot}/src/DotNetCore/bin/Debug/netcoreapp1.0/DotNetCore.dll",
    "args": [],
    "cwd": "${workspaceRoot}",
    "stopAtEntry": false,
    "console": "internalConsole"
}
```
