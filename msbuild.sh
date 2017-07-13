#!/usr/bin/env bash
DOTNET_CLI_PATH="$(dirname $(which dotnet))/sdk/$(dotnet --version)"
export MSBuildExtensionsPath="$DOTNET_CLI_PATH/"
export CscToolExe="$DOTNET_CLI_PATH/Roslyn/RunCsc.sh"
export MSBuildSDKsPath="$DOTNET_CLI_PATH/Sdks"

msbuild /nologo "$@"