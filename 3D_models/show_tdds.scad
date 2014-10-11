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

use <tdds.scad>;
use <util.scad>;
use <LiteOn_P_100_E302.scad>;

include <dimensions.scad>;

difference() {
  tdds_centered(0, 0, 0, 1, 1);

//  pos_c_cube(-50, 0, 0, 100, 100, 100);

} // end difference