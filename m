Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242611A262D
	for <damon@lists.linux.dev>; Sun, 30 Aug 2026 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071518; cv=none; b=gBv7wfCSXGx6zKtFiYwhf19h4FG2Pc4aQFnaDcQ0LiIAvFXTTb6SFs0HxrYB5oNijXToSL/M9e1VpEt8Y7SKk80lWiY1asUnQVV5X4uCPgmzVmll5lblv+GhTl8klTz2zguSfjR1fLj2HBxeQzrTMj4CAACpWwbKeIe8EsHp2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071518; c=relaxed/simple;
	bh=cjGZh6aJzF6tvnNxut3Za7JYORBuyxbP4UJEMgWdxxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj047M3Mo6dVhR3NurgJmWyVUPooFl7Oh3KY6kCIe5Gm8eGoRBkTVy6xDKQTiweZajykXGOyExfgv4C5VroBoAiQnXkRZoGM/ne0cM2wrZ5Fol+LJ1TIXNNgR9PoQhPOMT8kjZh0MTnS6HyQ3oKnkK66r2Qz54dVT0yAukj6OMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUvo+889; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUvo+889"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-395cf2535acso2338902a91.1
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071516; x=1788676316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QjCEjlQx+exRVLDUDevoSIURgdv5YYALfDraYMLva0o=;
        b=nUvo+889tTtxmTsl103qtqzAWml8wgLuMNtYT9XxoKcxH/KBPWqTTpluiln9iLWRuD
         zvgrUmhffqRBcU7a61Oz0FGLMXgBcVeLqTlWkwcQSWY2CmBvuPXhxQHjlzOKmP0Pu+gP
         hc9jftb/EflhGvR7CQW3PwAAU7WTMOE8z6bNs/ItLQFJcWqMEGW5RAkub3P2V2HuMVUG
         dw/RevR5jHCHm4KpLjsAViu2DZKw+u9LVSMOdEdLRUQjXFRZEZtI9uKLkdRlbhVCx61W
         RCCSS5xiHqo4DZ2FPjtalZv+msy8pOsIHXi4d4BeJ80ukQVu6yota/Z6p1ldglvQDNVW
         s29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071516; x=1788676316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QjCEjlQx+exRVLDUDevoSIURgdv5YYALfDraYMLva0o=;
        b=O2NdZSX5y9zmOvK1J2Hj8L8f2sBgx5DVQbVp/lz16YGAN+9ekEKhaDzq0MtLZNAJIW
         vnyY87XzSHuWpoiFyrZ9z9jnfBQTXBG/HBtbi66ZWW6JUXlh6I1w85LlGpZl3ulXWNFh
         2SVtGjqucACjKzFSQ6gHqYQRMKZOTpp49T/VmbS2vj2nlNa3z1BzdzCzYC9Dz2HH7RJ8
         +ehGK/IwKCczb/3w3erJ8TULc3dX+MryrNZrCMgFD4tb9Ojc/v64hBz3bUm/EayrMUQf
         SiAea27tTqoqlWALFEy5H5HyQG8ZaA7DXQKdKmBbw9qDR5xnkv0pVgpM0u5brs7G1O7G
         3MYw==
X-Forwarded-Encrypted: i=1; AKwUvBye7NeHCv/PzIrMufFu6GFyP0mNvj0XyE5Pc+isl7uB/2VG+uv9rmENqG3z5FKK65VzqKCTUQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n0ofcR1XopDTpCbtnUTC1vEqibP1DTneDVciK/m9dPOlRPbZqu
	3sIrmykYQsf46Jgv8Jxis+yIJJRIx4SmSm6GU9nOKTEATGemOXmeP6bP
X-Gm-Gg: AYBFou2fOv+9JbuLkugFUawwkso9MfTFzLaorja82v1oDxKtpyTHzy71HXqXUIKm1Hs
	15pc8WRLyFp3XKOxaetCgyjLk0rDG0XCjomCUbdkIxMMNgCUoLxs2uzMLIM4YROOJE7dXSEa2f9
	VKDqNkpDM2w+ZeusdzGUkZxAs+v8R51P8AjSCaWZVeiaHPxev0TDp92ZkoSDfW1EZEuS5T4yYeH
	cdyv325mDQvNs6PIfdeeihRb+oZkMXqun1pUfKb0zmFubx0KhXEYfoHBsUDiAuOaJEVs4UoGk3B
	SXb1gXFFpCySSko32Dfw0A5Ulku5gudMwL66ytCmZw1D3qX5vn2ClBycjvoBDfsgblEuO9j4ROv
	4FFRbyKJhkPp2P9OUdRNKX7HzdnaZ5iK1UDKjgwsk4PZnY32eBpfBQLbt85H3EmLzqaFs/svkMz
	OtIlHbmllYzXojeb1DULpdyvbAP7KFWHAjUe+yjMxTq/VeWoLqpwMAkUVa8n7sv7HEgFHs681bR
	NrjdyiGHW9FruCs
X-Received: by 2002:a17:90b:55cc:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-398da65a974mr587978a91.8.1788071516309;
        Sat, 29 Aug 2026 23:31:56 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc0c703sm10079411a91.9.2026.08.29.23.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 23:31:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 14:31:50 +0800
Message-ID: <20260830063159.6347-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can
be skipped even when it has not been processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 100 bytes per window.
    3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
       addr}_from is saved at (Target, 100).
    4. Window 2: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the charge_{target,addr}_from.

    Result: R2 is permanently skipped even though it has never been
    processed.

However, it is important to note that this is a very minor issue.  This
is because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except
the last region were skipped by damos_skip_charged_region().

Fix this by only resets the charge_{target,addr}_from when last region
is reached, only skips when it applied or cannot split.

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # v5.16.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v1:
- Simplify example in commit message.
- Add clarification regarding the severity of the bug to avoid causing
  users unnecessary afraid.
- Modify the patch code, each time the last region is reached, only
  charge_{target,addr}_from is reset, but the return value depends on
  the situation.
- Modify patch's title from 'mm/damon' to 'mm/damon/core', since it only
  changes core.c.
- v1: https://lore.kernel.org/damon/20260828084737.290024-1-aethernet65535@gmail.com

Changes from RFC v1:
- Minimal fix, only fixes the issue where the last-region is skipped.
- Add an example to the commit message to demonstrate that this error
  occurs very rarely.
- RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com

---
 mm/damon/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..fb76b530bbc6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
+	bool skip = false;
 
 	/* Skip previously charged regions */
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
 			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-			return true;
-		}
 		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
-			return true;
+				r->ar.end <= quota->charge_addr_from) {
+			skip = true;
+			goto out;
+		}
 
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
 					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_region_sz)
-					return true;
+				if (damon_sz_region(r) <= min_region_sz) {
+					skip = true;
+					goto out;
+				}
 				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			return true;
+			skip = true;
 		}
+	}
+out:
+	if (r == damon_last_region(t)) {
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
 	}
-	return false;
+	return skip;
 }
 
 static void damos_update_stat(struct damos *s,
-- 
2.55.0

