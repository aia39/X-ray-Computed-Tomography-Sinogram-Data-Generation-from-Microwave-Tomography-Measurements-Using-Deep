# X-ray-Computed-Tomography-Sinogram-Data-Generation-from-Microwave-Tomography-Measurements-Using-Deep

# Getting Started

First execute forward solution to get electric field from shepp logan. 

1. Run 'healthy_data_generation.m' to generate permittivity, conductiviy map and sinogram data of CT image
This will generate 'epsr_healcases.mat', 'cond_healcases.mat', 'coord_healcases.mat','training_set_healcases_output_CT.mat'

2. Run 'Comsole_1Case_OnlyHealthy_1GHz_1st.m' to get scattered electric field.

3. Run 'MakingMatrixCumulative.m' to get the final electric field vector.

Then execute inverse solution to get sinogram image reconstructed from the electric field from forward solution.
4. From Inverse Solution folder, run 'ANN_test_All_Meas_heal.m' to train the network.

5. Run 'R_constructing_heal.m' to construct any CT image from the testing set.

6. Run 'results_for_thesis.m' to acquire desired result on testset.


If you find the work useful in your research, please use the following entry for citation.

```BibTeX
@INPROCEEDINGS{10088739,
  author={Istiak, Md. Abrar and Hasnine, Iftekar Mahmud and Kiourti, Asimina and Alam, M. Shah and Islam, Md. Asiful},
  booktitle={2022 12th International Conference on Electrical and Computer Engineering (ICECE)}, 
  title={X-ray Computed Tomography Sinogram Data Generation from Microwave Tomography Measurements Using Deep Neural Networks}, 
  year={2022},
  volume={},
  number={},
  pages={164-167},
  doi={10.1109/ICECE57408.2022.10088739}}
```
