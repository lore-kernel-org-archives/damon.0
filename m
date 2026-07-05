Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4826B95B;
	Sun,  5 Jul 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267315; cv=none; b=GL6n6EV5BgncPNn46PAwef8sGi6GejIPdbgXbVqUc1REvU/UJXbZAIBZ2TzaIcF8mfHodiz9OYheTADqsVp4fCgdz/FZoidPffE4S9Lh8NkpIulkPkCFkuvReRG4x9Df0+bqlrF4fdJ3gTrU/ACmIZxi/XA3fqCG6KnSBaj3FJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267315; c=relaxed/simple;
	bh=zw18eCF9o/kXw8UfeN/aNgCviJlDOibZN7c7tPL19WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyeY9V3adfaC6sCzAwP7dxmbgzQcg8Mj4kurttA5mbRTsoF2phM2/4H2HvVMAUr1hJ0gQRxMiZsr9xjwGlibg4tA/sf1ixLgFFa5cFKYrXARg+6wZnbtsLFNqb769jl/OI/3nGXctGxE9tI8p9iQsa0I5YcTkNZYc9Uz12HZ3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROAUPDnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROAUPDnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E1D1F00A3D;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267314;
	bh=XifFyfJolobUF4kXii9SDmtvZzvIFxqywQe1D4fl4uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROAUPDnF7g0SVKc8EEVwSnzosmZw/JCYYDGP+2yL4GZHCFn/CEjsT6WKOgsdKyfJG
	 1gFiY4VHLhDHqrDYFMTGv1G1Pnx8bIdV30W2Y+ep5A7sU4LYSYeZQioRr6kRczBfTo
	 q+3KKsd2uX3MqVJhWnaEgHJ9vJ7d81HZSUr+UYj3B4jlkXWLYF5yftLsRul+BSQQQe
	 behg0MoGVRcygHTV7U7lSsRMUJSq0Ni1LpV7jWyW3FL9ePZUOyFPTHpCoFy4iD9auC
	 /NuqYH4YDk7w1ycxwIgipgPvywioO6TxJT61autgeR9MfxQXIw7XpscQ95W3/EAvP9
	 QtFzJQ26E9PIw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 06/11] mm/damon/lru_sort: ignore damon_stop() return value
Date: Sun,  5 Jul 2026 09:01:33 -0700
Message-ID: <20260705160142.97308-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 2dd0cd0d26273..e8c389ad3226f 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -409,8 +409,10 @@ static int damon_lru_sort_turn(bool on)
 {
 	int err;
 
-	if (!on)
-		return damon_stop(&ctx, 1);
+	if (!on) {
+		damon_stop(&ctx, 1);
+		return 0;
+	}
 
 	err = damon_lru_sort_apply_parameters();
 	if (err)
-- 
2.47.3
