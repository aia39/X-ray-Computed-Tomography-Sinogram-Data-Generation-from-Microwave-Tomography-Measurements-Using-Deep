# X-ray-Computed-Tomography-Sinogram-Data-Generation-from-Microwave-Tomography-Measurements-Using-Deep

# Getting Started

First execute forward solution then inverse solution

1) Run 'healthy_data_generation.m' to generate permittivity, conductiviy map and sinogram data of CT image
This will generate 'epsr_healcases.mat', 'cond_healcases.mat', 'coord_healcases.mat','training_set_healcases_output_CT.mat'

2) Run 'Comsole_1Case_OnlyHealthy_1GHz_1st.m' to get scattered electric field.

3) Run 'MakingMatrixCumulative.m' to get the final electric field vector.

4) From Inverse Solution folder,
run 'ANN_test_All_Meas_heal.mat' to train the network.

5) Run 'R_constructing_heal.m' to construct any CT image from the testing set.

6) Run 'results_for_thesis.m' to acquire desired result on testset.
