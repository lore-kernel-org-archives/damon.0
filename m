Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774543;
	b=rczLm3Rn8QWvxZSS3SrLXmCnVVnV9wQL7mkFliqEiXYp5zZVWBo2GhDhjHQi7oiEgbtO
	 lXG4tvezfDHSAi9K2ei5VnD6mZz7yJvE8ivp60uTetVRTjZNjzrG9hQ/ZuUXXM1/fGFZJ
	 Og1sGE2wsSpuTGb3hl5fsGw5XHUSBXwPMFse+DiaS3zb6OlUTlU+quk7D236atCk0Tby6
	 /xdQApyZAERw75eFLiMThVjyp3b7CbXdpaYLPZIugRJQJTIbZaytOfWFGkbsmKxBIVmsG
	 XZtiQwfprzSZ3qy4iJ8KvoU8wMGoULsrPxneoT2H5ueX8yIXKn6MFSKqyYXnU3ot94w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PvBIDhzkcMdHdrHP3Rxf/89i78BrWd7FuX3cNOeI1e0=;
	b=iLPCjy7cA9ywKDbNg1rdAvGz4xCmdIXlL/i14TRMmwZDMxTWKSaapHaytqklq/dC/8Uf
	 4KU4B5X/pH5NMbcd0H/UnNBMygPQslAp9Q1bEFHpWhPsdB4JUcjJB7ZRbSU2K/6zSPava
	 NMu2OX67xu2zS61ekOMbQJJwq4jWgk8DBCMU46+w8r0DmTAYRE8cb+Cuf1QR58F0q4Dzs
	 MethDYNrV3i/pKXpGwTNoMazbGMfadk0m16AP6JDlH/GM4PcWg82gn8xjw0yF5M+QeBMF
	 lu7cDAcpXvYma+aw6EsGgMLYpQMP1xdtSnZrkZ5ZOApt0PjEr/63xgGVfKuMXj0MdVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEahCePr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB3606A335;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEahCePr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE81F000C6;
	Sun, 15 Nov 2026 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774542;
	bh=PvBIDhzkcMdHdrHP3Rxf/89i78BrWd7FuX3cNOeI1e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UEahCePrCCo4xXZZJ8VFEBktekX07qPapwC/uYnCW0CQoV5uBe3BgS4a23TORVouO
	 p+ZkZcAsZLLHrScI/NUDMdFo/z6Vb23ONxkXnqpPQKe4V20IRmo5aVMycJkT1b3xiL
	 A64Yw6O2vL6df//t67r/rPqFx4fjEiq9ns75a5HPkZ746YiRkDNpToAjBDfu9Hy4Uq
	 CVMT6qb0HpQu8Rhi9Jx+Xxi31ruml2mXTGsEBCDLld4V/993WPhMY+AONLbI7zZB39
	 Wyv5ZI/lgI5XvC44cwoXB50bLAegwbiGomywZvPgqRoz2JnvFDA0UnJI8nefhybcTB
	 xBEfv4IxiUX9A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/27] mm/damon/api: introduce struct damon_report
Date: Sun, 15 Nov 2026 12:28:19 -0800
Message-ID: <20261115202849.99134-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a struct for data attribute report.  The struct provides public
fields for the type and the memory address range.  The type field
represents the type of the report itself.  The address range is for the
memory of the reporting data.  Data attribute producers can format their
report using those fields.

It also has a private field representing when the report is submitted.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 06bd92981af21..5c32ddebf4625 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -751,6 +751,29 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * enum damon_report_type - Type of &struct damon_report.
+ */
+enum damon_report_type {
+	NR_DAMON_REPORT_TYPES,
+};
+
+/**
+ * struct damon_report - Data attribute report information.
+ *
+ * @type:	Type of the report.
+ * @addr_range:	The address range of the memory to report for.
+ *
+ * Note that the @start_addr and @end_adr represents an end-open range.
+ */
+struct damon_report {
+	enum damon_report_type type;
+	struct damon_addr_range addr_range;
+/* private: */
+	/* when this report is generated */
+	unsigned long jiffies;
+};
+
 /**
  * enum damon_prep_action - DAMON probing preparation action.
  *
-- 
2.47.3
