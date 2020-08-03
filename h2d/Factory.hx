package common.h2d;

class WrappedObject {
    public var object(default, null): h2d.Object;

    public function new(object: h2d.Object) {
        this.object = object;
    }

    inline public function position(x: Float, y: Float): WrappedObject {
        this.object.x = x;
        this.object.y = y;
        return this;
    }

    inline public function visible(visible: Bool): WrappedObject {
        this.object.visible = visible;
        return this;
    }

    inline public function addChild(object: h2d.Object): WrappedObject {
        this.object.addChild(object);
        return this;
    }
}

class WrappedTextObject {
    public var text(default, null): h2d.Text;

    public function new(text: h2d.Text) {
        this.text = text;
    }

    inline public function maxWidth(width: Float): WrappedTextObject {
        this.text.maxWidth = width;
        return this;
    }

    inline public function textColor(color: Int): WrappedTextObject {
        this.text.textColor = color;
        return this;
    }

    inline public function setText(string: String): WrappedTextObject {
        this.text.text = string;
        return this;
    }

    inline public function position(x: Float, y: Float): WrappedTextObject {
        this.text.x = x;
        this.text.y = y;
        return this;
    }

    inline public function visible(visible: Bool): WrappedTextObject {
        this.text.visible = visible;
        return this;
    }
}

class Factory {
    inline public static function object(object: h2d.Object): WrappedObject {
        return new WrappedObject(object);
    }

    inline public static function text(text: h2d.Text): WrappedTextObject {
        return new WrappedTextObject(text);
    }
}