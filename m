Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67722C355;
	Wed,  2 Jul 2025 05:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433367; cv=none; b=gsiofbEP76WKL+HpGaeFqoGanWhLFQr5XFgT9L1ZDslG8Fep9NJLKTJhMpcHs8PpTEDbKIScf8jK6xocVurdI6Mnm8gaoq8jV6xiaa4fs0Lyk9YqPWxdULTMzo0ZTBxpD9NNPTwHk+uk03oo8Vj2XrpN6KOF6qHMFi/2uUcIgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433367; c=relaxed/simple;
	bh=pdcyWRPhdb/cEUr29Fl+//1LhV5HJEfdKz0MuDMK0gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioEFIhKsAlylQvncZ4oh1eQ0RWAYugIx3f8R4ZwsFSjFvQqH4scKHZFCMnqlPxxXZ3f91dMXRw4h9CfltGKdoSGtKn1Qw3R2FlYp9oZyg85Zv32RCZTopIZ9QrtRpKC6qXuYyXJJcIH7Zh+BEjs+k73eJ2t4pLecwmIQNGXuEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKLPHEDs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKLPHEDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA4BC4CEEE;
	Wed,  2 Jul 2025 05:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433366;
	bh=pdcyWRPhdb/cEUr29Fl+//1LhV5HJEfdKz0MuDMK0gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKLPHEDscW0asBaatY8YWMDSRwEYdSjhUjAouUQLJbPr0zQ0Ri12x3EB3Z/IOUcuE
	 Am6Fx5D/vFvsOSwoxt6p6UBJW52c6y90isCKkUXNfMzTQ1qbeQm5Rfm/QFP/K7TzJW
	 u6HMGmZ9/TMMx3zXy39Ibb/4vZvWU9o6mZ29Z+XB78wSaE7hCb2WwppR3SxfF+4KTc
	 55XGYZVZxsU+ZYt0lH/tsrNt6TiIGwqq4UpHabPrMM5ylzQjJT3beq4HqE7l0Ra/9O
	 ro63YmYEqBozIfJtJLIvHDkbTSIaVRRKa/GTsqDS5MKkUHuSc3/HBVJq3FVjyNMh2e
	 PsYCnxhaLmUbw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/6] mm/damon: add struct damos_migrate_dest
Date: Tue,  1 Jul 2025 22:15:53 -0700
Message-Id: <20250702051558.54138-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702051558.54138-1-sj@kernel.org>
References: <20250702051558.54138-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new struct, namely damos_migrate_dest, for specifying
multiple DAMOS' migration destination nodes and their weights.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb58e36f019e..d60addd0b7c8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -447,6 +447,22 @@ struct damos_access_pattern {
 	unsigned int max_age_region;
 };
 
+/**
+ * struct damos_migrate_dest - Migration destination nodes and their weights.
+ * @node_id_arr:	Array of migration destination node ids.
+ * @weight_arr:		Array of migration weights for @node_id_arr.
+ * @nr_dests:		Length of the @node_id_arr and @weight_arr arrays.
+ *
+ * @node_id_arr is an array of the ids of migration destination nodes.
+ * @weight_arr is an array of the weights for those.  The weights in
+ * @weight_arr are for nodes in @node_id_arr of same array index.
+ */
+struct damos_migrate_dest {
+	unsigned int *node_id_arr;
+	unsigned int *weight_arr;
+	size_t nr_dests;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
-- 
2.39.5
