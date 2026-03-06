# devstreak-agent

Windows local activity collector for DevStreak.

## Folder Structure

```text
devstreak-agent/
├── requirements.txt
├── README.md
└── src/
    ├── config.py
    ├── main.py
    ├── event_sender.py
    ├── models.py
    ├── process_detector.py
    ├── git_watcher.py
    └── leetcode_poller.py
```

## Build / Setup

```bash
python -m venv .venv
source .venv/bin/activate   # Windows PowerShell: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

## Run

```bash
python src/main.py
```

Set optional environment variables:

- `DEVSTREAK_BACKEND_URL` (default `http://localhost:8080`)
- `DEVSTREAK_USER_ID` (default `pallav`)
- `DEVSTREAK_GIT_ROOT` (default current directory)
- `DEVSTREAK_LEETCODE_USERNAME` (default `pallav`)

## Notes

- IntelliJ is detected via `idea64.exe`.
- VS Code is detected via `Code.exe`.
- Git commits are detected by monitoring `.git/logs/HEAD`.
- LeetCode solved stats are polled from LeetCode GraphQL endpoint.
