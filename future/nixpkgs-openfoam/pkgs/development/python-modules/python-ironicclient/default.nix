{
  lib,
  buildPythonPackage,
  fetchPypi,
  cliff,
  dogpile-cache,
  jsonschema,
  keystoneauth1,
  openstackdocstheme,
  openstacksdk,
  osc-lib,
  oslo-utils,
  oslotest,
  pbr,
  platformdirs,
  pyyaml,
  requests,
  requests-mock,
  setuptools,
  sphinxcontrib-apidoc,
  sphinxHook,
  stestr,
  stevedore,
}:

buildPythonPackage rec {
  pname = "python-ironicclient";
  version = "5.10.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Eg2eakri5+1hPuKyq9+f4dL33il6G4LYLZvoWYfU4LY=";
  };

  build-system = [
    openstackdocstheme
    setuptools
    sphinxcontrib-apidoc
    sphinxHook
  ];

  sphinxBuilders = [ "man" ];

  dependencies = [
    cliff
    dogpile-cache
    jsonschema
    keystoneauth1
    openstacksdk
    osc-lib
    oslo-utils
    pbr
    platformdirs
    pyyaml
    requests
    stevedore
  ];

  nativeCheckInputs = [
    stestr
    requests-mock
    oslotest
  ];

  checkPhase = ''
    runHook preCheck
    stestr run
    runHook postCheck
  '';

  pythonImportsCheck = [ "ironicclient" ];

  meta = with lib; {
    description = "Client for OpenStack bare metal provisioning API, includes a Python module (ironicclient) and CLI (baremetal)";
    mainProgram = "baremetal";
    homepage = "https://github.com/openstack/python-ironicclient";
    license = licenses.asl20;
    maintainers = teams.openstack.members;
  };
}
