Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56A3CF207
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280995; cv=none; b=esIks8SXkb1W79Bb1NneQW2Jub+dyw+RTWzenygn//09CDITIu7tR2WepJtEGE/caY6nkh29gaeXLgdRkURx9pZS/Gj5zz/r2ALF2iULEHF3FPqzN0wZNcZiCQ0eykq+IPp+xLRvbTdNjU49wdbbKGFv3k1P5xmSq08eoV7/PjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280995; c=relaxed/simple;
	bh=LmbjwTK4tuaONw1jCkYsUmgRPvsp4oLyl3+5bT69KPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b800fhys7UJ9x2W0L7dXkbl7ZW+ityb8eeoKas9UrsnDt0NFJ9epZb6mHlCL/imVSFk3cmn0WenF1gor81ukHWh106WyRa/1ffT1j6KA1kD4o6DX+/ghm9wjJc3t6aok70fYHKCX1pU4g36l2gkAfnCbuqJZMvu2wxGUcOfhcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNy10wF+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNy10wF+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso755785e9.0
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280990; x=1790885790; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WT1vJAlJB3UqsXiDI150AgVhKS27Afshhi+pSW9AfhY=;
        b=pNy10wF+v8IwMYCd1EztX7VJhi5M0MxU7YZlPGzPWGHo6WBk1xdO6AP/HsI1LXuSza
         R23VVb021RNLGhUjYGu1fCxGgPj3+mnJSZIZGy4DrEhTyVXtTZhqwFzwbb8wcOxKk2dm
         gQCfFwOnBexFAqyDreEa5PzuBHGyDsxyJSR3W4BxdQNhlAspcZkUZe2irz8Cmzo8d21P
         kSTPhfTgif8T/Gzg1u616ttgFeLGougkjF3DoHeMAvfPC8Y7GMqkElEVnAH99NtA3NKi
         K94SjNqDMZVKN1lCrAspT1OLIOfqkccY2pcQ/vYCAWy+axtyMkvSgmwun6a23TDkepn+
         h8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280990; x=1790885790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WT1vJAlJB3UqsXiDI150AgVhKS27Afshhi+pSW9AfhY=;
        b=t5mLQEcAlS2xRPAaXolylI7CAJ55H/ynYFH8PYRktKfz9VjcLmVLOTrYidB5NWfcpi
         0Ys+ED3cD6y8uXgUiXogr6yVx0FkiNP8oA42d3XvKGQEqANi7ZgduyYNFOQ6i//aG1GX
         CGtEt+hkdXw/acwTNFzDJjxA26KIc6dhVvpx9Pu7DQjiziicjB34wy/eTAvB03mNcUXW
         0KJ3dVixwglggkJJVVbWwTOIa3Tkr+PWrmdZG8s3RZiiFUwbwBxFdlUUw89NqWuSf/lS
         Ez6+UWeE7eRo2paErVi3ojV0sObJgZOFY+uyTyiXgt+YIkXOzuOqat8PhJ0Ga4vFkwzU
         5vaA==
X-Forwarded-Encrypted: i=1; AKwUvBxju7ZK61ZG4AAGPgKoL8NU0tTcq5stsudjHVtPpCzxELh3qTIx7Bv8NmJB2G9n59RK/qv+Gg==@lists.linux.dev
X-Gm-Message-State: AFuF++nh0fNOo67ulE+19kPInnqEvj4j+BnHJVsyGzOrdWj9TXwOawhC
	jMf3XZIvwG1GSEbpkcDGOTAMbFRVTTNRuUSiz1akRGNrx5L4OmQgFdZl
