Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D743446D6;
	Tue, 16 Dec 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872113; cv=none; b=faJVqsOxpwJl8hemSR6szeXwdtZNN3foHobNTWOoyBvzAXKw37sHPA63/h82Cv+HjnxyUulpauaJvSmYMYa6xXZin0TL0YDgCPeb5ZntgUQMy+jw995O5NGpGtO9VLClcpDDGilJs+dNf03rR3IC+FdRSTHr9wiW05WHRgF97hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872113; c=relaxed/simple;
	bh=dyfJoVaMw2se3otvFoArpX9pnB7yY+god8b9Qd1MKC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtgDOXxudIRvJQ7I2vIUbqpGmUPX2pIbLA6KSRf6vke5gG5AMdSJAomF3XRGsS0HHrudrhoZWe9dL0HJGULeiroj55/h5fvp3TjLi1fFKgj15/xRphxyzA0cZcg6xi6wWfMojyFvCMkrvPrf97qVFL+Hw8OSeXfpQxajGxQrwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpL35w/Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpL35w/Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ECCC19423;
	Tue, 16 Dec 2025 08:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872113;
	bh=dyfJoVaMw2se3otvFoArpX9pnB7yY+god8b9Qd1MKC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WpL35w/Q+dEm4/26EIsm2RWsTVlntA3hjNzSTCFpkAhWTkLvdizet+5IJnAPoEBg1
	 wKx2iw0YDROKUTEfRk8YYMthRAMrADKxAgyG1d/0DgmApnbj7bf02yjQRkGf0FsGg6
	 qO6hG4aZ0xyiLekKrM5TzL2tDywpgMo/V/QLvxzOqhM2Gf2E6xgTSmquMVUByCN6iZ
	 suyhysPUCq8RaXKTICW4qAt8LKshVhDseeXzwFGbVdB8BJ3yGtq2J3deVZTKzllZ1C
	 9Qf0HigxOK430zaYZuqV33SYk/L5P9xJgR5te+DBzhoZ70mvGOFwjQ9Su1Y0chNY7W
	 vyWxdn7z5Y5eQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/12] mm/damon: update damos kerneldoc for stat field
Date: Tue, 16 Dec 2025 00:01:19 -0800
Message-ID: <20251216080128.42991-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0e92c2ee9f45 ("mm/damon/schemes: account scheme actions that
successfully applied") has replaced ->stat_count and ->stat_sz of
'struct damos' with ->stat.  The commit mistakenly did not update the
related kernel doc comment, though.  Update the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1d8a1515e75a..43dfbfe2292f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -532,9 +532,7 @@ struct damos_migrate_dests {
  * unsets @last_applied when each regions walking for applying the scheme is
  * finished.
  *
- * After applying the &action to each region, &stat_count and &stat_sz is
- * updated to reflect the number of regions and total size of regions that the
- * &action is applied.
+ * After applying the &action to each region, &stat is updated.
  */
 struct damos {
 	struct damos_access_pattern pattern;
-- 
2.47.3
