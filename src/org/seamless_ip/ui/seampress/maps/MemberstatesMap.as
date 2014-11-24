package org.seamless_ip.ui.seampress.maps
{
  import ilog.maps.MapBase;
  import ilog.maps.Map;

 /**
  * Implementation of a specialized <code>MapBase</code>.
  * 
  *  @mxml
  *  
  *  <p>
  *  The <code>&lt;ilog:MemberstatesMap&gt;</code> tag inherits all the tag attributes of its superclass and
  *  adds the following tag attributes:
  *  </p>
  *  <pre>
  *  &lt;ilog:MemberstatesMap
  *    <b>Properties</b>
  *    allowMultipleSelection="true|false"
  *    mapFeatures="[]"
  *    selectedFeatures="[]"
  *    symbols="[]"
  *    zoomableSymbols="true|false"
  *    allowNavigation="true|false"
  *    filterEvents="true|false"
  *    featureNames="[]"
  *    duration="-1"
  *    
  *    <b>Styles</b>
  *    animationDuration="0"
  *    backgroundFill="0x6A5ACD"
  *    fill="0xFAEBD7"
  *    stroke="0xA9967D"
  *    highlightFill="0xA354FF"
  *    highlightStroke="0xFFD39B"
  *    filters="[]"
  *    highlightFilters="[]"
  *    cursor="[]"
  *    showZoomReticle="true|false"
  *    
  *    <b>Events</b>
  *    mapChange="<i>No default</i>"
  *    mapItemDoubleClick="<i>No default</i>"
  *    mapItemRollOut="<i>No default</i>"
  *    mapItemRollOver="<i>No default</i>"
  *    mapItemClick="<i>No default</i>"
  *  /&gt;
  *  </pre>
  *
  *  @see ilog.maps.MapBase 

  */
  public class MemberstatesMap extends MapBase  {
   /**
    * @inheritDoc
    */
    public override function createMap():Map {
      return new Memberstates();
    }
   /**
    * @inheritDoc
    */
    public override function getString(k:String):String {
      if(resourceManager != null)
        return resourceManager.getString("Memberstates", k);
      return k;
    }
  }
}
