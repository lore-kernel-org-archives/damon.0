Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55E31A56C;
	Mon,  8 Dec 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175392; cv=none; b=t8lSJWS3Jqp5IfOe2LOIZD8bBPSl2Yv7oqpWWqxK8tqwhhrJndbknhBG4x7o6EBI1WxxrxpjNynMbI1E28AnNjFJzrrWgHICHAaBAb+vkov+EXTJbJNNGrreznxmpPZeRMYaIFnpVyiriC39HvGCRQ7g2JIfStBsZSJrMwPdQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175392; c=relaxed/simple;
	bh=rQEjNspwX8hWrc2KTuqlN5FanQkO7AzzeHJdwmQvvNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctgYMTNXMZOmAWEsfm6+fL0FdbchLwbbcB5D1PYeNI0SseV1kzoJZ7ecLGs0+Ik9eNx44TiZUrNC76CPxbz8k4A8ec9YGl8Vz1frPbsNou8fdS8K+MO9NYS8Tt6oN8rGCC0LTutX65kJ2yoMXAcwlM8kMIylVwdhUH/JgGWQHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWJkADCO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWJkADCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1035C4CEF1;
	Mon,  8 Dec 2025 06:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175391;
	bh=rQEjNspwX8hWrc2KTuqlN5FanQkO7AzzeHJdwmQvvNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWJkADCOqjmtshNcqcdsfl9W/5939KuuwE2xNNVM99lQcloQ/Y4+rNRFo46AhWiSn
	 B0t4CRnuVzxhJnf+RR8AzAJYe3g0S/4/7dW/7F6UbdtyvIfaCNilyUxbaSBA4HV/ez
	 AH4s9HbPno59H1ha813qr5bA/da59GKO61xaGQcb+ulTBsranuFY6sGzAPx6M+rmGS
	 f9YDz8YmUdoYeyIQDt5c4Kmgc0rNZhiOO4U/7exoW6pBmSCgUEyU4GSZXFsXRL12SO
	 1kjX9szQ10x2ZeH3A/RDddmTq1FDtQ7++SEXJB59PaOZA+1ezIRRzKw1nfrfKRnNzB
	 P66fBYR26aDcA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 02/37] mm/damon: define struct damon_sample_control
Date: Sun,  7 Dec 2025 22:29:06 -0800
Message-ID: <20251208062943.68824-3-sj@kernel.org>
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

All existing DAMON operation sets are using page table Accessed bits as
their access check sampling primitive.  In following commits, the
operation set for physical address space will be extended for multiple
access sampling primitives, specifically page fault events.  Define a
new DAMON core layer API data structure for controlling which primitives
the given operation set should use.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1bee6e7fed1d..b9359c76a6f1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -765,6 +765,33 @@ struct damon_attrs {
 	unsigned long aggr_samples;
 };
 
+/**
+ * struct damon_primitives_enabled - Enablement of access sampling primitives.
+ *
+ * @page_table:	Page table Accessed bits scanning.
+ * @page_fault:	Page faults monitoring.
+ *
+ * Read &struct damon_sample_control for more details.
+ */
+struct damon_primitives_enabled {
+	bool page_table;
+	bool page_fault;
+};
+
+/**
+ * struct damon_sample_control - Low level access check sampling rules.
+ *
+ * @primitives_enabled:	Enablement of access check primitives.
+ *
+ * DAMON collect low level access information using sampling, and aggregate
+ * that to make higher access pattern picture.  It can use multiple sampling
+ * primitives including page table accessed bits and page fault events.  This
+ * struct is for controlling what sampling primitives to use (enable).
+ */
+struct damon_sample_control {
+	struct damon_primitives_enabled primitives_enabled;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -833,6 +860,7 @@ struct damon_ctx {
 	struct mutex kdamond_lock;
 
 	struct damon_operations ops;
+	struct damon_sample_control sample_control;
 	unsigned long addr_unit;
 	unsigned long min_sz_region;
 
-- 
2.47.3
