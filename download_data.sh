#!/usr/bin/env bash
#
# download_data.sh — fetch and organize the input files for the 2-hour
# Surface Morphometrics tutorial (baradlab.com/morphometrics_2hr).
#
# Downloads three files and lays them out the way the morphometrics
# pipeline expects:
#
#   morpho_run/
#   ├── tomograms/     YTC041_1_lam4_2_ts_002.mrc_9.98Apx.mrc   (raw tomogram, ~875 MB)
#   ├── segmentations/ YTC041_1_lam4_2_ts_002_labels.mrc        (IMM/OMM labels, ~437 MB)
#   └── star/          clean_ribosomes.star                     (ribosome picks, bonus)
#
# The tomogram + segmentation come from EMPIAR-12534
# (https://www.ebi.ac.uk/empiar/EMPIAR-12534/). The STAR file is served from
# the tutorial site. Downloads resume if interrupted (curl -C -), so it is
# safe to re-run.
#
# Usage:
#   bash download_data.sh            # downloads into ./morpho_run
#   bash download_data.sh /path/dir  # downloads into /path/dir

set -euo pipefail

PROJECT_DIR="${1:-morpho_run}"

EMPIAR_BASE="https://ftp.ebi.ac.uk/empiar/world_availability/12534/data/EMPIAR_upload"
TOMO_URL="${EMPIAR_BASE}/Reconstructed_tomograms/YTC041_1/YTC041_1_lam4_2_ts_002.mrc_9.98Apx.mrc"
SEG_URL="${EMPIAR_BASE}/Voxel_segmentations/YTC041_1/YTC041_1_lam4_2_ts_002_labels.mrc"
STAR_URL="https://baradlab.com/michigan_tutorial/latest/static/clean_ribosomes.star"

echo "Setting up project in: ${PROJECT_DIR}"
mkdir -p "${PROJECT_DIR}/tomograms" "${PROJECT_DIR}/segmentations" "${PROJECT_DIR}/star"

# -L follow redirects, -C - resume partial downloads, --fail stop on HTTP errors.
fetch() {
  local url="$1" out="$2"
  echo ">>> Downloading $(basename "${out}")"
  curl -L --fail -C - -o "${out}" "${url}"
}

fetch "${TOMO_URL}" "${PROJECT_DIR}/tomograms/YTC041_1_lam4_2_ts_002.mrc_9.98Apx.mrc"
fetch "${SEG_URL}"  "${PROJECT_DIR}/segmentations/YTC041_1_lam4_2_ts_002_labels.mrc"
fetch "${STAR_URL}" "${PROJECT_DIR}/star/clean_ribosomes.star"

echo
echo "Done. Files are organized under ${PROJECT_DIR}/:"
find "${PROJECT_DIR}" -type f -exec ls -lh {} + | awk '{print "  " $5 "\t" $NF}'
echo
echo "Next: cd ${PROJECT_DIR} && morphometrics new_config"
