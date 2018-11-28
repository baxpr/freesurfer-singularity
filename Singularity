Bootstrap: docker
From: centos:7.5.1804

%help

Freesurfer 201811 development version. Runs recon-all plus hippocampus, 
thalamus, brainstem modules. Requires a valid license file at runtime - example:
  --bind /where/is/freesurfer_license.txt:/usr/local/freesurfer/license.txt

To identify the specific Freesurfer version that was installed, view the file
/usr/local/freesurfer/build-stamp.txt within the container.

Do not use singularity's --contain flag when running, as this will cause 
problems with Freesurfer's use of temp storage.


REFERENCES

recon-all:

   Collins, DL, Neelin, P., Peters, TM, and Evans, AC. (1994) Automatic 3D 
   Inter-Subject Registration of MR Volumetric Data in Standardized Talairach 
   Space, Journal of Computer Assisted Tomography, 18(2) p192-205, 1994 PMID: 
   8126267; UI: 94172121

   Cortical Surface-Based Analysis I: Segmentation and Surface Reconstruction 
   Dale, A.M., Fischl, Bruce, Sereno, M.I., (1999). Cortical Surface-Based 
   Analysis I: Segmentation and Surface Reconstruction. NeuroImage 9(2):179-194

   Fischl, B.R., Sereno, M.I.,Dale, A. M. (1999) Cortical Surface-Based 
   Analysis II: Inflation, Flattening, and Surface-Based Coordinate System. 
   NeuroImage, 9, 195-207.

   Fischl, Bruce, Sereno, M.I., Tootell, R.B.H., and Dale, A.M., (1999). 
   High-resolution inter-subject averaging and a coordinate system for the 
   cortical surface. Human Brain Mapping, 8(4): 272-284

   Fischl, Bruce, and Dale, A.M., (2000). Measuring the Thickness of the Human 
   Cerebral Cortex from Magnetic Resonance Images. Proceedings of the National 
   Academy of Sciences, 97:11044-11049.

   Fischl, Bruce, Liu, Arthur, and Dale, A.M., (2001). Automated Manifold 
   Surgery: Constructing Geometrically Accurate and Topologically Correct 
   Models of the Human Cerebral Cortex. IEEE Transactions on Medical Imaging, 
   20(1):70-80

   Non-Uniform Intensity Correction. 
   http://www.bic.mni.mcgill.ca/software/N3/node6.html

   Fischl B, Salat DH, Busa E, Albert M, Dieterich M, Haselgrove C, van der 
   Kouwe A, Killiany R, Kennedy D, Klaveness S, Montillo A, Makris N, Rosen B, 
   Dale AM. Whole brain segmentation: automated labeling of neuroanatomical 
   structures in the human brain. Neuron. 2002 Jan 31;33(3):341-55.

   Bruce Fischl, Andre van der Kouwe, Christophe Destrieux, Eric Halgren, 
   Florent Segonne, David H. Salat, Evelina Busa, Larry J. Seidman, Jill 
   Goldstein, David Kennedy, Verne Caviness, Nikos Makris, Bruce Rosen, and 
   Anders M. Dale. Automatically Parcellating the Human Cerebral Cortex. 
   Cerebral Cortex January 2004; 14:11-22.


Brainstem:

   Bayesian segmentation of brainstem structures in MRI. Iglesias, J.E., Van 
   Leemput, K., Bhatt, P., Casillas, C., Dutt, S., Schuff, N., Truran-Sacrey, 
   D., Boxer, A., and Fischl, B. NeuroImage, 113, June 2015, 184-195.


