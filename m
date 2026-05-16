Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F108387364
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970887; cv=none; b=ByBalt3HAt5l105AgRryjTq4XKMG0WNGT6v8MJnPy2EzP2L3eWUYNYIV2VJjW0AMXsrhQNNKb2d7hS+xSc7UAxLvoBs1XNzMf2/X5pc+oDpBBMhPAiAXUOSw2iw5+jwoWSXs2e6od01kC1tVChVQMKIgCNmwWPG34ujXq2O6YUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970887; c=relaxed/simple;
	bh=RGTQjDI4J9zN6ogXHBydYjAWRRH6xgj1FRwnKHtWy40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8oPym2vEN1T/F+YMoQvEJsKzFaiekLdHoAx4cH4Bfy80PgLLE+5h74R0lGvuwgFcakjElc7ioQ4mNSDcJvsK2OsKj/pbBIHpBbQECtkaFzRMY1d+WlQPFrAbZijD8vVBu+pXGjfsO1ittOWLyBwHRSm5On79xHa3i0g+k4n4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqwi4I6P; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqwi4I6P"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7c0de780bf1so4567217b3.2
        for <damon@lists.linux.dev>; Sat, 16 May 2026 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778970885; x=1779575685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14OZdlsCd/minckeoEg/l7pBnGdlCv1AuWKncPE3uPM=;
        b=Fqwi4I6PJn+yg9/XR4VTA+KZZd3o3BBu47i+1SfIknqLH8kTfRpd3BmQYpZ65WqhEL
         jG1IOBmmDNttUetp90SwkJULfwX80eRtc87BgF7d3mF5Q5TM58fhGuGOXVBiDX8+QaC1
         rT+FobiCdPRqWLBAuXalyED+PM0pIrILTAtpDqdRcnhIyS6KXQ8xzmWnQqilaa+4UrTx
         FzedXqykOnMvMeaSxgPpQWPLeF+3Ts66PN4njWuyFsj/EU+WWm7ViT2ZWnguk5U+MNb4
         wWeqNNU0ahl/3j/8oCqEaO6BNfRs9+8eqTlaNQY6M6Z3bp9CRq9BNa8E2bPeIQj5/tJt
         Beuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778970885; x=1779575685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14OZdlsCd/minckeoEg/l7pBnGdlCv1AuWKncPE3uPM=;
        b=oLCCol5BB4Ekwfzr9BT70EiCLBNuvHi9RYQJJ558DBaOGe3L0G0CkuCRUrUSVE/m2c
         GrCh3tqCSRxLc0ngeQflyk2rpa5e9V07DnBCBM2+0lD0u8SUahSKGh758lY3/jdIzU/z
         IyJL2PdMSfkS5wWjFqtJGiuwLERTnL6cGwELwVF+NuA05bdAc1o5Yfa5gIESKnEek/LL
         u6CkC/rHceSpj2MkKdd+s0jpX0XHNDOzYQvNjUiDiomo2jmmRBuyXfXxqf2Z0MIzZwpE
         OkPzLue5rNQjDYhG7RZyRICNRetKxb1GzPSXK0VJSNu3CgP85pKPUe0038PoJXHqLGYp
         BTBw==
X-Forwarded-Encrypted: i=1; AFNElJ8nkbLFcXsILQMR62ZX2WJFxJ5191hSP7qeq6mLpu7zqu2Ilk8jIHDmK2JxRPus4XLq9pRYGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNnMlb7g2XR8lua7GuavpRRGa7dlaWQ/vIyeS1JAmMYgf39Y4n
	gyKmQ3fuvpS/mMdbqci3gEFzhD+oZsCx0I8ViyO5tN6Gaacwcy8vtBY=
X-Gm-Gg: Acq92OFbgpRciVqNT3Up5XEtI1m2Ot7j6cVmKPlBhiAmfRUEz3NCPCbceBvLmtrtIiX
	xldNkI/zjg9m4S4q9oynvjSghnoydImwsuCDxx2lfphJYst/FS0LlmEV5vrSbKnzhiYP0fpbwlx
	B/0eQRi3ZwDE8ptXkeBsj8d/30SjavwVyUo5a69uQdkyF9dSO1DMwuAAFEs1xXGFxfOnDALiYA3
	BadHvEPBttKY9m24TN/7GJJZlH33roD8AbN9CgYsdrnI6X2tCN0Ab4MAHqR3DofZYEc1yKUox6Y
	OS+LqGvtB6G7xYAVpwU69UeVdOe34OACbtvSxSGMMXfs4gDRYomVxP1OJiWzkJFAqjUTEnAgDDi
	tpq/MIfiWSXETD2vefTWcSa9nFKRRySYvTwAICHTy4IGTf1tdCNKiYs0MxRw68oa3sX7eKlqSny
	Nj5kt6GX7xgHBUlIq7yfkQCn5AlcQO47756SWU92vDRa2b5hFOLYNwtrnh3VnCu0L1Eb6jSP6Qq
	w==
X-Received: by 2002:a05:690c:6b12:b0:7bd:d4f4:261b with SMTP id 00721157ae682-7c95b33d4b2mr103710917b3.29.1778970885288;
        Sat, 16 May 2026 15:34:45 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9c2e49e9sm668787b3.33.2026.05.16.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 15:34:44 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	bharata@amd.com
