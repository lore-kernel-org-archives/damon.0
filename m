Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534605;
	b=3Xaet546jT2JKU9TZgDYx0aPT3P2iJyz4iKpqyfikjJh14Drhm+HKsnimxOeGyh2lPBj
	 rF+KHl5kjSmGpAoFrj8Og998mJaW550nE5i8IxmH22uX41M40uePZRG2fUAMyZrudhDEH
	 Ito85QxBY3Db//3tg2cBY3YFqq45i4ngepjryPEyNgHBSicobwb1OyLCFmBs7IiRsdHXM
	 369SUrDNCtjYzJI3O2BfMX2/ehTFgUMME3r13VQy49gfQbhtEd7kuFb4wYDvXrZ4djJkz
	 1upXHKK1e8Bx/HAzjJmR765n7eDuX0RiUJBDCD4DQKKHLzbnQDUpKblBMMhsr6CXcKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534605;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s4WULBvjRFLiiJiFHBxE8QngaPERSKMf2wY3GVjljHk=;
	b=3Zz4k5JlACJpFrZegx45kSgJb4o8CIRiN7li8ZTrdxOmH2Knq8xGo6SZa+vzm0Hj2s2G
	 3r8q8mKUueOy7YXJlAphvvCMoceT34HTYS2iF9QKPvkYjBzyO5K+wYVTltFgU30VOKzaJ
	 YAYPtU4mbX46PhakgqCUW1aHIKWUYK+O0EhIDO5xsgE/ZB1heXatPLa97EtO9V0XM1H+S
	 Bpeh+XryUQbnriBHCCNA3SeFdntl2sYKqoun4AzQbv6wixlLiS/Qel9NOoP1loaLzq/vZ
	 1DFVORJBBuOT06eVGt3Qwmx7QY9n5ujLSZBbGUG6Tn2ZuTFBG3zEGEZJE5tM15gvWjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8FJArd0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3A606A326
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8FJArd0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F15C1F000C4;
	Tue, 24 Nov 2026 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534605;
	bh=s4WULBvjRFLiiJiFHBxE8QngaPERSKMf2wY3GVjljHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W8FJArd02TjjV267Axt6tnCzEbxh0b1lW8/BK+9BgzBpnnE570ian47fnlAsLTDpX
	 i7oSZGWwPHsUZGtZoexTSnfwYVKENPVEiYKDVg6LDu+stI7CbGpVUfkEurKanNZgcc
	 IR/BmwetXIC/3m4YDhMJW522/nmB9DVV3fm84n8HusMj5ykRt12EKizZASralzAlfA
	 PzcuPGEqbUUbjTZf9u6eFPOp781Lqwteg+6NomNY1Q/7C2slRMCWmgbtoarzamLWPM
	 i6y7k72gKdZqJjHamUgKLxaD4S8TgQlCvOvrtEoeKmlWimkQH0lLUf6VXXQAmpJCWb
	 uu784NNzfpwBQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 01/27] mm/damon/api: introduce struct damon_report
Date: Tue, 24 Nov 2026 07:36:07 -0800
Message-ID: <20261124153636.91854-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3aff5c525132b..2520c036306f3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -757,6 +757,27 @@ struct damon_intervals_goal {
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
