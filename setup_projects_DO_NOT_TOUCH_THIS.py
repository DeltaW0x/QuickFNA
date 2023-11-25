import sys
import xml.etree.ElementTree as ET

default_code = """
using System;
using Microsoft.Xna.Framework;

class FNAGame : Game
{
	[STAThread]
	static void Main(string[] args)
	{
		using (FNAGame g = new FNAGame())
		{
			g.Run();
		}
	}

	private FNAGame()
	{
		GraphicsDeviceManager gdm = new GraphicsDeviceManager(this);

		// Typically you would load a config here...
		gdm.PreferredBackBufferWidth = 1280;
		gdm.PreferredBackBufferHeight = 720;
		gdm.IsFullScreen = false;
		gdm.SynchronizeWithVerticalRetrace = true;
	}

	protected override void Initialize()
	{
		/* This is a nice place to start up the engine, after
		 * loading configuration stuff in the constructor
		 */
		base.Initialize();
	}

	protected override void LoadContent()
	{
		// Load textures, sounds, and so on in here...
		base.LoadContent();
	}

	protected override void UnloadContent()
	{
		// Clean up after yourself!
		base.UnloadContent();
	}

	protected override void Update(GameTime gameTime)
	{
		// Run game logic in here. Do NOT render anything here!
		base.Update(gameTime);
	}

	protected override void Draw(GameTime gameTime)
	{
		// Render stuff in here. Do NOT run game logic in here!
		GraphicsDevice.Clear(Color.CornflowerBlue);
		base.Draw(gameTime);
	}
}"""


project_name = sys.argv[1]
project_file = project_name + '/' + project_name + '/' + "Program.cs"
csproj_path = project_name + '/' + project_name + '/' + project_name + '.csproj'
solution_path = project_name + '/' + project_name + '.sln'

csproj_tree = ET.parse(csproj_path)
csproj_root = csproj_tree.getroot()

windows_condition = "'" + "$(OS)'" + "!=" +"'Windows_NT'"+'"'
other_os_condition = "'" + "$(OS)'" + "==" +"'Windows_NT'"+'"'


property_group = ET.SubElement(csproj_root,'PropertyGroup')
aot = ET.SubElement(property_group,'PublishAot')
aot.text = 'true'

global_item_group = ET.SubElement(csproj_root,'ItemGroup')
rd_xml_file = ET.SubElement(global_item_group,'RdXmlFile Include="rd.xml"')
sdl = ET.SubElement(global_item_group,'DirectPInvokeList Include="SDLApis.txt"')
fna_3d = ET.SubElement(global_item_group,'DirectPInvoke Include="FNA3D"')
faudio = ET.SubElement(global_item_group,'DirectPInvoke Include="FAudio"')
libtheora = ET.SubElement(global_item_group,'DirectPInvoke Include="libtheorafile"')


windows_property_group = ET.SubElement(csproj_root,'ItemGroup')
windows_property_group.set('Condition',windows_condition)
window_sdl_natlib =  ET.SubElement(windows_property_group,'NativeLibrary Include="SDL2.lib"')
window_fna_3d_natlib =  ET.SubElement(windows_property_group,'NativeLibrary Include="FNA3D.lib"')
window_faudio_natlib =  ET.SubElement(windows_property_group,'NativeLibrary Include="FAudio.lib"')
window_theorafile_natlib =  ET.SubElement(windows_property_group,'NativeLibrary Include="libtheorafile.lib"')

other_os_property_group = ET.SubElement(csproj_root,'ItemGroup')
other_os_property_group.set('Condition',other_os_condition)
other_os_sdl_natlib =  ET.SubElement(other_os_property_group,'NativeLibrary Include="-lSDL2"')
other_os_fna_3d_natlib =  ET.SubElement(other_os_property_group,'NativeLibrary Include="-lFNA3D"')
other_os_faudio_natlib =  ET.SubElement(other_os_property_group,'NativeLibrary Include="-lFAudio"')
other_os_theorafile_natlib =  ET.SubElement(other_os_property_group,'NativeLibrary Include="-ltheorafile"')

ET.indent(csproj_root)

output = open(csproj_path, "wb")
csproj_tree.write(output)
output.close()

f = open(csproj_path,'r')
filedata = f.read()
f.close()
newdata = filedata.replace('&quot;','')
f = open(csproj_path,'w')
f.write(newdata)
f.close()

f = open(project_file,'w')
f.write(default_code)
f.close()
