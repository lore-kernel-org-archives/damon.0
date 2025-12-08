Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C63320CA8;
	Mon,  8 Dec 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175432; cv=none; b=Hq6FlVKPEk8tUipkOY0H1vaFWQJf7CMADaNL7DvqwBDfvMAAen7t73nm5V/NTbeqEofWI4B0X37PVIMmLCeic1NQMHaHmP/T4P92ER4iJv5Yyjwob0HK8u8ZWx4F0VnzAvhD2S9riXhgrR+vyWSW89JhrRMBOhOPK3obsWc/pvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175432; c=relaxed/simple;
	bh=5bka80r89gRSONmAfQQwGshd2Lcq1UBCMlN2eimMurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI6wBJs37+cjEznsuyzCNZ1TmsoZond9ZP3oL1kCbGho9Aa40fjTNSHb/MPd0GvT6EJMNAuhfHbKSrvJJDPHtZGe5Tjp5QspkcWCzorU0kPjj/o3KudBzQB0CCGo0c/Afr1dD1Ucfdnj/f2UOE+mR6n+7lFg8B6ajbrvd+PCoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdPmNLQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdPmNLQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B08C4CEF1;
	Mon,  8 Dec 2025 06:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175432;
	bh=5bka80r89gRSONmAfQQwGshd2Lcq1UBCMlN2eimMurQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdPmNLQb0JS4kyN0C0aSoPXZcXcC7pKfrTP1MSY+OtHS9al9RJAd+Nbyj+Ik3k5BP
	 IRERY4Z+6ATXkmOOoOJnf1rh8RWQCPK63AHKeazoV3/Q7WfHtEaNhC+9SrCa7dUDXg
	 TZ5z2GaNy1bgSzGGz5vjrAXGDvGFGyDRohfks2I2k0Q8wGeB5db/DMSWpDr+FpLlM1
	 XE8atbc/zYtR+0xbpIBWXV4+W4FqTr/y/wqf8AzikmNXDYmFhRmkxDlL9xvVfNJow6
	 UGllFv5ETbtMBvDmJ7Dc8ECbu11DSX99uofXonsxVWsJySVQPlg9LGroBt1lua3RHV
	 S6ZYQTE58i+Dw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 28/37] mm/damon: extend damon_sample_filter for threads
Date: Sun,  7 Dec 2025 22:29:32 -0800
Message-ID: <20251208062943.68824-29-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now DAMON access reports could inform which thread was making the
reporting access.  By filtering the reports based on the threads, DAMON
can do per-threads monitoring.  Extend DAMON access sample filter to do
such filtering.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 80332bb2b73c..e3408280ea72 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -787,11 +787,13 @@ struct damon_primitives_enabled {
  * enum damon_sample_filter_type - Type of &struct damon_sample_filter.
  *
  * @DAMON_FILTER_TYPE_CPUMASK:	Filter by access-generated CPUs.
+ * @DAMON_FILTER_TYPE_THREADS:	Filter by access-generated threads.
  *
  * Read &struct damon_sample_control for more details.
  */
 enum damon_sample_filter_type {
 	DAMON_FILTER_TYPE_CPUMASK,
+	DAMON_FILTER_TYPE_THREADS,
 };
 
 /**
@@ -801,6 +803,9 @@ enum damon_sample_filter_type {
  * @matching:	Whether it is for condition-matching reports.
  * @allow:	Whether to include or excludie the @matching reports.
  * @cpumask:	Access-generated CPUs if @type is DAMON_FILTER_TYPE_CPUMASK.
+ * @tid_arr:	Array of access-generated thread ids, if @type is
+ *		DAMON_FILTER_TYPE_THREADS.
+ * @nr_tids:	Size of @tid_arr, if @type is DAMON_FILTER_TYPE_THREADS.
  * @list:	List head for siblings.
  *
  * Read &struct damon_sample_control for more details.
@@ -809,7 +814,13 @@ struct damon_sample_filter {
 	enum damon_sample_filter_type type;
 	bool matching;
 	bool allow;
-	cpumask_t cpumask;
+	union {
+		cpumask_t cpumask;
+		struct {
+			pid_t *tid_arr;
+			int nr_tids;
+		};
+	};
 	struct list_head list;
 };
 
@@ -823,9 +834,9 @@ struct damon_sample_filter {
  * that to make higher access pattern picture.  It can use multiple sampling
  * primitives including page table accessed bits and page fault events.  It can
  * also filter in/out specific types of sampled access events to monitor
- * accesses of specific types, such as access-generated CPUs.  This struct is
- * for controlling what sampling primitives to use (enable), and what sampled
- * access events should be filtered in/out.
+ * accesses of specific types, such as access-generated CPUs and threads.  This
+ * struct is for controlling what sampling primitives to use (enable), and what
+ * sampled access events should be filtered in/out.
  */
 struct damon_sample_control {
 	struct damon_primitives_enabled primitives_enabled;
-- 
2.47.3
