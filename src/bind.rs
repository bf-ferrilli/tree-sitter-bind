use zed_extension_api as zed;

struct BindExtension;

impl zed::Extension for BindExtension {
    fn new() -> Self {
        Self
    }
}

zed::register_extension!(BindExtension);
