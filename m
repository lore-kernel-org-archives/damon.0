Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B313382C7;
	Mon, 18 May 2026 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147684; cv=none; b=Yx/0uYfUUmAsjTFhdrjmccVZ1hHcuQY4BLO3VsTUC16ANfmlIjfLd9LPt7oLoUCY0WAxQynu2Fce0pvssFeE/0oe0Ap1mGdrGAheB5Oo+zJ8ylJy0QGvGgi2X/K9/OMuxkkQC1ofNp+kP6rnYMPGChbY+ADU5olAc6wL2LRb6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147684; c=relaxed/simple;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SItix55JbPdfP9sw9fYIPAV6VDwnFYjJgQ0/bGZbrHPDqnem/VbUwFhOjuSZb492jF+LK66eSXOe8nQ/O0jBKiXTvHji2r0qhD+j432kee15AGLBkmH5iIFj5EUxs41bGlu4B1Y/mTAZ07VqsF35uFhU56f7K1ujmLVL5fSbvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ+RRDi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ+RRDi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F4CC2BCB8;
	Mon, 18 May 2026 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147684;
	bh=Kv/gTWHqRbjarAkUDYzqDqtowKyfqdWveUKMXCNryl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ+RRDi6YBmsa/4T6O0oOaztaI8BRoed5K2kxdEX9GjQoU0x/rODNv/eujhCdwa4S
	 b2y59gcw76olyuSLgZ27kWlEJBODOr+CpyXHordESuJH84aCwzwDHNB6Cnjt2SFDJo
	 j3Pk2ZqKMLZygNozt/DuGwFJDD+CtamF1mY4z2nZOf2RpvOihG95q22gjotx2zHbu5
	 YSEC/jarx5GJBNIIbHicVbilG/hmAkriybKNOBGUPEDg0JQIyElNWx34RrdPHnBqgq
	 Md40eGcrwVGzVJgp3o+vozedcZC+jQIMOaZ01kT9BmHd3vfZwHqGL2tsv8jvwQ6fJX
	 UCJN8PwdS5L4g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/28] mm/damon/core: introduce struct damon_probe
Date: Mon, 18 May 2026 16:40:49 -0700
Message-ID: <20260518234119.97569-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a data structure for data attribute probe.  It is just a
linked list header at this step.  It will be extended in a way that it
can determine if a given memory has a specific data attribute.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4d4f031bcb453..4794931fa2ea3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -730,6 +730,15 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * struct damon_probe - Data region attribute probe.
+ *
+ * @list:	Siblings list.
+ */
+struct damon_probe {
+	struct list_head list;
+};
+
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
-- 
2.47.3
