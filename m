Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBB644AB65;
	Mon, 31 Aug 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186385; cv=none; b=B8UIZCct6U3YfRy6rYZWmRdH70+pVRY8M7PRh+l9u3sK1EPJizKYWIDMqeayWykSEExOhk9lmGNpwIEvISu6DXq+bv8nvWo6Io0/ntWBVfDKyn8674QrctX3XN6cmdSg7XP2ITnlRDEL7fjG/s7cXRl34DymZe/FoZcnmExPYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186385; c=relaxed/simple;
	bh=1lRYNBIPqLnqZWFPCUhKGl8TmGTXEgyGBb/FpGx72Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caz0/qp2hv8Ncx1/B6obuKGCiqI75XZMd+3YvYvGC32cBrzWTznpoIiG+XSYi8fhRT0Aqb0YgiP0kJnpHMYKNoXmG274Ghxl9CQEKpQakdWZu0AlaszQHpkts98wUkJOXjeJjekSNcXw91gQZFDZ1r3NyZqI+rFpebFhqMt6l0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn4FJMnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn4FJMnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651AE1F00A3D;
	Mon, 31 Aug 2026 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186383;
	bh=WLeUJLJYpDmFjxBILukrXtcofCnOjUGJ9w/aNU3G8fk=;
	h=From:To:Cc:Subject:Date;
	b=Qn4FJMnwqJ1tVWBtnDCKXBEcM0yNf9/lDDInE4uBfFkJtoHOfzF/x8cN4gi+5lg6e
	 2X5xMVdT92vUXbR8ZHf2foXPBSCTKBDejGrOwgitD2HmyQHrULY6PjfdcR09fZuphv
	 HLz3mbAOxGPxqOnnOSqtI8mpn1gcsSzWinxtepUZWTjpXxXZGGn2721cxU+ojV7bGj
	 NiB0KPUz48QSBC6PMa5Ct/3AI5AipabCAkzck9kXQ4m8lcWJGjySeIc8OH8RUePxfU
	 7hMikOIGowHHaIIa7gIY5EhPU4qNIZZRo4nuD+EKa7UE3rndlgphj2+xp2jgHrgoE1
	 eAAa14X4Pg+qg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: misc cleanups
Date: Mon, 31 Aug 2026 07:26:02 -0700
Message-ID: <20260831142611.77572-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup the code, tests and samples for clarifications and readability.

The patches are individually sent by the authors.  I'm reposting those
as one series for convenience of handling.  For this reason, changelog
is on each patch's commentary section.

Enze Li (1):
  samples/damon/mtier: add comment for struct region_range

Hari Mishal (1):
  selftests/damon/sysfs.py: clean up sh processes used for
    obsolete_target test

Jaeyeon Lee (1):
  mm/damon/tests: use scoped_guard() for damon_test_ops_registration

Li Youhong (1):
  mm/damon/ops-common: factor out damon_putback_folio_list()

SJ Park (1):
  mm/damon/core: introduce damon_set_target_pid()

Zenghui Yu (Huawei) (1):
  mm/damon/core: remove declaration of __damon_commit_ctx()

zhaozhengzhuo (1):
  selftests/damon: prevent remaining cross-object state pollution

 include/linux/damon.h                         |  1 +
 mm/damon/core.c                               | 14 ++++++-
 mm/damon/ops-common.c                         | 30 +++++++--------
 mm/damon/sysfs.c                              |  6 +--
 mm/damon/tests/core-kunit.h                   | 21 +++++-----
 samples/damon/mtier.c                         |  5 +++
 samples/damon/prcl.c                          |  5 +--
 samples/damon/wsse.c                          |  5 +--
 tools/testing/selftests/damon/_damon_sysfs.py | 38 ++++++++++++++-----
 tools/testing/selftests/damon/sysfs.py        |  4 ++
 10 files changed, 79 insertions(+), 50 deletions(-)


base-commit: 58132fed7967e3401e3f293a0a2cc983161e229e
-- 
2.47.3
