#!/bin/bash

#     Copyright (C) 2015 KreAch3R
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#          http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.

# if variant variable is unset, use "user" as default
if [ -z "$variant" ]; then
    export variant=user
fi

# add all lunch combos
vendorsetups=($(ls vendor/krexus/products/ | grep krexus_ | sed "s/.mk/-$variant/"))
for combo in "${vendorsetups[@]}"; do
    add_lunch_combo $combo
done
