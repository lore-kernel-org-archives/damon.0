Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCB47ECD3;
	Tue, 14 Jul 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039759; cv=none; b=kdT7aMWrfo0uq/v70w7Pxy3/NclTLmmu863fpcP1MOjj1Ff0A6tkBiGVjXJxJqcZGk+KiwJeWKYI3CuY9ByXFVsFQ68hvuf5oegb/uuZriXn9+bjLx02y/AxGmE7ogFHDMIfrj6Ata4DTmoDwk68ifDhz7Vh5sw0jTVNgWbZWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039759; c=relaxed/simple;
	bh=UfuQFaQAE52zcf10oVu3LHduiT5JIasy1NGQTVWftkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/A/I/fJxD865KNl4ika0dmvAajYlBIXIAOHKbJ/1X5QN6yLfbbcI/fP+6g3W2wxtb9py5byl4VBvADJLnD/GMdgAUREyVzMpWAlaC5G/QRP5MTb6uW5P9nhhhcwIg2zsMaBdENwpesmHYOR00p5qcUkgrLUZmsXGewickSSVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2Rciwt8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2Rciwt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314151F000E9;
	Tue, 14 Jul 2026 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039758;
	bh=Nx5e31jEsyo+C5Jzh5WXWtwiWc9v5lBvS+tYDZCZe5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2Rciwt8/MTshxbMH0LSsW0OR5pxu4vbJGl88cl2PRUro+DUfPRKEYh7Vts9El31w
	 X8TbZ54j1otU/V0hjiojVpRFfLpBdszW/YtCED1ora5wJIx0lxLqL6Ow4CxGQO20ii
	 Mg6CyV3lXbGzoHAtXfHrB7lfOF5QnBFUR2EzQdWm8ibl7qgdvMRcayZiM42ol8lb62
	 7WGvox44qnx8rpsLk0YKFfM9TlYfXSd5ZJrZA/D3cgcMwkpTfLBYx3eR1FOKXxOmWr
	 Uv5+KueXbDIJ7Hlf4Fc5vreeym9sZajj3btVddDyt3mBHllF50x6qphpx/fDSexBOf
	 Lui7jPMAJhntg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] mm/damon/core: hide core-private damon_ctx fields
Date: Tue, 14 Jul 2026 07:35:43 -0700
Message-ID: <20260714143544.101305-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'ops', 'probes', 'adaptive_targets', 'schemes', and 'rnd_state' fields
of damon_ctx are intended to be used by only the DAMON core layer.
However, those are mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 537e59bfd7072..327f534696aa8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -848,14 +848,9 @@ struct damon_attrs {
  * thread other than the kdamond should be made using safe DAMON APIs,
  * including damon_call() and damos_walk().
  *
- * @ops:	Set of monitoring operations for given use cases.
- * @probes:	Head of probes (&damon_probe) list.
  * @addr_unit:	Scale factor for core to ops address conversion.
  * @min_region_sz:	Minimum region size.
  * @pause:	Pause kdamond main loop.
- * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
- * @schemes:		Head of schemes (&damos) list.
- * @rnd_state:	Per-ctx PRNG state for damon_rand().
  */
 struct damon_ctx {
 	struct damon_attrs attrs;
@@ -904,15 +899,21 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 /* public: */
-	struct damon_operations ops;
-	struct list_head probes;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 	bool pause;
 
+/* private: */
+	/* Set of monitoring operations for given use cases. */
+	struct damon_operations ops;
+	/* Head of monitoring targets (&damon_target) list. */
 	struct list_head adaptive_targets;
+	/* Head of probes (&damon_probe) list. */
+	struct list_head probes;
+	/* Head of schemes (&damos) list. */
 	struct list_head schemes;
 
+	/* @rnd_state:	Per-ctx PRNG state for damon_rand(). */
 	struct rnd_state rnd_state;
 };
 
-- 
2.47.3
