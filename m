Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F51B6D0D;
	Thu,  2 Jan 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844512; cv=none; b=tfpK6E6q12TG59vh3eyzJo0KffwkBBfg14qfP9UaHw61sYF0eeT6Fo+r0322GjNCwWYa3BoEP+hpjZRr9HGQO3L8SrC/w0dSqKmF4WTcghoOkguXLMP+n9HKl8xbK+Ao0wYzGyOWdoiNbwCu4gLZe2EAGeN/CcgC4xxasPkQrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844512; c=relaxed/simple;
	bh=Y1NV3w3Fvk/peP/cJXxwGprVnmhKsS9FZwzyPyCKXNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkOuyxYLp+UXlrQo83Urf8mCAATC0s1o55dNjcRr9uMARoJH3jku2S0Y+0BciYkbtt6NXC3XYWRBVs52rdAsVDp/Pmrpjq05DWG6Cex66GiaTM6CkLKZ1bmtgSt4BRFdMtTNoDQzRdOEA2+HcebfxEigVVZH1ISFQDdI7k3e2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlaCOO5r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlaCOO5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B1CC4CED0;
	Thu,  2 Jan 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844511;
	bh=Y1NV3w3Fvk/peP/cJXxwGprVnmhKsS9FZwzyPyCKXNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlaCOO5rNn19HvIkCUNx1ojxpPoXV5gCSrJ79URuhc4SthOwBVX5GaPmmpbfCBST9
	 4wzNVnBEI+1lU5WNwV0TYHnnBEvI90xXCEblFhyjxNJqFNW6fDzuu+eE3x9EpFc3TT
	 do8fW2RPtllMT+6IcYVaJI67yPSps96ROFY86k43IksroZBefuUqgjLsZJ/84FNuEL
	 +ei8vdF1xdhTyHSB8cpemAx+l2y520q8yUFhSx8ZN2Gwpvh0tJtKrQ30jKphByKXZf
	 vz5wR5xA5N2ICq5J6T3Kvj91ikIIGgxDGCV+Yq548AZhl6Ri7d4J3AuyElYT2SaoyN
	 RvhJzPmVpbgbQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH 5/5] mm/damon: explain "effective quota" on kernel-doc comment
Date: Thu,  2 Jan 2025 11:01:38 -0800
Message-Id: <20250102190138.47258-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250102190138.47258-1-sj@kernel.org>
References: <20250102190138.47258-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for 'struct damos_quota' describes how "effective
quota" is calculated, but does not explain what it is.  Actually there
was an input[1] about it.  Add the explanation on the comment.

Also, fix a trivial typo on the comment block: s/empt/empty/

[1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043

Cc: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Changes from single-RFC
(https://lore.kernel.org/20241126002921.50035-1-sj@kernel.org)
- fix a typo and grammartical error (Honggyu Kim)
- Integrate into this patch series

 include/linux/damon.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ad0360711aca..ce477a0ed6a2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -193,11 +193,16 @@ struct damos_quota_goal {
  * size quota is set, DAMON tries to apply the action only up to &sz bytes
  * within &reset_interval.
  *
- * Internally, the time quota is transformed to a size quota using estimated
- * throughput of the scheme's action.  DAMON then compares it against &sz and
- * uses smaller one as the effective quota.
+ * To convince the different types of quotas and goals, DAMON internally
+ * converts those into one single size quota called "effective quota".  DAMON
+ * internally uses it as the only one real quota.  The conversion is made as
+ * follows.
  *
- * If @goals is not empt, DAMON calculates yet another size quota based on the
+ * The time quota is transformed to a size quota using estimated throughput of
+ * the scheme's action.  DAMON then compares it against &sz and uses smaller
+ * one as the effective quota.
+ *
+ * If @goals is not empty, DAMON calculates yet another size quota based on the
  * goals using its internal feedback loop algorithm, for every @reset_interval.
  * Then, if the new size quota is smaller than the effective quota, it uses the
  * new size quota as the effective quota.
-- 
2.39.5
