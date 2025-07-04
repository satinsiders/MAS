def test_sanity(monkeypatch):
    required = [
        "OPENAI_API_KEY",
        "AZURE_CLIENT_ID",
        "AZURE_TENANT_ID",
        "AZURE_SUBSCRIPTION_ID",
        "POSTGRES_USER",
        "POSTGRES_PASSWORD",
        "POSTGRES_DB",
    ]

    for var in required:
        monkeypatch.setenv(var, "dummy")

    import sys
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    if str(root) not in sys.path:
        sys.path.insert(0, str(root))

    import importlib

    config = importlib.import_module("virtual_department.config")
    importlib.reload(config)

    expected = {var: "dummy" for var in required}

    assert config.CONFIG == expected
