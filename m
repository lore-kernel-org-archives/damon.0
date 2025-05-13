Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4133C465;
	Tue, 13 May 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096043; cv=none; b=GVJxQICHZGYcZ/1j8qVb/WIikviCA9aTJM2oV85loWUuOPapaOi/eujEADZLmTSRBSRcmeS4o6zvQGfN7gGSkYtnfQty8cr15vdiVdm3DjvjgiHKsDuYYxVMc3RABWenyoEABfx5XyNyxEOHI3wJC89TJwsMGzmyLwTXYubKkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096043; c=relaxed/simple;
	bh=+UepWcvB4j5IIdMlwj/7IUz2JlnuDciOXP00Kk2kwfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCPvjTo/dXtkjSoVFzJnOjBalcDHEBjtX2xCjZ0DxkInf/WtYLsQ/i42GKTvmcQc1Iim7AaXEGh23koW1mk0B22rvvdLeDh08QIEFPnLWTOv5Wlye7+r87xJ3IHaYdlpIWOp7UWtEvV7OmqrWmQdGmrdmtEZmF3koAYEaJ6g/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGM7q6NY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGM7q6NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0960C4AF0B;
	Tue, 13 May 2025 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096043;
	bh=+UepWcvB4j5IIdMlwj/7IUz2JlnuDciOXP00Kk2kwfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGM7q6NY0RGPtma6XKBKBDTDVamsbLcEe129SvMTYo/pYQTrlXI6ShYDpvNxv0GLU
	 hR9GO6oLEDQTcSi6abxDzJCmpRDJVsnee66r8l7krBy87wh+iwsAXvTvDTdyxYzdTc
	 8DiCetR/htAIJrF1RghTokeTAUhEJU5g0zwjcp+HM5Lv/wSMhoJ1WvYvtEQ96XceSL
	 +yDu+X9qcuJnV7WLQHB5Ze1t3bXAWCNcMSddl5DCiNYQU9wnUoxyuSjdnIaLiV4irl
	 WF+JtuIFW/2D/GBPh9jwnIR8IKqvc0Um7IOzTycboL6MIkg1YnU0fIqd7q8v1N0vgX
	 DuZ8j0AwpRzUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] mm/damon/sysfs-schemes: fix wrong comment on damons_sysfs_quota_goal_metric_strs
Date: Mon, 12 May 2025 17:27:11 -0700
Message-Id: <20250513002715.40126-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment on damos_sysfs_quota_goal_metric_strs is simply wrong, due to
a copy-and-paste error.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index c2b8a9cb44ec..0f6c9e1fec0b 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -940,7 +940,7 @@ struct damos_sysfs_quota_goal {
 	int nid;
 };
 
-/* This should match with enum damos_action */
+/* This should match with enum damos_quota_goal_metric */
 static const char * const damos_sysfs_quota_goal_metric_strs[] = {
 	"user_input",
 	"some_mem_psi_us",
-- 
2.39.5

