Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF55267732;
	Sat, 21 Jun 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527098; cv=none; b=qx3xO7GRv7OnxNxUzlOTyBN8QAejTf3K6cAIWtFLJepEv51/fxGi94kam+eyD5uGsGdElHxZMTmc/qW2CBab/B56fJhmcG2gCgaOkHhBBQKoAsrus1t7n5TKV3wLmMHOrp6l6EioquSkZanVNtSoc8a2fGS8Quy9OmormWAPDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527098; c=relaxed/simple;
	bh=pdcyWRPhdb/cEUr29Fl+//1LhV5HJEfdKz0MuDMK0gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lH8B5FKsKZBD6GuqBI2QOyblDwPU0V1JW1gWfckY9mQsA3VRoOHrx8kbgAWbiIDRwNlT1t5ci9TBkegPcbhJL1jl/kEIFDVciT8mHlL2XIaX3SxUhEap4QjP34prYlTmnVutuP5xk/S5Tzt6/9fvTHF0+3xrLWMQKiXNREDXN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dr1XIiLZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dr1XIiLZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B926C4CEEE;
	Sat, 21 Jun 2025 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527095;
	bh=pdcyWRPhdb/cEUr29Fl+//1LhV5HJEfdKz0MuDMK0gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dr1XIiLZ+ix4RZ5xxjvkWQBPfGqPsMo/4roF6u2SlzD4CGnSW/RUgOMiBatMc/2KI
	 PVyWMUBk7/VYWJXgY4vVLsHc3hRIyiWTK3ZLGxTDBmrJPthVzqwQnNWFWWMTh1fTXu
	 tPcbyzIv12jLvEzhl3b5RvevikWwvOsf352T2wEulKcYETmqANDQiVmQ2IBQDLZVe2
	 EVnE/FuUrqXe357rWuSRTtB2GG+n4A1PN76nR0qDk/FgFA/B9RZ5sN6MboArR+Lne4
	 Gd/HS9rfPObP4x5ngx3pqhl9D3VMebgS399V5mHaHGpxLPfBCpVvfLLBzA4oIGtQAz
	 q9pClqSAOS7ow==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon: add struct damos_migrate_dest
Date: Sat, 21 Jun 2025 10:31:28 -0700
Message-Id: <20250621173131.23917-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250621173131.23917-1-sj@kernel.org>
References: <20250621173131.23917-1-sj@kernel.org>
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
