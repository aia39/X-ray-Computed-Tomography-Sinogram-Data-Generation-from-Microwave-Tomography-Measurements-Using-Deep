%function out = model
%
% small_rad_anomfunction.m
%
% Model exported on Apr 29 2021, 22:34 by COMSOL 5.5.0.359.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('G:\Thesis Work\Comsol related code');

model.label('small_rad_anomfunction.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 2);

model.func.create('extm1', 'MATLAB');
model.func('extm1').set('clearsolve', true);
model.func('extm1').set('funcs', {'mat_propertyme' 'x,y'});
model.func('extm1').set('plotargs', {'-0.1' '0.1'; '-0.1' '0.1'});

model.component('comp1').mesh.create('mesh1');

model.component('comp1').geom('geom1').create('c1', 'Circle');
model.component('comp1').geom('geom1').feature('c1').set('r', 0.1);
model.component('comp1').geom('geom1').create('c2', 'Circle');
model.component('comp1').geom('geom1').feature('c2').set('r', 0.15);
model.component('comp1').geom('geom1').create('c3', 'Circle');
model.component('comp1').geom('geom1').feature('c3').set('r', 0.2);
model.component('comp1').geom('geom1').create('pt1', 'Point');
model.component('comp1').geom('geom1').feature('pt1').set('p', [0.105 0]);
model.component('comp1').geom('geom1').create('pt2', 'Point');
model.component('comp1').geom('geom1').feature('pt2').set('p', [0.0909 0.0525]);
model.component('comp1').geom('geom1').create('pt3', 'Point');
model.component('comp1').geom('geom1').feature('pt3').set('p', [0.0525 0.0909]);
model.component('comp1').geom('geom1').create('pt4', 'Point');
model.component('comp1').geom('geom1').feature('pt4').set('p', [0 0.105]);
model.component('comp1').geom('geom1').create('pt5', 'Point');
model.component('comp1').geom('geom1').feature('pt5').set('p', [-0.0525 0.0909]);
model.component('comp1').geom('geom1').create('pt6', 'Point');
model.component('comp1').geom('geom1').feature('pt6').set('p', [-0.0909 0.0525]);
model.component('comp1').geom('geom1').create('pt7', 'Point');
model.component('comp1').geom('geom1').feature('pt7').set('p', [-0.105 0]);
model.component('comp1').geom('geom1').create('pt8', 'Point');
model.component('comp1').geom('geom1').feature('pt8').set('p', [-0.0909 -0.0525]);
model.component('comp1').geom('geom1').create('pt9', 'Point');
model.component('comp1').geom('geom1').feature('pt9').set('p', [-0.0525 -0.0909]);
model.component('comp1').geom('geom1').create('pt10', 'Point');
model.component('comp1').geom('geom1').feature('pt10').set('p', [0 -0.105]);
model.component('comp1').geom('geom1').create('pt11', 'Point');
model.component('comp1').geom('geom1').feature('pt11').set('p', [0.0525 -0.0909]);
model.component('comp1').geom('geom1').create('pt12', 'Point');
model.component('comp1').geom('geom1').feature('pt12').set('p', [0.0909 -0.0525]);
model.component('comp1').geom('geom1').run;

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material.create('mat2', 'Common');
model.component('comp1').material('mat1').selection.set([1 2]);
model.component('comp1').material('mat2').selection.set([3]);

model.component('comp1').coordSystem.create('pml1', 'PML');
model.component('comp1').coordSystem('pml1').selection.set([1]);

model.component('comp1').physics.create('emw', 'ElectromagneticWaves', 'geom1');
model.component('comp1').physics('emw').create('lco1', 'LineCurrentOutOfPlane', 0);
model.component('comp1').physics('emw').feature('lco1').selection.set([20]);

model.component('comp1').mesh('mesh1').create('size1', 'Size');
model.component('comp1').mesh('mesh1').create('ftri1', 'FreeTri');
model.component('comp1').mesh('mesh1').feature('size1').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftri1').selection.geom('geom1', 2);
model.component('comp1').mesh('mesh1').feature('ftri1').selection.set([1 2 3]);

model.component('comp1').view('view1').axis.set('xmin', -0.3706040382385254);
model.component('comp1').view('view1').axis.set('xmax', 0.3706040382385254);
model.component('comp1').view('view1').axis.set('ymin', -0.21409396827220917);
model.component('comp1').view('view1').axis.set('ymax', 0.21409396827220917);

model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity', {'40' '0' '0' '0' '40' '0' '0' '0' '40'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermittivity_symmetry', '0');
model.component('comp1').material('mat1').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat1').propertyGroup('def').set('relpermeability_symmetry', '0');
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity', {'0.5' '0' '0' '0' '0.5' '0' '0' '0' '0.5'});
model.component('comp1').material('mat1').propertyGroup('def').set('electricconductivity_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity', {'mat_propertyme(x,y)' '0' '0' '0' 'mat_propertyme(x,y)' '0' '0' '0' 'mat_propertyme(x,y)'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermittivity_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability', {'1' '0' '0' '0' '1' '0' '0' '0' '1'});
model.component('comp1').material('mat2').propertyGroup('def').set('relpermeability_symmetry', '0');
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.component('comp1').material('mat2').propertyGroup('def').set('electricconductivity_symmetry', '0');

model.component('comp1').coordSystem('pml1').set('ScalingType', 'Cylindrical');

model.component('comp1').physics('emw').feature('lco1').set('Iop', 1);

model.component('comp1').mesh('mesh1').feature('size').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('size').set('hmax', '0.0059250');
model.component('comp1').mesh('mesh1').feature('size').set('hmin', '1.2000E-4');
model.component('comp1').mesh('mesh1').feature('size1').set('custom', 'on');
model.component('comp1').mesh('mesh1').feature('size1').set('hmax', '0.0046480');
model.component('comp1').mesh('mesh1').feature('size1').set('hmaxactive', true);
model.component('comp1').mesh('mesh1').feature('size1').set('hmin', '1.2000E-4');
model.component('comp1').mesh('mesh1').feature('size1').set('hminactive', true);
model.component('comp1').mesh('mesh1').feature('size1').set('hcurveactive', true);
model.component('comp1').mesh('mesh1').feature('size1').set('hnarrowactive', true);
model.component('comp1').mesh('mesh1').feature('size1').set('hgradactive', true);
model.component('comp1').mesh('mesh1').run;

model.study.create('std1');
model.study('std1').create('freq', 'Frequency');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('s1', 'Stationary');
model.sol('sol1').feature('s1').create('p1', 'Parametric');
model.sol('sol1').feature('s1').create('fc1', 'FullyCoupled');
model.sol('sol1').feature('s1').create('d1', 'Direct');
model.sol('sol1').feature('s1').feature.remove('fcDef');

model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result.export.create('data1', 'Data');

model.study('std1').feature('freq').set('ngen', 5);

model.sol('sol1').attach('std1');
model.sol('sol1').feature('v1').set('clistctrl', {'p1'});
model.sol('sol1').feature('v1').set('cname', {'freq'});
model.sol('sol1').feature('v1').set('clist', {'1[GHz]'});
model.sol('sol1').feature('s1').set('stol', 0.01);
model.sol('sol1').feature('s1').set('plot', true);
model.sol('sol1').feature('s1').feature('aDef').set('complexfun', true);
model.sol('sol1').feature('s1').feature('p1').set('pname', {'freq'});
model.sol('sol1').feature('s1').feature('p1').set('plistarr', {'1[GHz]'});
model.sol('sol1').feature('s1').feature('p1').set('punit', {'GHz'});
model.sol('sol1').feature('s1').feature('p1').set('pcontinuationmode', 'no');
model.sol('sol1').feature('s1').feature('p1').set('preusesol', 'auto');
model.sol('sol1').feature('s1').feature('p1').set('plot', true);
model.sol('sol1').feature('s1').feature('d1').label('Suggested Direct Solver (emw)');
model.sol('sol1').feature('s1').feature('d1').set('linsolver', 'pardiso');
model.sol('sol1').runAll;

model.result('pg1').label('Electric Field (emw)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature('surf1').label('Surface');
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').feature('surf1').set('smooth', 'internal');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result.export('data1').set('expr', {'emw.normE'});
model.result.export('data1').set('unit', {'V/m'});
model.result.export('data1').set('descr', {'Electric field norm'});
model.result.export('data1').set('filename', 'G:\Thesis Work\Comsol related code\twelve_ant_anomfunc.csv');
model.result.export('data1').set('location', 'file');
model.result.export('data1').set('coordfilename', 'G:\Thesis Work\Comsol related code\coordinate_smallrad.txt');

out = model;
