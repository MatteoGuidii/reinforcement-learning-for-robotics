# Reinforcement Learning for Robotics

This repository holds the development environment and demos used in the Reinforcement Learning for Robotics video series, which can be found [here](https://www.youtube.com/watch?v=zsdceSTRBl4&list=PLYExBrZNJeQg&index=1).

> If you are looking for the workshop/webinar version of this demo, please use this repository: [github.com/ShawnHymel/workshop-reinforcement-learning-for-robotics](https://github.com/ShawnHymel/workshop-reinforcement-learning-for-robotics/)

<a href="https://www.youtube.com/watch?v=zsdceSTRBl4&list=PLYExBrZNJeQg&index=1">
  <img src=".images/rl-for-robotics-thumbnail-play.png" alt="Reinforcement Learning for Robotics" height="500">
</a>

## Installation (native, uv)

Requires [uv](https://docs.astral.sh/uv/). Tested on macOS (Apple Silicon); training runs on the CPU.

```sh
make            # uv sync + register the viewer kernel + open JupyterLab
```

Other commands:

```sh
make setup        # install only (uv sync + kernel)
make tensorboard  # TensorBoard on http://localhost:6006
make clean        # remove .venv and the viewer kernel
```

In JupyterLab or VS Code, pick a kernel per notebook:
 * **Python (RL + MuJoCo viewer)**: required for any cell that opens the MuJoCo viewer (`render_mode="human"` or `mujoco.viewer.launch_passive`). On macOS the viewer only works under `mjpython`, and this kernel runs through it.
 * **.venv (Python 3.12)**: fine for headless cells (training with rendering off, ONNX export, plots).

Notebooks use paths relative to their own folder, so open them from their directory (the default in JupyterLab and VS Code).

## Installation (Docker)

Download and install [Docker Desktop](https://www.docker.com/products/docker-desktop/). Make sure it is running before continuing to the next step.

Open a terminal and build the Docker image:

```sh
docker build -t rl-robotics -f Dockerfile.cpu .
```

Run the image:

```sh
docker run -it --rm -p 3000:3000 -p 6006:6006 -v "${PWD}/workspace:/workspace" --shm-size=2g rl-robotics
```

Notes:
 * Port 3000 is for the WebTop interface
 * Port 6006 is for TensorBoard
 * VS Code is memory hungry, so we bump the shared memory up to 2 GB

Browse to [http://localhost:3000/](http://localhost:3000/) to interact with WebTop.

## License

All software in this repository, unless otherwise noted, is licensed under the [Apache-2.0](https://www.apache.org/licenses/LICENSE-2.0) license.
