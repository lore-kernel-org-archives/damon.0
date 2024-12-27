Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A91F7580;
	Fri, 27 Dec 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333709; cv=none; b=aJz2PpfEWfPVquuriR8hk33px7o0dgJmgAPqsaaEM4R3xlBPJuTip/MJqcwgletHEbVaFmtb+ZAx+5obJGJ8ydo/9lNYSomHnMmsxs3NybQZWC0uM56PSNvYR9/iRxyLF+k0NmdnJLV3rwaFQm31EamJtVr+RjbuQjkyeUDUW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333709; c=relaxed/simple;
	bh=BqfFuozL0F0mxvXeJ3OdZ9G2Y0SIHcS2uBA23Vwog2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ct85ZthPU7mBQ1KTFQgI5TaWxdMgoKl1pjJ/v3rRQ+VOzB4MpXhWPA5Rf1eRfywgdV3pd7m7wtuFRqk7fM4XciaJPAtMeScmekhNrd3lJdavslk9Jd0290jysZPjNRpGxTuDJOjmRhuimoP2IYrIETVmm3Pml+Rmu+F3vZa0laE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnUJit8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnUJit8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4CAC4CED4;
	Fri, 27 Dec 2024 21:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333708;
	bh=BqfFuozL0F0mxvXeJ3OdZ9G2Y0SIHcS2uBA23Vwog2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnUJit8naTGjkWHL3DW4n2LgDjBhljJs3/AlXhk8vOKW2ODhnwksLa4AD6FosMtt/
	 CxxsY20yI4KKTgSOye90gFHjilVnGOYBnKXpH9lNWDVmyrXjPq66bqMkSDqc/+cBNe
	 DEfb7ufAsYr4jf1XHfvVHDTuDS+ZacbU91Vs63RITRROYhr+vjDeavZkEygd5WnVMu
	 vYm21Ke3on1fFF+z7XVlgEQsKYxG9YBib5wdq+cqKCo5SJLlx2dGm3Q9I/9+2aUAeC
	 n8SSjpFZTjnnP1hPlkN4jjfJUtYwDrkL732B2av7ax7t2sHP8/UEJp6fRO/0EWoCMB
	 UM0X07Znk6JDQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon: fixup damos_filter kernel-doc
Date: Fri, 27 Dec 2024 13:08:10 -0800
Message-Id: <20241227210819.63776-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
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
