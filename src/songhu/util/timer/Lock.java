package songhu.util.timer;

public class Lock {
	private static boolean lock;

	public static boolean isLock() {
		return lock;
	}

	public static void setLock(boolean lock) {
		Lock.lock = lock;
	}

}
