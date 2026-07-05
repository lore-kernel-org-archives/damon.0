Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466A72A1CF;
	Sun,  5 Jul 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266966; cv=none; b=IfIcpPpH0eNOkj1I/GU1VV6Dn/rAaTztYbc+dmvzBZVLxe6tyifzXGHjL90gAeuMnwpwCszl57ZEsR1YZOv39+N1/rHR3HtdHhw2GJAFlECqHsWBPE+nzlzokdAib3faa3AtP1ZHvhYgvBYoGDTfTRgSp5gQe4ajFQrEzpmYGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266966; c=relaxed/simple;
	bh=PV46LMWnfPsuygjvVotcAhKzQ/0++wZOL/CSgz862Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KI9Bx09Os37JR7I3fX8JwaR5z84SNeV5SA3PtnYZMpXyPugp11jPTSa6y+kZVS1Yl8kD04eJrhEZTKnXE/T1YE5C/z9V11K/f5TRB2G6aVceeU+8Dumv0rMCMcsAEkIli7tFK2JGDkb6U5ldC/Htm9XB6qEQDoATe/b1AhPr5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak7sUkQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak7sUkQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066F81F00A3D;
	Sun,  5 Jul 2026 15:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266965;
	bh=AqypLn7HBMPm5n3CjY0saNzxrJSnEmu/vZcmx6jzwgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ak7sUkQ4wVZTIBJmrbqmax34EK515ywicFzFT5Y4soPvpvK0OuLm4agWT4ReH0wl6
	 oVlzrPRqYWsZ8cIMEYvnYdHYAdL+EUpW4YSPFPoiX/8IJRGHngwipqq0Lw5wi2ECxP
	 pwD64fmLs8oFOC7pY7jPFcZ9ela8TAf8IOnSfr0j+eFKzQwEFlENJ7nJe2Lcu7C4gw
	 jw2wpeWqpnM9gYC5i0afcb7Lqtfw9cCYXvzhpbLARU0mi6pJiPCRQkXs87Ro60Ohk/
	 dOs9EejTTyn+w4hhpU8qfk5vRY/c0Y7pxMce4ajHU0U+xLEzjSre9n+q/5yd/mJdTq
	 hJDiOvDmG8lHA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/core: safely validate src on damon_commit_ctx()
Date: Sun,  5 Jul 2026 08:55:52 -0700
Message-ID: <20260705155600.96555-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_commit_ctx() does its holistic parameter set validation while
applying the new parameter in the set one by one.  If it finds a
parameter is invalid, because some invalid parameters may already be
committed (it is called "commit" but not atomic and irreversable), it
stops the running DAMON context.

The callers of the function therefore have to validate the parameters
before calling it.  Because the function already embeds holistic
validation, DAMON_SYSFS reuses it in a safe way.  It creates a
test-purpose context that is not running but mimics the running one, and
calls damon_commit_ctx() against the test purpose context.  If it
succeeds, the parameters are considered valid, and a real
damon_commit_ctx() call against the running context is made with those.

Other callers such as DAMON_RECLAIM and DAMON_LRU_SORT do not expose
full parameters to users.  For efficiency, they validate only the known
set of parameters.  The efficiency gain is arguably small and doubtful,
though.  Meanwhile the maintenance overhead of the multiple different
validations is clearly high.  We actually found and fixed a few bugs in
the class.

Update damon_commit_ctx() to embed DAMON_SYSFS' safe and holistic
validation approach.  Callers can simply call damon_commit_ctx() without
worrying if their parameters are invalid.

Note that damon_commit_ctx() can still cause an unexpected stop of the
running context, if internal memory allocation fails.  It is arguably
unlikely since those internal allocations are too small to fail, but
theoretically possible.  It should also be better addressed, but not
necessarily a blocker of this small and incremental improvement effort.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 61 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 871c6f5257c9e..018dd5ff80324 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1664,20 +1664,7 @@ static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
 	return 0;
 }
 
-/**
- * damon_commit_ctx() - Commit parameters of a DAMON context to another.
- * @dst:	The commit destination DAMON context.
- * @src:	The commit source DAMON context.
- *
- * This function copies user-specified parameters from @src to @dst and update
- * the internal status and results accordingly.  Users should use this function
- * for context-level parameters update of running context, instead of manual
- * in-place updates.
- *
- * This function should be called from parameters-update safe context, like
- * damon_call().
- */
-int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
+static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 {
 	int err;
 	struct damos *scheme;
@@ -1732,6 +1719,52 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	return 0;
 }
 
+static struct damon_ctx *damon_new_test_ctx(struct damon_ctx *dst)
+{
+	struct damon_ctx *test_ctx;
+	int err;
+
+	test_ctx = damon_new_ctx();
+	if (!test_ctx)
+		return NULL;
+	err = __damon_commit_ctx(test_ctx, dst);
+	if (err) {
+		damon_destroy_ctx(test_ctx);
+		return NULL;
+	}
+	return test_ctx;
+}
+
+/**
+ * damon_commit_ctx() - Commit parameters of a DAMON context to another.
+ * @dst:	The commit destination DAMON context.
+ * @src:	The commit source DAMON context.
+ *
+ * This function copies user-specified parameters from @src to @dst and update
+ * the internal status and results accordingly.  Users should use this function
+ * for context-level parameters update of running context, instead of manual
+ * in-place updates.
+ *
+ * This function should be called from parameters-update safe context, like
+ * damon_call().
+ */
+int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
+{
+	struct damon_ctx *test_ctx;
+	int err;
+
+	test_ctx = damon_new_test_ctx(dst);
+	if (!test_ctx)
+		return -ENOMEM;
+	err = __damon_commit_ctx(test_ctx, src);
+	if (err)
+		goto out;
+	err = __damon_commit_ctx(dst, src);
+out:
+	damon_destroy_ctx(test_ctx);
+	return err;
+}
+
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
  */
-- 
2.47.3
