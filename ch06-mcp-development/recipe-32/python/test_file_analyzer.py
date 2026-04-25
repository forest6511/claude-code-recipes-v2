import pytest
from pathlib import Path
from file_analyzer import analyze_file_impl


def test_relative_path_returns_error():
    result = analyze_file_impl("./relative/path.py")
    assert result.startswith("エラー: 絶対パスを指定してください")


def test_nonexistent_file_returns_error(tmp_path: Path):
    missing = tmp_path / "missing.py"
    result = analyze_file_impl(str(missing))
    assert result.startswith("エラー: ファイルが見つかりません")


def test_normal_file_returns_stats(tmp_path: Path):
    target = tmp_path / "sample.py"
    target.write_text("line1\nline2\n")
    result = analyze_file_impl(str(target))
    assert "行数: 2" in result
    assert "文字数: 12" in result
