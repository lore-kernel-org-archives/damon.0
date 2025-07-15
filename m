Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9872BE7BC;
	Tue, 15 Jul 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605569; cv=none; b=sMiRqIDm5glyp4yh888pXuI8lVLoULp9q6QZ27eqGOd3hQqdZxCmERpF7THcskuK0sRCwmM3qu2QItY2AngdRl/n7MKbuZL7h4maUQYYZuqEPxsaX7DpMFTaDWT/EkkOHRSJ1LcIs/T9/2tSi2qZidez3/TQx1Ihs36yQrK1A8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605569; c=relaxed/simple;
	bh=7b2CGBh4NWnWWA60sSmxcZlkyX4m9XWgySvq01QIawM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=im2iKzjZO1OsPAq0KaVOXKxYA9hX4H/BfcX899ejACOSV+y3hSwXsmml19HHMGMxT+r2O83ESf9rPBJW5rsSZxGNQbBUjO2i9c9UX5JGBp8d1KGbKVjPt8bBFcVl2y3MRZQycd6+GsDxLE7eajaBfACeA8EfCd38QIva3Zv4P5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPqazmwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPqazmwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA79C4CEE3;
	Tue, 15 Jul 2025 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605568;
	bh=7b2CGBh4NWnWWA60sSmxcZlkyX4m9XWgySvq01QIawM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YPqazmwnprnggB1HpAMAc8yNIR3UP1yvIZClI4k2JdcqWqASdb608IemENd0iyW/G
	 dov8wIGi7h8M5cuIfVkiOpqRdJU1CrpPpaqBgzFznKtjrwtHyIbYgRGn3JeyWcLf05
	 WM/ZJakX0kmpQC+RG0b4thbJlkj1qHSSgCQzsUJ9NZgCsdzMR/q5Q6s2BbBB/pyWw2
	 10j+rxBMg7U+gIS1lfeMjO2RIddDndXhnNji4jVmgTncctsc61S0QM3owoYkJiE3BF
	 zsFNc4kdURShgBs2hiOeSFzT8vq2eb1Sq6qp3rnRh1yaVUZLRD8/MlegUnoWTi1h+x
	 6nSiA0KYWykEg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH mm-unstable 2/2] mm/damon: remove damon_ctx->callback kernel-doc comment
Date: Tue, 15 Jul 2025 11:52:39 -0700
Message-Id: <20250715185239.89152-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715185239.89152-1-sj@kernel.org>
References: <20250715185239.89152-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 769bd386e490 ("mm/damon/core: add cleanup_target() ops callback")
on mm-unstable tree removed callback field of damon_ctx, but not erased
the kernel-doc comment for the field.  This results in build warning.
Fix it by removing the obsolete comment.

Fixes: 769bd386e490 ("mm/damon/core: add cleanup_target() ops callback")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 769bd386e490 ("mm/damon/core: add cleanup_target() ops callback") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index efabc3ba52ee..f13664c62ddd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -746,7 +746,6 @@ struct damon_attrs {
  * Accesses to other fields must be protected by themselves.
  *
  * @ops:	Set of monitoring operations for given use cases.
- * @callback:	Set of callbacks for monitoring events notifications.
  *
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
-- 
2.39.5
