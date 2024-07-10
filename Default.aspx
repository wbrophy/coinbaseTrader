<!DOCTYPE html>
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE" />
<META HTTP-EQUIV="EXPIRES" CONTENT="-1" />
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script src="core.js"></script>
		<script src="sha256.js"></script>
		<script src="hmac.js"></script>
		<script src="enc-base64.js"></script>
		<style type="text/css">
			.alertRow
				{
					background-color: #f9d1dd
				}
			.alertRow1
				{
					background-color: #a2fc9f
				}
			.classGain
				{
					color: green;
				}
			.classLoss
				{
					color: red;
				}
			body
				{
					font-family:Arial, sans-serif;
					font-size:14px;			
				}
			table[id=ChartTable]  
				{
					border-collapse:collapse;
					border-spacing:0;
				}
			table[id=ChartTable] > thead > tr > td
				{
					border-color:black;
					border-style:solid;
					border-width:1px;
					overflow:hidden;
					padding:10px 5px;
					word-break:normal;
					text-align:left;
					vertical-align: top;
				}
			table[id=ChartTable] > thead > tr:first-child > td
				{
					border-color:black;
					border-style:solid;
					border-width:1px;
					overflow:hidden;
					padding:10px 5px;
					word-break:normal;
					text-align:left;
					font-weight: bold;
				}
			table[id=ChartTable] > thead > tr > td > span
				{
					display: block;
				}
			table[id=ChartTable] > thead > tr > td[id=Guages] > span
				{
					display: inline-block;
				}
			table[id=ChartTable] > thead > tr:first-child > td > span
				{
					display: none;
				}
			table[id=ChartTable] > thead > tr:first-child > td[id=Product] > p[id=Buttons]
				{
					display: none;
				}
			table[id=ChartTable] > thead > tr:first-child > td::before
				{
				  content: attr(id);
				}			
			table[id=ChartTable] > thead > tr > td > span[id=Average]::before
				{
				  content: "A:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=CurrentPrice]::before
				{
				  content: "C:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=PurchasePrice]::before
				{
				  content: "P:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=OpenPrice]::before
				{
				  content: "O:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=Shares]::before
				{
				  content: "S:";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=SubsequentHigh]::before
				{
				  content: "SH:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=SubsequentLow]::before
				{
				  content: "SL:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=Trades]::before
				{
				  content: "Trades:";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=TotalTrades]::before
				{
				  content: "TotalTrades:";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=TradesValue]::before
				{
				  content: "Trades:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=High]::before
				{
				  content: "H:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=Low]::before
				{
				  content: "L:$";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=Volume]::before
				{
				  content: "V:";
				}			
			table[id=ChartTable] > thead > tr > td > span[id=VolumeValue]::before
				{
				  content: "V:$";
				}			
			table[id=ChartTable] > thead > tr > td[id=Guages] > span
				{
				  width: 10px;
				  height: 100px;
				  background-image: linear-gradient(green 50%, tan 0%, red 50%);;
				}			
		</style>
	</head>
    <body>
	<audio id="audioSiren">
	  <source src="AirHorn.mp3" type="audio/mpeg">
	  Your browser does not support the audio element.
	</audio>
	<audio id="audioShipHorn">
	  <source src="ShipHorn.mp3" type="audio/mpeg">
	  Your browser does not support the audio element.
	</audio>
	<p id="cb-authentication">
		<input size=100 type=text value="" id="cb-access-key" placeholder="cb-access-key"><br>
		<input size=100 type=text value="" id="cb-access-secret" placeholder="cb-access-secret"><br>
		<input size=100 type=text value="" id="cb-access-passphrase" placeholder="cb-access-passphrase"><br>
		<button type="button" onclick="javascript: fnAuthenticate(coinbaseURI + 'accounts', fnAuthenticate_Success);">Authenticate</button>
	</p>
	<p id='p_realtimeJavascript'>
		<textarea id='realtimeJavascript' style='width: 100%'></textarea><br>
		<button type="button" onclick="javascript: eval(document.getElementById('realtimeJavascript').value.toString());">Execute</button>
	</p>
	<p>
		<form>
			Crypto: <input id="frmCrypto" name="frmCrypto" type="text" value="" />&nbsp;&nbsp;Purchase Price: <input id="frmPrice" name="frmPrice" type="text" value="" /><br/> 
			<button type="button" value="Submit" onclick="fnAddCrypto();">Add Crypto</button>
		</form>
	</p>
	<p>
		Import Object<input type="file" id="objectfile" onchange="fnImportObject(this)" />
	</p>
	<button type="button" onclick="javascript: OpenWebSocket();">OpenWebSocket</button><button type="button" onclick="javascript: CloseWebSocket();">CloseWebSocket</button>
	<p id="TimeMarker"></p>
	<p id="WebSocketMessage"></p>
		<table id="ChartTable">
			<thead>
				<tr>
					<td id='Product'>
						<span id="ProductId">ProductId</span>
						<span id="PurchasePrice">PurchasePrice</span>
						<span id="Shares">Shares</span>
						<span id="DownloadLogs">DownloadLogs</span>
						<span id="DownloadMessages">DownloadMessages</span>
						<p id='Buttons'>
							<button id="RemoveProduct" type='button' onclick='javascript:fnButtonRemoveProduct(this);'>Remove Product</button>
						</p>
					</td>
					<td id='CurrentPrice'>
						<span id="CurrentPrice">CurrentPrice</span>
						<span id="OpenPrice">OpenPrice</span>
						<span id="SubsequentHigh">SubsequentHigh</span>
						<span id="SubsequentLow">SubsequentLow</span>
						<span id="Average">Average</span>
						<span id="TotalTrades">TotalTrades</span>
						<span id="Trades">Trades</span>
						<span id="TradesValue">TradesValue</span>
						<span id="Volume">Volume</span>
						<span id="VolumeValue">VolumeValue</span>
					</td>
					<td id='Guages'>
						<span id="SidePressure"></span>
						<span id="PricePressure"></span>
					</td>
					<td id='Triggers'>
						<button id="AddTrigger" type='button' onclick='javascript:addTrigger(this);'>Add Trigger</button>
						<button id="ImportTriggers" type='button' onclick='javascript:importTriggers(this);'>Import Triggers</button>
						<button id="ExportTrigger" type='button' onclick='javascript:exportTrigger(this);'>Export Trigger</button>
						<table id='triggers'></table>
					</td>
					<td id='24hr'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
						<span id="Volume">Volume</span>
					</td>
					<td id='7day'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
					</td>
					<td id='30day'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
						<span id="Volume">Volume</span>
					</td>
					<td id='90day'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
					</td>
					<td id='180day'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
					</td>
					<td id='300day'>
						<span id="High">High</span>
						<span id="Low">Low</span>
						<span id="Average">Average</span>
					</td>
					<td id='Messages'></td>
				</tr>
			</thead>
		</table>
		<p></p>
		<datalist id=triggerVariables >
			<option>fnV_Product.CurrentPrice
			<option>Products[fnV_ProductIndex].PurchasePrice
		</datalist>
        <script type="text/javascript">
			var coinbaseURI = "https://api.exchange.coinbase.com/";
			var coinbaseWebSocketURI = "wss://ws-feed.pro.coinbase.com/";
			var coinbaseProductsURI = coinbaseURI + "products/<ProductId>";
			var coinbaseBookURI = coinbaseURI + "products/<ProductId>/book/?level=<Level>";
			var coinbaseStatsURI = coinbaseURI + "products/<ProductId>/stats";
			var coinbaseCandlesURI = coinbaseURI + "products/<ProductId>/candles/?start=<StartTime>&end=<EndTime>&granularity=<Granularity>";
			var coinbaseTradeURI = "https://www.coinbase.com/advanced-trade/";  // "https://pro.coinbase.com/trade/";
			var audioSiren = document.getElementById("audioSiren");
			var audioShipHorn = document.getElementById("audioShipHorn");
			coinbaseSocket = {}; //new WebSocket(coinbaseWebSocketURI);
			
			// Variables --- START
			// Future Work - START
			const portfolioObj = 	{
										Products : [],
										Trades : function()	{
																fnV_Trades = 0;
																Products.forEach(function(obj) { fnV_Trades += Number(obj.ticker.length); });
																//fnV_Trades = Number.isNaN(fnV_Trades) ? Number(0) : fnV_Trades;
																return fnV_Trades;
															},
										TradeValue : function()	{
																	fnV_TradeValue = 0;
																	this.Products.forEach(function(obj) { fnV_TradeValue += Number(obj.TradeValue); });
																	//fnV_TradeValue = Number.isNaN(fnV_TradeValue) ? Number(0) : fnV_TradeValue;
																	return fnV_TradeValue;																	
																},
										Triggers : []
									};
			// Future Work - END
			

			fnVtemp_CurrentTime = fnGetCurrentTime().iso;
			dataObj = { 
						CurrentPrice : Number(0),
						CurrentPriceTimeStamp : fnVtemp_CurrentTime,
						MessageDuration : Number(604800),
						MessageMax : Number(1000),
						OpenPrice : Number(0),
						OpenPriceTimeStamp : fnGetCurrentTime().iso,
						ProductId : "",
						PurchasePrice : Number(0),
						Shares : Number(0),
						SubsequentHigh : Number(0),
						SubsequentHighTimeStamp : fnVtemp_CurrentTime,
						SubsequentLow : Number(0),
						SubsequentLowTimeStamp : fnVtemp_CurrentTime,
						TickerDuration : Number(60),
						TradeCount : Number(0),
						TradeShare : Number(0),
						TradeValue : Number(0),
						TradeValueShare : Number(0),
						Volume : Number(0),
						VolumeShare : Number(0),
						VolumeValue : Number(0),
						VolumeValueShare : Number(0),
						Average : function()			{
															fnV_AverageList = new Array(); //[ ];
															fnV_Average = Number(0);
															for (let i = 0; i < this.candles.length; i++)
																{
																	fnV_candleLow = Number(this.candles[i][1]);
																	fnV_candleHigh = Number(this.candles[i][2]);
																	fnV_Average += fnV_candleLow + fnV_candleHigh;
																	fnV_Averaged = fnV_Average / ((i+1) * 2);
																	fnV_unshift = fnV_AverageList.push(fnV_Averaged);
																}
															return fnV_AverageList;
														},
						Bounce : function(fnV_Difference = 0, fnV_Count = 0) 		
														{
															// Does Price fluctuate fnV_Difference%(or more), fnV_Count times within the ticker collection?
															// A riddled with flaws function - build back better --later
															fnV_Bounce = {};
															fnV_Bounce.bouncing = false;
															fnV_Counter = 0;
															fnV_Direction = "";
															fnV_High = 0;
															fnV_Low = 0;
															
															if (fnV_Difference == 0 || fnV_Count == 0)
																{ return fnV_Bounce; }
																
															this.ticker.forEach(function(obj) 	{ 
																									fnV_High = (fnV_High == 0 || fnV_High < obj.price) ? obj.price : fnV_High;
																									fnV_Low = (fnV_Low == 0 || fnV_Low > obj.price) ? obj.price : fnV_Low;
																									// X is what % of Y? ((X*100)/Y) * 100
																									fnV_Difference1 = fnV_Low == fnV_High ? 0 : 100 - ((fnV_Low * 100) / fnV_High);
																									if (fnV_Difference1 >= fnV_Difference)
																										{
																											if ( (obj.price == fnV_High) && (fnV_Direction != "up") )
																												{
																													fnV_Counter++;
																													fnV_Direction == "up";
																													//fnV_Low = fnV_High;
																												}
																											else if ( (obj.price == fnV_Low) && (fnV_Direction != "down") )
																												{
																													fnV_Counter++;
																													fnV_Direction == "down";
																													//fnV_High = fnV_Low;
																												}
																										}
																								})
															fnV_Bounce.bouncing = fnV_Counter >= fnV_Count ? true : false;
															fnV_Bounce.high = fnV_High;
															fnV_Bounce.low = fnV_Low;
															return fnV_Bounce;
														},
						Difference : function(fnV_Value1, fnV_Value2)
														{
															fnV_Difference = Number((fnV_Value1 - fnV_Value2)*100)/fnV_Value2;
															return fnV_Difference;
														},
						High : function() 				{
															fnV_HighList = new Array(); //[ ];
															fnV_High = Number(0);
															for (let i = 0; i < this.candles.length; i++)
																{
																	fnV_candleHigh = Number(this.candles[i][2]);
																	fnV_High = fnV_High > fnV_candleHigh ? fnV_High : fnV_candleHigh;
																	fnV_unshift = fnV_HighList.push(fnV_High);
																}
															return fnV_HighList;
														},
						Low : function() 				{
															fnV_LowList = new Array(); //[ ];
															fnV_Low = Number(0);
															for (let i = 0; i < this.candles.length; i++)
																{
																	fnV_candleLow = Number(this.candles[i][1]);
																	fnV_Low = ((fnV_Low < fnV_candleLow) && (fnV_Low != 0)) ? fnV_Low : fnV_candleLow;
																	fnV_unshift = fnV_LowList.push(fnV_Low);
																}
															return fnV_LowList;
														},
						PricePressure : function()
														{ // "up", "down", "unchanged"
															fnV_PricePressure = { up : Number(0), down : Number(0), unchanged : Number(0) };
															for (let i = 0; i < this.ticker.length-1; i++)
																{
																	fnV_TickerPreviousPrice = Number(this.ticker[i+1].price);
																	fnV_TickerPrice = Number(this.ticker[i].price);
																	fnV_PricePressure.up = fnV_TickerPrice > fnV_TickerPreviousPrice ? fnV_PricePressure.up+1 : fnV_PricePressure.up;
																	fnV_PricePressure.down = fnV_TickerPrice < fnV_TickerPreviousPrice ? fnV_PricePressure.down+1 : fnV_PricePressure.down;
																	fnV_PricePressure.unchanged = fnV_TickerPrice == fnV_TickerPreviousPrice ? fnV_PricePressure.unchanged+1 : fnV_PricePressure.unchanged;
																}
															fnV_PricePressure.down = fnV_PricePressure.down == 0 ? 0 : (100 / this.ticker.length) * fnV_PricePressure.down;
															fnV_PricePressure.unchanged = fnV_PricePressure.unchanged == 0 ? 0 : (100 / this.ticker.length) * fnV_PricePressure.unchanged;
															fnV_PricePressure.up = fnV_PricePressure.up == 0 ? 0 : (100 / this.ticker.length) * fnV_PricePressure.up;
															//alert("down:" + fnV_PriceDown + " | up:" + fnV_PriceUp + " | pu:" + fnV_PriceUnchanged);
															return fnV_PricePressure;
														},
						SidePressure : function()
														{
															fnV_SidePressure = { buy : Number(0), sell : Number(0) };
															fnV_SidePressure.buy =  Number(this.ticker.filter(ticker => ticker.side === "buy").length);
															fnV_SidePressure.sell =  Number(this.ticker.filter(ticker => ticker.side === "sell").length);
															fnV_SidePressure.buy =  (100 / this.ticker.length) * fnV_SidePressure.buy;
															fnV_SidePressure.sell =  (100 / this.ticker.length) * fnV_SidePressure.sell;
															return fnV_SidePressure;
														},
						TradesValue : function()		{
															fnV_TradesValue = Number(0);
															this.ticker.forEach(function(obj) 	{ fnV_TradesValue += Number(obj.price) * Number(obj.last_size); });
															fnV_TradesValue = Number.isNaN(fnV_TradesValue) ? Number(0) : fnV_TradesValue;
															this.TradeValue = fnV_TradesValue;
															return fnV_TradesValue;
														}
					  };
			var WebSocketMessageP = document.getElementById("WebSocketMessage");
			Products = [];
			cryptoUpdatingHistory = false;
			// Variables --- END


			// Functions --- START
			//******************************************************************************************************
			
			//******************************************************************************************************
			// coinbaseSocket EventListeners --- START
			//******************************************************************************************************
			
			//------------------------------------------------------------------------------------------
			function coinbaseSocket_Close(event) 
				{
					if (event.wasClean) 
						{
							//alert(`[close] Connection closed cleanly, code=${event.code} reason=${event.reason}`);
						} 
					else
						{
							// e.g. server process killed or network down
							// event.code is usually 1006 in this case
							//alert('[close] Connection died');
						}
					if (event.code != 4911)
						{
							OpenWebSocket();
						}
				};
			//------------------------------------------------------------------------------------------

			
			//------------------------------------------------------------------------------------------
			function coinbaseSocket_Error(error) 
				{
					alert(`[error] ${error.message}`);
				};
			//------------------------------------------------------------------------------------------

			
			//------------------------------------------------------------------------------------------
			function coinbaseSocket_Open(event) 
				{
					var urlParams = new URLSearchParams(window.location.search);
					if (urlParams == "" && Products.length < 1)
						{ fnGetAllTradeableCrypto(); }
					else if (Products.length)
						{ fnGetData1(); }
					else
						{ fnGetData(); }
				};
			//------------------------------------------------------------------------------------------

			//------------------------------------------------------------------------------------------
			function coinbaseSocket_Message(fnV_event) 
				{
					fnV_objJSONresult = JSON.parse(fnV_event.data);
					const fnV_strJSONPretty = JSON.stringify(fnV_objJSONresult, null, "<br>");
					fnV_MessageType = fnV_objJSONresult.type;
					fnV_ProductId = fnV_objJSONresult.product_id;

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					if (fnV_ProductIndex == -1)
						{ return 0; }

					var fnV_WebSocketMessageP = document.getElementById("WebSocketMessage");
					//WebSocketMessageP.innerHTML = "Type: " + fnV_MessageType + "<br>" + fnV_event.data;
					WebSocketMessageP.innerHTML = "Type: " + fnV_MessageType + "<br>" + fnV_strJSONPretty;
					//return;
					
					
					switch (fnV_MessageType)
						{
							case "ticker":
								// Message == "ticker" - Start
								//{
								//    "type": "ticker",
								//    "trade_id": 20153558,
								//    "sequence": 3262786978,
								//    "time": "2017-09-02T17:05:49.250000Z",
								//    "product_id": "BTC-USD",
								//    "price": "4388.01000000",
								//    "side": "buy", // Taker side
								//    "last_size": "0.03000000",
								//    "best_bid": "4388",
								//    "best_ask": "4388.01"
								//}
								//alert(strJSONPretty);
								// Push the Ticker to the Product
								fnV_unshift = Products[fnV_ProductIndex].ticker.unshift(fnV_objJSONresult);
								// Clean expired ticker objects
								//fnV_date1 = new Date(fnV_objJSONresult.time);
								//fnV_MinDate = Date.parse(fnV_date1) - (Number(Products[fnV_ProductIndex].TickerDuration) * 1000);
								//fnV_index = Products[fnV_ProductIndex].ticker.findIndex(function(ticker){ return (Date.parse(Date(ticker.time)) < fnV_MinDate); }); // ticker => Date.parse(Date(ticker.time)) < fnV_MinDate);
								//Products[fnV_ProductIndex].ticker.splice(fnV_index - 1);
								
								for (fnV_index = 0; fnV_index < Products[fnV_ProductIndex].ticker.length; fnV_index++)
									{
										fnV_date1 = new Date(Products[fnV_ProductIndex].ticker[fnV_index].time);
										fnV_date2 = new Date(fnV_objJSONresult.time);
										fnV_diffTime = Math.abs(fnV_date2 - fnV_date1);
										if (fnV_diffTime >= (Number(Products[fnV_ProductIndex].TickerDuration) * 1000)) 
											{
												Products[fnV_ProductIndex].ticker.splice(fnV_index - 1);
											}
									}
								
									
								Products[fnV_ProductIndex].TradeCount++;
								Products[fnV_ProductIndex].CurrentPrice = Number(fnV_objJSONresult.price);
								Products[fnV_ProductIndex].CurrentPriceTimeStamp = fnV_objJSONresult.time;
								Products[fnV_ProductIndex].OpenPrice = Products[fnV_ProductIndex].OpenPrice != 0 ? Products[fnV_ProductIndex].OpenPrice : Number(fnV_objJSONresult.price);
								Products[fnV_ProductIndex].OpenPriceTimeStamp = Products[fnV_ProductIndex].OpenPrice != 0 ? Products[fnV_ProductIndex].OpenPriceTimeStamp : fnV_objJSONresult.time;
								Products[fnV_ProductIndex].SubsequentHighTimeStamp = Number(Products[fnV_ProductIndex].SubsequentHigh) < Number(fnV_objJSONresult.price) ? fnV_objJSONresult.time : Products[fnV_ProductIndex].SubsequentHighTimeStamp;
								Products[fnV_ProductIndex].SubsequentLowTimeStamp = Number(Products[fnV_ProductIndex].SubsequentLow) > Number(fnV_objJSONresult.price) ? fnV_objJSONresult.time : Products[fnV_ProductIndex].SubsequentLowTimeStamp;
								Products[fnV_ProductIndex].SubsequentHigh = Products[fnV_ProductIndex].SubsequentHigh > Number(fnV_objJSONresult.price) && Products[fnV_ProductIndex].SubsequentHigh != 0 ? Number(Products[fnV_ProductIndex].SubsequentHigh) : Number(fnV_objJSONresult.price);
								Products[fnV_ProductIndex].SubsequentLow = Products[fnV_ProductIndex].SubsequentLow < Number(fnV_objJSONresult.price) && Products[fnV_ProductIndex].SubsequentLow != 0 ? Number(Products[fnV_ProductIndex].SubsequentLow) : Number(fnV_objJSONresult.price);

								if (isObject(Products[fnV_ProductIndex].stats))
									{
										Products[fnV_ProductIndex].stats.high = fnV_objJSONresult.high_24h;
										Products[fnV_ProductIndex].stats.low = fnV_objJSONresult.low_24h;
										Products[fnV_ProductIndex].stats.volume = fnV_objJSONresult.volume_24h;
										Products[fnV_ProductIndex].stats.volume_30day = fnV_objJSONresult.volume_30d;
									}
								if (Array.isArray(Products[fnV_ProductIndex].candles))
									{
										Products[fnV_ProductIndex].candles[0][2] =  Number(fnV_objJSONresult.price) > Number(Products[fnV_ProductIndex].candles[0][2]) ? Number(fnV_objJSONresult.price) : Number(Products[fnV_ProductIndex].candles[0][2]);
										Products[fnV_ProductIndex].candles[0][1] =  Number(fnV_objJSONresult.price) < Number(Products[fnV_ProductIndex].candles[0][1]) ? Number(fnV_objJSONresult.price) : Number(Products[fnV_ProductIndex].candles[0][1]);
									}
								
								Products[fnV_ProductIndex].Volume += Number(fnV_objJSONresult.last_size);
								Products[fnV_ProductIndex].VolumeValue += (Number(fnV_objJSONresult.last_size) * Number(fnV_objJSONresult.price));
								Products[fnV_ProductIndex].TradeShare = ((Number(Products[fnV_ProductIndex].ticker.length) * 100) / Number(fn_TotalTrades())).toFixed(2);
								Products[fnV_ProductIndex].TradeValue = Products[fnV_ProductIndex].TradesValue();
								Products[fnV_ProductIndex].TradeValueShare = ((Products[fnV_ProductIndex].TradeValue * 100) / Number(fn_TotalTradesValue())).toFixed(2);
								Products[fnV_ProductIndex].VolumeValueShare = ((Number(Products[fnV_ProductIndex].VolumeValue) * 100) / Number(fn_TotalVolumeValue())).toFixed(2);
								
								
								fnChartProduct(fnV_ProductId);
								break;

							default:
								var fnV_WebSocketMessageP = document.getElementById("WebSocketMessage");
								//WebSocketMessageP.innerHTML = "Type: " + fnV_MessageType + "<br>" + fnV_event.data;
								//WebSocketMessageP.innerHTML = "Type: " + fnV_MessageType + "<br>" + fnV_strJSONPretty;
								break;
						}
					};
			//------------------------------------------------------------------------------------------
				
			//******************************************************************************************************
			// coinbaseSocket EventListeners --- END
			//******************************************************************************************************

			//------------------------------------------------------------------------------------------
			function subscribe(objSocket, productId, channel)
				{
					// Request
					// Subscribe to ETH-USD and ETH-EUR with the level2, heartbeat and ticker channels,
					// plus receive the ticker entries for ETH-BTC and ETH-USD
					//				{
					//					"type": "subscribe",
					//					"product_ids": [
					//						"ETH-USD",
					//						"ETH-EUR"
					//					],
					//					"channels": [
					//						"level2",
					//						"heartbeat",
					//						{
					//							"name": "ticker",
					//							"product_ids": [
					//								"ETH-BTC",
					//								"ETH-USD"
					//							]
					//						}
					//					]
					//				}
					// Subscribe to status channel
					// 			{
					//  			"type": "subscribe",
					//  			"channels": [{ "name": "status"}]
					// 			}
					 
					if (channel == "ticker")
						{ strJSON = '{ "type": "subscribe", "product_ids": ["' + productId + '"], "channels": ["' + channel + '"] }'; }
					else if (channel == "status")
						{ strJSON = '{ "type": "subscribe", "channels": [{ "name": "' + channel + '"}] }'; }
					objSocket.send(strJSON);
				};
			//------------------------------------------------------------------------------------------
			

			//------------------------------------------------------------------------------------------
			function unsubscribe(objSocket, productId, channel)
				{
					if (channel == "ticker")
						{ strJSON = '{ "type": "unsubscribe", "product_ids": ["' + productId + '"], "channels": ["' + channel + '"] }'; }
					else if (channel == "status")
						{ strJSON = '{ "type": "unsubscribe", "channels": [{ "name": "' + channel + '"}] }'; }
					objSocket.send(strJSON);
				};
			//------------------------------------------------------------------------------------------
			
			
			//******************************************************************************************************
			// coinbaseURI (coinbase API) --- START
			//******************************************************************************************************

			//------------------------------------------------------------------------------------------
            function fnGetCurrentTime()
                { 
					// Get Time
					// HTTP REQUEST GET /time
					// ex. - {"iso":"2021-07-11T19:10:08.675Z","epoch":1626030608.675}
					fnV_RequestURI = coinbaseURI + "time";
					fnV_Response = httpGetSync(fnV_RequestURI);
					fnV_obj = JSON.parse(fnV_Response);
					return fnV_obj;
				}
            //------------------------------------------------------------------------------------------


			//------------------------------------------------------------------------------------------
            function fnSetTimeMarker()
                { 
					// Get Time
					// HTTP REQUEST GET /time
					// ex. - {"iso":"2021-07-11T19:10:08.675Z","epoch":1626030608.675}
					RequestURI = coinbaseURI + "time";
					httpGetAsync(RequestURI, fnSetTimeMarker_Success); 
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnSetTimeMarker_Success(requestURI, result)
                {
					// ex. JSON:
					// ex. - {"iso":"2021-07-11T19:10:08.675Z","epoch":1626030608.675}
					const obj = JSON.parse(result);
					//alert(obj.last)
					var TimeMarkerP = document.getElementById("TimeMarker");
					const d = new Date(obj.iso);
					TimeMarkerP.innerHTML += "<b>Updated: " + d.toDateString() + " " + d.toTimeString() + "</b><br>";
                }			
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetBook(fnV_ProductId, fnV_Level)
                {
					// HTTP REQUEST GET /products/<product-id>/book --- START
					// PARAMETERS:
					// 		level		1/2/3
					fnV_RequestBookURI = coinbaseBookURI.replace("<ProductId>", fnV_ProductId);
					fnV_RequestBookURI = fnV_RequestBookURI.replace("<Level>", fnV_Level);
					fnV_GetBookResponse = httpGetSync(fnV_RequestBookURI); 
					//fnV_GetBookResponseObj = JSON.parse(fnV_GetBookResponse); // Convert to Javascript Object
					// HTTP REQUEST GET /products/<product-id>/book --- END

					return fnV_GetBookResponse;
				}
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetBookAsync(fnV_ProductId, fnV_Level)
                {
					// HTTP REQUEST GET /products/<product-id>/book --- START
					// PARAMETERS:
					// 		level		1/2/3
					fnV_RequestBookURI = coinbaseBookURI.replace("<ProductId>", fnV_ProductId);
					fnV_RequestBookURI = fnV_RequestBookURI.replace("<Level>", fnV_Level);
					fnV_GetBookResponse = httpGetAsync(fnV_RequestBookURI, fnGetBookAsync_Success);
					// HTTP REQUEST GET /products/<product-id>/book --- END
				}
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetBookAsync_Success(requestURI, result)
                {
					// Ge the ProductId from the URI
					fnV_ProductId = requestURI.slice(requestURI.search("/products/") + 10).split("/")[0];

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					Products[fnV_ProductIndex].book = JSON.parse(result);
				}
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetHistory(fnV_ProductId, fnV_StartTime, fnV_EndTime, fnV_Granularity)
                {
					// HTTP REQUEST GET /products/<product-id>/candles --- START
					// PARAMETERS:
					// 		start			Start time in ISO 8601
					// 		end				End time in ISO 8601
					// 		granularity		Desired timeslice in seconds
					fnV_RequestHistoryURI = coinbaseCandlesURI.replace("<ProductId>", fnV_ProductId);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<StartTime>", fnV_StartTime);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<EndTime>", fnV_EndTime);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<Granularity>", fnV_Granularity);
					fnV_RequestHistoryResponse = httpGetSync(fnV_RequestHistoryURI); 
					//fnV_GetHistoryResponseObj = JSON.parse(fnV_RequestHistoryResponse);	// Convert to Javascript Object
					// HTTP REQUEST GET /products/<product-id>/candles --- END
					
					return fnV_RequestHistoryResponse;
				}
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetHistoryAsync(fnV_ProductId, fnV_StartTime, fnV_EndTime, fnV_Granularity)
                {
					// HTTP REQUEST GET /products/<product-id>/candles --- START
					// PARAMETERS:
					// 		start			Start time in ISO 8601
					// 		end				End time in ISO 8601
					// 		granularity		Desired timeslice in seconds
					fnV_RequestHistoryURI = coinbaseCandlesURI.replace("<ProductId>", fnV_ProductId);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<StartTime>", fnV_StartTime);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<EndTime>", fnV_EndTime);
					fnV_RequestHistoryURI = fnV_RequestHistoryURI.replace("<Granularity>", fnV_Granularity);
					fnV_RequestHistoryResponse = httpGetAsync(fnV_RequestHistoryURI, fnGetHistoryAsync_Success); 
					// HTTP REQUEST GET /products/<product-id>/candles --- END
				}
            //------------------------------------------------------------------------------------------
			

            //------------------------------------------------------------------------------------------
            function fnGetHistoryAsync_Success(requestURI, result)
                {
					// Ge the ProductId from the URI
					fnV_ProductId = requestURI.slice(requestURI.search("/products/") + 10).split("/")[0];

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					Products[fnV_ProductIndex].candles = JSON.parse(result);
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnGetStats(fnV_ProductId)
                {
					// Get 24 hr stats for the product.
					// HTTP REQUEST GET /products/<product-id>/stats --- START
					fnV_RequestStatsURI = coinbaseStatsURI.replace("<ProductId>", fnV_ProductId);
					fnV_GetStatsResponse = httpGetSync(fnV_RequestStatsURI); 
					// fnV_GetStatsResponseObj = JSON.parse(fnV_GetStatsResponse);	// Convert to Javascript Object
					// HTTP REQUEST GET /products/<product-id>/stats --- END

					return fnV_GetStatsResponse;
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnGetStatsAsync(fnV_ProductId)
                {
					// Get 24 hr stats for the product.
					// HTTP REQUEST GET /products/<product-id>/stats --- START
					fnV_RequestStatsURI = coinbaseStatsURI.replace("<ProductId>", fnV_ProductId);
					fnV_GetStatsResponse = httpGetAsync(fnV_RequestStatsURI, fnGetStatsAsync_Success); 
					// HTTP REQUEST GET /products/<product-id>/stats --- END

					return fnV_GetStatsResponse;
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnGetStatsAsync_Success(requestURI, result)
                {
					// Ge the ProductId from the URI
					fnV_ProductId = requestURI.slice(requestURI.search("/products/") + 10).split("/")[0];

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					Products[fnV_ProductIndex].stats = JSON.parse(result);
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnGetProduct(fnV_ProductId)
                {
					// Get the product.
					// HTTP REQUEST GET /products/<product-id> --- START
					fnV_RequestProductsURI = coinbaseProductsURI.replace("<ProductId>", fnV_ProductId);
					fnV_GetProductResponse = httpGetSync(fnV_RequestProductsURI); 
					//fnV_GetProductResponseObj = JSON.parse(fnV_GetProductResponse);	// Convert to Javascript Object
					// HTTP REQUEST GET /products/<product-id> --- END

					return fnV_GetProductResponse;
				}
            //------------------------------------------------------------------------------------------

            //------------------------------------------------------------------------------------------
            function fnGetProductAsync(fnV_ProductId)
                {
					// Get the product.
					// HTTP REQUEST GET /products/<product-id> --- START
					fnV_RequestProductsURI = coinbaseProductsURI.replace("<ProductId>", fnV_ProductId);
					fnV_GetProductResponse = httpGetAsync(fnV_RequestProductsURI, fnGetProductAsync_Success); 
					//fnV_GetProductResponseObj = JSON.parse(fnV_GetProductResponse);	// Convert to Javascript Object
					// HTTP REQUEST GET /products/<product-id> --- END

					return fnV_GetProductResponse;
				}
            //------------------------------------------------------------------------------------------

            //------------------------------------------------------------------------------------------
            function fnGetProductAsync_Success(requestURI, result)
                {
					// Ge the ProductId from the URI
					fnV_ProductId = requestURI.slice(requestURI.search("/products/") + 10).split("/")[0];

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					Products[fnV_ProductIndex].product = JSON.parse(result);
				}
            //------------------------------------------------------------------------------------------
			
			
			//******************************************************************************************************
			// coinbaseURI (coinbase API) --- END
			//******************************************************************************************************

			//------------------------------------------------------------------------------------------
			const isObject = (obj) =>
				{
					return Object.prototype.toString.call(obj) === '[object Object]';
				};			
			//------------------------------------------------------------------------------------------

			
			//******************************************************************************************************

			
//******************************************************************************************************
            //------------------------------------------------------------------------------------------
			function sortByProperty(property)
				{
					return function(a,b)
						{  
						  if(a[property] > b[property])  
							 return 1;  
						  else if(a[property] < b[property])  
							 return -1;  
						  return 0;  
						}  
				}
            //------------------------------------------------------------------------------------------
//******************************************************************************************************


				function byteArrayToWordArray(ba) {
					var wa = [],
						i;
					for (i = 0; i < ba.length; i++) {
						wa[(i / 4) | 0] |= ba[i] << (24 - 8 * i);
					}

					return CryptoJS.lib.WordArray.create(wa, ba.length);
				}

				function wordToByteArray(word, length) {
					var ba = [],
						i,
						xFF = 0xFF;
					if (length > 0)
						ba.push(word >>> 24);
					if (length > 1)
						ba.push((word >>> 16) & xFF);
					if (length > 2)
						ba.push((word >>> 8) & xFF);
					if (length > 3)
						ba.push(word & xFF);

					return ba;
				}

				function wordArrayToByteArray(wordArray, length) {
					if (wordArray.hasOwnProperty("sigBytes") && wordArray.hasOwnProperty("words")) {
						length = wordArray.sigBytes;
						wordArray = wordArray.words;
					}

					var result = [],
						bytes,
						i = 0;
					while (length > 0) {
						bytes = wordToByteArray(wordArray[i], Math.min(4, length));
						length -= bytes.length;
						result.push(bytes);
						i++;
					}
					return [].concat.apply([], result);
				}


            //------------------------------------------------------------------------------------------
			function fnAuthenticate(fnV_Url = coinbaseURI + "accounts", callbackSuccess)
				{
					//var crypto = require('crypto');
					var fnV_HostURL = window.location;
					
					var cb_access_timestamp = fnGetCurrentTime().epoch;
					var cb_access_passphrase = document.getElementById("cb-access-passphrase").value;
					var cb_access_key = document.getElementById("cb-access-key").value;
					var cb_access_secret = document.getElementById("cb-access-secret").value;
					var requestPath = "/accounts";
					var body = "";
/*					var body = JSON.stringify({
						price: '1.0',
						size: '1.0',
						side: 'buy',
						product_id: 'BTC-USD'
					});
*/
					var method = 'GET';

					// create the prehash string by concatenating required parts
					var message = cb_access_timestamp + method + requestPath + body;

					// decode the base64 secret
					//cb_access_secret_decoded = window.atob(cb_access_secret);
					//var cb_access_key = Array.from(window.atob(cb_access_secret));
					//var key = Buffer(secret, 'base64');
					
					//* Converts a Base64 string to a word array.
					//var cb_access_key = CryptoJS.enc.Base64.parse(cb_access_secret);
					//test_access_key = cb_access_key.toString()
					//test1_access_key = wordArrayToByteArray(cb_access_key,0);
					//const bytesString = String.fromCharCode(cb_access_key);
					

					// create a sha256 hmac with the secret
					//var hmac = CryptoJS.SHA256(cb_access_key);
					//var hmac = crypto.createHmac('sha256', key);
					var hmac = CryptoJS.HmacSHA256(message, cb_access_secret);

					
					// sign the require message with the hmac
					// and finally base64 encode the result
					//var cb_access_sign = CryptoJS.HmacSHA256(message, hmac); //.toString(CryptoJS.enc.Base64);
					var cb_access_sign = hmac.toString(CryptoJS.enc.Hex);

					//var cb_access_sign = hmac.update(message).digest('base64');
					
/*					const options = {
					  method: 'GET',
					  headers: {
						Accept: 'application/json',
						'cb-access-key': cb_access_key.toString(),
						'cb-access-passphrase': cb_access_passphrase,
						'cb-access-sign': cb_access_sign,
						'cb-access-timestamp': cb_access_timestamp
					  }
					};

					fetch('https://api.exchange.coinbase.com/accounts', options)
					  .then(response => response.json())
					  .then(response => console.log(response))
					  .catch(err => console.error(err));
*/

					
                    var xmlHttp = new XMLHttpRequest();
                    xmlHttp.onreadystatechange = function ()
                        { 
                            if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                                callbackSuccess(fnV_Url, xmlHttp.responseText);
                        }
                    xmlHttp.open(method, fnV_Url, true);
					xmlHttp.withCredentials = "true";
					//xmlHttp.withCredentials = "false";
					xmlHttp.setRequestHeader('accept', 'application/json');
					xmlHttp.setRequestHeader("cb-access-key", cb_access_key);
					xmlHttp.setRequestHeader("cb-access-passphrase", cb_access_passphrase);
					xmlHttp.setRequestHeader("cb-access-sign", cb_access_sign);
					xmlHttp.setRequestHeader("cb-access-timestamp", cb_access_timestamp);
                    xmlHttp.send(null);
                    //if (xmlHttp.status === 200)
                    //    { response = xmlHttp.responseText };
                    //return response;

				}
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
			function fnAuthenticate_Success(fnV_Url, result)
				{
					alert(result);
				}
            //------------------------------------------------------------------------------------------
			
			
			
//******************************************************************************************************
            //------------------------------------------------------------------------------------------
            function httpGetAsync(theUrl, callbackSuccess)
                {
                    var xmlHttp = new XMLHttpRequest();
                    xmlHttp.onreadystatechange = function ()
                        { 
                            if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
                                callbackSuccess(theUrl, xmlHttp.responseText);
                        }
                    xmlHttp.open("GET", theUrl, true); // true for asynchronous 
                    xmlHttp.send(null);
                }
            //------------------------------------------------------------------------------------------

            //------------------------------------------------------------------------------------------
            function httpGetSync(theUrl)
                {
                    var response = "";
                    var request = new XMLHttpRequest();
                    request.open('GET', theUrl, false);
                    request.send(null);
                    if (request.status === 200)
                        { response = request.responseText };
                    return response;
                }
            //------------------------------------------------------------------------------------------
//******************************************************************************************************


//******************************************************************************************************

			//------------------------------------------------------------------------------------------
            function fnGetProductObject(fnV_ProductId)
                {
					var urlParams = new URLSearchParams(window.location.search);
					// Get Product History
					var DateCalculate = new Date();
					HistoryEndTime = DateCalculate.toISOString();
					DateCalculate.setDate(DateCalculate.getDate() - 300);
					HistoryStartTime = DateCalculate.toISOString();
					//fnV_GetHistoryResponse = fnGetHistory(fnV_ProductId, HistoryStartTime, HistoryEndTime, "86400"); 
					//fnV_GetHistoryResponseObj = JSON.parse(fnV_GetHistoryResponse);
					
					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					
					if (fnV_ProductIndex == -1)
					{
						fnV_Product = Object.create(dataObj);
						fnV_Product.ProductId = fnV_ProductId;
						fnV_Product.PurchasePrice = Number(urlParams.get(fnV_ProductId)) != 0 ? Number(urlParams.get(fnV_ProductId)) : 0;
						fnV_Product.History = new Array(new Object());
							// History
							// fnV_History = 
							//	{
							//		high: Number(0),
							//		low: Number(0),
							//		time: fnV_Product.CurrentPriceTimeStamp
							//	}
						fnV_Product.log = new Array(new Object()); //[ {} ];
						fnV_Product.message = new Array(new Object()); //[ {} ];
						fnV_Product.ticker = new Array(new Object()); //[ {} ];
						fnV_Product.transactions = new Array(new Object()); //[ {} ];
							// Transaction
//							fnV_Transaction = 
//								{
//									feerate : Number(0),
//									price : Number(0),
//									quantity : Number(0),
//									time : fnV_Product.CurrentPriceTimeStamp,
//									tradeid : Number(0),
//									type : "buy/sell",
//									value : Number(0)
//								};						
						Products.push(fnV_Product);
					}

					fnGetBookAsync(fnV_ProductId, "2");
					fnGetHistoryAsync(fnV_ProductId, HistoryStartTime, HistoryEndTime, "86400");
					fnGetProductAsync(fnV_ProductId);
					fnGetStatsAsync(fnV_ProductId);

					/*
					// Delay "Execution" 1/2 second
					var d = new Date();
					var TimeNow = d.getTime();
					var TimeDelay = d.getTime();
					do 
						{
							var d = new Date();
							var TimeDelay = d.getTime();
						}
					while (Number(TimeDelay) < (Number(TimeNow) + 500));
					*/
					
					//WebSocketMessageP.innerHTML = JSON.stringify(fnV_ProductResponse, null, "<br>");
					//alert(fnV_ProductResponse.product.id);
					//subscribe(coinbaseSocket, fnV_ProductId, "ticker");
                }
            //------------------------------------------------------------------------------------------


            //------------------------------------------------------------------------------------------
            function fnGetAllTradeableCrypto()
                {
					// Set the Time Marker
					fnSetTimeMarker();

					// HTTP REQUEST GET /products
					RequestURI = coinbaseURI + "products/";
					httpGetAsync(RequestURI, fnGetAllTradeableCrypto_Success); 
                }

            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
            function fnGetAllTradeableCrypto_Success(requestURI, result)
                {
					// {"id":"SOL-USD","base_currency":"SOL","quote_currency":"USD","base_min_size":"0.01","base_max_size":"6000","quote_increment":"0.001","base_increment":"0.001","display_name":"SOL/USD","min_market_funds":"5.0","max_market_funds":"100000","margin_enabled":false,"fx_stablecoin":false,"post_only":false,"limit_only":false,"cancel_only":false,"trading_disabled":false,"status":"online","status_message":""}
					obj = JSON.parse(result);
					obj = obj.sort(sortByProperty("id"));
					CryptoAll = obj.length;
					CryptoTradeable = 0;
					fnV_Delay = 500;
					for (var i = 0; i < obj.length; i++)
						{
							if ((obj[i].trading_disabled == false) && obj[i].id.endsWith("-USD") && (obj[i].fx_stablecoin == false))
								{
									//alert(obj[i].id);
									CryptoTradeable++;
									//fnGetProductObject(obj[i].id);
									setTimeout(fnGetProductObject, (fnV_Delay * (i+1)), obj[i].id);
									fnChartProduct(obj[i].id);
								}
						}
					for (var i = 0; i < obj.length; i++)
						{
							if ((obj[i].trading_disabled == false) && obj[i].id.endsWith("-USD") && (obj[i].fx_stablecoin == false))
								{
									subscribe(coinbaseSocket, obj[i].id, "ticker");
								}
						}
                }

            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
            function fnGetData1()
                {
					// Set the Time Marker
					fnSetTimeMarker();

					fnV_Delay = 500;
					fnV_Counter = 0;

					// Get data for all the Products in the Products array
					Products.forEach(function(obj) 	{
														fnV_ProductId = obj.ProductId;
														setTimeout(fnGetProductObject, (fnV_Delay * fnV_Counter), fnV_ProductId);
														fnV_Counter++;
														fnChartProduct(fnV_ProductId);
													})
					// Subscribe to the Websocket
					Products.forEach(function(obj) 	{
														fnV_ProductId = obj.ProductId;
														subscribe(coinbaseSocket, fnV_ProductId, "ticker");
													})
                }
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
            function fnGetData()
                {
					var urlParams = new URLSearchParams(window.location.search);
					urlParams.sort();

					// Set the Time Marker
					fnSetTimeMarker();
					
					fnV_Delay = 500;
					fnV_Counter = 0;
					
					// Get data
					urlParams.forEach
						(
							function(value, key) 
								{
									fnV_ProductId = key;
									//fnGetProductObject(fnV_ProductId);
									setTimeout(fnGetProductObject, (fnV_Delay * fnV_Counter), fnV_ProductId);
									fnV_Counter++;
									fnChartProduct(fnV_ProductId);
								}
						);
					urlParams.forEach
						(
							function(value, key) 
								{
									subscribe(coinbaseSocket, key, "ticker");
								}
						);
					//WebSocketMessageP.innerHTML = JSON.stringify(Products, null, "<br>");
                }
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
            function fnChartProduct(fnV_ProductId)
                {
					//subscribe(coinbaseSocket, ProductId, "status");
					//subscribe(coinbaseSocket, fnV_ProductId, "ticker");
					// Variables
					var urlParams = new URLSearchParams(window.location.search);
					var fnV_row;
					
					// Find a <table> element with id="ChartTable":
					var fnV_ChartTable = document.querySelector("table[id=ChartTable]");
					//alert(fnV_ProductId);
					//Using document.body.contains.
					if(fnV_ChartTable.contains(document.getElementById(fnV_ProductId)))
						{
							var fnV_row = document.getElementById(fnV_ProductId);
						} 
					else 
					//fnV_row = fnV_ChartTable.querySelector("thead > tr[id=" + fnV_ProductId + "]");
					//if (fnV_row == null)
						{
							fnV_Insert = 1;
							try
								{
									for (fnV_trS = 1; fnV_trS < fnV_ChartTable.rows.length; fnV_trS++)
										{
											fnV_RId = fnV_ChartTable.rows[fnV_trS].id;
											if (fnV_RId > fnV_ProductId)
												{
													fnV_Insert = fnV_trS;
													break;
												}
											if (fnV_trS == fnV_ChartTable.rows.length - 1)
												{
													fnV_Insert = -1;
												}
										}
								}
							catch
								{ /* Do nothing */ }
								
							// Create an empty <tr> element and append it to the table:
							var fnV_row = fnV_ChartTable.insertRow(fnV_Insert);
							fnV_row.setAttribute("id", fnV_ProductId);
							// Copy the cells from the top row 
							fnV_row.innerHTML = fnV_ChartTable.rows[0].innerHTML;
						}
					
					// Clear the rows class attribute
					fnV_row.removeAttribute("class");
						
					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					if (fnV_ProductIndex == -1 || !isObject(Products[fnV_ProductIndex].stats) || !Array.isArray(Products[fnV_ProductIndex].candles) || !isObject(Products[fnV_ProductIndex].product) || !isObject(Products[fnV_ProductIndex].book))
						{ return 0; }
					
					
					// Variables for object functions, Triggers & Actions -- START
					fnV_Product = Products[fnV_ProductIndex];
					fnV_PricePresure = fnV_Product.PricePressure();
					fnV_SidePresure = fnV_Product.SidePressure();
					fnV_Average = fnV_Product.Average();
					fnV_High = fnV_Product.High();
					fnV_Low = fnV_Product.Low();
					fnV_SnapshotData = 
						{
							Average : fnV_Average, // An Array of days (derived from Product.candles)
							CurrentPrice : fnV_Product.CurrentPrice,
							CurrentPriceTimeStamp : fnV_Product.CurrentPriceTimeStamp,
							High : fnV_High,
							Low : fnV_Low,
							OpenPrice : fnV_Product.OpenPrice,
							OpenTimeStamp : fnV_Product.OpenTimeStamp,
							PricePressure : fnV_PricePressure,
							ProductId : fnV_Product.ProductId,
							PurchasePrice : fnV_Product.PurchasePrice,
							Shares : fnV_Product.Shares,
							SidePressure : fnV_SidePressure,
							SubsequentHigh : fnV_Product.SubsequentHigh,
							SubsequentHighTimeStamp : fnV_Product.SubsequentHighTimeStamp,
							SubsequentLow : fnV_Product.SubsequentLow,
							SubsequentLowTimeStamp : fnV_Product.SubsequentLowTimeStamp,
							Ticker : fnV_Product.ticker.length != 0 ? JSON.parse(JSON.stringify(fnV_Product.ticker[0])) : {},
							Trades : fnV_Product.ticker.length,
							TradeShare : fnV_Product.TradeShare,
							TradeValue : fnV_Product.TradeValue,
							TradeValueShare : fnV_Product.TradeValueShare,
							Transactions : fnV_Product.transactions.length != 0 ? JSON.parse(JSON.stringify(fnV_Product.transactions)) : {},
							Volume : fnV_Product.Volume,
							VolumeShare : fnV_Product.VolumeShare,
							VolumeValue : fnV_Product.VolumeValue,
							VolumeValueShare : fnV_Product.VolumeValueShare
						}
					//Variables for object functions, Triggers & Actions -- END

					
					// Display data on the chart --- START
					// Loop through the cells in the row
					for (fnV_index = 0; fnV_index < fnV_row.cells.length; fnV_index++)
						{
							fnV_cell = fnV_row.cells[fnV_index];

							// Loop through all the child elements of the cell 
							for (fnV2_index = 0; fnV2_index < fnV_cell.children.length; fnV2_index++)
								{
									// Set the title attribute of the element to match the id
									fnV_cell.children[fnV2_index].title = fnV_cell.children[fnV2_index].id;
									//fnV_PropertyNames = Object.getOwnPropertyNames(Products[fnV_ProductIndex]); //****List of 'properties' in Javascript Object (ex. CurrentPrice,OpenPrice,book,stats) (NOT REALLY)
									//WebSocketMessageP.innerHTML = fnV_PropertyNames;

									//TEMPORARY SOLUTION
									fnV_BaseValueforDifference = Number(fnV_Product.PurchasePrice) != 0 ? Number(fnV_Product.PurchasePrice) : Number(fnV_Product.CurrentPrice);
									
									// Remove classGain & classLoss from element.
									fnV_cell.children[fnV2_index].classList.remove("classGain", "classLoss");
									
									//alert();
									
									// do something based on the element .id
									switch (fnV_cell.children[fnV2_index].id)
										{
											case "Average":
												if (fnV_cell.id == "24hr")
													{
														fnV_tempAverage = ((Number(fnV_Product.stats.high) + Number(fnV_Product.stats.low)) / 2).toFixed(fn_DecimalCount(fnV_Product.product.quote_increment));
														fnV_cell.children[fnV2_index].innerHTML = fnV_tempAverage + "&nbsp;(" + fnV_Product.Difference(fnV_tempAverage, fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(((Number(fnV_Product.stats.high) + Number(fnV_Product.stats.low)) / 2) >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												else if (fnV_cell.id.includes("day"))
													{
														fnV_days = Number(fnV_cell.id.replace("day",""));
														fnV_days = fnV_days > fnV_Average.length ? fnV_Average.length : fnV_days;
														fnV_tempAverage = Number(fnV_Average[fnV_days-1]).toFixed(fn_DecimalCount(fnV_Product.product.quote_increment));
														fnV_cell.children[fnV2_index].innerHTML = fnV_tempAverage + "&nbsp;(" + fnV_Product.Difference(fnV_tempAverage, fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(fnV_Average[fnV_days-1] >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												else if (fnV_cell.id == "CurrentPrice")
													{
														fnV_tempAverage = ((Number(fnV_Product.SubsequentHigh) + Number(fnV_Product.SubsequentLow)) / 2).toFixed(fn_DecimalCount(fnV_Product.product.quote_increment));
														fnV_cell.children[fnV2_index].innerHTML = fnV_tempAverage + "&nbsp;(" + fnV_Product.Difference(fnV_tempAverage, fnV_BaseValueforDifference).toFixed(2) + "%)";;
														fnV_cell.children[fnV2_index].classList.add(((Number(fnV_Product.SubsequentHigh) + Number(fnV_Product.SubsequentLow)) / 2) >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												break;
											case "CurrentPrice":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product['CurrentPrice'].toFixed(fn_DecimalCount(fnV_Product.product.quote_increment)) + "&nbsp;(" + fnV_Product.Difference(fnV_Product.CurrentPrice, fnV_BaseValueforDifference).toFixed(2) + "%)";
												fnV_cell.children[fnV2_index].classList.add(fnV_Product.CurrentPrice >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
												break;
											case "DownloadLogs":
												fnV_cell.children[fnV2_index].innerHTML = "<a href='javascript:void(0);' onclick='DownloadLogs(\"" + fnV_ProductId + "\")'>Logs</a>: " + fnV_Product.log.length;
												break;
											case "DownloadMessages":
												fnV_cell.children[fnV2_index].innerHTML = "<a href='javascript:void(0);' onclick='DownloadMessages(\"" + fnV_ProductId + "\")'>Messages</a>: " + fnV_Product.message.length;
												break;
											case "High":
												if (fnV_cell.id == "24hr")
													{
														fnV_cell.children[fnV2_index].innerHTML = fnV_Product.stats.high + "&nbsp;(" + fnV_Product.Difference(fnV_Product.stats.high, fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(fnV_Product.stats.high >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												else if (fnV_cell.id.includes("day"))
													{
														fnV_days = Number(fnV_cell.id.replace("day",""));
														fnV_days = fnV_days > fnV_High.length ? fnV_High.length : fnV_days;
														fnV_cell.children[fnV2_index].innerHTML = fnV_High[fnV_days-1] + "&nbsp;(" + fnV_Product.Difference(fnV_High[fnV_days-1], fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(fnV_High[fnV_days-1] >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												break;
											case "Low":
												if (fnV_cell.id == "24hr")
													{
														fnV_cell.children[fnV2_index].innerHTML = fnV_Product.stats.low + "&nbsp;(" + fnV_Product.Difference(fnV_Product.stats.low, fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(fnV_Product.stats.low >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												else if (fnV_cell.id.includes("day"))
													{
														fnV_days = Number(fnV_cell.id.replace("day",""));
														fnV_days = fnV_days > fnV_Low.length ? fnV_Low.length : fnV_days;
														fnV_cell.children[fnV2_index].innerHTML = fnV_Low[fnV_days-1] + "&nbsp;(" + fnV_Product.Difference(fnV_Low[fnV_days-1], fnV_BaseValueforDifference).toFixed(2) + "%)";
														fnV_cell.children[fnV2_index].classList.add(fnV_Low[fnV_days-1] >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
													}
												break;
											case "OpenPrice":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.OpenPrice + "&nbsp;(" + fnV_Product.Difference(fnV_Product.OpenPrice, fnV_BaseValueforDifference).toFixed(2) + "%)";
												fnV_cell.children[fnV2_index].classList.add(fnV_Product.OpenPrice >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
												break;
											case "PricePressure":
												//fnV_cell.children[fnV2_index].style.backgroundImage = "linear-gradient(green " + Number(fnV_Product.PricePressure('up')).toFixed(0) + "%,red 0%)";
												fnV_UnchangedEnd = fnV_PricePresure.down + fnV_PricePresure.unchanged;
												fnV_cell.children[fnV2_index].style.backgroundImage = "linear-gradient(red " + fnV_PricePresure.down.toFixed(0) + "%, tan " + fnV_PricePresure.down.toFixed(0) + "% " + fnV_UnchangedEnd.toFixed(0) + "%, green " + (100 - fnV_PricePresure.up).toFixed(0) + "%)"; //"linear-gradient(red " + (100 - Number(fnV_Product.PricePressure('up')).toFixed(0)) + "%,green 0%)";
												//fnV_cell.children[fnV2_index].style.backgroundImage = "linear-gradient(red " + (100 - Number(fnV_Product.PricePressure('up')).toFixed(0)) + "%,green 0%)";
												break;
											case "ProductId":
												//fnV_cell.children[fnV2_index].innerHTML = "<a id='ProductId' href='" + coinbaseTradeURI + fnV_ProductId + "' target='_blank'>" + fnV_ProductId + "</a>";
												fnV_cell.children[fnV2_index].innerHTML = "<a id='ProductId' href='" + coinbaseTradeURI + fnV_Product.product.id + "' target='_blank'>" + fnV_Product.product.id + "</a>";
												break;
											case "PurchasePrice":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.PurchasePrice + "&nbsp;(" + fnV_Product.Difference(fnV_Product.PurchasePrice, fnV_BaseValueforDifference).toFixed(2) + "%)";
												//fnV_cell.children[fnV2_index].classList.add(fnV_Product.PurchasePrice >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
												break;
											case "Shares":
												fnV_cell.children[fnV2_index].innerHTML = (Number(fnV_Product.Shares)).toFixed(fn_DecimalCount(fnV_Product.product.base_increment));
												break;
											case "SidePressure":
												fnV_cell.children[fnV2_index].style.backgroundImage = "linear-gradient(green " + Number(fnV_SidePresure.buy).toFixed(0) + "%,red 0%)";
												break;
											case "SubsequentHigh":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.SubsequentHigh + "&nbsp;(" + fnV_Product.Difference(fnV_Product.SubsequentHigh, fnV_BaseValueforDifference).toFixed(2) + "%)";
												fnV_cell.children[fnV2_index].classList.add(fnV_Product.SubsequentHigh >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
												break;
											case "SubsequentLow":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.SubsequentLow + "&nbsp;(" + fnV_Product.Difference(fnV_Product.SubsequentLow, fnV_BaseValueforDifference).toFixed(2) + "%)";
												fnV_cell.children[fnV2_index].classList.add(fnV_Product.SubsequentLow >= fnV_BaseValueforDifference ? "classGain" : "classLoss");
												break;
											case "TotalTrades": // Since Page Load
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.TradeCount;
												break;
											case "Trades": // (X*100)/Y
												fnV_cell.children[fnV2_index].innerHTML = Number(fnV_Product.ticker.length) + "&nbsp;(" + Number(fnV_Product.TradeShare).toFixed(2) + "%)";
												break;
											case "TradesValue":
												fnV_cell.children[fnV2_index].innerHTML = fnV_Product.TradeValue.toFixed(2) + "&nbsp;(" + Number(fnV_Product.TradeValueShare).toFixed(2) + "%)";
												break;
											case "Volume":
												if (fnV_cell.id == "CurrentPrice")
													{
														fnV_cell.children[fnV2_index].innerHTML = (Number(fnV_Product.Volume)).toFixed(fn_DecimalCount(fnV_Product.product.base_increment));
													}
												else if (fnV_cell.id == "24hr")
													{
														fnV_cell.children[fnV2_index].innerHTML = (Number(fnV_Product.stats.volume)).toFixed(fn_DecimalCount(fnV_Product.product.base_increment));
													}
												else if (fnV_cell.id == "30day")
													{
														fnV_cell.children[fnV2_index].innerHTML = (Number(fnV_Product.stats.volume_30day)).toFixed(fn_DecimalCount(fnV_Product.product.base_increment));
													}
												break;
											case "VolumeValue":
												if (fnV_cell.id == "CurrentPrice")
													{
														fnV_cell.children[fnV2_index].innerHTML = Number(fnV_Product.VolumeValue).toFixed(2) + "&nbsp;(" + Number(fnV_Product.VolumeValueShare).toFixed(2) + "%)";
													}
												break;
										}
								}
						}
					// Display data on the chart --- END
					
					//  Global Alerts/Triggers - Start
					//Triggered = 0;
					fnV_MessagesCell = fnV_row.querySelector("td[id=Messages]");
					fnV_TriggersCell = fnV_ChartTable.rows[0].querySelector("td[id=Triggers]");
					fnV_MessagesPrevious = [];
					fnV_MessagesPreviousP = fnV_MessagesCell.getElementsByTagName('p');
					for (let fnVt_msg of fnV_MessagesPreviousP) { fnV_MessagesPrevious.unshift({text : fnVt_msg.innerText})}
					fnV_Messages = [];
					fnV_MessagesCell.innerHTML = "";
					
					
					fnV_ProductTriggerTable = fnV_TriggersCell.querySelector("table[id=triggers]");
					fnV_objAddTriggerButton = fnV_TriggersCell.querySelector("button[id=AddTrigger]");
					

					if (fnV_ProductTriggerTable.rows.length != 0)
						{
							// for each Trigger
							for (fnV_ProductTriggerTableRowIndex = 0; fnV_ProductTriggerTableRowIndex < fnV_ProductTriggerTable.rows.length; fnV_ProductTriggerTableRowIndex++) 
								{
									fnV_ProductTriggerTableRow = fnV_ProductTriggerTable.rows[fnV_ProductTriggerTableRowIndex];
									fnV_ProductTriggerInputElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('input');
									fnV_ProductTriggerSelectElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('select');
									fnV_ProductTriggerParagraphElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('p');
									fnV_ProductTriggerAlarmCheckbox = fnV_ProductTriggerInputElements[1];
									fnV_ProductTriggerEnableCheckbox = fnV_ProductTriggerInputElements[2];
									fnV_triggerEquation = fnV_ProductTriggerInputElements[0].value;
									fnV_triggerActions = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('textarea');

									// if trigger is enabled
									if (fnV_triggerEquation != "" && fnV_ProductTriggerEnableCheckbox.checked == true)
										{
											fnV_evalExpression = new String(fnV_triggerEquation);
											if (eval(fnV_evalExpression.toString())) 
												{ 
													if (fnV_ProductTriggerAlarmCheckbox.checked == true && audioSiren.paused)
														{ audioSiren.play(); }
													/**/
													// Leave a Message
													fnV_Message = 
														{
															text: fnV_evalExpression,
															time : fnV_Product.CurrentPriceTimeStamp,
															type: "trigger",
															lock: false
														};
													fnV_MessageJSON = JSON.stringify(fnV_Message);
													fnV_MessageJSONresult = JSON.parse(fnV_MessageJSON);
													fnV_MessageJSONresult1 = JSON.parse(fnV_MessageJSON);
													//fnV_unshift = fnV_Messages.unshift(fnV_MessageJSONresult);
													fnV_MsgIndex = fnV_MessagesPrevious.findIndex(msg => msg.text == fnV_Message.text);
													if (fnV_MsgIndex == -1)
														{
															fnV_unshift = fnV_Product.message.unshift(fnV_MessageJSONresult1); // ****************(To DO)************* ONLY if the message did not exist
														}
													/**/
													
													// eval Actions - Start
													if (fnV_triggerActions.length != 0)
														{
															for (fnV_triggerAction = 0; fnV_triggerAction < fnV_triggerActions.length; fnV_triggerActions++)
																{
																	fnV_evalAction = new String(fnV_triggerActions[fnV_triggerAction].value);
																	eval(fnV_evalAction.toString());
																}
														}
													// eval Actions - End
												}
										}
								}
						}
					//  Global Alerts/Triggers - End

					//  Product Alerts/Triggers - Start
					//Triggered = 0;
					fnV_MessagesCell = fnV_row.querySelector("td[id=Messages]");
					//fnV_MessagesCell.innerHTML = "";
					fnV_TriggersCell = fnV_row.querySelector("td[id=Triggers]");
					
					
					fnV_ProductTriggerTable = fnV_TriggersCell.querySelector("table[id=triggers]");
					fnV_objAddTriggerButton = fnV_TriggersCell.querySelector("button[id=AddTrigger]");
					

					if (fnV_ProductTriggerTable.rows.length != 0)
						{
							for (fnV_ProductTriggerTableRowIndex = 0; fnV_ProductTriggerTableRowIndex < fnV_ProductTriggerTable.rows.length; fnV_ProductTriggerTableRowIndex++) 
								{
									fnV_ProductTriggerTableRow = fnV_ProductTriggerTable.rows[fnV_ProductTriggerTableRowIndex];
									fnV_ProductTriggerInputElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('input');
									fnV_ProductTriggerSelectElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('select');
									fnV_ProductTriggerParagraphElements = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('p');
									fnV_ProductTriggerAlarmCheckbox = fnV_ProductTriggerInputElements[1];
									fnV_ProductTriggerEnableCheckbox = fnV_ProductTriggerInputElements[2];
									fnV_triggerEquation = fnV_ProductTriggerInputElements[0].value;
									fnV_triggerActions = fnV_ProductTriggerTableRow.cells[0].getElementsByTagName('textarea');

									if (fnV_triggerEquation != "" && fnV_ProductTriggerEnableCheckbox.checked == true)
										{
											fnV_evalExpression = new String(fnV_triggerEquation);
											if (eval(fnV_evalExpression.toString())) 
												{ 
													if (fnV_ProductTriggerAlarmCheckbox.checked == true && audioSiren.paused)
														{ audioSiren.play(); }
													/**/
													// Leave a Message
													fnV_Message = 
														{
															text: fnV_evalExpression,
															time : fnV_Product.CurrentPriceTimeStamp,
															type: "trigger",
															lock: false
														};
													fnV_MessageJSON = JSON.stringify(fnV_Message);
													fnV_MessageJSONresult = JSON.parse(fnV_MessageJSON);
													fnV_MessageJSONresult1 = JSON.parse(fnV_MessageJSON);
													//fnV_unshift = fnV_Messages.unshift(fnV_MessageJSONresult);
													fnV_MsgIndex = fnV_MessagesPrevious.findIndex(msg => msg.text == fnV_Message.text);
													if (fnV_MsgIndex == -1)
														{
															fnV_unshift = fnV_Product.message.unshift(fnV_MessageJSONresult1); // ****************(To DO)************* ONLY if the message did not exist
														}
													/**/
													
													// eval Actions - Start
													if (fnV_triggerActions.length != 0)
														{
															for (fnV_triggerAction = 0; fnV_triggerAction < fnV_triggerActions.length; fnV_triggerActions++)
																{
																	fnV_evalAction = new String(fnV_triggerActions[fnV_triggerAction].value);
																	eval(fnV_evalAction.toString());
																}
														}
													// eval Actions - End
												}
										}
								}							
						}
					//  Product Alerts/Triggers - End
					
					//  Display Messages - Start
					fnV_Messages.forEach(function(obj) { fnV_MessagesCell.innerHTML += "<p>" + obj.text + "</p>"; })
					//  Display Messages - End
					

					// Clean expired message objects - START
						//fnV_MessageIndex = Products.message.findIndex(msg => msg.product.id === obj[i].id);
						/*if (fnV_diffTime >= (Number(Products[fnV_ProductIndex].MessageDuration) * 1000)) 
							{ Products[fnV_ProductIndex].message.splice(fnV_index - 1); }*/
						if (fnV_Product.message.length > Number(fnV_Product.MessageMax))
							{
								fnV_Product.message.splice(Number(fnV_Product.MessageMax) - 1);
							}
					// Clean expired message objects - START
                }
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function fn_TotalTrades()	
				{
					fnV_Trades = Number(0);
					Products.forEach(function(obj) 	{ 
														fnV_Trades += Number(obj.ticker.length);
													}
									)
					//fnV_Trades = Number.isNaN(fnV_Trades) ? Number(0) : fnV_Trades;
					return fnV_Trades;
				}
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function fn_TotalTradesValue()	
				{
					fnV_TradesValue = Number(0);
					Products.forEach(function(obj) 	{ 
														fnV_TradesValue += Number(obj.TradeValue);
													}
									)
					//fnV_TradesValue = Number.isNaN(fnV_TradesValue) ? Number(0) : fnV_TradesValue;
					return fnV_TradesValue;
				}
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function fn_TotalVolumeValue()	
				{
					fnV_VolumeValue = Number(0);
					Products.forEach(function(obj) 	{ 
														fnV_VolumeValue += Number(obj.VolumeValue);
													}
									)
					//fnV_VolumeValue = Number.isNaN(fnV_VolumeValue) ? Number(0) : fnV_VolumeValue;
					return fnV_VolumeValue;
				}
            //------------------------------------------------------------------------------------------

			
			//------------------------------------------------------------------------------------------
			function fn_DecimalCount(value) 
				{
					if (Math.floor(Number(value)) !== Number(value))
						return value.toString().split(".")[1].length || 0;
					return 0;
				}
			//------------------------------------------------------------------------------------------

            //------------------------------------------------------------------------------------------
			function addTriggerToProduct(fnV_ProductId, bAlarm = false, bEnableTrigger = false, strLock = false, strEquation= "")
				{
					// Find a <table> element with id="ChartTable":
					var fnV_ChartTable = document.querySelector("table[id=ChartTable]");

					// Get the Product Row
					fnV_ProductRow = fnV_ChartTable.querySelector("tr[id=" + fnV_ProductId + "]");

					// Get the Triggers Cell
					fnV_TriggerCell = fnV_ProductRow.querySelector("td[id=Triggers]");

					// Get the Triggers Table
					fnV_triggersTable = fnV_TriggerCell.querySelector("table[id=triggers]");

					// Create a new row
					fnV_triggersTableNewRow = fnV_triggersTable.insertRow(fnV_triggersTable.rows.length);

					// Create a cell in the new row
					fnV_triggersTableNewRowNewCell = fnV_triggersTableNewRow.insertCell(0);

					strAlarm = bAlarm == true ? ' checked' : '';
					strEnableTrigger = bEnableTrigger == true ? ' checked' : '';
				
					strcellTriggers = "<input id='equation' size=60 type=text value='" + strEquation + "' list=triggerVariables ><br>"; 
						
					//strcellTriggers += "<p>";
					strcellTriggers += "<button type='button' onclick='javascript:addAction(this);'>Add Action</button>&nbsp;&nbsp;";
					strcellTriggers += "<input type='checkbox'" + strAlarm + "><span>Alarm</span>&nbsp;&nbsp;";
					strcellTriggers += "<input type='checkbox'" + strEnableTrigger + "><span>Enable&nbsp;Trigger</span><br>";
					//strcellTriggers += "</p>";
							
					fnV_triggersTableNewRowNewCell.innerHTML = strcellTriggers;
					
				}
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function addTrigger(objButton, bAlarm = false, bEnableTrigger = false, strEquation = "")
				{
					var urlParams = new URLSearchParams(window.location.search);
					triggerCell = objButton.parentElement;
					triggerRow = triggerCell.parentElement;
					triggerTables = triggerCell.getElementsByTagName("table");
					triggerTable = triggerTables[0];
					triggerTableRows = triggerTable.rows.length;
					ProductId = triggerRow.id;

					// Create a new row
					triggersTableNewRow = triggerTable.insertRow(triggerTableRows);

					// Create a cell in the new row
					triggersTableNewRowNewCell = triggersTableNewRow.insertCell(0);

					strAlarm = bAlarm == true ? ' checked' : '';
					strEnableTrigger = bEnableTrigger == true ? ' checked' : '';
				
					strcellTriggers = "<input size=60 type=text value='" + strEquation + "' list=triggerVariables >&nbsp;<button id='DeleteTrigger' type='button' onclick='javascript:deleteTrigger(this);'>Delete Trigger</button><br>"; 
						
					//strcellTriggers += "<p>";
					strcellTriggers += "<button type='button' onclick='javascript:addAction(this);'>Add Action</button>&nbsp;&nbsp;";
					strcellTriggers += "<input type='checkbox'" + strAlarm + "><span>Alarm</span>&nbsp;&nbsp;";
					strcellTriggers += "<input type='checkbox'" + strEnableTrigger + "><span>Enable&nbsp;Trigger</span><br>";
					//strcellTriggers += "</p>";
							
					triggersTableNewRowNewCell.innerHTML = strcellTriggers;

					// Triggers Define - END
				}

            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function deleteTrigger(objButton)
				{
					var urlParams = new URLSearchParams(window.location.search);
					triggerCell = objButton.parentElement;
					triggerRow = triggerCell.parentElement;
					triggerTable = triggerRow.parentElement.parentElement;
					triggerTable.deleteRow(triggerRow.rowIndex);
				}
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function addAction(objButton)
				{
					var urlParams = new URLSearchParams(window.location.search);
					ProductRow = objButton.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement;
					ProductId = ProductRow.id;
					ActionsContainer = objButton.parentElement;
					
					// Create a new Actions Div
					strAction = "<textarea style='width: 100%'></textarea>";
					var newDiv = document.createElement("div");
					newDiv.innerHTML = strAction;
					ActionsContainer.appendChild(newDiv); 
				}

            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function fnButtonRemoveProduct(fnT_objButton)
				{
					fnT_ChartTable = document.querySelector("table[id=ChartTable]");
					fnT_buttonP = fnT_objButton.parentElement;
					fnT_buttonCell = fnT_buttonP.parentElement;
					fnT_buttonRow = fnT_buttonCell.parentElement;
					fnT_ProductId = fnT_buttonRow.id;
					fnRemoveProduct(fnT_ProductId);
				}
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function fnRemoveProduct(fnT_ProductId)
				{
					// Remove Product - START
					var fnT_ChartTable = document.querySelector("table[id=ChartTable]");
					unsubscribe(coinbaseSocket, fnT_ProductId, "ticker");

					// Get the index of Product in the Products array
					fnT_ProductIndex = Products.findIndex(prd => prd.ProductId === fnT_ProductId);
					if (fnT_ProductIndex != -1)
						{ 
							Products.splice(fnT_ProductIndex, 1);
						}

					if(fnT_ChartTable.contains(document.getElementById(fnT_ProductId)))
						{
							fnT_row = document.getElementById(fnT_ProductId);
							fnT_ChartTable.deleteRow(fnT_row.rowIndex);
						}
					// Remove Product - END
				}
            //------------------------------------------------------------------------------------------
			
			
			//------------------------------------------------------------------------------------------
            function fnAddCrypto()
                {
                    var addCrypto = document.getElementById("frmCrypto").value;
					var addPrice = document.getElementById("frmPrice").value;
					//alert(addCrypto);
					/*if (location.search == "")
						{
							NewqueryString = "?" + addCrypto + "=" + addPrice;
						}
					else
						{
							NewqueryString = location.search + "&" + addCrypto + "=" + addPrice;
						}
					URL =  NewqueryString;
					window.location.replace(URL);*/
					fnGetProductObject(addCrypto);

					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === addCrypto);
					if (fnV_ProductIndex != -1)
						{ 
							Products[fnV_ProductIndex].PurchasePrice = Number(addPrice);
							fnChartProduct(addCrypto);
							subscribe(coinbaseSocket, addCrypto, "ticker");
						}
                }
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function fnImportObject(fileInput) 
				{
					if(fileInput.files[0] == undefined)
						{
							return;
						}

					// Example of what information you can read
					// var filename = fileInput.files[0].name;
					// var filesize = fileInput.files[0].size;
					var reader = new FileReader();
					reader.onload = function(ev) 	{
														var content = ev.target.result; // content is a string
														// Get the index of Product in the Products array
														//fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
														//if (fnV_ProductIndex == -1 || !isObject(Products[fnV_ProductIndex].stats) || !Array.isArray(Products[fnV_ProductIndex].candles) || !isObject(Products[fnV_ProductIndex].product) || !isObject(Products[fnV_ProductIndex].book))
														//	{ return 0; }
														
														
														Products.push(JSON.parse(content));
														//console.log("Successfully read file");
													};
					reader.onerror = function(err) 	{
														console.error("Failed to read file", err);
													};
					return reader.readAsText(fileInput.files[0]);
				}			
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function fnImportTriggers(fileInput) 
				{
					if(fileInput.files[0] == undefined)
						{
							return;
						}

					// Example of what information you can read
					// var filename = fileInput.files[0].name;
					// var filesize = fileInput.files[0].size;
					var reader = new FileReader();
					reader.onload = function(ev) 	{
														var fnV_Triggers = JSON.parse(ev.target.result);
														fnV_Triggers.forEach(function(fnV_objTrigger)	{
																								fnV_Trades += Number(obj.ticker.length);
																								/*
																									{
																										ProductId : "",
																										Alarm : true/false,
																										Enabled : true/false,
																										Lock : true/false,
																										Equation : "",
																										Actions : []
																									}
																								*/
																								addTriggerToProduct(fnV_objTrigger.ProductId, fnV_objTrigger.Alarm, fnV_objTrigger.Enabled, fnV_objTrigger.Lock, fnV_objTrigger.Equation= ""/*, fnV_objTrigger.Actions*/);
																								
																							});


														// Get the index of Product in the Products array
														//fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
														//if (fnV_ProductIndex == -1 || !isObject(Products[fnV_ProductIndex].stats) || !Array.isArray(Products[fnV_ProductIndex].candles) || !isObject(Products[fnV_ProductIndex].product) || !isObject(Products[fnV_ProductIndex].book))
														//	{ return 0; }
														
														
														Products.push(JSON.parse(content));
														//console.log("Successfully read file");
													};
					reader.onerror = function(err) 	{
														console.error("Failed to read file", err);
													};
					return reader.readAsText(fileInput.files[0]);
				}			
            //------------------------------------------------------------------------------------------

			
            //------------------------------------------------------------------------------------------
			function DownloadObject(fnV_Object)
				{
					strJSON = JSON.stringify(fnV_Object);
					// (A) CREATE BLOB OBJECT
					var myBlob = new Blob([strJSON], {type: "application/json"});

					// (B) CREATE DOWNLOAD LINK
					var url = window.URL.createObjectURL(myBlob);
					var anchor = document.createElement("a");
					anchor.href = url;
					anchor.download = "object.json";
						
					// (C) "FORCE DOWNLOAD"
					// NOTE: MAY NOT ALWAYS WORK DUE TO BROWSER SECURITY
					// BETTER TO LET USERS CLICK ON THEIR OWN
					anchor.click();
					window.URL.revokeObjectURL(url);
					document.removeChild(anchor);
				}
            //------------------------------------------------------------------------------------------
			
			
            //------------------------------------------------------------------------------------------
			function DownloadMessages(fnV_ProductId)
				{
					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					if (fnV_ProductIndex == -1 || !Array.isArray(Products[fnV_ProductIndex].message))
						{ return 0; }

				
					strJSON = JSON.stringify(Products[fnV_ProductIndex].message);
					// (A) CREATE BLOB OBJECT
					var myBlob = new Blob([strJSON], {type: "application/json"});

					// (B) CREATE DOWNLOAD LINK
					var url = window.URL.createObjectURL(myBlob);
					var anchor = document.createElement("a");
					anchor.href = url;
					anchor.download = fnV_ProductId + "_message.log";
						
					// (C) "FORCE DOWNLOAD"
					// NOTE: MAY NOT ALWAYS WORK DUE TO BROWSER SECURITY
					// BETTER TO LET USERS CLICK ON THEIR OWN
					anchor.click();
					window.URL.revokeObjectURL(url);
					document.removeChild(anchor);
				}
            //------------------------------------------------------------------------------------------

			
			
            //------------------------------------------------------------------------------------------
			function DownloadLogs(fnV_ProductId)
				{
					// Get the index of Product in the Products array
					fnV_ProductIndex = Products.findIndex(prd => prd.ProductId === fnV_ProductId);
					if (fnV_ProductIndex == -1 || !Array.isArray(Products[fnV_ProductIndex].log))
						{ return 0; }

				
					strJSON = JSON.stringify(Products[fnV_ProductIndex].log);
					// (A) CREATE BLOB OBJECT
					var myBlob = new Blob([strJSON], {type: "application/json"});

					// (B) CREATE DOWNLOAD LINK
					var url = window.URL.createObjectURL(myBlob);
					var anchor = document.createElement("a");
					anchor.href = url;
					anchor.download = fnV_ProductId + ".log";
						
					// (C) "FORCE DOWNLOAD"
					// NOTE: MAY NOT ALWAYS WORK DUE TO BROWSER SECURITY
					// BETTER TO LET USERS CLICK ON THEIR OWN
					anchor.click();
					window.URL.revokeObjectURL(url);
					document.removeChild(anchor);
				}
            //------------------------------------------------------------------------------------------

			
			
            //------------------------------------------------------------------------------------------
			function OpenWebSocket()
				{
					try { coinbaseSocket.close(4911); }
					catch(err) { }
					coinbaseSocket = new WebSocket(coinbaseWebSocketURI);
					coinbaseSocket.addEventListener("open", coinbaseSocket_Open);
					coinbaseSocket.addEventListener("close", coinbaseSocket_Close);
					coinbaseSocket.addEventListener("message", coinbaseSocket_Message);
					coinbaseSocket.addEventListener("error", coinbaseSocket_Error);
				}
            //------------------------------------------------------------------------------------------
			

            //------------------------------------------------------------------------------------------
			function CloseWebSocket()
				{
					coinbaseSocket.close();
				}
            //------------------------------------------------------------------------------------------

			
//******************************************************************************************************



			
			</script>
		
		<script type="text/javascript">
			//OpenWebSocket();
			
		</script>
    </body>
</html>
