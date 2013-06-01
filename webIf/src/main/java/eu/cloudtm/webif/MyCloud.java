/*
 * $Id: HelloWorld.java 739661 2009-02-01 00:06:00Z davenewton $
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package eu.cloudtm.webif;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.gson.Gson;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientHandlerException;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

import eu.cloudtm.model.*;

/**
 * <code>Set welcome message.</code>
 */
public class MyCloud extends BaseAction {

	private static Log log = LogFactory.getLog(MyCloud.class);

	public String execute() throws Exception {
		log.info("MyCloud execute()");

		//String output = response.getEntity(String.class);
		
		setMessage(getText(MESSAGE));
		return SUCCESS;
	}

	
	public Scale scale;
	public Scale getScale(){ return scale; }
	public void setScale(Scale value){ scale = value; }
	
	
	/**
	 * Provide default value for Message property.
	 */
	public static final String MESSAGE = "MyCloud.message";

	/**
	 * Field for Message property.
	 */
	private String message;

	/**
	 * Return Message property.
	 * 
	 * @return Message property
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * Set Message property.
	 * 
	 * @param message
	 *            Text to display on HelloWorld page.
	 */
	public void setMessage(String message) {
		this.message = message;
	}
}