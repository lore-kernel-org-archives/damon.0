Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795818447;
	b=yOppF6U48oG/C5+MffWtWJGeFXeRhM85e1o/eafrn1qdAidW3WKuA6DO6YgsNkTApbdP
	 kSPaczWeHCnMMUCjJLnUd4lpdgBmpGl53XvGEpoG6KFy9ckdqcNVAK4d8GtQ+7Ir4S7sW
	 gcRO/B9NUnASFFwZi8wRuL1K7G2T1GX+ILHwpOzvn47mH6s1zsjFOtG0OGWATuZzru28S
	 BJt+ZddbK5FCUT9qxt13zISaDAGGRz6zyfWNny/Ti+58z1VYM/Z+VfkeftDzo6ue74hU5
	 zxv3ZFsQBhBbLM5nY0m+mQxyH9jwy5uRyf/OXeT+6gvrPmJiCG9wUHBsHS1a/YPhdCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795818447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6lBdhfWXWDM1BJfgF8wRgQ9FWT8DwEuH6a0DOJBJBFA=;
	b=AksC83FNtbxS6acTFqwY4wexMtRO0CM7J7vhvLe0wtQKePBscbMCRWb1dqVJT+anTioM
	 WpFj+GhpkkhmJqj6DXsn+punSE0HX2FBtdhoD+xLsW39liHfPW3Nf7N7LMBHWCI1fCA+5
	 teR0EFSQ/sUbBoiihnEEmdt2yU6P7/KJ3NtZv9d/pgwkbansiR0mu7DnbT/P+v6NCsnVy
	 v/GfA5wBiUUMSIBTS57ZbCqNgaf681hGbDSeLt72Hn9DnlMnl0RW5mZs8GejyVc1sOYWK
	 2IBoqHZgqggo0qkJi9WQdBCAvafBOfK/IniwyjywAYApZSa1kPu8k5/aDzpC/clyoLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZ80EMhd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF454606A31E;
	Fri, 27 Nov 2026 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZ80EMhd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223291F000C1;
	Fri, 27 Nov 2026 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795818447;
	bh=6lBdhfWXWDM1BJfgF8wRgQ9FWT8DwEuH6a0DOJBJBFA=;
	h=From:To:Cc:Subject:Date;
	b=gZ80EMhdqxW1hW8lBfnxIryIkYqgywZ1EP4YBcNbDCWjeea6eG9LwyjKIu0SH0s1J
	 n8idgbfIiH8aBJTLQNtScDkmSPiO4AYW684Iuq+4vLxrPmjGDCq90hx7nCoM3S3+Q8
	 wb1FnpmoHd3NeoCzyuiKo3f/X7fahMop2kkl4bImRiq2k5AkrJcWZeNRsVJcfJK4xV
	 Ra+aHOdTLxWP6ir6thvCigW42pOSEBRUbn589Rcpe6p4apFaS3yKlr+Mdb9SfBGZn8
	 e4J4BV128rGxc+AQJzL716yobxLrDijbnlgBdl+lExwLdZEBJqgQIZAOrdsZCDyrBN
	 jjXYzAuO9LH5w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/7] mm/damon: various improvements/cleanups for code, tests and comments
Date: Fri, 27 Nov 2026 14:27:11 -0800
Message-ID: <20261127222719.105510-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code, optimize code speed, add missing feature supports, and
update comments on various areas of DAMON.

Optimize the efficiency of vaddr damos_migrate action under filter
failures with patch 1.  Use damos->last_applied on damos_migrate action
in vaddr and support sz_filter_passed for damos_migrate action in vaddr,
respectively with patch 2 and 3.  Drop a redundant and racy quota goal
target value validation in sysfs, in favor of that in the core layer,
with patch 4.  Drop unused variables and imports from selftests with
patch 5 and 6.  Update source file intro comments to call DAMON just
DAMON, via patch 7.

Issues for patches 1 and 3 were found by Sashiko.  Those are
mild inefficiency and unsupported features, though.  Hence not Cc-ing
stable.

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20261101171630.81477-1-sj@kernel.org
- Set last_applied regardless of damos-filtering.
- Advance entire folio for invalid folio.
- update subject for unused imports removal.
- Add source file intro comments update patch.
- Rebase to the latest mm-new.
Changes from RFC
- RFC: https://lore.kernel.org/20261031202614.96036-1-sj@kernel.org
- Drop charge_target_from fixup consolidation.
- Add a patch for using last_applied on vaddr migrate action.
- Add missed damos_va_migrate_private->sz_filter_passed setup.
- Fix wrong commit message for unused imports removal.

SJ Park (7):
  mm/damon/vaddr: advance migration attempt in folio level for filter
    out
  mm/damon/vaddr: use damos->last_applied for migrate action
  mm/damon/vaddr: implement sz_filter_passed for migrate_{hot,cold}
    action
  mm/damon/sysfs-schemes: drop redundant and racy zero target_value
    check
  selftests/damon/damos_apply_interval: remove unused variables
  selftests/damon: remove unused imports of sys and time modules
  mm/damon: update file intro comments to call DAMON just DAMON

 mm/damon/core.c                               |  2 +-
 mm/damon/ops-common.c                         |  2 +-
 mm/damon/ops-common.h                         |  2 +-
 mm/damon/sysfs-schemes.c                      |  3 ---
 mm/damon/tests/core-kunit.h                   |  2 +-
 mm/damon/tests/paddr-kunit.h                  |  2 +-
 mm/damon/tests/sysfs-kunit.h                  |  2 +-
 mm/damon/tests/vaddr-kunit.h                  |  2 +-
 mm/damon/vaddr.c                              | 27 ++++++++++++-------
 .../selftests/damon/damos_apply_interval.py   |  2 --
 .../damon/sysfs_no_op_commit_break.py         |  1 -
 ...sysfs_update_schemes_tried_regions_hang.py |  1 -
 12 files changed, 24 insertions(+), 24 deletions(-)


base-commit: f3e166bac17470d6c215e1b4c2af36f5ac5ee75c
-- 
2.47.3
