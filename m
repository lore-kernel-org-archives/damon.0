Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80145192D8E;
	Thu,  9 Jan 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445098; cv=none; b=oSnYTNBw/o34y0q3B3GZ3uvehc6tuO1AN3ZZJNyiNjiZKkVkdrmLFWpk7DTKxy5ZNkodjk+8K66VMKSZ+TG2bTbPG/pBOPXFtUfXX9DFQYC8gwLT9P8LOReNB0FoxsZCoAoDlOGhS6edtjbAF1mnZo6aMRuENrQMD/9/hJiqlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445098; c=relaxed/simple;
	bh=97I76lDfvaM6L2LOAAduyShBBxqQhcZ1zQRaRPWTvuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lvw7MmPPN1/jAtaYEW1uBwzREDECVPdfSlD9kyEnJaSXqE2ePgns+HClfK0TohVKPSWigRxBmA3PocHNIQr3QhMFbTtkgd72UmYpqs1k3lyT3wF33hAdznqdIDF0K8obaw2vT3q6BWw6Q/FvDbwyUDRMA4946nvqeOdBKgGpZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtXAjCKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtXAjCKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C4C4CED2;
	Thu,  9 Jan 2025 17:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445098;
	bh=97I76lDfvaM6L2LOAAduyShBBxqQhcZ1zQRaRPWTvuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtXAjCKQhCXp6XoAzncBThz0kaOtImaAYZIh+2dMqtJca447B2ZLB0/KZW9C6EKwS
	 tYgd4e8PzXMPQGuimjfE7awNMh+Ue58ZeG57xpCMyQgj9Kh6gXR0BDVBNTM+LDjBFS
	 OJ35/YSQ2AYXSlV3kWJR6NeKTsjBABupqrMIQsf/CwT6x18zy1VHzoGdBwsgROPym0
	 2R9PoraJyf6PAvJ/fNbTJZWwcPTNCvN5Fjwgjd9xtJqZEuWf+ZvW+2KraUaTUJ64Jq
	 9gPoaPMLqUjH8wQRWwXOkbxtVjv2PVIlw/VdcOMaAiAePHI8bcvYQANhWKCjBlHa20
	 xnlIkeVQIiekg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 01/10] mm/damon: fixup damos_filter kernel-doc
Date: Thu,  9 Jan 2025 09:51:17 -0800
Message-Id: <20250109175126.57878-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment is slightly wrong.  DAMOS filters are not only for pages,
but general bytes of memory.  Also the description of 'matching' is bit
confusing, since DAMOS filters do only filtering out.  Update the
comments to be less confusing.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 298b1a831e62..72afba74ac6d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -347,8 +347,8 @@ enum damos_filter_type {
 
 /**
  * struct damos_filter - DAMOS action target memory filter.
- * @type:	Type of the page.
- * @matching:	If the matching page should filtered out or in.
+ * @type:	Type of the target memory.
+ * @matching:	If the @type-matching memory should be filtered out.
  * @memcg_id:	Memcg id of the question if @type is DAMOS_FILTER_MEMCG.
  * @addr_range:	Address range if @type is DAMOS_FILTER_TYPE_ADDR.
  * @target_idx:	Index of the &struct damon_target of
@@ -357,9 +357,10 @@ enum damos_filter_type {
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
- * page of the region matches to this and avoid applying the action if so.
- * Support of each filter type depends on the running &struct damon_operations
- * and the type.  Refer to &enum damos_filter_type for more detai.
+ * byte of the region matches to this given condition and avoid applying the
+ * action if so.  Support of each filter type depends on the running &struct
+ * damon_operations and the type.  Refer to &enum damos_filter_type for more
+ * details.
  */
 struct damos_filter {
 	enum damos_filter_type type;
-- 
2.39.5
