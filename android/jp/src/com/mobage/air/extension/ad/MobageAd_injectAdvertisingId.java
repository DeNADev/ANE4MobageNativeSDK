package com.mobage.air.extension.ad;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.mobage.air.extension.ArgsParser;
import com.mobage.air.extension.Dispatcher;
import com.mobage.android.extension.AdIdInjector;

public class MobageAd_injectAdvertisingId implements FREFunction {

	@Override
	public FREObject call(final FREContext context, FREObject[] args) {
		try {
			ArgsParser a = new ArgsParser(args);
			String adID = a.nextString();
			a.finish();
			
			AdIdInjector.injectAdvertisingId(adID);
			
		} catch (Exception e) {
			Dispatcher.exception(context, e);
		}
		
		
		return null;
	}

}
