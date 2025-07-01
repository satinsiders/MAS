import os

REQUIRED_VARS = [
    "OPENAI_API_KEY",
    "AZURE_CLIENT_ID",
    "AZURE_TENANT_ID",
    "AZURE_SUBSCRIPTION_ID",
    "POSTGRES_USER",
    "POSTGRES_PASSWORD",
    "POSTGRES_DB",
]


def load_config() -> dict:
    """Load and validate required environment variables."""
    missing = [var for var in REQUIRED_VARS if not os.getenv(var)]
    if missing:
        raise RuntimeError(
            f"Missing required environment variables: {', '.join(missing)}"
        )
    return {var: os.getenv(var) for var in REQUIRED_VARS}


CONFIG = load_config()