Subject: [RFC PATCH 1/7] mm/damon/core: refcount ops owner module to prevent rmmod UAF
Date: Sat, 16 May 2026 15:34:26 -0700
Message-ID: <20260516223439.4033-2-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260516223439.4033-1-ravis.opensrc@gmail.com>
References: <20260516223439.4033-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_select_ops() copies the registered damon_operations struct into
ctx->ops by value.  After damon_unregister_ops() is called from a
backend module's exit path, the registry slot is cleared but any
surviving ctx still holds function pointers that resolve into the
unloaded module's text.  Restarting kdamond on such a ctx, or invoking
any ops callback, jumps into freed code.

Add a struct module *owner field to damon_operations.  In
damon_select_ops(), take a reference to ops->owner via try_module_get()
after locating the registry entry; on failure return -EBUSY without
binding the ctx.  If the ctx already had an ops bound (re-select
case), drop the previous owner's reference before installing the new
one to keep the refcount balanced.  In damon_destroy_ctx(), release
the reference via module_put(ctx->ops.owner).

In damon_commit_ctx(), the live ops field is overwritten by a value
copy from src.  Balance the refcount when the owner changes: take a
ref on the new owner (return -EBUSY on failure) and put the ref on the
old owner before the assignment.

Built-in ops sets (vaddr, paddr) leave owner = NULL; try_module_get(NULL)
returns true and module_put(NULL) is a no-op.  Loadable backends set
owner = THIS_MODULE in their registration.

Also add damon_unregister_ops() so loadable backends have a clean exit
path.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h       |  4 ++++
 mm/damon/core.c             | 46 ++++++++++++++++++++++++++++++++++---
 mm/damon/tests/core-kunit.h |  2 +-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index df7910a39b407..8e6e1cd89e551 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -682,6 +682,8 @@ enum damon_ops_id {
  * struct damon_operations - Monitoring operations for given use cases.
  *
  * @id:				Identifier of this operations set.
+ * @owner:			Module that provides this operations set, or NULL
+ *				for built-in ops.
  * @init:			Initialize operations-related data structures.
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
@@ -728,6 +730,7 @@ enum damon_ops_id {
  */
 struct damon_operations {
 	enum damon_ops_id id;
+	struct module *owner;
 	void (*init)(struct damon_ctx *context);
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
@@ -1206,6 +1209,7 @@ int damon_commit_ctx(struct damon_ctx *old_ctx, struct damon_ctx *new_ctx);
 int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
+int damon_unregister_ops(enum damon_ops_id id);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
 static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e4b9adc0a64dd..b605d36b29b1a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/psi.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -93,6 +94,31 @@ int damon_register_ops(struct damon_operations *ops)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL_GPL(damon_register_ops);
+
+/**
+ * damon_unregister_ops() - Unregister a monitoring operations set.
+ * @id:	ID of the operations set to unregister.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_unregister_ops(enum damon_ops_id id)
+{
+	if (id >= NR_DAMON_OPS)
+		return -EINVAL;
+
+	/*
+	 * Callers (typically the owning module exit path) hold a
+	 * module ref via try_module_get() in damon_select_ops(); the
+	 * unregister cannot race with active ctxs because module_exit
+	 * runs only at owner refcount 0.
+	 */
+	mutex_lock(&damon_ops_lock);
+	memset(&damon_registered_ops[id], 0, sizeof(damon_registered_ops[id]));
+	mutex_unlock(&damon_ops_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(damon_unregister_ops);
 
 /**
  * damon_select_ops() - Select a monitoring operations to use with the context.
@@ -112,10 +138,18 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 		return -EINVAL;
 
 	mutex_lock(&damon_ops_lock);
-	if (!__damon_is_registered_ops(id))
+	if (!__damon_is_registered_ops(id)) {
 		err = -EINVAL;
-	else
-		ctx->ops = damon_registered_ops[id];
+		goto out;
+	}
+	if (!try_module_get(damon_registered_ops[id].owner)) {
+		err = -EBUSY;
+		goto out;
+	}
+	/* Drop previous owner ref if this ctx had ops selected before. */
+	module_put(ctx->ops.owner);
+	ctx->ops = damon_registered_ops[id];
+out:
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
@@ -835,6 +869,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	damon_for_each_sample_filter_safe(f, next_f, &ctx->sample_control)
 		damon_destroy_sample_filter(f, &ctx->sample_control);
 
+	module_put(ctx->ops.owner);
 	kfree(ctx);
 }
 
@@ -1749,6 +1784,11 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 			return err;
 	}
 	dst->pause = src->pause;
+	if (src->ops.owner != dst->ops.owner) {
+		if (!try_module_get(src->ops.owner))
+			return -EBUSY;
+		module_put(dst->ops.owner);
+	}
 	dst->ops = src->ops;
 	err = damon_commit_probes(dst, src);
 	if (err)
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0369c717b93db..300659b115602 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -342,7 +342,7 @@ static void damon_test_split_regions_of(struct kunit *test)
 static void damon_test_ops_registration(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
-	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
+	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak = {};
 	bool need_cleanup = false;
 
 	if (!c)
-- 
2.43.0

