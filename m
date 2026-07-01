Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4C355F46;
	Wed,  1 Jul 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917306; cv=none; b=ozEiS7NaIIQ/wI8yA02DiOeM7bTADxFZsm0BVN3wAM5LOAjlDATHAjgY0VbilYE4ocltYbkDaoxYTXWMYJHrPSft6coiN6hyV8dnWv4tSlnlXd3cGMNpnTbMemnDXZvRGpB81Nva57KeOqhDXhgE8EvdiiM/B8/u7Iu2JScSdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917306; c=relaxed/simple;
	bh=cVEkOsqI+s9FwDJqs9vRzwlwXyvYL3tdmmSYKWT6sx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKwhOr8wqJ1A+oR/BMjlnEYSGpx/PaSFoDCcy/QREQmDoLqQ//tHFXheGEBbkBhJv1S5wcHkTUFHzAaulcNJRFxrESY4Rk0u410Q4cKSW/Qf3nWMLR9CzYSjxD1rsdjDgg41TM9ot1mIvV4spS1e3HBp0u2OQZcxwP7qmSzyFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTrbqQ0j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTrbqQ0j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D0A1F00A3A;
	Wed,  1 Jul 2026 14:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917305;
	bh=QkKbN8JT013PFC22cFEAzBpDHHTSG1t3VeAW4U+gBVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTrbqQ0jrniuvVaZzyOK3vdvPOT3SRcyfKFnltmDJns3tib9ZjPxDn37q76QCETH/
	 jAaO3CcN/ZtyhOlO/WoN9lC7yI2whBEGhXWMqLNQLi5GrmsKU5FYLZ8fsi0IgBhlMg
	 oGDUesv4iD0ixBlDnHqil4ba7XN7MWeRhR85NellhG6BqDfRgYFtoVJyJMwpB7hZ52
	 JmWZfG1IxUqx3wpHo0EZszqiYvPdLlTwk1f5USSNshL3LmVNOisGyr2dbT8ol92UYA
	 grgIrquocVLpzvfSbtTLEOAtkRi+gi9qrnOe1w0GeWB7BSW8fSyj8dQ+piwcfIxqyl
	 nK8JAr2jjhKCg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/8] mm/damon/core: safely validate src on damon_commit_ctx()
Date: Wed,  1 Jul 2026 07:48:03 -0700
Message-ID: <20260701144815.113325-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701144815.113325-1-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
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
index 871c6f5257c9e..62c27002219cd 100644
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
+	err = __damon_commit_ctx(test_ctx, dst);
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
