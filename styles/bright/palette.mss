/* ****************************************************************** */
/* GéoPicardie - OSM Styles for GéoPicardie (bright one)              */
/* ****************************************************************** */

/* Directory of project specific fonts                                */
Map {
  font-directory: url(./fonts);
  background-color: @water;
  buffer-size: 512;
}

/* Fonts                                                              */
@sans_light:            "Exo Light";
@sans:                  "Exo Demi Bold";
@sans_bold:             "Exo Extra Bold";
@sans_italic:           "Exo Regular Italic";
@sans_semi_bold_italic: "Exo Demi Bold Italic";
@sans_bold_italic:      "Exo Bold Italic";

/* land use colors                                                    */
@land:              #FFFEF5;
@urban:             #DDDDDD;
@water:             #C4DFF6;
@grass:             #D4F2C4;
@wood:              #BEE5A9;

@beach:             @land;
@agriculture:       @land;

@park:              @grass;
@sports:            @grass;

@cemetery:          @urban;
@residential:       @urban;
@commercial:        @urban;
@industrial:        @urban;
@hospital:          @urban;
@school:            @urban;
@cultural:          @urban;
@parking:           @urban;
@aerodrome:         lighten(@urban, 10%);

/* Building color                                                     */
@building:          darken(@urban, 15%);

/* Stream and canal line features                                     */
@stream:            lighten(@water, 15%);
@canal:             @stream;

/* Factors used to darken or lighten colors at highest scales         */
@urban_darken_scale_factor:     -3%;
@building_darken_scale_factor:  -2%;

/* Factors used to darken borders                                     */
@wood_darken_border_factor:     20%;
@grass_darken_border_factor:    10%;
@urban_darken_border_factor:    30%;
@sports_darken_border_factor:   30%;
@aerodrome_darken_border_factor:30%;
@waterway_darken_border_factor: 15%;
@waterarea_darken_border_factor:15%;
@building_darken_border_factor: 30%;

/* ================================================================== */
/* ROAD COLORS
/* ================================================================== */

/* For each class of road there are three color variables:
 * - line: for lower zoomlevels when the road is represented by a
 *         single solid line.
 * - case: for higher zoomlevels, this color is for the road's
 *         casing (outline).
 * - fill: for higher zoomlevels, this color is for the road's
 *         inner fill (inline).
 */

@standard_line:     #999;
@standard_fill:     #fff;
@standard_case:     @standard_line;
@standard_tunnel_fill: #fcfcfb;

@motorway_line:     #813865;
@motorway_fill:     #ffe8f6;
@motorway_case:     #813865;
@motorway_tunnel_fill: #ffe8f6;

@trunk_line:        @motorway_line;
@trunk_fill:        @motorway_fill;
@trunk_case:        @motorway_case;
@trunk_tunnel_fill: @motorway_tunnel_fill;

@primary_line:      @standard_line * 0.90;
@primary_fill:      @standard_fill;
@primary_case:      @standard_case * 0.90;
@primary_tunnel_fill: @standard_tunnel_fill;

@secondary_line:    @primary_line;
@secondary_fill:    @standard_fill;
@secondary_case:    @standard_case;
@secondary_tunnel_fill:@standard_tunnel_fill;

@path:              darken(@urban, 30%);
@track:             darken(@urban, 30%);
@cycleway:          darken(@urban, 30%);

@big_bridge_fill:   @urban;
@big_bridge_case:   darken(@big_bridge_fill, 30%);

@small_bridge_fill: @urban;
@small_bridge_case: darken(@small_bridge_fill, 30%);

@rail_fill:         #888;
@rail_bridge_fill:  @urban;

@aeroway:           darken(@aerodrome, 5%);

/* ================================================================== */
/* LABEL COLORS
/* ================================================================== */

/* We set up a default halo color for places so you can edit them all
   at once or override each individually. */
@place_halo:        fadeout(#fff, 25%);

@city_text:         #222;
@city_halo:         @place_halo;
@city_marker_opacity: 1.00;
@city_text_size:    12;

@town_text:         #222;
@town_halo:         @place_halo;
@town_text_size:    11;

/*BCR @road_text:         #555;*/
@road_text:         #777;
@road_halo:         @place_halo;

/* ****************************************************************** */
