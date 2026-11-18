Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968553;
	b=y29CcCOqPif3XzAG21joCPizVWroDgZhXJLa8AU3cYjT3p8MUUMjFRBwFt3Rmj0xWE7i
	 goQY185yVJ4TWa6nlJ9MD/J/mhnpZLJY1nUJO5M7tqB0xG7x3sbQPau+0bVSTvjlFgGnc
	 lI6meZzCtfRZFA0uF0bFfHH0EceuNbj2pSEY0pLY4Xt/IE/lRmkmnssbtNxNBuqKEgtyb
	 kmgCzS1DfKgb/NpcB99VE9VpdFZik6VFlQ+x6Qndo3YzUotHxGL7ryamA0OSotAGkQ5bA
	 e8a11ZrsW/BnA0o0HckWGPjvrI7jg9KtuHkwzJJkocO9oe+tTnpKXj8GmHORj5MdxWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JF+qXeshGtN/Mdrgpk6OIMKsGHFFBSP3QQN4BVwWXEc=;
	b=emjLy0Cs1w2NBFoAKdF3WQgwFFH6K37e7TI1JoP182u8nJgxIKkX9XiJpycBA9GiHOH3
	 8lpq+mRxON7bk+Z8Sq7OVQxZGmJupf/itjVJ4qcK5XfsLcaQPLg826knto0pOvbAHTRWd
	 R0qtUPLYMBHiAw5J4nqfBn6cTWc1KfNTLsr6VXpsVOUDt0Z3zKlKARtUmCxMG3BJPBRlh
	 /ioFIW/qOrGl/6OM1NN42mLCfA2j//Z7M6vXWM3NGGhPQ8X50bLqVgGxiQPc32LRnlDKv
	 PbyT2oSf+ncVy7jyIwuCrXZU3ioEBOfhog70eS7+VzXBu3CoRVtK1WwlrElZmHMSd3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oVVoCg/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186F606A32A;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVVoCg/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FA41F000C8;
	Wed, 18 Nov 2026 02:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968553;
	bh=JF+qXeshGtN/Mdrgpk6OIMKsGHFFBSP3QQN4BVwWXEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oVVoCg/Yep0OK6Ox8yTsCXbXsxmiGxMt75A2Qzf2sA7AD89T3fIY7nbr9zH6VKdjk
	 bEVLdKIMY1oqOxutGTN3kcDWq/2VYf4qskGEh7bDymlyoMx1Xz+YZWrCdq0sJst1f9
	 IO7Gp6pyCHVgUPAJvagaMuwHL4IbvynL7LEBcXGCQuISLQa905IpvQ0V9CKU0KT5u9
	 jCoihM21AvkEnf2GCYf2v0psBPOIUQfyK8GiZa+B7IcoGukWAU9+b79bsgPcqA8oks
	 GGxPidLyy4+p4H7D+MBqRDt7rj7M8R1PGY6o3stxmgOfo8WSXfcSskWMc+nHortkZt
	 HogBPESgMKLIQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/27] mm/damon/api: introduce struct damon_report
Date: Tue, 17 Nov 2026 18:21:56 -0800
Message-ID: <20261118022225.100659-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
