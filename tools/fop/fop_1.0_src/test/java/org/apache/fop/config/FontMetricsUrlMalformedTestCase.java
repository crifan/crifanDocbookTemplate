/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* $Id: FontMetricsUrlMalformedTestCase.java 679326 2008-07-24 09:35:34Z vhennebert $ */

package org.apache.fop.config;

/*
 * this font has a malformed metrics-url
 */
public class FontMetricsUrlMalformedTestCase extends BaseDestructiveUserConfigTestCase {

    public FontMetricsUrlMalformedTestCase(String name) {
        super(name);
    }

    /**
     * @see org.apache.fop.config.BaseUserConfigTestCase#getUserConfigFilename()
     */
    public String getUserConfigFilename() {
        return "test_font_metricsurl_malformed.xconf";
    }
}
