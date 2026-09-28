# Native setup with uv (macOS / Linux). Run `make` for JupyterLab.

VIEWER_KERNEL := $(HOME)/Library/Jupyter/kernels/rl-viewer/kernel.json

.PHONY: lab setup tensorboard clean

lab: setup
	uv run jupyter lab --notebook-dir=workspace

setup: .venv/.synced $(VIEWER_KERNEL)

.venv/.synced: pyproject.toml $(wildcard uv.lock)
	uv sync
	touch $@

# Jupyter kernel launched via mjpython, required on macOS for mujoco.viewer
$(VIEWER_KERNEL): .venv/.synced
	mkdir -p $(dir $@)
	printf '{"argv": ["%s/.venv/bin/mjpython", "-m", "ipykernel_launcher", "-f", "{connection_file}"], "display_name": "Python (RL + MuJoCo viewer)", "language": "python"}\n' "$(CURDIR)" > $@

tensorboard:
	uv run tensorboard --logdir workspace/software

clean:
	rm -rf .venv $(dir $(VIEWER_KERNEL))
