Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795892441;
	b=LHM60lsxLePZAdpVvFmGNAj4XR3Q18hfOebvCsNN4clBmpJfuc1bjB0Ys4X1teShQRWI
	 lwh00XkmrzNUhl8cCMGHUuLSRLqtAxz/kjgnqOvjjLpxFz6EWwYsXJqn2Cx5YQaleULjp
	 S6tnad8AdNL3QEJwCDpaRz9aURh3OiYii5OOg2rbfcfP0Cld4BjIi+3DTt7ixCk9gA3LI
	 gXYGLLfbVDFFTkHxCWRn7Zy1kmwK0rtVm5co4hOqOsRE+jcnuSo9XxoD+1CGxLsk9jRkP
	 mviTIy4cXAsbFy2kcw3m17BcdIPUTU4ZRU0RvbeN0bzSFsrSMHnwEY7qESAe0k/40Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795892441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q3Ayp3mf5LZNEnREMb+uXcykhhHuaIN8Xp18yqPUd3A=;
	b=4OZ5/NhS6yQT0ISD37Jz5xo+UZv1zuDjz6pLMIPaS7qtqiw3dY8E4xINRLajyygAmNK8
	 rxdCvCw9C3SGPLc4F2LYDikQlY22qLD23U0vcuqzHAzUtFQ9gKPL+T5CcL/pqs3q1TO8x
	 temiChU29KPKgvp1V4Yj0DoyZuw3hFdxxoiahzXDUqAqf1A1YqUnhbg1JqzY8KNFjPPQD
	 ysMa/ztF0iNWXQxNMUB/hWMtTQpUdDHGbGPV3tYI3D4i8peexaf2A0qHhQPiYxppKpq24
	 AAnvDBt5Ay4tZiQRFsYYK47yQuLR38A8Fo3TDabmK0S3TamMkeAQdmEAkjWZbgn7UPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdnGfLMj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C2606A32F;
	Sat, 28 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdnGfLMj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48EE1F000C1;
	Sat, 28 Nov 2026 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795892440;
	bh=q3Ayp3mf5LZNEnREMb+uXcykhhHuaIN8Xp18yqPUd3A=;
	h=From:To:Cc:Subject:Date;
	b=GdnGfLMjul9fQRT6906rDXCgC2/D0Y5dW/e2PWhjxZ8N8fAF7RPdXyO2vx3WMwtAt
	 5BJQWHu4eQTYZ+2rPP653yS19LweSjGhtbe/xwNh64gf22/fqJrHu1UvkJY05U2UYN
	 V30gWCTN6RNjHzagJwFD+NposNA/DlipgFY385d0GL9zwyrQIQCmdZDl2JqyLVCAZJ
	 FZAlKEmtXpnCrn+DoDwLn4dfUk+Fp+gyBdcrxDy9YwT4W2A7rmUw6/tCX2PjzPeaMK
	 1D/JX047UmTX121RrdncGnhxApjgrVvRoaZygIhCcLwyuLJS+AznhnEM1wxulPMj/N
	 MJRlI8Q6dTZpA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 0/7] mm/damon: various improvements/cleanups for code, tests and comments
Date: Sat, 28 Nov 2026 11:00:25 -0800
Message-ID: <20261128190033.164440-1-sj@kernel.org>
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

Changes from RFC v3
- RFC v3: https://lore.kernel.org/20261127222719.105510-1-sj@kernel.org
- Avoid NULL dereference when vm_normal_folio() returns NULL, in patch 2.
- Rebase to the latest mm-new.
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
 12 files changed, 25 insertions(+), 23 deletions(-)


base-commit: 23cd682622886800b912219e307cf46a99f69c10
-- 
2.47.3
