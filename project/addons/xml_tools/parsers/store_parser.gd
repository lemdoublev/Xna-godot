# The MIT License (MIT)
#
# Copyright (c) 2016 George Marques
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends "base_parser.gd"

func parse(file):

	var err = open(file)
	if err != OK:
		return err

	# Read the header of the file to make sure it's a Store
	err = read_header("Store")
	if err != OK:
		return err

	var store_data = { "AssetName": asset_name }

	err = read_float("BuyMultiplier", store_data)
	if err != OK:
		return err

	err = read_float("SellMultiplier", store_data)
	if err != OK:
		return err

	err = read_object_array("StoreCategories", store_data, funcref(self, "parse_category"))
	if err != OK:
		return err

	err = read_string("WelcomeMessage", store_data)
	if err != OK:
		return err

	err = read_string("ShopkeeperTextureName", store_data)
	if err != OK:
		return err

	# Finished :)
	return store_data

# Parse each category
func parse_category(parser):

	var entry = {}

	var err = read_string("Name", entry)
	if err != OK:
		return err

	err = read_string_array("AvailableContentNames", entry)
	if err != OK:
		return err

	return entry
