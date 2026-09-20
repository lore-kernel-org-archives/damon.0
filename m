Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872523F660D
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907080; cv=none; b=Ei8f0viZsIYhrCbP5d17JtELTCOa6xCzrhBp9+KVlR1FKhyNRheqPYZcLhuFi4Pi0w6GGLexDBFgRim083bv+z+fgOKrEyW+Cmqd+00wG7gc2uTc9moPvquiXKeQi5HVjk5wUR1KTkoTq7BGeUAokDyRcqYUiRGoVB+1z+xJMWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907080; c=relaxed/simple;
	bh=X9og+gkcKs3FqJesjCqjxPxucohjf/RASztug2OUqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8DvwG1PYZWu5e6LGrq0pCZaGO7tRml8gp5AvoorrGIWl4Po1YRKW80XLes3yXabWxav8xt5bFODl/8iZStgbjdAbWj3uX1I47aWh1kquhvwN2fS/2RmKgY5Rqqz/V9RccTZDy8zU8cFLrbYmVg48AFudNjUosJXHVXjXEucxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdKdMtZt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdKdMtZt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1551739a91.3
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907060; x=1790511860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ONHA4wMDILxcRZ+Lg+d1Nlct6hNZeNgcOdxBA0gn77s=;
        b=XdKdMtZtXIZxDiu9l+wEQTeEW+3ZxfHHed5w/ZeFV+9qUh/ZM5ePwJZXUo4OHrs0Ui
         +3694XR4UQc3JhCGwwh90bgjh5MTSNyeZr/8GT4JFxh5KUQfgqsQjKGg4FzorgKMTR6+
         uvCUe39Bl6JnncingOafp9MZKKYiArclPCPAcxMKVLL15LCYEi29BhZMBu83pxDsXZDY
         UFvKUUfYoBdXkMk0kE+VaQUJI5yKH/7eLX8BDrUFeX30Sei1tZO+CZImYg/844Y6vY46
         iHMfA94w9MvFLDSxVDzc0NmoMKqsx5AoWmDckVFui7mGerboL2Y3wpAEvDLZ9iZB8Coj
         faCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907060; x=1790511860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ONHA4wMDILxcRZ+Lg+d1Nlct6hNZeNgcOdxBA0gn77s=;
        b=vWdMv5G9faQurIbyjnGyW7Icw3hF/gt+l2S/hFKDzb8ZPVt1Pv8H5hDVtyQLM+/H62
         Xk8He4FmfQ2FBSqy3heEQdKCs15MsH3VBD7FpOPvYAqVF4oIiDm1IF+FfIyLlTV+ywXr
         T3H1SmcyXiaczjXklMIef1RPxUFIJQHwlXJ1HHEAxwPgFaVKj7uPaVDtnOoZEhOyN9aS
         /ZP31/w7egEmmNx8raNOD9B5wFp0hzurvf7lL7fuWiHZy6yhrsFZ5ApU81CJiVK38a+1
         LiTE0gkaDBnKNB1F0xtcvbJ2799gDd99lnD+WRCYuzDPdIQb+PFsfs0Rcc5HVOdhElxr
         4ZxQ==
X-Gm-Message-State: AFuF++lC93CnmYgGYeSPqB4T5bha6KYt2OZhqohIf7SPzWP5ohsLV5Qp
	UU38c6sGdRW6F54udt6P870mrJw85T1Cbt9J3fb68rHTsENNnO6Jsuk=
X-Gm-Gg: AYBFou3KUgRn9Gic+gZ1OC0jKZqsgcAl52tobSc/vnhWntw81A/Bdp1AlvYtyPRDdqT
	raNuaHaHEYHVcdw6AoL3agDWhUsQRbuKF0wcJeLjLgh7jagKdTAyjIcSdRw7e5dBNC8da6IyXko
	aTXRT7VgzjqvUgJfpL8UWcl6sTIIusnButBlqjq0VDCUirSoUrMeqgRrTxnNTOZv/NifpdwG0fv
	jNz4V8O2Siug+hn4KoBMIkr1JCZReL4tCwJJ5Rbw2Lej1qc8qoOglwBRvLYAigL+3JphbQHu3nJ
	peUt58uMsEzYcu11gxqTbxcFbQDpxrLLAii3p/BN2NmYQT1xb6402QZA9q8l8hOl88xzD/uuy2b
	XG3RywgKei4OFl2jQfVgrkmBWlbOCdE2e3xA6u2r0o+onu3xijUEF/3hnyX00oO1Su+2cLUQOfP
	I6h3kBt0s14ti/h90sZSQMItAiExCLRbGOqbpeUzxxNfYxNjO1HGl1bAvr6jQcAWG2swtmQBQ+a
	l9slVsETaMbRNdDM8TRlnpnoW0=
X-Received: by 2002:a17:90b:1dc7:b0:39e:6c68:1553 with SMTP id 98e67ed59e1d1-39e6c68331amr8421991a91.27.1789907059964;
        Sun, 20 Sep 2026 05:24:19 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm8753943a91.11.2026.09.20.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:19 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 21:24:10 +0900
Message-ID: <20260920122411.610213-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
References: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
into basis points with "quota->esz_bp = quota->sz * 10000", both
unsigned long, and damos_set_effective_quota() divides the result
back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
kstrtoul() as is.

On 32-bit the product wraps for any size quota above ULONG_MAX /
10000, that is 429496 bytes.  It lands on exactly zero when the quota
is a multiple of 256 MiB, which includes the 1 GiB that
Documentation/admin-guide/mm/damon/usage.rst uses in its example, and
a zero effective quota makes damos_quota_is_full() true on the first
test of every charge window.  The scheme then applies nothing while
the goal is unachieved.  Other wrapped values are simply wrong, and
any product below 10000 divides to a zero effective quota too: 429497
gives 0, 500000 gives 70503.

Triggering this needs a scheme with a quota goal, the temporal goal
tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
32-bit, 1844674407370955 on 64-bit -- so it is unlikely to be hit on
a tested setup.  Nothing is corrupted and nothing leaks.  The scheme
makes no progress for as long as the goal is unachieved, which is
easy to notice, and writing a smaller size quota restores it.

addr_unit does not cover this.  It only scales the numbers a paddr
context writes to quotas/bytes, so a large enough scaled value wraps
just the same, and vaddr and fvaddr contexts take raw byte values.

Bound the multiply.  A size quota too large to convert now takes the
same ULONG_MAX branch as a scheme with no size quota, so the
effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.

Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
Cc: <stable@vger.kernel.org> # 7.1.x
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Measured on i386 under QEMU: one paddr context with a stat scheme, the
temporal goal tuner, and one unachieved user_input goal.  Each size is
written to quotas/bytes and quotas/effective_bytes is read back after
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

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2258b72da7a78..16d4145379a2b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3274,7 +3274,7 @@ static void damos_goal_tune_esz_bp_temporal(struct damon_ctx *c,
 
 	if (score >= 10000)
 		quota->esz_bp = 0;
-	else if (quota->sz)
+	else if (quota->sz && quota->sz <= ULONG_MAX / 10000)
 		quota->esz_bp = quota->sz * 10000;
 	else
 		quota->esz_bp = ULONG_MAX;
-- 
2.53.0

