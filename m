Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A43B8BB8;
	Thu, 15 Jan 2026 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490454; cv=none; b=GacP3k2aJ+tRVWfyEHem4LCxQl/HSxBRa+RRWkEvPYcLUV/lnOJolhTx2iSEKyOUurR2XUElonaoUMS3zKkKJNyMk9f/DtOKoF1FC3pWfR+eFkQRgFtCXtbLrktx2AZQGBPMMM7qootKOpnbUAckUhPJMeDtBULeU6hxS3MXfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490454; c=relaxed/simple;
	bh=4axDbWJSGHLGv1FOAfVefI2HSvmv3TegEZMiJ4E32WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=maVYgdlV0+Fy7hkBxfdAg0b+lhsio6FCzQluiXFBhrnsN3IRnROokZI/LsRoBNtaH4Wd54MuWqlFYn3wV1xwTQantLTdQ99i6bpuxZQkc0K3wgtauc1/Vc4K4g2AB3iufQenT1YpnyE2zD9hT4i8+bdx3z+uSXxuUPTQy4V0pfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKy7uMmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKy7uMmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79B6C2BC86;
	Thu, 15 Jan 2026 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490453;
	bh=4axDbWJSGHLGv1FOAfVefI2HSvmv3TegEZMiJ4E32WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKy7uMmA3zHE6AvGwvQKg+fZQLbN6YxmONtC5clgQYvmX+YpYURjV9YJ8yn70Qsvn
	 C4U0oIRN6bH8Z5E5ELBDm0Wf1MMUhLvBY4sY57+trSwAG4XA+qEiG3t6sbfG2aN8zf
	 eHAtB0p6oQI85gkRxcpaN5d0oUdnHkKTWEdrb1UqpD2nvVs82IKjGgHY5mZIDsjbnR
	 rZCnn95qL2y7SgKiTfOKKQby67WdDFYTAZyd0JneyajyQuIG5/sOFsm60x5Eap9Ope
	 kpA/cYVudWbfWJx/WNNi/SEL9WoXAVH1kh5iDH0NebE3DRs+zB19yJF3mkPgNw0Lgv
	 SoJDgbdF3GTaA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] mm/damon: hide kdamond and kdamond_lock of damon_ctx
Date: Thu, 15 Jan 2026 07:20:45 -0800
Message-ID: <20260115152047.68415-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115152047.68415-1-sj@kernel.org>
References: <20260115152047.68415-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no DAMON API caller that directly access 'kdamond' and
'kdamond_lock' fields of 'struct damon_ctx'.  Keeping those exposed
could only encourage creative but error-prone usages.  Hide them from
DAMON API callers by marking those as private fields.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5b7ea7082134..e6930d8574d3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -759,23 +759,20 @@ struct damon_attrs {
  * of the monitoring.
  *
  * @attrs:		Monitoring attributes for accuracy/overhead control.
- * @kdamond:		Kernel thread who does the monitoring.
- * @kdamond_lock:	Mutex for the synchronizations with @kdamond.
  *
- * For each monitoring context, one kernel thread for the monitoring is
- * created.  The pointer to the thread is stored in @kdamond.
+ * For each monitoring context, one kernel thread for the monitoring, namely
+ * kdamond, is created.  The pid of kdamond can be retrieved using
+ * damon_kdamond_pid().
  *
- * Once started, the monitoring thread runs until explicitly required to be
- * terminated or every monitoring target is invalid.  The validity of the
- * targets is checked via the &damon_operations.target_valid of @ops.  The
- * termination can also be explicitly requested by calling damon_stop().
- * The thread sets @kdamond to NULL when it terminates. Therefore, users can
- * know whether the monitoring is ongoing or terminated by reading @kdamond.
- * Reads and writes to @kdamond from outside of the monitoring thread must
- * be protected by @kdamond_lock.
+ * Once started, kdamond runs until explicitly required to be terminated or
+ * every monitoring target is invalid.  The validity of the targets is checked
+ * via the &damon_operations.target_valid of @ops.  The termination can also be
+ * explicitly requested by calling damon_stop().  To know if a kdamond is
+ * running, damon_is_running() can be used.
  *
- * Note that the monitoring thread protects only @kdamond via @kdamond_lock.
- * Accesses to other fields must be protected by themselves.
+ * While the kdamond is running, all accesses to &struct damon_ctx from a
+ * thread other than the kdamond should be made using safe DAMON APIs,
+ * including damon_call() and damos_walk().
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
@@ -816,10 +813,12 @@ struct damon_ctx {
 	struct damos_walk_control *walk_control;
 	struct mutex walk_control_lock;
 
-/* public: */
+	/* Working thread of the given DAMON context */
 	struct task_struct *kdamond;
+	/* Protects @kdamond field access */
 	struct mutex kdamond_lock;
 
+/* public: */
 	struct damon_operations ops;
 	unsigned long addr_unit;
 	unsigned long min_sz_region;
-- 
2.47.3