X-Gm-Gg: AYBFou11ZzwsJ2G0O/mUuZSRWR1Hd/E4svSXKq31h4uGBUjHXFoLgQFMaEG3hMjaEkr
	ojScuJ0yTjuTKjGL1GF3q8usz/3EXfV4PTJDUYA4Igg+802f37+wbD7isGphU3x1oxJA5GMEOyF
	aKLiWFU6802WKKXq7EbpZyo8W+MK8uijatkSomE76LoEVzIIw/SxlM4BHCILSCH8FpB3XEKgvQP
	DidK6xU0eNVTjRcnIUhXSX3FrdMN1oNbfpuGrAdqSjQjY9dB2ohO1BH02RmtIuJpS04jZvLD2gh
	AcmYoQRtY2IQbBQWcWwYilcrJutOiklIihj2CmLWT8lfKiQXYZqd9lkvqtNTc9lXYlucA5aKFLq
	W0wub5NGK1fU1joIy4Lvenl8tyZpUf1+KiVxkz2nQG1RunUiqts63nXUO7DPHGyv/bRGcTZAaQA
	Y65jxjVrFkXfrdAdgh/LzixEQ3YANuxTxhk1sWgzcnQz/j55L60yeicJNjGxGv8uJVj5EKx2vbs
	DsKys0x91slsZqLTLT0uwi7HNKFrRnGZkBgyKLhudl42lt8QYSHY8z92N/2OF3P75hUmbLy4IPq
	FX190nybdsHFSbHAI95P2r3hKleqECl9C/a4rXcVAjB8N1UqWHIBLkTb2GJv2U/JBmOXEoFF0N8
	d4y5fKrkGILoF81L0PUaPLw==
X-Received: by 2002:a05:600c:8b5b:b0:49c:f13e:e4d with SMTP id 5b1f17b1804b1-49fe66f17damr60720065e9.10.1790280989870;
        Thu, 24 Sep 2026 13:16:29 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-adbf-6901-3138-76b5-e9f7-b9cf.310.pool.telefonica.de. [2a02:3100:adbf:6901:3138:76b5:e9f7:b9cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm144818795e9.12.2026.09.24.13.16.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 13:16:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mm/damon: preserve quota state when constructing schemes
Date: Thu, 24 Sep 2026 22:16:12 +0200
Message-Id: <20260924201615.4478-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_ctx() first commits the running context's parameters to a
temporary context for validating proposed updates. Constructing the
temporary schemes clears the running schemes' quota state because
damon_new_scheme() initializes the quota passed as a parameter before
copying it to the new scheme. Even an update later rejected with -EINVAL
loses the running quota state.

Initialize the new scheme's copy instead, and add KUnit tests for the
constructor and for accepted and rejected context updates.

In the v1 live test with damo, a scheme with a plain 64 KiB size quota and
a 60-second reset interval uses its quota, and a full "damo tune" with
unchanged parameters then lets it try another 64 KiB within the same
window. With the fix, sz_tried stays at 64 KiB.

KUnit was rerun after the rebase on x86-64 and i386. With only patch 2
applied, the two new tests fail. With the fix, all 46 DAMON KUnit tests
pass on both architectures.

The v1 DAMON selftests showed no new failures (QEMU TCG guest; the
wss_estimation test missed its accuracy bounds with and without the fix).

Changes since v1 [1], following SJ's review [2]:
 - Collect SJ's Reviewed-by for patch 2.
 - Explain the running-context validation in the opening paragraph.
 - Clarify which quota is passed as a parameter and use "commit" for the
   context operation.
 - Point Fixes to commit 60bd24f272d0 ("mm/damon/sysfs: test commit input
   against realistic destination"). Drop the redundant stable version
   comment.
 - Rebase onto mm-new. No changes to the fix or test logic.

The series is based on mm-new at ad8b9fe7a502. On damon/next, patch 2
shares context with the PSI goal test [3] and applies with git am -3.

[1] v1
https://lore.kernel.org/r/20260921003047.12041-1-kmehltretter@gmail.com/

[2] SJ's clarification
https://lore.kernel.org/r/20260922120845.44460-1-sj@kernel.org/

[3] PSI goal tests
https://lore.kernel.org/r/20260921020013.33105-3-kmehltretter@gmail.com/

Karl Mehltretter (2):
  mm/damon/core: preserve the quota passed to damon_new_scheme()
  mm/damon/tests/core-kunit: test preservation of quota state

 mm/damon/core.c             |   6 +-
 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 3 deletions(-)


base-commit: ad8b9fe7a5021ee745b61d6d33254a69af65efdb
-- 
2.53.0

