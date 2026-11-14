import os
from pathlib import Path
from mcp.server.fastmcp import FastMCP

# FastMCPサーバーの初期化
mcp = FastMCP("file-analyzer")

# ディレクトリ集計時にデフォルトで除外するディレクトリ名
DEFAULT_EXCLUDE_DIRS = frozenset({
    ".git",
    ".venv",
    "venv",
    "__pycache__",
    "node_modules",
    ".mypy_cache",
    ".pytest_cache",
    ".ruff_cache",
    ".tox",
    "dist",
    "build",
})


@mcp.tool()
async def analyze_file(file_path: str) -> str:
    """指定されたファイルの統計情報を返します。

    Args:
        file_path: 分析対象のファイルの絶対パス（例: /Users/user/project/src/main.py）
    """
    path = Path(file_path)

    if not path.is_absolute():
        return f"エラー: 絶対パスを指定してください。受け取ったパス: {file_path}"

    if not path.exists():
        return f"エラー: ファイルが見つかりません: {file_path}"

    if not path.is_file():
        return f"エラー: ディレクトリではなくファイルを指定してください: {file_path}"

    try:
        content = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return f"エラー: バイナリファイルは分析できません: {file_path}"

    lines = content.splitlines()
    non_empty_lines = [line for line in lines if line.strip()]

    return (
        f"ファイル: {path.name}\n"
        f"パス: {file_path}\n"
        f"サイズ: {path.stat().st_size:,} bytes\n"
        f"総行数: {len(lines)}\n"
        f"空行を除く行数: {len(non_empty_lines)}\n"
        f"文字数: {len(content):,}\n"
        f"拡張子: {path.suffix or 'なし'}"
    )


@mcp.tool()
async def analyze_directory(
    directory_path: str,
    extension: str = "",
    extra_exclude_dirs: list[str] | None = None,
) -> str:
    """指定されたディレクトリ内のファイルを集計します。

    .git / .venv / __pycache__ / node_modules などのディレクトリはデフォルトで除外します。

    Args:
        directory_path: 分析対象ディレクトリの絶対パス
        extension: フィルタする拡張子（例: .py, .ts）。空文字の場合は全ファイル対象
        extra_exclude_dirs: デフォルトに加えて除外するディレクトリ名のリスト（例: ["logs", "tmp"]）
    """
    path = Path(directory_path)

    if not path.is_absolute():
        return f"エラー: 絶対パスを指定してください。受け取ったパス: {directory_path}"

    if not path.exists():
        return f"エラー: ディレクトリが見つかりません: {directory_path}"

    if not path.is_dir():
        return f"エラー: ファイルではなくディレクトリを指定してください: {directory_path}"

    exclude_dirs = DEFAULT_EXCLUDE_DIRS | set(extra_exclude_dirs or [])

    # os.walk で除外ディレクトリの中には降りないようにする（.venv 等を走査しない）
    files: list[Path] = []
    for root, dirs, filenames in os.walk(path):
        dirs[:] = [d for d in dirs if d not in exclude_dirs]
        for name in filenames:
            if extension and not name.endswith(extension):
                continue
            f = Path(root) / name
            if f.is_file():
                files.append(f)

    pattern = f"*{extension}" if extension else "*"
    if not files:
        return f"該当するファイルが見つかりません（パターン: {pattern}）"

    total_size = sum(f.stat().st_size for f in files)
    total_lines = 0
    for f in files:
        try:
            total_lines += len(f.read_text(encoding="utf-8").splitlines())
        except (UnicodeDecodeError, PermissionError):
            pass

    return (
        f"ディレクトリ: {directory_path}\n"
        f"フィルタ: {extension or '全ファイル'}\n"
        f"除外ディレクトリ: {', '.join(sorted(exclude_dirs))}\n"
        f"ファイル数: {len(files)}\n"
        f"合計サイズ: {total_size:,} bytes\n"
        f"合計行数: {total_lines:,}"
    )


def main():
    mcp.run(transport="stdio")


if __name__ == "__main__":
    main()
