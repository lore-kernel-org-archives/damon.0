Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516F2EDD6B;
	Tue, 14 Jul 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003686; cv=none; b=onNbKxHtXNIcNJQ1C02AK9pbKHkT4oxyY5ASdtKZ5YjbkoNGJyB8t1k6KzZcVwUuwEBnp7rCVnSCxAyCqIpS0Hj+bzhvdqIbqTsb0QNn1fZr4RkVwCspXDASGAWnPkt57SdIe2PR5njrx+TKhnF2s5V2kCNFW0WIl0yfD93F3eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003686; c=relaxed/simple;
	bh=UfuQFaQAE52zcf10oVu3LHduiT5JIasy1NGQTVWftkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsLRX4jrQhfFcLASe/+GeE6wld6qX8mVxGIokcWc37AnBkHUZh8IQ3xeYBhCnobxEcovJsDGvn0dCmQiQ6axy2KL1m41FZoyjyI2GhNItWwWQVIoH9arYA8K3ZQka2l5PMdZNjMUAj57a65X9NmxWXh1UHHd8m64xA0UYoX1aWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkEe8e3U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkEe8e3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A87B1F00A3F;
	Tue, 14 Jul 2026 04:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003685;
	bh=Nx5e31jEsyo+C5Jzh5WXWtwiWc9v5lBvS+tYDZCZe5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LkEe8e3UTZtu/dCxbCA9jUo0qcEklu5uKbpCJX1k35d8t0paquV8tRgmoEkqPO1Ma
	 FQCWvJ0ChNjq+V2aoC86L3SFkFxnHaY7gfcFgB+9f/Udy2WkSldao2xE60CSM6bAgh
	 v+sot+OTbqguCtNuaYDQG9EOtx4+Kj4sGmvBDt3l9PvxoC6JKKMPoufbcOPpJY1MAX
	 +8SIikf9AhD2zYpEJPINKqaAARyOD6aapQwUz64A9QQ69MHX/PKhnmEQEV/OwtniN6
	 XxQKChVCZgdHzw8yTdJIxUVs0jSu5s9NY9V0FfDZj+L0L/0TjTitxX2YXkABMDuBZo
	 uSZnYBORIrBKA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/10] mm/damon/core: hide core-private damon_ctx fields
Date: Mon, 13 Jul 2026 21:34:36 -0700
Message-ID: <20260714043437.95811-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
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
