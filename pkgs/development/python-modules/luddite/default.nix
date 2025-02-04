{ lib
, buildPythonPackage
, fetchFromGitHub
, packaging
, pytestCheckHook
, pytest-mock
}:

buildPythonPackage rec {
  pname = "luddite";
  version = "1.0.3";

  src = fetchFromGitHub {
    owner = "jumptrading";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-JXIM7/5LO95oabM16GwAt3v3a8uldGpGXDWmVic8Ins=";
  };

  postPatch = ''
    substituteInPlace pytest.ini \
      --replace "--cov=luddite --cov-report=html --cov-report=term --no-cov-on-fail" "" \
      --replace "--disable-socket" ""
  '';

  propagatedBuildInputs = [ packaging ];

  nativeCheckInputs = [ pytestCheckHook pytest-mock ];
  pythonImportsCheck = [ "luddite" ];

  meta = with lib; {
    description = "Checks for out-of-date package versions";
    homepage = "https://github.com/jumptrading/luddite";
    license = licenses.asl20;
    maintainers = with maintainers; [ emilytrau ];
  };
}
