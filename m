Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE663CF96B;
	Sat, 11 Jul 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793063; cv=none; b=P1Vj7zWBAHqOnvmPh2UV8X7nvL52yofGjZWrbIZj9S44PO+AHnw34yDJVVyw4Qsx5ieoW91XoVACYE62n/uzZb8L9Y6drAfBitzfoWVtp5A/FqLIoo16oDj7FiFIojY7/2m2litYW1F40olLkeiWNx2rpiR0IEk0LFCfl5TRElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793063; c=relaxed/simple;
	bh=nt1m4yOHpUkfhmuPI5sfQNBML1ejUt2LDcM7VHyWuzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LK9dJtV2sBa4SB8IFdEy4P/US8IFZVXx1ip5Mtzn5G7Sh7Y1SPf5pJzpSlI1X5KOzshSd6fza2f5xcL0uncusPmM4EwaW3Gl7gFmqvUJXup6iVtTMCEkc4Uc+z4uDipEbOGD/OAXG9I/FMgCsFvZq1Ll2/JYYRvig8Mf7/d9ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq8LOAv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq8LOAv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999F91F00A3A;
	Sat, 11 Jul 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783793061;
	bh=hhmDCI+ot7IL3VsT3pLzYBJmbk4njLZd345nGTc/fNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eq8LOAv38/JT//HvNVNFuX9mQYVns/QjBaRg4lFD6H13iiyHwdAqqGAHzowFBfpYp
	 TQ845vSB2U/vzHnithCWeTxZHU2L4LlQ+w4ohRPsP+z26/uQkgXKJqxWwF7prLpa7F
	 v8OfWijkA7lDe0BKpuxMaLmjq7HPpxf92RN3DuqjlxcCn3NT+Gu63ScjWp2C/hdYEC
	 BJjrA9WqF1RvbnR5DP1QYEhLqbnKaftOrbc1Bb/x/+npMXPDZCH0OFnE1Yr2GL2PBB
	 Dz3LKLleFAI+dUaGDHW7S0oF1Y/p+03h9hzlCS7svr+6fURFqcY4prI2uxh8l5Thdc
	 Ihs5v09i67MxA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/5] mm/damon/sysfs: read ops_id only once
Date: Sat, 11 Jul 2026 11:04:08 -0700
Message-ID: <20260711180409.82093-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711180409.82093-1-sj@kernel.org>
References: <20260711180409.82093-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
ops_id_store().  As a result, the min_region_sz could wrongly be set up.
Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, only monitoring itself runs differently
than expected.  No critical consequences like kernel panic or memory
corruption happen.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b5fe036f78015..60a1a9e4ada34 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2094,14 +2094,16 @@ static inline bool damon_sysfs_kdamond_running(
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		struct damon_sysfs_context *sys_ctx)
 {
+	enum damon_ops_id ops_id;
 	int err;
 
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	ops_id = READ_ONCE(sys_ctx->ops_id);
+	err = damon_select_ops(ctx, ops_id);
 	if (err)
 		return err;
 	ctx->addr_unit = sys_ctx->addr_unit;
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
-	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
-- 
2.47.3
