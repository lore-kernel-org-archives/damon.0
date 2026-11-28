Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795891910;
	b=fl3AOuhHxfkvvGpJVM8EMTcD3+TYgp7o5TTYeurtnXavrNIxmd6fVo2NeKvNP+7BdQT0
	 E0CrgKyAlFcje2md94tUqpvkz7P9dwIzcK4TjJyfYnVJiiH7JhcpyHqhWrKBgukDnURJH
	 AxuwVxqaee2+NRBhS8JD3jFKrveRymyDQnEZ12A25Lp0fGr/SICy/zDIpylo5ax+0gn2n
	 Y8biJqRVP1Psm71lEN29A9GrM27YNFvVv2evioqHILptlhDGjm+IKMFkwGDAVdDvc3Amb
	 cKIuUP0U7sLyFLB2Uy52xOlA9yPL64+qcdGjHAY0x6WvceStrirtjZ4IcA6GEj9qb/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795891910;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NJK4FZjTkQR0Vf248sG0688C05VsjMNRBdJJA/ZZflI=;
	b=sUYTeWs4ny+UzD1nDlUp+bRYNTyvpBb4XTBQNdELUm1RTHF9JrZrVWCjjh4Bdko10GwM
	 6JttPgySSkpKJzy+9f7PIo5gQ+b4y3PsXz6GDUmk7x/V5DVgjCzMFWQF+eR1kcKhW+f6B
	 E8/wz9Pf7+S0HGA3NRX4Xl7CBajscWSZVerUD751UJ18M3dGfDB6Fq1xMp6EkzUy+2YHA
	 KTCMvHVufyFXtnstX9yJpNuPMItLYUwFeygrEf6OoScRauXcHiH/CSmE6tummS974c8jM
	 HKjzXNe4M+5TtoUaNTQ+toU0/sPhL9KiZlbOsCu1KCeXWy2YfgUjiUezd+GvuF1wdnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGO6KIlI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82785606A31C;
	Sat, 28 Nov 2026 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGO6KIlI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2351F00898;
	Sat, 28 Nov 2026 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795891909;
	bh=NJK4FZjTkQR0Vf248sG0688C05VsjMNRBdJJA/ZZflI=;
	h=From:To:Cc:Subject:Date;
	b=TGO6KIlIMnyxYA7IQpVa0VLeyKn6SkcA75Bm0xfDiFyf89ShIJkaLTjp7PE6FUVH1
	 N/Mahy8lWTL8QndR3jfy5suR3vnPw8H72UTXkT19kqTRnWaqPLUowNILaclcOVkrYg
	 sIpjAav5UcNvPT6gb09Czr4/xOcf32PpLIYemebf+RHt3sudTDqL/G1dulxWBYKR2d
	 eyD41H4l0/krfHsbOGUVqOtLZ09zQ2FFlaPxdGzN6KQZ00EfINZb/E4DroERJ/YHs+
	 t0jfy6JVavnsbTcrqMz7G+007N8mW1A4cONqHlAmgJL5HSSiwUgQPrC4/D6KrdRXr4
	 6SzPwzyH0O0Yg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH mm-hotfixes-unstable v2] mm/damon/core: do not update stat for core filter rejecting region
Date: Sat, 28 Nov 2026 10:51:39 -0800
Message-ID: <20261128185140.163079-1-sj@kernel.org>
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

damos_apply_scheme() update stats for regions that were unable to apply
the scheme due to the quota.  Those are counted as tried and failed.  It
doesn't update stats for regions that were rejected by DAMOS core
filters.  Those are counted as not tried at all.

However, the DAMOS quota-driven failure is handled before DAMOS core
filters.  Regions that would be rejected by the core filter can, hence,
be accounted as tried and failed.  As a result, users could show
confusing stat changes.

Fix by handling core filters before quotas.

The user impact is not critical.  No crash or leak happens.  Only the
DAMOS stat could occasionally move in an unexpected way.

Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos filter")
Cc: <stable@vger.kernel.org> # 6.6.x
Closes: https://sashiko.dev/#/bug/linux-9c51890e-a25c-4534-afab-ef33f22a9557
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from RFC
- RFC: https://lore.kernel.org/20261127203938.94339-1-sj@kernel.org
- Update 'sz' in damos_apply_scheme() after the core filter handling.
- Rebase to latest mm-hotfixes-unstable.

 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e6b361f97ea..38444a9f0500 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2785,6 +2785,9 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	}
 
 	if (c->ops.apply_scheme) {
+		if (damos_core_filter_out(c, t, r, s))
+			return;
+		sz = damon_sz_region(r);
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
@@ -2794,8 +2797,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 			if (damon_split_region_at(t, r, sz))
 				goto update_stat;
 		}
-		if (damos_core_filter_out(c, t, r, s))
-			return;
 		sz = damon_sz_region(r);
 		ktime_get_coarse_ts64(&begin);
 		trace_damos_before_apply(cidx, sidx, tidx, r, nr_accesses,

base-commit: ba13b07abc534725a32302825071f2c6bd26b033
-- 
2.47.3
