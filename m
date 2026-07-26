Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2823D6494;
	Sun, 26 Jul 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087588; cv=none; b=aVEM+blf/FsD2/DO1cFOWGvOpq1sXs4XWtKBS/0xrPLcspl9cAavnE/zgvGcas3+5NQWoEK86Y6Rlt/bsB6M9kNPL2fHCitDbUl3OUZMRX/FpQr5/5KzGrysDbiYBw1S0/B+bwwvOAIoj0yV19vfIhVrIUAEnY0rtNVoyRNR0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087588; c=relaxed/simple;
	bh=7SsPEMKt3HljA5a704mz9vOlsKHXICL6itYdJL0meGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/0P9HHMLvW2vvJ6A3LC0RQWTMMDU/ls/4OYvAneNu5D4iQJXTiMpmp1m/+t7nByfvW3fH8sKRUlohkqGpzquivpwar5lahRWVKIdqEPQ7VOVSsbiYGgyLH6MA5tK+baebRcmne61HCG7fRoDJWa5kZMY1cyPz917kNuLzSNxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUq4OHmU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUq4OHmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED52C1F000E9;
	Sun, 26 Jul 2026 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087586;
	bh=vA1pWiT60A2Sjmy1IPxMrwPYIsPuAFR2O+VHNv6q4bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YUq4OHmUTQCdSYrB/KWNSjzdEckIpS0QhuOSAqLFiZPJVozJMfEJgc+hNFJ50Prsg
	 SoooqX4Y3dJ3DiAeMY7eaIpe+1sqPCFVofjLkHtYQ05U+GCmCpoP7C5NjXbNOeurkf
	 cwEYYCr/JCTdHdXoUWkMfxk7/hioIOrfziL7d4LA1Rn9grHKUAOVpUGZ/Cj5CnRrs2
	 6aMUbNAI+puutijacp1QvuwBly5D93Y9XI8k/WDC1swxHD3hQDYBi3XCduta+hlwZT
	 7TNIo+5fEjS1dQkZa1pjYepG8oSSZtHsMNhaWp++nNCeGjePm88zteyZ+iXOfKFzoO
	 Kf1K/NkA3seQA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/17] mm/damon/core: introduce damon_prep struct
Date: Sun, 26 Jul 2026 10:39:21 -0700
Message-ID: <20260726173935.94046-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMON probe filter types require preparatory actions.  For example,
pgilde_unset probe filter can say if the page was accessed but when.  To
answer the second question, the PG_Idle flag should be set at a specific
time.  It can make life much easier if DAMON can do such preparatory
actions.  Introduce a new data type called damon_prep.  It specifies
each of the preparation actions for each probe.  DAMON will execute the
action for each region per sampling interval, like it clears page table
accessed bits and unsets PG_Idle flag for access monitoring.

Also introduce DAMON_PREP_SET_PGIDLE as the initial prep action.  As the
name says, it will do exactly what DAMON was doing as the preparation
action for the access monitoring.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 32 ++++++++++++++++++++++++++++++++
 mm/damon/core.c       | 26 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cee4b74761081..255b20e44287f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -741,6 +741,27 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * enum damon_prep_action - DAMON probing preparation action.
+ *
+ * @DAMON_PREP_SET_PGIDLE:	Set the probing memory as idle page.
+ */
+enum damon_prep_action {
+	DAMON_PREP_SET_PGIDLE,
+};
+
+/**
+ * struct damon_prep - DAMON probing preparation request.
+ *
+ * @action:	Action to do to the probing memory for the preparation.
+ */
+struct damon_prep {
+	enum damon_prep_action action;
+/* private: */
+	/* siblings list. */
+	struct list_head list;
+};
+
 /**
  * enum damon_filter_type - Type of &struct damon_filter
  *
@@ -782,6 +803,8 @@ struct damon_filter {
 struct damon_probe {
 	unsigned int weight;
 /* private: */
+	/* Preparation actions to apply to each probing memory. */
+	struct list_head preps;
 	/* Filters for assessing if a given region is for this probe. */
 	struct list_head filters;
 	/* Siblings list. */
@@ -961,6 +984,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_prep(p, prep) \
+	list_for_each_entry(p, &(prep)->preps, list)
+
+#define damon_for_each_prep_safe(p, next, prep) \
+	list_for_each_entry_safe(p, next, &(prep)->preps, list)
+
 #define damon_for_each_filter(f, p) \
 	list_for_each_entry(f, &(p)->filters, list)
 
@@ -1014,6 +1043,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_prep *damon_new_prep(enum damon_prep_action action);
+void damon_add_prep(struct damon_probe *p, struct damon_prep *prep);
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5eb0400d5ce16..bda61f9ec0266 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,28 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+struct damon_prep *damon_new_prep(enum damon_prep_action action)
+{
+	struct damon_prep *prep;
+
+	prep = kmalloc_obj(*prep);
+	if (!prep)
+		return NULL;
+	prep->action = action;
+	INIT_LIST_HEAD(&prep->list);
+	return prep;
+}
+
+void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
+{
+	list_add_tail(&prep->list, &p->preps);
+}
+
+static void damon_free_prep(struct damon_prep *p)
+{
+	kfree(p);
+}
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow)
 {
@@ -167,6 +189,7 @@ struct damon_probe *damon_new_probe(void)
 	if (!p)
 		return NULL;
 	p->weight = 0;
+	INIT_LIST_HEAD(&p->preps);
 	INIT_LIST_HEAD(&p->filters);
 	INIT_LIST_HEAD(&p->list);
 	return p;
@@ -184,8 +207,11 @@ static void damon_del_probe(struct damon_probe *p)
 
 static void damon_free_probe(struct damon_probe *p)
 {
+	struct damon_prep *prep, *prep_next;
 	struct damon_filter *f, *next;
 
+	damon_for_each_prep_safe(prep, prep_next, p)
+		damon_free_prep(prep);
 	damon_for_each_filter_safe(f, next, p)
 		damon_free_filter(f);
 	kfree(p);
-- 
2.47.3
