Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4E48D860;
	Wed, 29 Jul 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336465; cv=none; b=X5CZBMTw+Bz3RCx8f9SpF9WOuV2T6oV/iPJsx7/RKWD8IRr1/jf1HiqN4PSFGIrur8IA17mSqalRvPYrIEHs3jVUZEGdC53x7aq41IXHS5iR29YJrMB2ObNA6B/VH8hTtySBJFQmfrpLgEf91nBpyNXQuUxSw07T1XkylFULR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336465; c=relaxed/simple;
	bh=loGLgY5ItIsMY88MkR/DfsoCUrV7HI8lv3NLVWyqBRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lhu7UPw+WOh9oW/D/ptkYBY8svZ4/8fH4yZGw2eKJ1rDej4N12JMsazMcRYVH8b44GG53jcLOj5ilTVf86RCxXmJWH+7GiQoPsq6yJ4rBlSqQE6lx24Rcz/bqOE2DFcFLaMnDpgBE7DfVVpa3PmVCZpSXJ8CIaaoo9SC1EZzmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiqIDOQw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiqIDOQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C561F00A3E;
	Wed, 29 Jul 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336462;
	bh=DKnDu4X+rd4KrlY4SCfiPQqPTppxa4AM+AMSVEZhOAo=;
	h=From:To:Cc:Subject:Date;
	b=TiqIDOQwPGDBSVnMJbEvoEPzZcNn+F3m5XzA85F62BYB1ZlzLADlSx0vjAchcq/tj
	 mXRKiKsJcnrgGuhrL6l9WdmnBs8MqDA+RS272sbGKsCHhmaEaUCu/xxc5ncW3+ighg
	 hcbHAAjkvNt2/ElFUCantFwaoxwv/TUkQ8i2Dot19CmoVnQymCCc0YR8Bj9l8KjsYu
	 FsL8VX2sEPx2S2fgv3GtoxmoKO1cMBisiLnukS7KV1uQzMcI97ou9tnlWkJSAszFyF
	 +OSmGzMj5PFeO1COnq4f5W6Mzuqlvfb1jUyu/5P7RmDkC7XY5a89olL+n/woqNgAI5
	 Q1I53lU/pJ2FA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/6] mm/damon: add kunit and selftests for probes and probe weights
Date: Wed, 29 Jul 2026 07:47:31 -0700
Message-ID: <20260729144738.90895-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON recently introduced probes and probe weights.  Add kunit and
selftests for ensuring the parameters for features can be set using the
core API and the sysfs ABI, respectively.

SJ Park (6):
  mm/damon/tests/core-kunit: test damon_commit_filter()
  mm/damon/tests/core-kunit: add damon_commit_probes() test
  selftests/damon/_damon_sysfs: implement DamonProbes
  selftests/damon/drgn_dump_damon_status: dump probes
  selftests/damon/sysfs.py: extend commit assertion function for probes
  selftests/damon/sysfs.py: test damon probes

 mm/damon/tests/core-kunit.h                   | 121 +++++++++++++++++
 tools/testing/selftests/damon/_damon_sysfs.py | 123 +++++++++++++++++-
 .../selftests/damon/drgn_dump_damon_status.py |  32 +++++
 tools/testing/selftests/damon/sysfs.py        |  35 ++++-
 4 files changed, 309 insertions(+), 2 deletions(-)


base-commit: 2f558ff382eed84b9ffde4dbd630a1fc4c57fab4
-- 
2.47.3
