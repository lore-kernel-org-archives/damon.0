Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7043392B90;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318051; cv=none; b=t8YJroV8RFlS3hB9H72FIMQVzX0XhocAt9umcujDMFCLiL8DZrm3oYKCT1EN+04VmhUlNBupstjCzAosFxb55cW8OGEBXasJJhTMi8sgQTiCv6i+/9pmRyXvTM/sl2bc94GcZ9j/dQ00nS8EErMbHxeUqxXhiKE8AkTyZ6Jjy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318051; c=relaxed/simple;
	bh=1yLzbYEUiETjkqkRJcB6Pqye8DL4YZB4qDv/HnOmOps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ6vK1e5mnpQQjNM/ggzs38IB8p0GC3exqe6+iKZWiJB8KYAsDm6cBkOKnRDu2Q1gvaL9ibfP6KSi8fq6unh6OCWFhKd4r7HThaLRNmT+lwI7pRIjBuDGIuJSz4yW8u1Payx/73bmzBZryXb+Bk0GLekq8uruT88n6zQA8WYcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwOWgdQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwOWgdQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D71C19422;
	Tue, 13 Jan 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318050;
	bh=1yLzbYEUiETjkqkRJcB6Pqye8DL4YZB4qDv/HnOmOps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RwOWgdQbKo9fy3X4sYy5porDOpEkj5B8IZSuP7I1voJXWf0bUifkU7luWi7BAelAG
	 EBp/NJl+5Neo2tfWcVA/cxrjFOsXWAZ2XMX8JbaOw+aolPfDPm3+eVoo+5FLjarI5S
	 N3tnJOfb76yBcvBxTTZU4gpvsqsInowHNEsr/rPR5mXP2OFoODacz2H4r8Ps6qcsxS
	 SfOrlcZ/rKvRNo5NVdcY5hWqkwz0s14IIoBg9Wm1EDUetYIucnzEJyqZqMWWSOHSL3
	 nngr2TF2IdrVx1b14UpB8ea1TUgkcUYzAqpnHXnhfxCt8m5ES4xFx7N2AUcUCFBoCM
	 88J7IWrf+VTnQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/11] mm/damon/sysfs-schemes: support DAMOS_QUOTA_[IN]ACTIVE_MEM_BP
Date: Tue, 13 Jan 2026 07:27:07 -0800
Message-ID: <20260113152717.70459-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of DAMOS_QUOTA_[IN]ACTIVE_MEM_BP on DAMON sysfs interface.
Users can use [in]active_mem_bp keyword input to the target_metric sysfs
file to use the new DAMOS quota auto-tune target metrics.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 419d6e7ee945..2b05a6477188 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1079,6 +1079,14 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
 		.name = "node_memcg_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_ACTIVE_MEM_BP,
+		.name = "active_mem_bp",
+	},
+	{
+		.metric = DAMOS_QUOTA_INACTIVE_MEM_BP,
+		.name = "inactive_mem_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
-- 
2.47.3
