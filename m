Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534231;
	b=yDAfEVIZg8wxdbk0NGFaRR2SVoVf/PmS/EaXML61qQQLOsWT3W8tEm1QZ2Na2KcMoTsN
	 d2z+oxTWk5IntufkZAMAc8lbTIxdtij6/NmmqYa1TOUfuTbaWfZe89YWRvkkZ8mzQX69l
	 HTSX87yh2u3g8DDpq9GiP19/m82FAG2W6gzeq33n21E4VXyhWFrayWC35q9W8X/w8Pjb0
	 L3zXoLZJ5V9IaZQtTP3Hx6F8NiSl26lOXVq0FH72iorsCU30MD+UyTcLTHEm7ng+Y5cMe
	 w4kDSj4sAkdvGBzn4pXUKM2cdaJlDjyidAXaJgc+YJ4ZDNV6/l+l9N6wwFIlR2/N0Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YNJQNexJ9sGmKCM+KVg0pSCkZeSfpKeIkM9/59mzZMA=;
	b=wqkS3oZSZxV9Fvj9K0BWMOL/vQmX1p205s2Vhxgba+FD5qB4Wn4r7WC1qyw9xZFJ7Ru5
	 46YQYyJi0lhEUQWbvfGimIeme3YX3N6NdE3qG00kv4nXhOyt7ciLOq4Vz27NTjqmyvbCK
	 ASKSRS/Uv/6TApe34iYqorafMwpHBzgrvOK6o9ESxoX973KEB05ZZJ5eimNdaZLcc/wj6
	 RSKnFkqMK/GSXUHcgx+DL5ahDMyhbtdx/NqLhr/Q4Rs1ihZVN0j6O9aHvVHzs2UcSvAdC
	 uwEaRMUiiqzc8hYymMV5jv8Ini+08Ly5KNSRRlnO7g2j2eEhoEZF9jIHo7svnJMjMMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCc96uiP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE381606A32C
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCc96uiP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F0D1F000EB;
	Tue, 24 Nov 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534231;
	bh=YNJQNexJ9sGmKCM+KVg0pSCkZeSfpKeIkM9/59mzZMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LCc96uiP/jxFA64O7qCvVAkU7x7Re4xeHrysmsYh4xgoQDNIDzJApLsX6QP9kF2RE
	 BDX7Ez2Q0ML5sUmFU6S+D6ZbFYrOo3CSeS5ta6iPQuNtxpG1THQqCuoEZHTv+vcaDz
	 QuqioM1JN30LBDx+zJdbnIxfzaY+wKtOOWUjeB5TpHJc8GGNDXGGHz27FDevHTDo9W
	 MGIB/mSgV6qXy/gE4JTHsHnu8ds3haHqZxSUr73SqepQT2cIkYByVjJiun9xOMMU0X
	 iIOPAAffsViFf4VIdpTXcWWX8/C0DoJLSNDYO6cUoobZZ53TuSW1RKIqeN6wR3UfQY
	 4wlqJWxC9o51w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/core: skip apply_probes() when no probes are installed
Date: Tue, 24 Nov 2026 07:30:18 -0800
Message-ID: <20261124153021.90142-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153021.90142-1-sj@kernel.org>
References: <20261124153021.90142-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

While measuring vaddr monitoring overhead, I noticed that kdamond calls
apply_probes() every sampling interval even if no probes are installed.
The vaddr callback walks the page tables for each region's sample, and
paddr looks up a folio and takes a reference if it can. There are no
probe hits to count in either case.

Skip the callback when the probe list is empty. Ordinary access checks
still run, and installed probes with zero weight are still applied.

Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20261119-damon-skip-empty-probes-20261119-v1-1-ec3e81c1f26b@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 649a4ac968abf..74058af5567fe 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4105,7 +4105,7 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
 			max_merge_score = ctx->ops.check_accesses(ctx);
-		if (ctx->ops.apply_probes) {
+		if (ctx->ops.apply_probes && !list_empty(&ctx->probes)) {
 			if (time_after_eq(ctx->passed_sample_intervals,
 						next_aggregation_sis) &&
 					access_check_disabled)
-- 
2.47.3
