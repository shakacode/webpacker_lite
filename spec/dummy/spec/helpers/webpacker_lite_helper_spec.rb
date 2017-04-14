require_relative "../rails_helper"
# ENV["RAILS_ENV"] ||= "test"
# require File.expand_path("../../../config/environment", __FILE__)
# require "rspec/rails"

describe WebpackerLite::Helper, type: :helper do
  let(:vendor_bundle) { WebpackerLite::Manifest.lookup("vendor.css") }
  let(:app_bundle) { WebpackerLite::Manifest.lookup("app.css") }

  context "without using a key (default)" do
    it "should include the tag, when input single value" do
      expect(helper.stylesheet_pack_tag("vendor")).to eql helper.stylesheet_link_tag(vendor_bundle)
    end

    it "should include the tag, when input is array" do
      expected_result = helper.stylesheet_link_tag(vendor_bundle) + "\n" + helper.stylesheet_link_tag(app_bundle)
      expect(helper.stylesheet_pack_tag(["vendor", "app"])).to eql expected_result
    end
  end

  context "with using static key" do
    context "when static loading" do
      let(:static_loading) { ENV.delete("REACT_ON_RAILS_ENV") }

      it "should include the tag, when input single value" do
        static_loading
        expect(helper.stylesheet_pack_tag(static: "vendor")).to eql helper.stylesheet_link_tag(vendor_bundle)
      end

      it "should include the tag, when input is array" do
        static_loading
        expected_result = helper.stylesheet_link_tag(vendor_bundle) + "\n" + helper.stylesheet_link_tag(app_bundle)
        expect(helper.stylesheet_pack_tag(static: ["vendor", "app"])).to eql expected_result
      end
    end

    context "when hot loading" do
      let(:hot_loading) { ENV["REACT_ON_RAILS_ENV"] = "HOT" }

      it "should not include the tag, when input single value" do
        hot_loading
        expect(helper.stylesheet_pack_tag(static: "vendor")).to eql ""
      end

      it "should not include the tag, when input is array" do
        hot_loading
        expected_result = ""
        expect(helper.stylesheet_pack_tag(static: ["vendor", "app"])).to eql expected_result
      end
    end

  end

  context "with using hot key" do
    context "when static loading" do
      let(:static_loading) { ENV.delete("REACT_ON_RAILS_ENV") }

      it "should not include the tag, when input single value" do
        static_loading
        expect(helper.stylesheet_pack_tag(hot: "vendor")).to eql ""
      end

      it "should not include the tag, when input is array" do
        static_loading
        expected_result = ""
        expect(helper.stylesheet_pack_tag(hot: ["vendor", "app"])).to eql expected_result
      end
    end

    context "when hot loading" do
      let(:hot_loading) { ENV["REACT_ON_RAILS_ENV"] = "HOT" }

      it "should include the tag, when input single value" do
        hot_loading
        expect(helper.stylesheet_pack_tag(hot: "vendor")).to eql helper.stylesheet_link_tag(vendor_bundle)
      end

      it "should include the tag, when input is array" do
        hot_loading
        expected_result = helper.stylesheet_link_tag(vendor_bundle) + "\n" + helper.stylesheet_link_tag(app_bundle)
        expect(helper.stylesheet_pack_tag(hot: ["vendor", "app"])).to eql expected_result
      end
    end

  end
end
