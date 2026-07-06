Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D57379C22;
	Mon,  6 Jul 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346801; cv=none; b=eUZaWalUQNf1mE0GeSOhECddHuo8k8TFoonCJw4FRKqerF5VK4A7t7QCLujobkxmWk5+QOFrEUTnRn42Z4YDEX06NfRZvhzXisugS24eFOdPajQGxVr4u3UOIIygpEsijvEmCpSpr4HXJ0FSl5Jya8ncrY/qEY8awPeUqd9dqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346801; c=relaxed/simple;
	bh=qA7aEmWvsXlBb5CZ0t0+ivvSN/TApACptnrIMsBXxj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/WiZnqlwLP4HL0bBe5ZRuBS9UQ4KeqA4enod0cGIiV+ZMvQEa+CbJ3+OkTZ8xYjVefeVz4PbTDZY9oDBu90n9uFXSPGfU7NzvGuTz6tpOGHhgKEHUgUFJf0pkpJodNo80LyXIQJOMUMTdqOFGl/Zv9eO3pSC5qcwZuGXxqKHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP8jNnzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP8jNnzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553B11F00A3A;
	Mon,  6 Jul 2026 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346800;
	bh=h+1wlgb4/vhq8hic6IHVay1RAoaGPrWWDyvHtZVfeMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nP8jNnzrHQhO/Sl4txrZ8a8G2rUVHvePdgstAuB23HFpv2D4bFikH4S7qCc90yVSF
	 y2yvzD4XdYqotlnODfTDIIjPgP4E9BMqbZLehKJUotDaYcC6dBaAZZUoBVqtypgzp4
	 aacA/K5pO1Gq2qgTu9lw+IO9lGN8eqnhYqutPyzc3NWft4uWvciRQehh2VvS6Jb7LT
	 8m56rff6My4FdWzUg/LB0iTBUvNfezd7RRmGT0FXVCPqxzaEk5Q+OC+DBXI3h2LJ7b
	 9jAynr5pHpRq8ua6h7Fun5wFVBaBe3DK7pgbiDmZVgjeWsjanT1nvptrbJdgvR8vWj
	 DJPBnYCdBwiyw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] mm/damon/core: change damon_stop() return type to void
Date: Mon,  6 Jul 2026 07:06:22 -0700
Message-ID: <20260706140628.87414-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() always returns 0, and nobody cares.  Change the return type
to void.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2661231c0ae82..19b7e839bde0b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1070,7 +1070,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+void damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
 int damon_kdamond_pid(struct damon_ctx *ctx);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84e400aa4e823..08510bf9b38da 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1947,14 +1947,13 @@ static void __damon_stop(struct damon_ctx *ctx)
  * @ctxs:	an array of the pointers for contexts to stop monitoring
  * @nr_ctxs:	size of @ctxs
  */
-int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
+void damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 {
 	int i;
 
 	for (i = 0; i < nr_ctxs; i++)
 		/* nr_running_ctxs is decremented in kdamond_fn */
 		__damon_stop(ctxs[i]);
-	return 0;
 }
 
 /**
-- 
2.47.3
