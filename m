Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE7267F58;
	Sat, 21 Jun 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750527099; cv=none; b=J4GCBuOcifXrr2n1ahF/VwccQzZRYNCBi0fl0/MxQpfTnoQldcLRM0lOPTBVofOMARg8KuwVn/Y19NpLIk9a+Iv0T6Hp4DUUxP6QbgrKtPgFsgkk0+TQBSLhb0xuleQjHXH2HQlSXyf6KASgXyGOI4RqXCRScv4j+pT2AXqPkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750527099; c=relaxed/simple;
	bh=Yysf3LajEIuwtoLoQcbL1zEZegxsuk3/GotP4vddbz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+3837xsGIC8q9QzXzDlBzuHHQBRWhrzFwxe4uXY+NB6exBDXytGNKb1De69SU1dN3S56DeJTA/J3t+m2rsctsyNCw3ypMH44XZrMe93BFNlqI4O9aPjU1FcvTE2JkDQofiE0ZkiT6ymcm8dQ8QHsIHl16qGBz7OFyrByHg4U14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP52vihA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP52vihA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7794BC4CEEF;
	Sat, 21 Jun 2025 17:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750527098;
	bh=Yysf3LajEIuwtoLoQcbL1zEZegxsuk3/GotP4vddbz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EP52vihAGOvoB7EdJ3ZYt5Celh2McBShfE+llp9YSQdwmeUWFrcCxPF6DOSvCKaEp
	 t1kS/NLjjHzjZjMnR/Dbf1PBwXe0VJskyhjpuOCFKb+nWpPl4X0R1mdV33O2GVCJ18
	 o2B/ECLOWLQpzlfvwFEswh7W0HBeKeuBynvQ79uRdJU2lZg6G500FAfncdtWSY3Wge
	 D1vtDrY+VjjaPjfLM64jPc9Chc5ik6jyQ7fD5Kto6nUbMQ8cU61NRxKnC+/LGNFVjz
	 O8JHNK/6MDtavuJrSG3V1B34Y7568FUDxpuWKPOMT3HqkOklx6eQnB04qREJGtLM7g
	 ESnMkHIOTf+bw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] mm/damon/sysfs-schemes: set damos->migrate_dest
Date: Sat, 21 Jun 2025 10:31:31 -0700
Message-Id: <20250621173131.23917-5-sj@kernel.org>
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

Pass user-specified multiple DAMOS action destinations and their weights
to DAMON core API, so that user requests can really work.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e04cd8d592b8..158a2be3fd45 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2445,6 +2445,29 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
+static int damos_sysfs_add_migrate_dest(struct damos *scheme,
+		struct damos_sysfs_dests *sysfs_dests)
+{
+	struct damos_migrate_dest *dest = &scheme->migrate_dest;
+	int i;
+
+	dest->node_id_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dest->node_id_arr), GFP_KERNEL);
+	if (!dest->node_id_arr)
+		return -ENOMEM;
+	dest->weight_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dest->weight_arr), GFP_KERNEL);
+	if (!dest->weight_arr)
+		/* ->node_id_arr will be freed by scheme destruction */
+		return -ENOMEM;
+	for (i = 0; i < sysfs_dests->nr; i++) {
+		dest->node_id_arr[i] = sysfs_dests->dests_arr[i]->id;
+		dest->weight_arr[i] = sysfs_dests->dests_arr[i]->weight;
+	}
+	dest->nr_dests = sysfs_dests->nr;
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -2507,6 +2530,11 @@ static struct damos *damon_sysfs_mk_scheme(
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
+	err = damos_sysfs_add_migrate_dest(scheme, sysfs_scheme->dests);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
 	return scheme;
 }
 
-- 
2.39.5
