/*
    Copyright 2017 Zheyong Fan and GPUMD development team
    This file is part of GPUMD.
    GPUMD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    GPUMD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with GPUMD.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once
#include "ensemble_mttk.cuh"
#include "model/box.cuh"
#include "utilities/common.cuh"
#include "utilities/error.cuh"
#include "utilities/read_file.cuh"
#include <math.h>

class Ensemble_TI_RS : public Ensemble_MTTK
{
public:
  Ensemble_TI_RS(const char** params, int num_params);
  virtual ~Ensemble_TI_RS(void);

  virtual void compute1(
    const double time_step,
    const std::vector<Group>& group,
    Box& box,
    Atom& atoms,
    GPU_Vector<double>& thermo);

  virtual void compute2(
    const double time_step,
    const std::vector<Group>& group,
    Box& box,
    Atom& atoms,
    GPU_Vector<double>& thermo);

  void init();
  void find_thermo();
  void scale_force();
  void find_lambda();
  double switch_func(double t);
  double dswitch_func(double t);
  void get_target_pressure();

protected:
  FILE* output_file;
  double lambda_f;
  double lambda = 1, dlambda = 0;
  int t_switch = -1, t_equil = -1;
  double t_max;
  double pe;
  std::vector<double> thermo_cpu;
  bool auto_switch = true;
};