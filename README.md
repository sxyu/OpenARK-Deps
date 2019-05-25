# OpenARK Dependency Pack Creator

Code for creating the [OpenARK](https://github.com/augcog/openark) dependency pack.

To create the installer, put all dependencies in `../arkdeps` directory (relative to the repo root) and use [NSIS](https://nsis.sourceforge.io) to compile `main.nsi`. The [EnVar](https://nsis.sourceforge.io/EnVar_plug-in) NSIS plugin is required.

### Contents
Due to size, PCL is not included. Please download it from:
https://github.com/PointCloudLibrary/pcl/releases/download/pcl-1.8.1/PCL-1.8.1-AllInOne-msvc2015-win64.exe

Make sure to select the option to add PCL to PATH. Boost and OpenNI will also be installed as part of this.

This dependency pack contains the following:
- Brisk
- Ceres
- DBoW2
- DLib
- DLoopDetector
- eigen3
- glog
- librealsense2
- okvis
- OpenCV + contrib
- OpenGV
- SuiteSparse

## Details

### binaries 
 We expect the directory `../arkdeps/bin` to contain all binaries (DLLs, executables) from dependencies. This will be added to PATH automatically after installation. Combining the binary directories helps to prevent PATH from getting too long.
 
### ARK_DEPS_DIR
 The ARK_DEPS_DIR environment variable will be set to the install directory. OpenARK's CMakeLists is set up to find the dependencies here if available.
 
### CMakeLists.txt
 The install directory should contain `CMakeLists.txt`, a CMake script to set dependency paths automatically.
 
## License
Apache 2.0. See [augcog/OpenARK](https://github.com/augcog/openark) for the license.
