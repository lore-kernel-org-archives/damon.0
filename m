Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409EC403B11;
	Thu, 13 Aug 2026 05:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599884; cv=none; b=pH5Pg2AuoyMTWQUVetfVJdyLPaMqHTLFu4tS9BY5lbwl0PtKDlfW3rc7PJRRVjoOeAs6FIHrDzHJ95NnmlSa+Xw8prjByCSBJZVb5V8thTsvPVhM10S1MrfAKXGnpizbnvqx31O8y6rzSn+R57qGsNmbqNbCrrMOZ3ZOg597qfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599884; c=relaxed/simple;
	bh=7BuePdqLsmCrpZcRRQjUY0RK2a5/39HdUmJOLbwdCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFkA57mNwYQRnc+12Y39RJMEJeI+TzzJrt9lEWqq9LIwtBJq+ijmsr1LOX2ueOKOM1pkTigLbpZ+1sjeDf7Wx9ErYliy+Ym39WvA8wyIj49JBz+BVROzverPnd8JnIA4nK/4jKbPOj9izsKiuXFplAFgG4tHTENe631hDoe7RSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0wAvhD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0wAvhD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57AD1F00A3F;
	Thu, 13 Aug 2026 05:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599883;
	bh=4SsJPfKsekeE5VptqHXgsGnvsq0lAUhbBGf4TqY9ku8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0wAvhD2+L6konNr9qCBUej2g8rzvAzHBd+qRn+PbrtFg4Wu1TUMr4xqr1qP/mvCK
	 mKYzllSCsR5bxeCz3Ptd2hFxfB7pxhbXVhzmXZIBpgnj6oYG1c59NeV1srNnsRP1LI
	 7NYe8Aj0PvjgqK2NAYCKvKN6AN8nGz9Ok2uraob5AZ7/7YdVrlix0Fi5LbJMGMsiN3
	 2ptE/rpll7lRuXJ9LCvNE2vkBAr2vTbPa0Qsg5jGxv7zbl+I8bI8XovmpSz/Ypniqr
	 zKSGqgx9/WgXQX2CJBYpQwyH3NTH8e8+kAzeGNTqRR0qZ+7PbuegewHNdt3CL/0gm6
	 cjddfudU9hQaA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] Revert "samples/damon/mtier: error out for zero quota goal target values"
Date: Wed, 12 Aug 2026 22:44:30 -0700
Message-ID: <20260813054432.101197-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813054432.101197-1-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a16fd3ad9d89b05475864da97327870464611736.

The commit was made to avoid zero damos quota goal target value, because
it can trigger division-by-zero.  Now the core layer handles the corner
case.  It returns an error for any attempt setting the aero
target_value.  The corner case handling in DAMON_SAMPLE_MTIER is hence
no more needed.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index bea45c87cc9be..27dc88bdf7a0e 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -161,9 +161,6 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!scheme)
 		goto free_out;
 	damon_set_schemes(ctx, &scheme, 1);
-	/* zero target value causes division by zero in damos_quota_store() */
-	if (!node0_mem_used_bp || !node0_mem_free_bp)
-		goto free_out;
 	quota_goal = damos_new_quota_goal(
 			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
 			DAMOS_QUOTA_NODE_MEM_FREE_BP,
-- 
2.47.3
