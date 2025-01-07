Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB0D1F709F;
	Tue,  7 Jan 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281091; cv=none; b=IUANmrbCkvbaqQJIeFbXvseHOCSN4xj0GVwxqEZoRY1BYkZI3GImomYPIeiR7e/xX1VlW6RZeIzXB2yr0zwMJ0BOSBzmkNSD2Jh3PlMVUk8jH6bgl06vRSt4hmtI7nML6maNjy/hP4qkclzUIuxs5Wz5uqasw/ibQUw1BoQ8H/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281091; c=relaxed/simple;
	bh=ChVZwNMuI/bsAh0W8ok2wqpnVeqESRBGmTcn2DPnef0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlnHJqL+0Adzy9TnTdN3BCpoMkOxjSYqcDn4lUf9BQhOSSMRHVahYdH8OCc1zt9xO2yVzi/u6Pz5ExjOH0teG/JLQli4XwJUVEyUcz6uUWGPhKaJYZJS36/94KID/qoW7VTgmSD8Agmza23rza20NVa+UJNKseLB8ODSm/LR6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIWbmkCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIWbmkCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569CFC4CED6;
	Tue,  7 Jan 2025 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281090;
	bh=ChVZwNMuI/bsAh0W8ok2wqpnVeqESRBGmTcn2DPnef0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIWbmkCF3+DLxU4uCCvggXf/JXln14DDVlxSUH0FgTRRshNE8iKyxdroUJnsGPmaK
	 EB1FBF5+V+7KQW4otNae+aZTWIQ+q5ddFZLBTJx/xR5ANK6saj1wEqmVkJ9rmJ3Yec
	 wxTW/2EarAmiOmoBxh9SMXFKVFDKNYsVKBlWgkkMk08R29R8Jcj6Q0ZVh1qlV+myfW
	 8Kgm96dyYY00511DZGeFqsOpU7GF7HNhqQpiGpFC5ObOVEtjZkKq0Ish0VpEXWZapZ
	 yVcx2Ed+SNg23fVcvkBNH5lv+2nPpjQv1iaqDRGQ+1ELMDqMDxw+P3rr+caS9hlRMk
	 NfLNkN8yEdaHA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon/core: add damos_filter->pass field
Date: Tue,  7 Jan 2025 12:17:31 -0800
Message-Id: <20250107201739.79484-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters work as only exclusive (block) filters.  This makes it
easy to be confused, and restrictive at combining multiple filters for
various types of memory.

Add a field anmed 'pass' to damos_filter.  The field will be used to
indicate whether the filter should work for inclusion or not.

Following two commits will make the core and operations set layer,
which handles the damos_filter object, respect the field, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 mm/damon/core.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 72afba74ac6d..baeb884ed156 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -348,7 +348,8 @@ enum damos_filter_type {
 /**
  * struct damos_filter - DAMOS action target memory filter.
  * @type:	Type of the target memory.
- * @matching:	If the @type-matching memory should be filtered out.
+ * @matching:	Whether this is for @type-matching memory.
+ * @pass:	Whether the memory should pass-through the filter.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -365,6 +366,7 @@ enum damos_filter_type {
 struct damos_filter {
 	enum damos_filter_type type;
 	bool matching;
+	bool pass;
 	union {
 		unsigned short memcg_id;
 		struct damon_addr_range addr_range;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 52e50f183ffe..e54bd19d6f06 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -275,6 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
+	filter->pass = false;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
-- 
2.39.5
