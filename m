Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC733D4FA;
	Sat, 21 Mar 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115676; cv=none; b=UuvnVYl7QRZmjGDcXGwPursyh3kJIB2WEMzVp0ABtdEaKh22529yP6dkj44LcMpGAo9Dczd0K7vJbeVtOVjq+S9623vxXXctIClUIo3e/65MmXvOrvIRol1FGiv3c8tGxmfIIemfPeKPUSzvKpkCRLSxNKdNhCVH2UVCobg05fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115676; c=relaxed/simple;
	bh=ozaZfolHMPA3TCsXC61RgAmpZFbdf9+Z14L9tHNxdsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1dnZrvG+NaAOoWnVR75WCNOxFblggyQMUeJxma4ZSuxR8Qi8ch2vAh47Z82VNgHZ08+O2J62mrmKms/Km/2JFGy6KJRTkq62FJWTtqA6g+4Lzq7bevlLu2FcQ7aaHc324X2TGcTccTDZ1cVoqFqzXnIUYzI2T9iOXNH1+rzOsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCIHzKeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCIHzKeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0406CC2BCB1;
	Sat, 21 Mar 2026 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774115676;
	bh=ozaZfolHMPA3TCsXC61RgAmpZFbdf9+Z14L9tHNxdsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCIHzKeX5pvZa/pwEj3y0EPD5StACRN04orUN65Kdv1WXpLao9Dujx/qWb/mXU4+C
	 RVus4wCtn5m7UE7RqBn42VtY5j9UsdYWu1juthqS5tAfl5+UpXVYz7n1nn0uMaqh2L
	 d0G5RwzGCzVI+SAvT6EVzdyKpu7150vdTBnFLBktJ8ZJnh/KP+hZa/jy/ocj33DodK
	 MfA3LgZbo0y5KgbHsEJFWJQZJtbssPudiDvd0u58tn5HsXH1rP+itsnU9dCrSLUdyq
	 tocW0aUsuhxVLw8eshlOWJLk3oKuRZx80ObGUz5H61jxy340nZPrKjLz7h3MRPlEeU
	 qZGrGlBzTQx8g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Josh Law <objecting@objecting.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Sat, 21 Mar 2026 10:54:25 -0700
Message-ID: <20260321175427.86000-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321175427.86000-1-sj@kernel.org>
References: <20260321175427.86000-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that kdamond->contexts->nr == 1.  A user can set nr_contexts
to 0 via sysfs while DAMON is running, causing NULL pointer
dereferences.

In more detail, the issue can be triggered by privileged users like
below.

First, start DAMON and make contexts directory empty
(kdamond->contexts->nr == 0).

    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/nr_contexts

Then, each of below commands will cause the NULL pointer dereference.

    # echo update_schemes_stats > state
    # echo update_schemes_tried_regions > state
    # echo update_schemes_tried_bytes > state
    # echo update_schemes_effective_quotas > state
    # echo update_tuned_intervals > state

Guard all commands (except OFF) at the entry point of
damon_sysfs_handle_cmd().

Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Cc: <stable@vger.kernel.org>	# 5.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b573b9d607848..ddc30586c0e61 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1749,6 +1749,9 @@ static int damon_sysfs_update_schemes_tried_regions(
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
-- 
2.47.3
