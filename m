Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27725377015;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188708; cv=none; b=fGkP5MgU1mroIc7y0iyZscDjQ0fZvjBKwvu5Yth/AAwwUGIhVjmV6u9AfbNdb1pyKfPOoTppWRuQyEGfqyedn/b6Vb0Q5d6oHov3EX2ktoJn0Iqm9gyfIuYGde7CfcaqIDfZaWd8+4Zl0n/mF1jtXe+LRIYEB6+lTzLAA0OmECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188708; c=relaxed/simple;
	bh=nbWAQRgqNy7FMFTkYigKuU7k9GA0MvfRwmrkbBkw1/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttmVBOlscwsE8Eq0n8Q5Rx0E9vpAOQP1ji8bVPlezIpD1nDc4ppobpk72pgvLnlJJeE2SyCt8IxQQTwExCmjvet+63FJeaEUeq1WAPRpHqH3yR9GpLhm/6UzmrsSDsUhzpQJCxkylBifMJ3weUcWRheuQs+1R95AOY++DkOnTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxgyzLj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxgyzLj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C427A1F00A3D;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188707;
	bh=h0Px2pc5d57ZghupeXW8ij/6164Zuz/qXDwibedUcL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZxgyzLj+MBt/efF+VjBrUc09pF0OZcufMkNpkBjceDlB2aPG/3aJv3N8u4SE5Ek1e
	 DbPYt8ivSd2IZzrqKgLqbpsUFJzkC/cH+n7TIsPCaFXr+er+yTEYoQ+fErR6gxmmMx
	 Di0khw5Wa7d/HU01KjspUs56sOeUjeo9qGErnh/+tb/kasjjYUi7rqTiZWYkAjqWqN
	 YhDvgVQCgpzbsKfHh5D7He1YuZ8CS85dfQVkWPcaayYBgcpjFZ76edf/fmV9Ai7UfZ
	 guxxxpFXxZcVNK1qQrWN/p4Zxh/lwGxXiKqc3MqErD3V7v58o1zlpLruA7S6j07c1n
	 nMw9+NE8Fsf+g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/11] mm/damon/core: change damon_stop() return type to void
Date: Sat,  4 Jul 2026 11:11:30 -0700
Message-ID: <20260704181135.132956-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
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
index ef40aa44850ff..1a6c30ae91711 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1946,14 +1946,13 @@ static void __damon_stop(struct damon_ctx *ctx)
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
