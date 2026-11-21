Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294821;
	b=oGAdL+eszbjSICqcx5IJaBV+wdM8RDEVQMjjH8Se5vFeWKIlrEUbOn2yol5iKDHnZc3E
	 SCFxRtyItb+nNIQhuzwoFj0GlXcYsUcwjPrgpFgaa4305/SsFgEABk8FAb8zSRGn7lN5n
	 rd6T6VjWpSsliZ8tG0Pbvd4au5AoiTpeWvPYqmbm9DWxdNhEV9BMa3PEb2L1xaeA0sCUP
	 3Cx4Nx9VefYPRrzYLFvk1hNve9cRzFmQ+4SZWX3OXvQKzQyO0zpgPTyZbZzMcqjSx6T3i
	 g7NIzsvBXBlK0CNsNpQuvU44B8W4jeNJWNMWSabngq84k2n8OnxZLYVt0F5824kyJWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JF+qXeshGtN/Mdrgpk6OIMKsGHFFBSP3QQN4BVwWXEc=;
	b=gJANOi5aS5CSoh+WJgZDQuG9HGZ6d7yYMT6xRvCT+774yID4gp0NK5PD0XlVdozWgP8s
	 JvwKN5PS0G2vqN7gFxL2hHe2Jna6cb1XX2tm17LfWK+FYOWV6RAvgqh6for0kcQIN+0eO
	 P+vOPpg+W4hwZQzxvdcgqu2TuDQczx6E2NvgrUK6YBymKPs4ezPJm1mNSINl3UyNeg5By
	 Pd8TpRRPVHUVCJ9WjXxQwKssXQQzzJPofTlE/i0768tCHCchoFQHbT8K8NOjoZHOWmHic
	 tGw8Xx+z8cvhXZiBDTzVfppkZMbmdOjMRyTbSLL6Z02gdQTiO3EtlU7zDwWjq/CHMBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0l4rjC6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FE606A320
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0l4rjC6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7381F000C4;
	Sat, 21 Nov 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294821;
	bh=JF+qXeshGtN/Mdrgpk6OIMKsGHFFBSP3QQN4BVwWXEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0l4rjC6/GxEYCDBQbgMmaqfldNP6aP3N4uPieQP0OctuOnfigSOpTSMB+Ha2jSkh
	 r+MPDNR+jSP2KwaH+WKhxu9+OTfOlMpN5P6WjPx/dPVazW3h6XAIFrkMneWR6To2GQ
	 T0e5FM4jCQUrEDsxMtIEGAFqgMswiPOpO6JVGv8tijKwERrEFoZWzA0VY4A/bU6lI3
	 AXWpI7O2aYlXGIUFt4l3Ebc55PC9EklJcsUIMN9A9DosWcOIeIBsMgdVP2H/s06R10
	 /nP/yy7SxHNTq80bJzttr3NUkskJiA7bTBPAL+Dk9xrfG9qtyPtIj55b8yAcTAmchX
	 Fe95THvqUTXQA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 01/27] mm/damon/api: introduce struct damon_report
Date: Sat, 21 Nov 2026 12:59:45 -0800
Message-ID: <20261121210013.130397-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
 include/linux/damon.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 06bd92981af21..cac1329397a4f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -751,6 +751,27 @@ struct damon_intervals_goal {
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