Hippocampus and amygdala:

   Hippocampus: A computational atlas of the hippocampal formation using ex 
   vivo, ultra-high resolution MRI: Application to adaptive segmentation of in 
   vivo MRI. Iglesias, J.E., Augustinack, J.C., Nguyen, K., Player, C.M., 
   Player, A., Wright, M., Roy, N., Frosch, M.P., Mc Kee, A.C., Wald, L.L., 
   Fischl, B., and Van Leemput, K. Neuroimage, 115, July 2015, 117-137.

   Amygdala: High-resolution magnetic resonance imaging reveals nuclei of the 
   human amygdala: manual segmentation to automatic atlas. Saygin ZM & Kliemann 
   D (joint 1st authors), Iglesias JE, van der Kouwe AJW, Boyd E, Reuter M, 
   Stevens A, Van Leemput K, Mc Kee A, Frosch MP, Fischl B, Augustinack JC. 
   Neuroimage, 155, July 2017, 370-382.

   Longitudinal method: Bayesian longitudinal segmentation of hippocampal 
   substructures in brain MRI using subject-specific atlases. Iglesias JE, Van 
   Leemput K, Augustinack J, Insausti R, Fischl B, Reuter M. Neuroimage, 141, 
   November 2016, 542-555.


Thalamus:

   A probabilistic atlas of the human thalamic nuclei combining ex vivo MRI and 
   histology. Iglesias, J.E., Insausti, R., Lerma-Usabiaga, G., Bocchetta, M., 
   Van Leemput, K., Greve, D., van der Kouwe, A., Caballero-Gaudes, C., 
   Paz-Alonso, P. Neuroimage (accepted).



%files

  # Freesurfer development version, if we are going to download manually and 
  # reference a local copy during the build
  # https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/dev/freesurfer-linux-centos7_x86_64-dev.tar.gz
  freesurfer-linux-centos7_x86_64-dev.tar.gz /usr/local

  # Matlab runtime, if we are going to download manually and reference a local 
  # copy during the build
  # http://ssd.mathworks.com/supportfiles/downloads/R2014b/deployment_files/R2014b/installers/glnxa64/MCR_R2014b_glnxa64_installer.zip
  MCR_R2014b_glnxa64_installer.zip /opt

  # Default run scripts
  runscripts /opt


%post
  
  # For installs
  yum -y install unzip wget
  
  # For Freesurfer
  yum -y install tcsh bc mesa-libGLU libgomp perl
  
  # For matlab runtime
  yum -y install java-1.8.0-openjdk
  
  # For X
  yum -y install xorg-x11-server-Xvfb xorg-x11-xauth which
  #xorg-x11-fonts-Type1 xorg-x11-fonts-75dpi
  
  # Install Freesurfer
  #wget -nv -P /usr/local https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/dev/freesurfer-linux-centos7_x86_64-dev.tar.gz
  cd /usr/local
  tar -zxf freesurfer-linux-centos7_x86_64-dev.tar.gz
  rm freesurfer-linux-centos7_x86_64-dev.tar.gz

  # Matlab runtime for brainstem, hippocampus, thalamus modules
  #wget -nv -P /opt http://ssd.mathworks.com/supportfiles/downloads/R2014b/deployment_files/R2014b/installers/glnxa64/MCR_R2014b_glnxa64_installer.zip
  unzip -q /opt/MCR_R2014b_glnxa64_installer.zip -d /opt/MCR_R2014b_glnxa64_installer
  /opt/MCR_R2014b_glnxa64_installer/install -mode silent -agreeToLicense yes
  rm -r /opt/MCR_R2014b_glnxa64_installer
  rm /opt/MCR_R2014b_glnxa64_installer.zip

  # Tell freesurfer where to find the MCR
  ln -s /usr/local/MATLAB/MATLAB_Compiler_Runtime/v84 /usr/local/freesurfer/MCRv84

  # Create input/output directories for binding
  mkdir /INPUTS && mkdir /OUTPUTS


%environment

  # Freesurfer
  export FREESURFER_HOME=/usr/local/freesurfer


%runscript
  xvfb-run --server-num=$(($$ + 99)) \
  --server-args='-screen 0 1600x1200x24 -ac +extension GLX' \
  bash /opt/runscripts/run_everything.sh "$@"
