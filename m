Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478384;
	b=gUCI7zcoRpPtEl7r8hqC+nhu8ZNMwhmMYe366/0eQuv4pJGs8cBwTKfAhxasUt4OdEFZ
	 9LS2+xxntbUic/n9kKl1YqygIAX0Gd70se3/qGdAFPVAbRKCOt7xOJi19PfqCV/XcGzVB
	 xqEg98xmkRlHYzdwudxRNKIA6C2F4XD5yAy1YcJVH466f3R3FXHOt6C/QalSn+ZeWj/lg
	 rutksUB7g8oJ6vRMTCteDpPbAIpWubC2H+pOAsMaEzRmNFM+qUs8nkm5MhCSgvRufLhtO
	 nB7mE9zHTQif0FEPDgmVsPbXEcPI67nJ1eEcEZ1SdHuPk/1zOPjqZ78b1Uekq1wqBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kuii1OxTBCJKn/aKUCi3+2COKzMgGJ8Y558hfckwvWc=;
	b=Pyxw77ZCocNLsWEkFj3qzTwyZYAicGIemn7IkyM/dDlfEg3TSIT30PALfuDSV4b/2tnU
	 TVMNHjDkxkyf0NTftStmCbXzu/u3cGhJKGZc8WillYPdXJFgLVJmgvrdHu9OyApneUlTI
	 X4K7vkVKJnAfFAdsomA9I/1tKPN31Ghlf262h5oYsiI9XmpGpPTtud18ieUAhwIQtDB8s
	 pu+WVxDxS1JlXX8y3DLyvkk0yloDlQxIdJuP6swZ7eAXBDj+T7ed9xi2TH+gWw+ssKtQo
	 VTVRlPvahk8fU3P7tiNk7j740YLPufTsQ/skCCKCWx5dmyUYfRiGkf1XZc2pG75Naow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJZKHTKg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611E606A327;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJZKHTKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6276F1F000C1;
	Sat, 31 Oct 2026 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793478383;
	bh=kuii1OxTBCJKn/aKUCi3+2COKzMgGJ8Y558hfckwvWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJZKHTKgxkFAm6c93xDqAvoQwjMN6iFhyBgIc/AWNrJTBMV5ToxMdx0C1WvtvY6yO
	 tiHmG/kp2qocNcaEp8x1xQkKpseGrUEoAWEq7x4wgh19j3R6ytAer6OQVSpACxluQC
	 JhuAm2J8WUnSAJ7vLpPNg/aG2ZX5yumCQGfzKLT8mNDS+bqZdtX4hLJV3YS0cXtFzj
	 L7Irvp3FD/jqqfaklw6jGp67En4y/OsTbXkd1i4Gt7NslSqughMwRiYUCj8BKW7uXj
	 Nmvnajxn45i1srr5n0MleeHWJSOUtiGHBY98uYJpo9X7W3oJOSRy8IMEz3wTy9G/nw
	 K+jL1++CPZ1Lg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/6] mm/damon/sysfs-schemes: drop redundant and racy zero target_value check
Date: Sat, 31 Oct 2026 13:26:11 -0700
Message-ID: <20261031202614.96036-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031202614.96036-1-sj@kernel.org>
References: <20261031202614.96036-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface disallowed zero target_value because it could
result in divide-by-zero in damos_quota_store().  Because similar checks
were duplicated to other DAMON API callers, a patch series that starts
with commit 610c4438fb66 ("mm/damon/core: error
damos_commit_quota_goal() for zero target_value") added a same check in
the core layer central parameters, and dropped redundant checks in
DAMON_LRU_SORT and DAMON_SAMPLIE_MTIER.  It forgot to drop that in the
DAMON sysfs interface.

Now the zero target_value check in DAMON sysfs interface is only
redundant.  Further, it has a time-of-check to time-of-use (toctou) race
with target_value_store().  It can confuse readers to believe [1] the
division-by-zero can still happen.  Drop the redundant and racy check.

[1] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 637f1bd0c950b..38efdc258ef3f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2898,9 +2898,6 @@ static int damos_sysfs_add_quota_score(
 		struct damos_sysfs_quota_goal *sysfs_goal =
 			sysfs_goals->goals_arr[i];
 
-		if (!sysfs_goal->target_value)
-			continue;
-
 		goal = damos_new_quota_goal(sysfs_goal->metric,
 				sysfs_goal->complement,
 				sysfs_goal->target_value);
-- 
2.47.3
