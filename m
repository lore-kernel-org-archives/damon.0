Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFEF1C3F1C;
	Tue, 18 Feb 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917864; cv=none; b=i4Ig/a66vjZbEoMaTI4bBotDMC2t/cToEQ/ukp6Q3WS/OiNFvpyFHmO99fXNS0NzrCi8JirzuFGhpRWz8Ujc4ap8/smCfTb9tJ91jyPPa4krlXEu0qNKCPlYcRMIczmb2ZA4uuMaHcLF44Bwb8CrIr8mBXx/9pF7KOhDEXtaCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917864; c=relaxed/simple;
	bh=eo5zEe1YVMqfePwXgPJeBAKRMQ7xc9BwvIjis3i9txg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HI/E8TMTFvk2LrbSHel9NhDAcRYnAYJtvwWKvPQ1DxGU3JLP7m1S/svMqtn/NuZ200BAQ0SoHB+wz21bwK4xvss93a5cUpVTp6FH+g3R68xih5khLcSdFARqejYI421+MjM4L6ixpUGmvn6CG0RaU419I5uTGUCaEEqYRa0S5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T++WVOeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T++WVOeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9ADC4CEE2;
	Tue, 18 Feb 2025 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739917864;
	bh=eo5zEe1YVMqfePwXgPJeBAKRMQ7xc9BwvIjis3i9txg=;
	h=From:To:Cc:Subject:Date:From;
	b=T++WVOeAnByBHn4HGh/xEmffD1poowCoA4k8CN3p4AAvwoPJ67fjMiiAzvNVa7L/a
	 5n0iejiibFif4GsgLitPHUcadxhE3mRi/zBWHc6JgtH161IpxsyxVn5301YW8OBmOu
	 bRQd+ZH60HD0J4Nk4eh1KJDP+VmeDM7z9nh63r+P7XZZLwAPY4g2QsK4mR4Q6oy7Pa
	 4qKBmIHUry9a7tE4CgUjBueRyJgEv3MeiLiMzoK4TqFVgaC+/hFjninQ5VwixdDU7x
	 sMzuV+MA5/CcSTeNTkc9tiDkO9ISG5et3gZ0VW75IvOYXGwXpQ1arVpRbsRAnGMueO
	 2KPKo54uOxIGA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable] mm/damon: add kernel-doc comment for damos_filter->sz_range
Date: Tue, 18 Feb 2025 14:30:58 -0800
Message-Id: <20250218223058.52459-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 212f4d0cb42c ("mm/damon: introduce DAMOS filter type
hugepage_size") on mm-unstable added sz_range field to 'struct
damos_filter'.  It missed updating the kernel-doc comment, though.  It
is making the documentation build unhappy.  Add a comment for the field.

Fixes: 212f4d0cb42c ("mm/damon: introduce DAMOS filter type hugepage_size") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0adfc2f4ca75..0ed84b3656fc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -372,6 +372,7 @@ enum damos_filter_type {
  * @target_idx:	Index of the &struct damon_target of
  *		&damon_ctx->adaptive_targets if @type is
  *		DAMOS_FILTER_TYPE_TARGET.
+ * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
  * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each

base-commit: 3afe77274e910ec6e2dd0c45aa24c0daa20dc9e6
-- 
2.39.5
