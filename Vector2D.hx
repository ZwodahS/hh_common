
package common;
import haxe.ds.Vector;

typedef XY = {
    x: Int,
    y: Int
}

class Vector2DIteratorXY<T> {

    var data: Vector2D<T>;
    var currX: Int;
    var currY: Int;
    public function new(data: Vector2D<T>) {
        this.data = data;
        this.currX = 0;
        this.currY = 0;
    }

    public function hasNext(): Bool {
        return (this.currX < this.data.lengthX && this.currY < this.data.lengthY);
    }

    public function next(): {key: XY, value: T} {
        var returnValue = {
            key: {x: this.currX, y: this.currY },
            value: this.data.get(this.currX, this.currY)
        }
        if (this.currX == this.data.lengthX-1) {
            this.currX = 0;
            this.currY += 1;
        } else {
            this.currX += 1;
        }
        return returnValue;
    }
}

class Vector2DIteratorYX<T> {

    var data: Vector2D<T>;
    var currX: Int;
    var currY: Int;
    public function new(data: Vector2D<T>) {
        this.data = data;
        this.currX = 0;
        this.currY = 0;
    }

    public function hasNext(): Bool {
        return (this.currX < this.data.lengthX && this.currY < this.data.lengthY);
    }

    public function next(): {key: XY, value: T} {
        var returnValue = {
            key: {x: this.currX, y: this.currY },
            value: this.data.get(this.currX, this.currY)
        }
        if (this.currY == this.data.lengthY-1) {
            this.currY = 0;
            this.currX += 1;
        } else {
            this.currY += 1;
        }
        return returnValue;
    }
}

class Vector2D<T> {
    /**
      A 2x3 (width * height)
      [ 0, 1
        2, 3
        4, 5
        ]
      will be stored as [0, 1, 2, 3, 4, 5]
      There shouldn't be a need to know this when using this from outside.
    **/

    public var lengthX(default, null): Int;
    public var lengthY(default, null): Int;
    var data: Vector<T>;
    var nullValue: T;

    public function toString(): String {
        var str = "";
        for (y in 0...this.lengthY) {
            for (x in 0...this.lengthX) {
                str += this.get(x, y) + " ";
            }
            str += "\n";
        }
        return str;
    }

    public function new(lengthX: Int, lengthY: Int, nullValue: T) {
        this.lengthX = lengthX;
        this.lengthY = lengthY;
        this.data = new Vector<T>(lengthX * lengthY);
        for (i in 0...data.length) {
            this.data[i] = nullValue;
        }
    }

    inline public function get(x, y): T {
        var p = pos(x, y);
        return _inBound(p) ? data[p] : nullValue;
    }

    inline public function set(x, y, value: T) {
        var pos = pos(x, y);
        if (_inBound(pos)) this.data[pos] = value;
    }

    inline function pos(x: Int, y: Int): Int { // return -1 if out of bound
        return x + (y*lengthX);
    }

    public function inBound(x: Int, y: Int): Bool {
        return _inBound(pos(x, y));
    }

    inline function _inBound(p: Int): Bool {
        return p >= 0 && p < data.length;
    }

    public function iterateXY(): Vector2DIteratorXY<T> {
        return new Vector2DIteratorXY<T>(this);
    }

    public function iterateYX(): Vector2DIteratorYX<T> {
        return new Vector2DIteratorYX<T>(this);
    }

    // https://stackoverflow.com/questions/18034805/rotate-mn-matrix-90-degrees
    public function rotateCCW() {
        var newLengthX = this.lengthY;
        var newLengthY = this.lengthX;
        var copy = new Vector<T>(this.data.length);
        var x1 = 0;
        var y1 = 0;
        var x0 = this.lengthX - 1;
        while (x0 >= 0) {
            x1 = 0;
            for (y0 in 0...this.lengthY) {
                copy[(y1*newLengthX)+x1] = this.data[pos(x0, y0)];
                x1 += 1;
            }
            x0 -= 1;
            y1 += 1;
        }
        for (i in 0...data.length) {
            data[i] = copy[i];
        }
        this.lengthX = newLengthX;
        this.lengthY = newLengthY;
    }

    public function rotateCW() {
        var newLengthX = this.lengthY;
        var newLengthY = this.lengthX;
        var copy = new Vector<T>(this.data.length);
        var x1 = 0;
        var y1 = 0;
        var x0 = this.lengthX - 1;
        for (x0 in 0...this.lengthX) {
            x1 = newLengthX - 1;
            for (y0 in 0...this.lengthY) {
                copy[(y1*newLengthX)+x1] = this.data[pos(x0, y0)];
                x1 -= 1;
            }
            y1 += 1;
        }
        for (i in 0...data.length) {
            data[i] = copy[i];
        }
        this.lengthX = newLengthX;
        this.lengthY = newLengthY;
    }
}
