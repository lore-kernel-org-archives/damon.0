Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AC18870C;
	Thu, 26 Dec 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251300; cv=none; b=l5TKGmpkFWXKOBifJjQLnrmhc0fdTsd3L6lwbecElClzQuC4l928g2vOKqenYzuqQCHffYkL0nJmSgBeQ52CwE7aGtca0gwW02qG1xRsAEAwLHTZR3ESyVnCm+vpM8+v0b/YetU/eCtTggFXLHox0UgcOy58Uj0xqE+QRmagAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251300; c=relaxed/simple;
	bh=BqfFuozL0F0mxvXeJ3OdZ9G2Y0SIHcS2uBA23Vwog2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fOMZ5DZWDk9U6YSmBfDvkNMj3FOr6Zo2cbmPFZ7toXTfgIrQ+Mxx91wGz7A6sk6+7iU9cI0/yLbo2stD0hH8cYzp4KK8JBOY1PwSiK+YukDY3zEvD2pHh/2BQppi3Hj0xevLJVk+gCIilEy+9pETBkWE3lg4OSuJfKanntwGtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ+ftHr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ+ftHr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8D6C4CED3;
	Thu, 26 Dec 2024 22:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251300;
	bh=BqfFuozL0F0mxvXeJ3OdZ9G2Y0SIHcS2uBA23Vwog2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZ+ftHr1CkAH5F63FDXtw0/BlvymU//usYo7FSrg35NHQ1sYDG48BuoNLXlHBZcsI
	 hn8XzMUIJRlJZW13Bn6vnDqyHQtTJXKhomujUWTXi3SjjR0YQRGeW7qxs4O4akLgTA
	 eELMnCRHUJ5GlQ0J4b8ds3pHxVNxRopSGsRkr9p9IIIIbSbylGw+uSvbETncTDMQZz
	 5uH/Da7PfzmNxtiUyvEVNRjehKnEyFLZY3n3DWaGIBjBWga6bW/3z7f8tAPzwtrnSC
	 bMPOiWeRL3btA7IXiJ5xDPRnqZPfN/MBeej8hcQedLut33s1yd2jCAlTlcOpTpJ0ng
	 WYDj6Qh9EfzjQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/10] mm/damon: fixup damos_filter kernel-doc
Date: Thu, 26 Dec 2024 14:14:36 -0800
Message-Id: <20241226221445.78433-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
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
index 18449b5c45df..15f098372672 100644
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
