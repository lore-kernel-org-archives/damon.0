Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2B44E053;
	Wed, 17 Jun 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707728; cv=none; b=N0v1ROzmZWDd3LnTnH2uoYbX+q6174eNd0aH3BClEbrzX9DDhwX474v4nwWbOI5s9cnzt9iOmDGgoAGkLEioFyk3be+nfe4V8jHUa0ONQxY6w/qvMA5OZ9X0pq9mxuazc+wUedYkf5bPT+gKcsKg+CGd+DKFMnaZ4vu3PgsMm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707728; c=relaxed/simple;
	bh=fi6lX815EX7DIpgNSFa0vkD5QF5JHxdgwNGUAa+4bIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeLFaYAo45CE2FgJfGmw1Qsy0q1LILpTLr9iT4fvIc6i7OGyvbF45Lcz9t/xGhPP9lmqAS8rAFg/6P3Bo8OMdDuTHUrn0RXYS7ZSN84kghuS9LHZePMjUdat64n/BArG72QuJ1i7FLR2iErh+X+C4qqHfnTW/gmtQkRPJsqhfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB0KHA/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB0KHA/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BCF1F000E9;
	Wed, 17 Jun 2026 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707727;
	bh=V69jCi4XbNmje4yP60Dxbb/L0C+xnieK6ht4H1cDOOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XB0KHA/K4VGjiEZRfZhsO6l5y4g+SMA4WmsJGyTLBkn1cfoI6eivorjwI/m8zHus6
	 cGsef1nja3A4l6IJA3J6q9AObiSQoCuOrBuU0JnllOCJG/aKfeRS6cuNCr/kBUWdPV
	 bqGkcr68AVdG3Dk3IPwnbVSb+1TxZ4tjishaXAraerjIvfDkDRvnPnyvOumUegH/yQ
	 8SR0b2Zjjeobv7PIY4qBGtHpai5uBUSLQwszxEJLBNVLK579LkN8ApIcYrJ4djeSRR
	 qHbbtE3nY83GIsgPA2sRwO8ILUNu4GtoISOkmDVwMbY4hvbtpUGK/j14r+/rrhu80H
	 dJkYheE+M/VVg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 10/11] mm/damon/sysfs: kobject_del() probe dirs in probes_addd_dir error path
Date: Wed, 17 Jun 2026 07:48:04 -0700
Message-ID: <20260617144807.91441-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix the issue for data attribute probe filter directories in the error
handling path of damon_sysfs_probes_add_dirs() by adding a kobject_del()
call.

Fixes: af7cb41af9a9 ("mm/damon/sysfs: implement filters directory")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 36a0e82601697..ffbc99411f53b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1183,6 +1183,7 @@ static int damon_sysfs_probes_add_dirs(
 
 		err = damon_sysfs_probe_add_dirs(probe);
 		if (err) {
+			kobject_del(&probe->kobj);
 			kobject_put(&probe->kobj);
 			damon_sysfs_probes_rm_dirs(probes);
 			return err;
-- 
2.47.3
