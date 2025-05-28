{config, lib, pkgs, ... }:

{

home.packages = with pkgs; [
    git
    libgcc
    flex
    python313Packages.cmake
    rocmPackages.mpi
    mpi
    paraview
    #dependencies
    xml2 #
    hdf5 #
    libtheora #
    #libavfilter-dev
    gl2ps
    x11basic
    libsForQt5.qt5ct
];



}


# ---- list from openfoam ---- #
#openfoam-nopv-deps:
   # build-essential libopenmpi-dev zlib1g-dev gnuplot gnuplot-x11
   # libxt-dev cmake flex
#openfoam-deps:
   #libxml2-dev libhdf5-dev libavfilter-dev libtheora-dev libgl2ps-dev
    #libx11-dev libqt5x11extras5-dev libglew-dev libutfcpp-dev
    #libdouble-conversion-dev libfreetype-dev libqt5svg5-dev
    #qtxmlpatterns5-dev-tools qttools5-dev python3-dev
    #libpdal-dev # Ubuntu 22.04 and 20.04 only
   # libadios2-serial-c-dev libadios2-serial-c++11-dev # Ubuntu 24.04 only
