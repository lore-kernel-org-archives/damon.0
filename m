Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E923ED63;
	Sun, 29 Jun 2025 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228092; cv=none; b=tlD+gD3i/AyTNZTBI70yVHlHh/yOEicfJRtUjBliAmwZmIuqa2Vmyii/LWz2ff7y9JPkxttoRGVzuXRqaxjwmJRxEkDvQNPyjHVBQAgmsDtGL3BOAmJ6/HEhe4XyC3Pz6GmiOSw6hPvi2vxnSIC4NmgN7QokZVzt7L5hgsVyjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228092; c=relaxed/simple;
	bh=abx9lNh1gFvopZEIiGDT9OF9wCpwby92bKkdaKzWw20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQJP1xEXCM5sXE2dV5/hKJ10PP1Pu6YEi4VFtM2rpwTqrPZ2uKaVIb7KS9B5s9wkuU5qfE0+2MSfYwMrSUv3IsXJAziD2bLz7UoHu1FiaRlv1OsgTBVMzoq/PmJi9ttO3wT5IrClB2M/tsth+llfICuEF7rFpSvT5FzbONeRz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLLQiMTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLLQiMTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B152C4CEEF;
	Sun, 29 Jun 2025 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228091;
	bh=abx9lNh1gFvopZEIiGDT9OF9wCpwby92bKkdaKzWw20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLLQiMTrdkfWG+0QJKZwk4tKX4x0i/eeK7i54O+f1YTLiM8iw6R9wxZHpKZzkUBUW
	 QYnHWqhzUKFCWlxwH8p4XuqoK/OrUko8ZLePedEcjY6CXWBvPGLCFcCibjBKrU+WRi
	 Cc4MkK3NqYP23pz70I+YBKgTyC3SPdDoW+u13sVelRJ8Y6Yqx2PlNYXRKjFGoP1w4N
	 YwIgBIZuR7P1uH+X2BQXuvZfgOglPsDfqupH0nUC3sdYAEZWTgBlpDhXfRQL0g2cjk
	 tZYH/4erPvfDEvxlQOQ2eL77aPwKZMayofNWR++bW9XG8CKJH9sSqQeFq7LDGpktlV
	 zLyP4ch46bMGQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/6] mm/damon: add node_id to damon_access_report
Date: Sun, 29 Jun 2025 13:14:42 -0700
Message-Id: <20250629201443.52569-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629201443.52569-1-sj@kernel.org>
References: <20250629201443.52569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In future, per-CPU or per-NUMA node monitoring might be required.  We
can add the information in damon_access_report and implement the
damon_report_access() callers filling the information.  And the new
operations set implementation for the per-CPU or per-NUMA node access
monitoring can show and ignore unnecessary reports via
damon_operations->eligible_report() callback.

This commit is for showing the first part of the idea.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9ec40ce7dde0..29223fea710f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -111,6 +111,7 @@ struct damon_target {
  * @addr:		The start address of the reporting region.
  * @size:		The size of the reporting region.
  * @nr_accesses:	Number of detected accesses to the region.
+ * @node_id:		NUMA node that made the access.
  *
  * @pid could be stale, and hence shouldn't be de-referenced.
  */
@@ -119,6 +120,7 @@ struct damon_access_report {
 	unsigned long addr;
 	unsigned long size;
 	int nr_accesses;
+	int node_id;
 /* private: */
 	unsigned long report_jiffies;	/* when this report is made */
 };
-- 
2.39.5
