Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26351F63FE;
	Tue,  7 Jan 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281090; cv=none; b=eUtkBhlZsVrtvjy87ZKsBLeOoGj1IcZywxX36np3NxZPPGOWhivOWCTKwSm0PNu8CuOItJ4CXB+kFaxzqwhmh00osSRPpyJD91LLgxqjCjaVGNHmFHzssyu7IwVKhR3QH4cR0sp07mnmfy2qS6e6SMq7L6Gl1DBklluMBBBcBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281090; c=relaxed/simple;
	bh=97I76lDfvaM6L2LOAAduyShBBxqQhcZ1zQRaRPWTvuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8v2NL4BuBrlwTGMjFYdkT4hUwlwSikxO+yi5kgQZbqUyGle0KZcQy/PuV8eNM/kf/B9gHpdPHSPcVmq7x3SOGtqO6NRCQSiIGwUHhx89ZXhQV756TLjVzUS5hTP8C70RApch9/Z7nTgfADsr3C/jjd/yBTwZMDhxw9BXUtfixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjMBpWAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjMBpWAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B874C4CEDE;
	Tue,  7 Jan 2025 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281089;
	bh=97I76lDfvaM6L2LOAAduyShBBxqQhcZ1zQRaRPWTvuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjMBpWAIL0F+1FBB03PXptlqXI5T1nzKca9WFZ4dkXqiSWkqFFNLPc5FewJragYFo
	 PHRjacKSyjgfSmKHiElJMUHk+Ispxlbfx4rXzxWPsIIP5YOGUvOQGgKU/+sUWL9eA0
	 a7h4Xm/ZxaZ7/whlpg0x3PXzW70D517Oozp/7iBdzkJ0qCrBa0ag+fKEQY7bpfdKqO
	 hhBcnVqucCBCsivL3cu3sWicCS3EtgbNMEOeCvpLBPIcVR8GEymQDsMurSfo/71k+a
	 8mDcL1f6i5mJ8fbP/FHPEuEs/pv2tKww3/ovQRMwFUSBSDa2YJx9kVxqlASSrP63++
	 tedpPoOWjAODg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/10] mm/damon: fixup damos_filter kernel-doc
Date: Tue,  7 Jan 2025 12:17:30 -0800
Message-Id: <20250107201739.79484-2-sj@kernel.org>
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
