import json
import sys
from pathlib import Path


def grade_trial(trial_dir: Path) -> bool:
    """Trial が PASS したかを判定する。
    実装は task の grader 種別に依存する。deterministic_tests なら test runner の
    終了コードを marker ファイルに書き出す、state_check なら期待ファイルの存在を
    確認する、など。ここでは run-trial.sh が pass.txt に "pass" を書き込む前提。"""
    pass_marker = trial_dir / "pass.txt"
    return pass_marker.exists() and pass_marker.read_text().strip() == "pass"


def pass_at_k(passes: int, total: int) -> float:
    """k 回中 1 回でも成功すれば pass@k は 1.0"""
    return 1.0 if passes >= 1 else 0.0


def pass_caret_k(passes: int, total: int) -> float:
    """全 trial 成功で pass^k は 1.0"""
    return 1.0 if passes == total and total > 0 else 0.0


if __name__ == "__main__":
    task_id = sys.argv[1]
    trial_dirs = sorted(Path(f"evals/trials/{task_id}").iterdir())
    results = [grade_trial(d) for d in trial_dirs]
    passes = sum(results)
    total = len(results)
    print(f"task={task_id} k={total} passes={passes}")
    print(f"  pass@k = {pass_at_k(passes, total):.2f}")
    print(f"  pass^k = {pass_caret_k(passes, total):.2f}")
