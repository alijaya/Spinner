import flash.display.BitmapData;
import flash.utils.ByteArray;
import flash.media.Sound;

class BD extends BitmapData { public function new() super(0, 0) }

@:bitmap("assets/Spinner/Ball.png")
class BBall extends BD {}

@:bitmap("assets/Spinner/BorderLeftUp.png")
class BBorderLeftUp extends BD {}

@:bitmap("assets/Spinner/BorderRightDown.png")
class BBorderRightDown extends BD {}

@:bitmap("assets/Spinner/BoundCountCounter.png")
class BBoundCountCounter extends BD {}

@:bitmap("assets/Spinner/BoundHollow.png")
class BBoundHollow extends BD {}

@:bitmap("assets/Spinner/BoundNormal.png")
class BBoundNormal extends BD {}

@:bitmap("assets/Spinner/BoundOneSideLeftUp.png")
class BBoundOneSideLeftUp extends BD {}

@:bitmap("assets/Spinner/BoundOneSideRightDown.png")
class BBoundOneSideRightDown extends BD {}

@:bitmap("assets/Spinner/Box.png")
class BBox extends BD {}

@:bitmap("assets/Spinner/SequenceCCW.png")
class BSequenceCCW extends BD {}

@:bitmap("assets/Spinner/SequenceCW.png")
class BSequenceCW extends BD {}

@:bitmap("assets/Spinner/SequenceFlip.png")
class BSequenceFlip extends BD {}

@:bitmap("assets/Spinner/SoundDisabled.png")
class BSoundDisabled extends BD {}

@:bitmap("assets/Spinner/SoundEnabled.png")
class BSoundEnabled extends BD {}

@:bitmap("assets/Spinner/Title.png")
class BTitle extends BD {}

@:sound("assets/Spinner/BGM.mp3")
class SBGM extends Sound {}

@:sound("assets/Spinner/Knock.mp3")
class SKnock extends Sound {}

@:sound("assets/Spinner/Swoosh.mp3")
class SSwoosh extends Sound {}

@:sound("assets/Spinner/Tap.mp3")
class STap extends Sound {}

@:file("assets/level/Level1.json")
class DLevel1 extends ByteArray {}

@:file("assets/level/Level2.json")
class DLevel2 extends ByteArray {}

@:file("assets/level/Level3.json")
class DLevel3 extends ByteArray {}

@:file("assets/level/Level4.json")
class DLevel4 extends ByteArray {}

@:file("assets/level/Level5.json")
class DLevel5 extends ByteArray {}

@:file("assets/level/Level6.json")
class DLevel6 extends ByteArray {}

@:file("assets/level/Level7.json")
class DLevel7 extends ByteArray {}

@:file("assets/level/Level8.json")
class DLevel8 extends ByteArray {}

@:file("assets/level/Level9.json")
class DLevel9 extends ByteArray {}

@:file("assets/level/Level10.json")
class DLevel10 extends ByteArray {}

@:file("assets/level/Level11.json")
class DLevel11 extends ByteArray {}

@:file("assets/level/Level12.json")
class DLevel12 extends ByteArray {}

@:file("assets/level/Level13.json")
class DLevel13 extends ByteArray {}

@:file("assets/level/Level14.json")
class DLevel14 extends ByteArray {}

@:file("assets/level/Level15.json")
class DLevel15 extends ByteArray {}

@:file("assets/level/Level16.json")
class DLevel16 extends ByteArray {}

@:file("assets/level/Level17.json")
class DLevel17 extends ByteArray {}

@:file("assets/level/Level18.json")
class DLevel18 extends ByteArray {}

@:file("assets/level/Level19.json")
class DLevel19 extends ByteArray {}

@:file("assets/level/Level20.json")
class DLevel20 extends ByteArray {}
