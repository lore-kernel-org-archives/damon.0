Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCCE36EA88;
	Tue, 31 Mar 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934829; cv=none; b=gFpFqDTLJdqn4MEMrm7EIfqvwqTG4E6XUpfeg/cMqsOQUsNszdpqEoLHxTQHouLDCym4lxTIucj1119pm4VQ6hkTAGAU9GhkOTQsXJrFj2zS9r56DhKMyprKTLTk6pONOHLFIQp0af/+nHibvdOvS9cFwuiTWLG95UFOc9YhtxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934829; c=relaxed/simple;
	bh=OUhwl+3SlasF9H3tNYW60V7D8FMSzXnMK2DpCetP1TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoQ55KJdvwTrOXVmyQSo0JqeUQuSzq1Uj3qEVk4uNuXQaaPHARcZwgGfIgl3EZ7gKhCF2Gr9S3DEOqJBslRcMnqyRksCoacZ17YGP5Aik+FjyRzE5vTZutmRgfqkcVrTueKHzN16VXM+O4udF6C44v+qyoDLhMxIhgWzU+XxaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7kwzDNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7kwzDNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6082C19423;
	Tue, 31 Mar 2026 05:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934828;
	bh=OUhwl+3SlasF9H3tNYW60V7D8FMSzXnMK2DpCetP1TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7kwzDNR9EjOoUTiUwMBahk+fZSHjJjn2CwxItYa+W9uAGER8ObrC557h/Q+7ha8b
	 VCdBLEMJUkcpITGDvZNc7a7MB7ki3kzgC+I7c+4JrImnusS9ZkRvNu+jAwB6E68E4c
	 vkDeb8aipKYR+tktO2WbhAUm3qr/TQnA7jb+VmGD5ZZTWEsLJF/V/0M2BM5DD915S2
	 QAm6+9Nlwm6UVLgQ67jopExEaILnS3SWmul7/N3yOClU6ZplX5AgcCGUZpwAbrPdXV
	 RMHnmi5e485ueExn5gSs9NBL4BBouiiHHSqHzPkcqhjX2GuSPXWHZoIL36Q8ZkW/J6
	 0gu3Zq8QZZTWw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	Josh Law <objecting@objecting.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Mon, 30 Mar 2026 22:27:05 -0700
Message-ID: <20260331052705.71212-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026033032-savor-relearn-225e@gregkh>
References: <2026033032-savor-relearn-225e@gregkh>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <objecting@objecting.org>

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that kdamond->contexts->nr == 1.  A user can set nr_contexts to
0 via sysfs while DAMON is running, causing NULL pointer dereferences.

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

Link: https://lkml.kernel.org/r/20260321175427.86000-3-sj@kernel.org
Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1bfe9fb5ed2667fb075682408b776b5273162615)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7fc44f279f4c..6545ab35be36 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1548,6 +1548,9 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 {
 	bool need_wait = true;
 
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	/* Handle commands that doesn't access DAMON context-internal data */
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
-- 
2.47.3

