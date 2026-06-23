-- Global routing enforcement function
function enforceDownstreamRouting()
-- Tie output.Virtual_Sink to Carla, trying both port naming variants safely
os.execute("pw-link output.Virtual_Sink:capture_1 Carla:audio-in1 2>/dev/null || pw-link output.Virtual_Sink:capture_FL Carla:audio-in1 2>/dev/null")
os.execute("pw-link output.Virtual_Sink:capture_2 Carla:audio-in2 2>/dev/null || pw-link output.Virtual_Sink:capture_FR Carla:audio-in2 2>/dev/null")

-- Tie Carla downstream straight to the physical HDMI hardware ports
os.execute("pw-link Carla:audio-out1 alsa_output.pci-0000_01_00.1.hdmi-stereo-extra3:playback_FL 2>/dev/null")
os.execute("pw-link Carla:audio-out2 alsa_output.pci-0000_01_00.1.hdmi-stereo-extra3:playback_FR 2>/dev/null")
end

-- Watch the graph for hardware state additions/changes dynamically
om = ObjectManager {
  Interest { type = "node" }
}

om:connect("object-added", function(_, node)
local name = node.properties["node.name"]
if name == "Carla" or (name and string.find(name, "hdmi")) or name == "Virtual_Sink" then
  Core.timeout_add(1000, enforceDownstreamRouting)
  end
  end)

om:activate()

-- Fail-safe fallbacks: Kick the connection script explicitly on system startup
Core.timeout_add(1000, enforceDownstreamRouting)
Core.timeout_add(5000, enforceDownstreamRouting)
