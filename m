Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5492DCBE3;
	Tue, 14 Jul 2026 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003686; cv=none; b=Vytzn94q2qBQr26+qr/yePcWBoMXzQ13ogz2SVmOQXklkmfnX9TSsimPQ+R6mBqFuwBOa2jA2r3HkvRNSMPCFBdxQCgrWI9Sjh1mPpPhE3XlMPtNt7tgOKRxsFE8FSUHxPZ0Z2Nl8idkcXERpD278ndOz4sl79QkUVIJ5eyk5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003686; c=relaxed/simple;
	bh=IivE0CWKTdcUn47+Hm3ucbbgQtvBEUhe8axmDQs6bPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9NtfrlO3aalq2pbsTngB/7D1ouEG1Y1sZRZwDDep5+x665geOLKypxrISrbak+gNbmwgpyaaP11P+7AbpzlCWbT0xARurstEmDQSyut+jAVMqbgYYdHZsWLeV2hM2yczM+ZML9vdjyILHUDYUo8ijoXup+jfxGwx0cNU11RGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRcG+bUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRcG+bUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8133B1F00A3A;
	Tue, 14 Jul 2026 04:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003684;
	bh=OgmQTZfSicG2akeujY0x1j+uFMrq86YzkqctonivABI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRcG+bUqxlShKXkBXEBVh/HqQEiB4R0Smqh5ZqJJu9ZeBTi5TU7fpq6ZUqNRGkZCB
	 cpy19YJ3Nd20RJp6KQ0KcqrwzgeKpbxbSWRo5/MztNkuJcB58M3CKq0ZJm3iPTbeH5
	 jfKdTJs8LLCYsXRHAnFpYwx7dvTCQBT5mWiauhuXhkJ++XrLU8ZRADyQ7r888K2JJL
	 ctYDqvBf6zYRVi55iP9fpoJJa5Lw2plZIZIUIqCtfRG+e5XOqxu+w/u5jzS25Olch5
	 ZPS8fZ98xQVM6LzOwYYfTSAUGCDcstA0kkBIhth8Iegu43AEf9XXwMg1h7vxvTnU37
	 v74H0eBKFSTUA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/10] mm/damon/core: hide private damon_filter fields
Date: Mon, 13 Jul 2026 21:34:33 -0700
Message-ID: <20260714043437.95811-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_filter->list is intended to be used by only the DAMON core layer.
However, it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 907d65f03d083..6c3c7c75b6ca3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -758,7 +758,6 @@ enum damon_filter_type {
  * @matching:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
- * @list:	Siblings list.
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -767,6 +766,8 @@ struct damon_filter {
 	union {
 		u64 memcg_id;
 	};
+/* private: */
+	/* Siblings list. */
 	struct list_head list;
 };
 
-- 
2.47.3
