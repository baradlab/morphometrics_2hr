# Surface Morphometrics in 2 Hours

A condensed, single-page [Surface Morphometrics](https://github.com/grotjahnlab/surface_morphometrics) tutorial designed to run end-to-end in about two hours. It starts from a pre-made IMM/OMM mitochondrial segmentation from [EMPIAR-12534](https://www.ebi.ac.uk/empiar/EMPIAR-12534/) and walks through meshing, curvature, a shortened 2-iteration mesh refinement, inter-membrane distances, and thickness.

**Live site:** <https://baradlab.com/morphometrics_2hr>

This is a slimmed-down offshoot of the full [U Michigan CryoET tutorial](https://baradlab.com/michigan_tutorial).

## Getting the data

```bash
curl -LO https://raw.githubusercontent.com/baradlab/morphometrics_2hr/main/download_data.sh
bash download_data.sh
```

This downloads the tomogram + segmentation from EMPIAR-12534 and the ribosome STAR file, organizing them under `morpho_run/` (`tomograms/`, `segmentations/`, `star/`) for the pipeline.

## Building the docs

This is a [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) site.

```bash
python -m venv .venv-docs
.venv-docs/bin/pip install mkdocs-material
.venv-docs/bin/mkdocs serve    # live preview
```

Pushing to `main` triggers `.github/workflows/build-and-deploy-docs.yml`, which runs `mkdocs gh-deploy --force` to publish to the `gh-pages` branch.

## License

Licensed under the BSD license. Please reuse liberally!
