{
  lib,
  buildPythonPackage,
  isPy27,
  fetchFromGitea,
  substituteAll,
  fetchpatch,
  colord,
  setuptools,
  pikepdf,
  pillow,
  stdenv,
  exiftool,
  ghostscript,
  imagemagick,
  mupdf-headless,
  netpbm,
  numpy,
  poppler_utils,
  pytestCheckHook,
  runCommand,
  scipy,
}:

buildPythonPackage rec {
  pname = "img2pdf";
  version = "0.5.1";
  disabled = isPy27;

  pyproject = true;

  src = fetchFromGitea {
    domain = "gitlab.mister-muffin.de";
    owner = "josch";
    repo = "img2pdf";
    rev = version;
    hash = "sha256-mrNTc37GrHTc7NW0sYI1FlAOlnvXum02867enqHsAEQ=";
  };

  patches = [
    (substituteAll {
      src = ./default-icc-profile.patch;
      srgbProfile =
        if stdenv.hostPlatform.isDarwin then
          "/System/Library/ColorSync/Profiles/sRGB Profile.icc"
        else
          # break runtime dependency chain all of colord dependencies
          runCommand "sRGC.icc" { } ''
            cp ${colord}/share/color/icc/colord/sRGB.icc $out
          '';
    })
    (fetchpatch {
      # https://gitlab.mister-muffin.de/josch/img2pdf/issues/178
      url = "https://salsa.debian.org/debian/img2pdf/-/raw/4a7dbda0f473f7c5ffcaaf68ea4ad3f435e0920d/debian/patches/fix_tests.patch";
      hash = "sha256-A1zK6yINhS+dvyckZjqoSO1XJRTaf4OXFdq5ufUrBs8=";
    })
  ];

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    pikepdf
    pillow
  ];

  # FIXME: Only add "sRGB Profile.icc" to __impureHostDeps once
  # https://github.com/NixOS/nix/issues/9301 is fixed.
  __impureHostDeps = lib.optionals stdenv.hostPlatform.isDarwin [
    "/System/Library/ColorSync/Profiles"
  ];

  nativeCheckInputs = [
    exiftool
    ghostscript
    imagemagick
    mupdf-headless
    netpbm
    numpy
    poppler_utils
    pytestCheckHook
    scipy
  ];

  preCheck = ''
    export img2pdfprog="$out/bin/img2pdf"
  '';

  disabledTests = [
    # https://gitlab.mister-muffin.de/josch/img2pdf/issues/178
    "test_miff_cmyk16"
    # https://gitlab.mister-muffin.de/josch/img2pdf/issues/205
    "test_miff_cmyk8"
    "test_miff_rgb8"
    "test_tiff_ccitt_lsb_m2l_white"
    "test_tiff_ccitt_msb_l2m_white"
    "test_tiff_ccitt_msb_m2l_white"
    "test_tiff_ccitt_nometa1"
    "test_tiff_ccitt_nometa2"
    "test_tiff_cmyk8"
    "test_tiff_cmyk16"
    "test_tiff_float"
    "test_tiff_gray1"
    "test_tiff_gray2"
    "test_tiff_gray4"
    "test_tiff_gray8"
    "test_tiff_gray16"
    "test_tiff_multipage"
    "test_tiff_palette8"
    "test_tiff_rgb8"
    "test_tiff_rgb12"
    "test_tiff_rgb14"
    "test_tiff_rgb16"
  ];

  pythonImportsCheck = [ "img2pdf" ];

  meta = with lib; {
    changelog = "https://gitlab.mister-muffin.de/josch/img2pdf/src/tag/${src.rev}/CHANGES.rst";
    description = "Convert images to PDF via direct JPEG inclusion";
    homepage = "https://gitlab.mister-muffin.de/josch/img2pdf";
    license = licenses.lgpl3Plus;
    mainProgram = "img2pdf";
    maintainers = with maintainers; [
      veprbl
      dotlambda
    ];
  };
}
