#!/bin/bash
#
# Generate a number of useful extra outputs from Freesurfer results: PDF page,
# regional volumes, and Nifti images.

echo "Generating outputs for ${SUBJECTS_DIR} ${SUBJECT}"

MRI="${SUBJECTS_DIR}"/"${SUBJECT}"/mri
RSCR=/opt/runscripts

# Screenshots for whole brain
"${RSCR}"/screenshot.sh brain_axi axial
"${RSCR}"/screenshot.sh brain_sag sagittal
"${RSCR}"/screenshot.sh brain_cor coronal

# Screenshots for ROIs. Region labels in aseg.mgz are
#    10   L thalamus
#    49   R thalamus
#    17   L hippocampus
#    53   R hippocampus
#    16   brainstem
"${RSCR}"/screenshot_roi.sh  Lthal_sag sagittal  3  10
"${RSCR}"/screenshot_roi.sh  Rthal_sag sagittal  3  49
"${RSCR}"/screenshot_roi2.sh thal_axi  axial     3  10 49
"${RSCR}"/screenshot_roi2.sh thal_cor  coronal   3  10 49

"${RSCR}"/screenshot_roi.sh  Lhipp_sag sagittal  2  17
"${RSCR}"/screenshot_roi.sh  Rhipp_sag sagittal  2  53

"${RSCR}"/screenshot_roi.sh  brainstem_sag sagittal  2  16
"${RSCR}"/screenshot_roi.sh  brainstem_cor coronal   2  16



# Make useful resources:

# VOLUMES
VOLUMES="${SUBJECTS_DIR}"/VOLUMES
mkdir "${VOLUMES}"
for f in \
  ThalamicNuclei.v10.T1.volumes.txt \
  brainstemSsVolumes.v12.txt \
  lh.amygNucVolumes-T1.v21.txt \
  lh.hippoSfVolumes-T1.v21.txt \
  rh.amygNucVolumes-T1.v21.txt \
  rh.hippoSfVolumes-T1.v21.txt \
  ; do
    cp "${MRI}"/"${f}" "${VOLUMES}"
done

# NII_NU
NII_NU="${SUBJECTS_DIR}"/NII_NU
mkdir "${NII_NU}"
mri_convert "${MRI}"/nu.mgz "${NII_NU}"/nu.nii.gz

# NII_ASEG
NII_ASEG="${SUBJECTS_DIR}"/NII_ASEG
mkdir "${NII_ASEG}"
mri_convert "${MRI}"/aseg.mgz "${NII_ASEG}"/aseg.nii.gz

# NII_WMPARC
NII_WMPARC="${SUBJECTS_DIR}"/NII_WMPARC
mkdir "${NII_WMPARC}"
mri_convert "${MRI}"/wmparc.mgz "${NII_WMPARC}"/wmparc.nii.gz

# NII_THALAMUS
NII_THALAMUS="${SUBJECTS_DIR}"/NII_THALAMUS
mkdir "${NII_THALAMUS}"
mri_convert "${MRI}"/ThalamicNuclei.v10.T1.FSvoxelSpace.mgz \
    "${NII_THALAMUS}"/ThalamicNuclei.v10.T1.FSvoxelSpace.nii.gz

# NII_BRAINSTEM
NII_BRAINSTEM="${SUBJECTS_DIR}"/NII_BRAINSTEM
mkdir "${NII_BRAINSTEM}"
mri_convert "${MRI}"/brainstemSsLabels.v12.FSvoxelSpace.mgz \
    "${NII_BRAINSTEM}"/brainstemSsLabels.v12.FSvoxelSpace.nii.gz

# NII_HIPP_AMYG
NII_HIPP_AMYG="${SUBJECTS_DIR}"/NII_HIPP_AMYG
mkdir "${NII_HIPP_AMYG}"
for f in \
  lh.hippoAmygLabels-T1.v21.FSvoxelSpace \
  rh.hippoAmygLabels-T1.v21.FSvoxelSpace \
  lh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace \
  rh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace \
  lh.hippoAmygLabels-T1.v21.FS60.FSvoxelSpace \
  rh.hippoAmygLabels-T1.v21.FS60.FSvoxelSpace \
  lh.hippoAmygLabels-T1.v21.CA.FSvoxelSpace \
  rh.hippoAmygLabels-T1.v21.CA.FSvoxelSpace \
  ; do
    mri_convert "${MRI}"/"${f}".mgz "${NII_HIPP_AMYG}"/"${f}".nii.gz
done


# Clean up
rm -r "${SUBJECTS_DIR}"/"${SUBJECT}"/tmp
rm -r "${SUBJECTS_DIR}"/"${SUBJECT}"/trash
