Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AC421EED;
	Mon, 29 Jun 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744577; cv=none; b=GhrKVTd0P64eEXhOuMm3c8URHnheKVnmVgnsb88fn3B5xiIXewsvDD4ygQzXjUdz+jdCRZ5bY541swv0g6Vqmfe19WhgksQTkUXNEUB+YFsSoicl+1rqKVLl7u9Tg0beKuX5WaeI3GwnFYim1QdATGfnHfAtJHijY0yUn2L3dJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744577; c=relaxed/simple;
	bh=UGwIYAzQ8x51FYo5CGMDePbzQyzF1U/MZiiO+OHGmT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hORJHh7n/zrh9J1K1h6atmAiB48bPlad/NL+bHyUB686ahXKbcHW6fFlGtF58S4lKlFfJD85KJTzS222+j6bINAPW1g7WYE8FZJrvNNzaoIEwcCozAJ8KpA5zdVKhuhMo9uj1/u8p213/sX0VcjTjD67CVNqRMMoGoSqcdhhsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUK0R1dE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUK0R1dE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6434A1F000E9;
	Mon, 29 Jun 2026 14:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744575;
	bh=zYB54nSNsC1cSvePQMmqCTyhvQRTVTX+nG90R7aX3cM=;
	h=From:To:Cc:Subject:Date;
	b=NUK0R1dEJcu8e5K+/EOxUGDzwIFsmYJ7Y9pvkPMQgkPlafcii5zsPnhsJZ6mn4d9I
	 jgGj0DA3FIN7j+ceIyVFKqrAZOrxU3rAzB8RKswIOOEpzQqKc6gZC/h+vp74Qz7Q7F
	 3D2XcEn9v9jgwMdf7JmLrOPI298bp+xG8yWlbnYDqE9hvljayGzNKvPrGmi8XQGdUr
	 MnLNZlWnO5bcm9D8Mmkrfsha3tayGPlqGFMjR2zKOCcI9LzFuJLbJgVQ1nlf8UdBH8
	 UK0anGAEX9uC3BkyY49RU55YN07nk5fMnrUJ/SgLMpt5fjDIfDg7dRqv42gd7Ml7px
	 fQZ7Nh9YqxdlA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/2] selftests/damon: test kdamond refresh_ms
Date: Mon, 29 Jun 2026 07:49:24 -0700
Message-ID: <20260629144927.134237-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kdamond 'refresh_ms' sysfs file makes DAMON periodically update its
read-only sysfs files (DAMOS stats, tuned monitoring intervals and the
kdamond pid) on its own, so users don't have to write update keywords
such as 'update_schemes_stats' to the 'state' file.  It has no selftest
coverage.

The first patch adds refresh_ms support to the _damon_sysfs.py test
control module.  The second adds a test that sets refresh_ms and confirms
a scheme's stats are updated under sysfs without an explicit update
request; the test skips on kernels that predate the refresh_ms file.

Tested on current mainline under a DAMON-enabled kernel: the new test
passes and the existing DAMON selftests show no new failures.

Changes from v1
- v1: https://lore.kernel.org/20260602131217.2210912-1-linuxoid@gmail.com
- Add R-b: from SJ.
- Rebase to latest mm-new.

Ruslan Valiyev (2):
  selftests/damon/_damon_sysfs: support kdamond refresh_ms
  selftests/damon/sysfs_refresh: test kdamond refresh_ms

 tools/testing/selftests/damon/Makefile        |  1 +
 tools/testing/selftests/damon/_damon_sysfs.py |  9 ++-
 .../testing/selftests/damon/sysfs_refresh.py  | 75 +++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/sysfs_refresh.py


base-commit: f46247bcce72b9e62868c347711c772657b00ce6
-- 
2.47.3
