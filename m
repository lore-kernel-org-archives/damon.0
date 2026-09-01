Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CC3AE6F3;
	Tue,  1 Sep 2026 04:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237268; cv=none; b=HbPPggb0FJf3fJ57kW9/CALysLwiecQMWv4q2V450IM10qbQV8JKEY8RT2y1wLF+gFun0bSjVT7sQRwFe3ArFapMtyuIBqp+ozUpbmDNPkfG0evOBWqvdSP5HXK5B6K42CTjt07ul5t1+bblMpMgrWDnYaauazJEu1PSJFotEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237268; c=relaxed/simple;
	bh=//uK5VLSyeG2PpmSTHj372R5hdfNw2eAp/n+fs5INA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFnGjN+BB3BjrIRmkHzZX5KZHIxNaqu4ZvlbzMrEQtMX2VexKDMJDLUzzy8KbNVa2O8D+rTsv0pBzpYp/bkbMlJ1P35fub0hW/4Wp1GxPtU1VJFL6ZUcAzxRyqXOZMVcMLun5YVedIaNdUVGi2knksGdfdCUBIMlFnfQxGQHAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpcWyOAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpcWyOAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F48A1F000E9;
	Tue,  1 Sep 2026 04:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237267;
	bh=xDsh4DffQRbrA3+l3qVbLOikgSrH6WeYk4b6TXVz7Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpcWyOANd2C9UyiEEq20jHtCu1I241GxdMY3ac9mT0fSF/WXG3sDspeQ2tsk9C4Sn
	 cfRZGdcbL3dUKtJwS38OC+2KqCVKJSYQmxXp7DMljtgzmlsIccM9FOae7j2dy8yzNb
	 lP9tDCzo7orLFclV+Lk2omL0EMrNb+zcf8FAfNo6rBbvWy8ijcgbczTNXeG2G9CCeH
	 6fn+UcCGDIuN1WznmG39Tx4bI8SFcT+jCt4H9QDkVbQGD+n9Zn9UFfeP0Svf3bmDnH
	 anlRo3WrMLxkzTYEKQphIwXy4O2jTiPL1MUibensFsklYrFCDhXhO5xORm4SwDBnpa
	 Owluaz4yAioag==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/17] mm/damon/core: introduce damon_prep struct
Date: Mon, 31 Aug 2026 21:34:01 -0700
Message-ID: <20260901043417.2165-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
index 7a42cbe791845..1780c14942e63 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -742,6 +742,27 @@ struct damon_intervals_goal {
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
@@ -783,6 +804,8 @@ struct damon_filter {
 struct damon_probe {
 	unsigned int weight;
 /* private: */
+	/* Preparation actions to apply to each probing memory. */
+	struct list_head preps;
 	/* Filters for assessing if a given region is for this probe. */
 	struct list_head filters;
 	/* Siblings list. */
@@ -962,6 +985,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_prep(p, probe) \
+	list_for_each_entry(p, &(probe)->preps, list)
+
+#define damon_for_each_prep_safe(p, next, probe) \
+	list_for_each_entry_safe(p, next, &(probe)->preps, list)
+
 #define damon_for_each_filter(f, p) \
 	list_for_each_entry(f, &(p)->filters, list)
 
@@ -1015,6 +1044,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_prep *damon_new_prep(enum damon_prep_action action);
+void damon_add_prep(struct damon_probe *p, struct damon_prep *prep);
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow);
 void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53c3f97e3f126..85774dbca64b8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -112,6 +112,28 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
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
@@ -168,6 +190,7 @@ struct damon_probe *damon_new_probe(void)
 	if (!p)
 		return NULL;
 	p->weight = 0;
+	INIT_LIST_HEAD(&p->preps);
 	INIT_LIST_HEAD(&p->filters);
 	INIT_LIST_HEAD(&p->list);
 	return p;
@@ -185,8 +208,11 @@ static void damon_del_probe(struct damon_probe *p)
 
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
