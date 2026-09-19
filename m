Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8BC3955E3
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802017; cv=none; b=ojmqr41c1yh013Y6SAckvAUFK+CnvLsUL17IaXgrp/fygrnUH9adEMJd4eFp+FLe2ctyTCuq65waAc36SErgN+u6al9zlz1pnhjd5LGlkl9w9L8pWMAlTkHJQQuTuoQaEME2DG7biHjcierLHfNndMRba4mWZHNdgvXZK4NcidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802017; c=relaxed/simple;
	bh=tCJZ0sGm20CQt/SDkdnQQGWtqC2TWAOAbuUKE9smfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R072rNZD24J13SqZf8mQQA68qktWxf2LJoOf2rEXI1FEfjUw70k7+94zmd3U5YD211LYmTXTSWb1kWVl/ottCfJoPzUs0EJTGMm5RYE09jo3t72mQzY1DYCVqmqcmFq9byYWvY9jY6L3hezuX9X+vlAqW7Ejv7o5CxLUyTe1slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcMHJ3XH; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcMHJ3XH"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1618868a12.3
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789802014; x=1790406814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7zSksbU63dtRbVANyp6hQdrkXI5XkDjvPOFv3Zg/ek=;
        b=EcMHJ3XH5v81vbYfT1ujA+0spZcJKFf9i3H4nx889zFhHT2QYwS2C3J97l8c99djET
         TPPP9sYsiKEHCj5S5eB0uOSbR5egiGns/SPsp+Uv/S4UCWDAShYvBj5UCxe/17mdd4oe
         0Hcptt3wVG9XdoJMdFM9TWWMs6mgt3zY9sVBoG/jIF0FAn2fqK1QFf6UuNv+/tomCO3M
         bnfZ3F+8zoVPhXrfJa9jL/3xA0BXVlaic486JIcABqkdqDiLSt1Tz6+laM0DD8TmI8CK
         ykqscima/k/z4u2ubF3Hn7E3lqpbdN/TylhipHySBmN1Bijrq6cBgYmi5BscfQ5s6NMI
         3jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789802014; x=1790406814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7zSksbU63dtRbVANyp6hQdrkXI5XkDjvPOFv3Zg/ek=;
        b=pb2HhRo/ZM9kcPRStHZgw5dCWMsc8OCKXdZB54ZaqWgcCIAbY7jEkQsWvLb+3d80+u
         Mawzax426K2dfUB9emri1Xv0UAW/zZrtQG2ZuKJqtld77+1ziJs93UDgfjEq97rVBoFq
         /G2KAfZU/vtzYz1058nsa1isX0BIlZ2l7ieZxgSsNQvaqrytpFs+sGRpn5afa0xT6c79
         6TorwjIKZO7jSNXTX0YP2/h+P7qdxDf1Sl7DF577DlVEjoY9H/Yc009Y56Rm3K5ZE+zE
         HJ2T1u8+1J5p1uzWdMEBmrv21Tfbxs2IwN15TSAtarnwHWn2w9fxMSImVu26DezoX0GD
         9m3g==
X-Gm-Message-State: AFuF++lwDafzaZEG+TpaIdeQmwR71eJa4JOj3RFpMVTleWAKfhu2nAgd
	kkBvFfRmbzKWBAvPVVaSa8fbXg8Uv9M3K58tT2A3Ydkg2GKXlX80OmQ=
X-Gm-Gg: AYBFou0+ZM8Eh6rCHx+MuOkeF517x2Rz6+XrhiwXeoVAC96m2RPhz4ewhDvMiSDC8J9
	vJaqA+MSuW6nfwIvjR+aa3dr8unHGSMGWUHBUwtvwWKugwbJEM0e+KIxkVuEPtnZrTExEL2JEsr
	xu4FsCBP8cFkhztzOYOwfbhd1lgrhLH/TxCQEY4DRGumYtWR7x6QHWj7pEyDmhKfKf6kxCjEcxL
	eAsaztsoaUSZcMW6xNCWMlzM/qig65Ukv683TmqIg1MURLbjCV6bUt+L5Y6kiBT8T3tnVNJkCHw
	rx3z8vdP3M4J4FGFXfTSgbaaK45J7qVafkZjhfDirHqdv+xZ05NFu9L0+fqxU7FUnjaYpu2Szdq
	8tEDecg0v73rrnuPeKTjx2vDT+IvUz6Aq+Cb7kHQZX6PQ3P4SiZAc55Og/QydMVs2LmQNlDkFEY
	O3y1wX7ByhJYFCd1V6wqck6KI7qkYhQhBM3Cw2bY/SURbDBwWCT4RUKKdzBZm7GQdSfKrHCQqi1
	m+BTn8vF/XPS8LyVCnAlAMsMX0=
X-Received: by 2002:a17:90b:164a:b0:39e:4d7b:b247 with SMTP id 98e67ed59e1d1-39e54ea66cbmr9161582a91.19.1789802013941;
        Sat, 19 Sep 2026 00:13:33 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:45e5:9e39:6356:6164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm1050170a91.3.2026.09.19.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:13:33 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sat, 19 Sep 2026 16:13:23 +0900
Message-ID: <20260919071324.1583280-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
References: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota into
basis points with "quota->esz_bp = quota->sz * 10000", both unsigned long,
and damos_set_effective_quota() divides the result back by 10000.
quotas/bytes is unbounded; bytes_store() hands it to kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX / 10000,
that is 429496 bytes.  Documentation/admin-guide/mm/damon/usage.rst
instructs "echo $((1024*1024*1024)) > quotas/bytes", and 1 GiB * 10000 is
2500 * 2^32, so that documented value wraps to exactly zero; 256 MiB and
every multiple of it do the same.  quota->esz then becomes zero while the
goal is not achieved, the trailing "if (quota->sz && quota->sz < esz)" can
only lower esz further, and damos_quota_is_full() is true on the first test
of every charge window, so the scheme applies nothing and the goal is never
approached.  Other sizes are wrong without being zero: 500000 yields 70503.

Saturate to ULONG_MAX, which is what the same function already writes for a
scheme with no size quota.  Widening esz_bp instead would reach the consist
tuner, which runs the same field through damon_feed_loop_next_input(),
unsigned long in and out; bounding the multiply keeps the change to this
branch.  On 32-bit a large size quota then behaves like no size quota
rather than like a dead scheme.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes, the kdamond is started, and
quotas/effective_bytes is read back after
update_schemes_effective_quotas.

  quotas/bytes    effective_bytes    effective_bytes
                  before             after
  4096            4096               4096
  429496          429496             429496
  429497          0                  429496
  268435456       0                  429496
  1073741824      0                  429496
  500000          70503              429496
  4294967295      429495             429496
  0               429496             429496

Everything the conversion can hold is unchanged, and 429496 is what the
no-size-quota row already produced before the patch.

Patch 2 pins the same boundary at ULONG_MAX / 10000 and so runs on any
word size.  Without this patch it fails on x86_64:

  # damos_test_esz_goal_temporal: EXPECTATION FAILED at mm/damon/tests/core-kunit.h:1959
  Expected s.quota.esz == max_sz, but
      s.quota.esz == 0 (0x0)
      max_sz == 1844674407370955 (0x68db8bac710cb)

 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a7..5ec476cef4db 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3274,10 +3274,10 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
-		quota->esz_bp = quota->sz * 10000;
-	else
+	else if (!quota->sz || quota->sz > ULONG_MAX / 10000)
 		quota->esz_bp = ULONG_MAX;
+	else
+		quota->esz_bp = quota->sz * 10000;
 }
 
 /*
-- 
2.53.0

