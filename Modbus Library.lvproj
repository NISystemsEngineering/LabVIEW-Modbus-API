<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="13008000">
	<Property Name="NI.LV.All.SourceOnly" Type="Bool">true</Property>
	<Property Name="NI.Project.Description" Type="Str"></Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Data and Functions" Type="Folder">
			<Item Name="Device Data Model.lvclass" Type="LVClass" URL="../Data Model/Device Data Model.lvclass"/>
			<Item Name="Standard Data Model.lvclass" Type="LVClass" URL="../Data Model/Standard Data Model/Standard Data Model.lvclass"/>
			<Item Name="Master Function Definition.lvclass" Type="LVClass" URL="../Master Function Definition/Master Function Definition.lvclass"/>
		</Item>
		<Item Name="Utility" Type="Folder">
			<Property Name="NI.SortType" Type="Int">3</Property>
			<Item Name="Bits to Bytes.vi" Type="VI" URL="../Utility/Bits to Bytes.vi"/>
			<Item Name="Bytes to Bits.vi" Type="VI" URL="../Utility/Bytes to Bits.vi"/>
			<Item Name="U16s to Bytes.vi" Type="VI" URL="../Utility/U16s to Bytes.vi"/>
			<Item Name="Bytes to U16s.vi" Type="VI" URL="../Utility/Bytes to U16s.vi"/>
			<Item Name="Generate UUID.vi" Type="VI" URL="../Utility/Generate UUID.vi"/>
		</Item>
		<Item Name="Transmission Data Unit (ADU)" Type="Folder">
			<Item Name="Transmission Data Unit.lvclass" Type="LVClass" URL="../Transmission Data Unit/Transmission Data Unit.lvclass"/>
			<Item Name="IP Data Unit.lvclass" Type="LVClass" URL="../Transmission Data Unit/IP/IP Data Unit.lvclass"/>
			<Item Name="Serial Data Unit.lvclass" Type="LVClass" URL="../Transmission Data Unit/Serial Interface/Serial Data Unit.lvclass"/>
			<Item Name="RTU Data Unit.lvclass" Type="LVClass" URL="../Transmission Data Unit/RTU/RTU Data Unit.lvclass"/>
			<Item Name="ASCII Data Unit.lvclass" Type="LVClass" URL="../Transmission Data Unit/ASCII/ASCII Data Unit.lvclass"/>
		</Item>
		<Item Name="Modbus Data Unit (PDU)" Type="Folder">
			<Property Name="NI.SortType" Type="Int">3</Property>
			<Item Name="Modbus Data Unit.lvclass" Type="LVClass" URL="../Modbus Data Unit/Modbus Data Unit.lvclass"/>
		</Item>
		<Item Name="Protocol" Type="Folder">
			<Item Name="Interfaces" Type="Folder">
				<Item Name="Network Protocol.lvclass" Type="LVClass" URL="../Network Protocol/Network Protocol.lvclass"/>
				<Item Name="Network Master.lvclass" Type="LVClass" URL="../Network Protocol/Network Master/Network Master.lvclass"/>
				<Item Name="Network Slave.lvclass" Type="LVClass" URL="../Network Protocol/Network Slave/Network Slave.lvclass"/>
			</Item>
			<Item Name="TCP" Type="Folder">
				<Item Name="TCP_NODELAY.vi" Type="VI" URL="../Network Protocol/TCP_NODELAY.vi"/>
				<Item Name="TCP Master.lvclass" Type="LVClass" URL="../Network Protocol/Network Master/TCP/TCP Master.lvclass"/>
				<Item Name="TCP Slave.lvclass" Type="LVClass" URL="../Network Protocol/Network Slave/TCP/TCP Slave.lvclass"/>
				<Item Name="TCP Shared Components.lvlib" Type="Library" URL="../Network Protocol/TCP Shared Components/TCP Shared Components.lvlib"/>
			</Item>
			<Item Name="Serial" Type="Folder">
				<Item Name="Serial Master.lvclass" Type="LVClass" URL="../Network Protocol/Network Master/Serial/Serial Master.lvclass"/>
				<Item Name="Serial Slave.lvclass" Type="LVClass" URL="../Network Protocol/Network Slave/Serial/Serial Slave.lvclass"/>
				<Item Name="Serial Shared Components.lvlib" Type="Library" URL="../Network Protocol/Serial Shared Components/Serial Shared Components.lvlib"/>
			</Item>
		</Item>
		<Item Name="Modbus API" Type="Folder">
			<Item Name="Modbus API.lvclass" Type="LVClass" URL="../API/Modbus API.lvclass"/>
			<Item Name="Modbus Master.lvclass" Type="LVClass" URL="../API/Master/Modbus Master.lvclass"/>
			<Item Name="Modbus Slave.lvclass" Type="LVClass" URL="../API/Slave/Modbus Slave.lvclass"/>
			<Item Name="API Main.lvlib" Type="Library" URL="../API/Wrapper/API Main.lvlib"/>
		</Item>
		<Item Name="Examples" Type="Folder">
			<Item Name="Modbus Serial Slave Example.vi" Type="VI" URL="../Examples/Modbus Serial Slave Example.vi"/>
			<Item Name="Modbus Serial Master Example.vi" Type="VI" URL="../Examples/Modbus Serial Master Example.vi"/>
			<Item Name="Modbus Master Example.vi" Type="VI" URL="../Examples/Modbus Master Example.vi"/>
			<Item Name="Modbus Slave Example.vi" Type="VI" URL="../Examples/Modbus Slave Example.vi"/>
		</Item>
		<Item Name="ModbusLibrary-errors.txt" Type="Document" URL="../ModbusLibrary-errors.txt"/>
		<Item Name="Dependencies" Type="Dependencies">
			<Item Name="vi.lib" Type="Folder">
				<Item Name="Clear Errors.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Clear Errors.vi"/>
				<Item Name="Error Cluster From Error Code.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/error.llb/Error Cluster From Error Code.vi"/>
				<Item Name="VISA Flush IO Buffer Mask.ctl" Type="VI" URL="/&lt;vilib&gt;/Instr/_visa.llb/VISA Flush IO Buffer Mask.ctl"/>
				<Item Name="TCP Get Raw Net Object.vi" Type="VI" URL="/&lt;vilib&gt;/Utility/tcp.llb/TCP Get Raw Net Object.vi"/>
				<Item Name="3D Plot.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Plot/3D Plot/3D Plot.lvclass"/>
				<Item Name="3D Comet.lvclass" Type="LVClass" URL="/&lt;vilib&gt;/Math Plots/3D Math Plots/3D Comet/3D Comet/3D Comet.lvclass"/>
			</Item>
			<Item Name="wsock32.dll" Type="Document" URL="wsock32.dll">
				<Property Name="NI.PreserveRelativePath" Type="Bool">true</Property>
			</Item>
		</Item>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="My Source Distribution" Type="Source Distribution">
				<Property Name="Bld_buildCacheID" Type="Str">{38ECD8AA-A1D8-42C8-A80A-EF0490FCE196}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">My Source Distribution</Property>
				<Property Name="Bld_excludedDirectory[0]" Type="Path">vi.lib</Property>
				<Property Name="Bld_excludedDirectory[0].pathType" Type="Str">relativeToAppDir</Property>
				<Property Name="Bld_excludedDirectory[1]" Type="Path">instr.lib</Property>
				<Property Name="Bld_excludedDirectory[1].pathType" Type="Str">relativeToAppDir</Property>
				<Property Name="Bld_excludedDirectory[2]" Type="Path">user.lib</Property>
				<Property Name="Bld_excludedDirectory[2].pathType" Type="Str">relativeToAppDir</Property>
				<Property Name="Bld_excludedDirectory[3]" Type="Path">resource/objmgr</Property>
				<Property Name="Bld_excludedDirectory[3].pathType" Type="Str">relativeToAppDir</Property>
				<Property Name="Bld_excludedDirectory[4]" Type="Path">/C/Users/ebeutlic/Documents/LabVIEW Data/InstCache</Property>
				<Property Name="Bld_excludedDirectoryCount" Type="Int">5</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/My Source Distribution</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{83E71208-A3C3-4B36-9793-7E9F3D3B5D88}</Property>
				<Property Name="Bld_version.major" Type="Int">1</Property>
				<Property Name="Destination[0].destName" Type="Str">Destination Directory</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/My Source Distribution</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/My Source Distribution/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Source[0].itemID" Type="Str">{A16C1C95-7DE8-4188-9DE2-4BD0006A51AB}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref"></Property>
				<Property Name="Source[1].Library.allowMissingMembers" Type="Bool">true</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[1].type" Type="Str">Library</Property>
				<Property Name="Source[2].Container.applyInclusion" Type="Bool">true</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[2].itemID" Type="Ref"></Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Container</Property>
				<Property Name="SourceCount" Type="Int">3</Property>
			</Item>
		</Item>
	</Item>
</Project>
