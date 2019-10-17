MINICONDA_HOME="$HOME/opt/miniconda3"
CONDA="$MINICONDA_HOME/etc/profile.d/conda.sh"

if [[ -f "${CONDA}" ]]; then
  . "${CONDA}"
else
  echo "Miniconda zsh plugin installed, but ${CONDA} not found"
fi
