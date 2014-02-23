/*
    This file is part of the DodoHand project. This project aims to create 
    an open implementation of the DataHand keyboard, capable of being created
    with commercial 3D printing services.

    Copyright (C) 2014 Scott Fohey

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// This file defines the frame for the 4-per-side thumb switch
// tf_ (Thumb Frame) is the prefix for these dimensions 

use <carrier.scad>
use <LiteOn_P_100_E302.scad>

include <dimensions.scad>;

// an eye-centered, and x-aligned irled component
module eye_centered_m_irled(x, y, z, sch) {
  translate([x, y, z]) {
    translate([-irle_m_x, -irle_m_y, -irle_m_z]) {
      rotate( a=-90, v=[0,0,1]) {
        Max_LiteOn_P_100_E302(0, 0, 0, sch);
      } // end rotate
    } // end translate
  } // end translate
} // end module eye_centered_m_irled

module tf_irled_holder(epx, epy, epz) {
  translate([epx, epy, epz]) {
  union() {
    difference() {
      union() {
        // make holder box 
        translate([tf_irlhb_x, tf_irlhb_y, tf_irlhb_z]) {
          cube([tf_irlhb_w, tf_irlhb_d, tf_irlhb_h]);
        }
        // make cap that blocks light from hitting sensor
        translate([tf_irlhbc_x, tf_irlhbc_y, tf_irlhbc_z])
          cube([tf_irlhbc_w, tf_irlhbc_d, tf_irlhbc_h]);
      }
      // subtract max-tolerance IR device
      eye_centered_m_irled(0, 0, (2.0 * csg_utol), -20);
      // subtract to make lever out of back of sidewall so eye can snap in
      translate([tf_lc_x, tf_lc_y-(csg_tol/2), tf_lc_z+csg_utol])
        cube([tf_lc_w, tf_lc_d+csg_tol, tf_lc_h]);
      translate([tf_lc2_x, tf_lc2_y-(csg_tol/2), tf_lc2_z+csg_utol])
        cube([tf_lc_w, tf_lc_d+csg_tol, tf_lc_h]);


      // subtract cylinder to make opening/shield for eye
      translate([0, -sw_eye_wall_w/2.0, 0])
        rotate(a=90, v=[1,0,0]) 
          cylinder(h=sw_eye_wall_w+2*csg_tol, r=irle_m_r, center=true, $fn=gfn);
    }
    // add in retaining bump to ensure that a nominal IR device is held firm
    translate([tf_irlrb_x, tf_irlrb_y, tf_irlrb_z]) 
      sphere(r=tf_irlrb_r, center=true, $fn=gfn);

  } // end union
  } // end translate
} // end module tf_irled_holder

// the back wall of the thumb frame
module tf_backstop() {
  translate([tf_bs_x, tf_bs_y, tf_bs_z]) {
    cube([tf_bs_w, tf_bs_d, tf_bs_h]);
  } // end translate
} // end module tf_backstop

// the upper wall of the thumb frame
module tf_uw() {
  translate([tf_uw_x, tf_uw_y, tf_uw_z]) {
    cube([tf_uw_w, tf_uw_d, tf_uw_h]);
  } // end translate
  translate([tf_uw_x + tf_uw_w - tf_mat_t, 
             tf_uw_y + tf_mat_t - csg_tol, 
             tf_uw_z]) {
    cube([tf_bs_x + tf_bs_w - tf_uw_x - tf_uw_w + tf_mat_t, tf_uw_d, tf_uw_h]);
  }
} // end module tf_uw

// the lower wall of the thumb frame
module tf_lw() {
  translate([tf_lw_x, tf_lw_y, tf_lw_z]) {
    cube([tf_lw_w, tf_lw_d, tf_lw_h]);
  } // end of translate
} // end of module tf_lw

module tf(x, y, z) {
  translate([x, y, z]) {
    union() {
      tf_irled_holder(tf_irle_x, tf_irle_y, tf_irle_z);
      tf_uw();
      tf_lw();
      mirror([0,1,0]) {
        tf_irled_holder(tf_irle_x, tf_irle_y, tf_irle_z);
        tf_uw();
        tf_lw();
      } // end mirror
      tf_backstop();
    } // end union
  } // end translate
} // end module tf

