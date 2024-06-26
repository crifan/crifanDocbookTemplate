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

/* $Id: IFCheck.java 746664 2009-02-22 12:40:44Z jeremias $ */

package org.apache.fop.intermediate;

import org.w3c.dom.Document;

/**
 * Check interface for intermediate format checks.
 */
public interface IFCheck {

    /**
     * Called to perform the check.
     * @param intermediate the intermediate format file as a DOM document
     */
    void check(Document intermediate);

}
