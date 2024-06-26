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

/* $Id: PCLRendererMaker.java 679326 2008-07-24 09:35:34Z vhennebert $ */

package org.apache.fop.render.pcl;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.MimeConstants;
import org.apache.fop.render.AbstractRendererMaker;
import org.apache.fop.render.Renderer;
import org.apache.fop.render.RendererConfigurator;

/**
 * RendererMaker for the PCL Renderer.
 */
public class PCLRendererMaker extends AbstractRendererMaker {

    private static final String[] MIMES = new String[] {
        MimeConstants.MIME_PCL,
        MimeConstants.MIME_PCL_ALT
    };

    /**{@inheritDoc} */
    public Renderer makeRenderer(FOUserAgent userAgent) {
        return new PCLRenderer();
    }

    /** {@inheritDoc} */
    public RendererConfigurator getConfigurator(FOUserAgent userAgent) {
        return new PCLRendererConfigurator(userAgent);
    }

    /** {@inheritDoc} */
    public boolean needsOutputStream() {
        return true;
    }

    /** {@inheritDoc} */
    public String[] getSupportedMimeTypes() {
        return MIMES;
    }
}
