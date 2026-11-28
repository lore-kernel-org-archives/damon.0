Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795891399;
	b=lGAy63NKius2vQDaS7Fc80eOtLy2QJ/4PDJFOpDyD1a17PpLPI4zuwh2ujuquEq4mSak
	 8wd9v+aNvxgyBagrbkAyB7EfSnUnu9eKKBR+6B8mxSCifFjqK5z8fys357augHj/7yaJl
	 6uE4ZWJNy6kFw2Xc4xT8uU5aGqlTcu572f9cRdvEa0MVugS3cNDsaOFuwyA1IHZxqg7pL
	 0clXZJxlzErJmrQX8CqLEXfAiNBlitEe0m0/kIZA6Cq8bcpvoAdjbxaZVIvWeGE/kV6F5
	 cfUdreACCSag4SMQ7j14FEhM0ImKtkt2NSTh/CH37Z2zxgweo0/fkYfZPvFopj0Aa2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795891399;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s1VNNE+MSsSM73sLX08PD2FQxgs2sn317vmT34gD7fg=;
	b=E3RTCGE/IoPWbE+sylQB+25H06mnUbZyG5tr1JfEC4/643/qbhED5/G+3AnsxEGLGvvM
	 cRBoZSA0Uy0/p3VLbfn8kpJ5/uCciUni9KP7DZIcYNJ4QKsskzLy8N81SpCOwgr9KIci1
	 OUAVDFGkIQCpdzzkQCHUiG8Yj5emAiFVIDgFdoSQIggzD0tcUndnCIdXCI4iRJZOf9/v5
	 L28vrUw9GgCpivNZcRM7LQuHpxszTXI+g91dUhYQKdeASi7kgqM6pa2wg5WKvoEijtNPz
	 yY/8f9Qo2VM2BTAwFx83k5tOTyssr2ORKZVzuYD0xAD/JmU4HFgU8SljnEmcD9h3y3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAuaGLF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE4606A31C;
	Sat, 28 Nov 2026 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAuaGLF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D881F00893;
	Sat, 28 Nov 2026 18:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795891399;
	bh=s1VNNE+MSsSM73sLX08PD2FQxgs2sn317vmT34gD7fg=;
	h=From:To:Cc:Subject:Date;
	b=aAuaGLF0A20VL9GHNvN2+rrY5v5WwgFOf6nnhBVofXfoDPPNTQyKT66LLhJVGqRRi
	 ZlbdsxNc1ZbplWYnGOttbw/bbXKOUFlDzBurAysykNAdgsGGaG4gA7G9z2+XHDgSSw
	 9AeeW6OMcAHDVSv/Ww5rG/tahDqOH0Go6W07WLGr3PQqjsfoBGBsZzaAeBQE+6C+w8
	 V4sAXDOiPg6Ds4BZWNJP5UZ1nbOu/a+OAhNuZ+NAedF1uVr+vpXKc+8iAA2bHHvtKa
	 8R4pklvqWMmv+3CPC4Kmg2+rvcswE4EDfyDfcJ2qrRe8+yd2B6Mq0C9MfK6fhwSTw8
	 u+Re7QpIRIyJw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Lin Ruifeng <linruifeng4@huawei.com>
Subject: [PATCH] mm/damon/core: let kdamond freezable
Date: Sat, 28 Nov 2026 10:43:10 -0800
Message-ID: <20261128184311.161492-1-sj@kernel.org>
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

DAMON's worker threads, kdamonds, are not freezable.  If DAMOS is set,
it could migrate or reclaim pages while the hibernation image is being
copied.  It could corrupt the resulting image.  As a result the system
could run with the corrupted memory after resuming from hibernation.

Users could work around by stopping or pausing the kdamond before the
hibernation imaging is started.  But it is easy to forget.  Just make it
freezable.

The user impact is quite bad.  Nonetheless, the problem is only found by
the theory.  No real issue from such memory corruption is found and
reported so far.

This change was originally suggested [1] by Lin Ruifeng.

[1] https://lore.kernel.org/20260408080652.1745410-1-linruifeng4@huawei.com

Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schemes")
Cc: <stable@vger.kernel.org> # 5.16.x
Suggested-by: Lin Ruifeng <linruifeng4@huawei.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20261127220255.99924-1-sj@kernel.org
- Rebase to the latest mm-new.
- Drop RFC tag.

 mm/damon/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e6b361f97ea..f421965d1f58 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -7,6 +7,7 @@
 
 #include <linux/damon.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
@@ -3845,7 +3846,7 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
 {
 	struct damon_target *t;
 
-	if (kthread_should_stop())
+	if (kthread_freezable_should_stop(NULL))
 		return true;
 
 	if (!ctx->ops.target_valid)
@@ -4056,6 +4057,7 @@ static int kdamond_fn(void *data)
 
 	sz_limit = damon_apply_min_nr_regions(ctx);
 
+	set_freezable();
 	while (!kdamond_need_stop(ctx)) {
 		/*
 		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could

base-commit: ba13b07abc534725a32302825071f2c6bd26b033
-- 
2.47.3
