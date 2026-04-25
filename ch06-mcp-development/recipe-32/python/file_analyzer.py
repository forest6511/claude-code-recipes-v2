from pathlib import Path
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("file-analyzer")


def analyze_file_impl(file_path: str) -> str:
    """ピュアな実装。MCPプロトコルに依存しない。"""
    path = Path(file_path)
    if not path.is_absolute():
        return f"エラー: 絶対パスを指定してください: {file_path}"
    if not path.is_file():
        return f"エラー: ファイルが見つかりません: {file_path}"
    content = path.read_text(encoding="utf-8")
    return f"行数: {len(content.splitlines())}, 文字数: {len(content)}"


@mcp.tool()
async def analyze_file(file_path: str) -> str:
    """指定されたファイルの統計情報を返します。"""
    return analyze_file_impl(file_path)
