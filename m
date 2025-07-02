Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66626232369;
	Wed,  2 Jul 2025 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433371; cv=none; b=i1T0PbbC9rQMf1r1TD05fL7U/jY/DQgI5s5LvictNXoBGQKQ6jBhvq1XJsNFRi/azACN5U7u9H7GoMseQgtOCLqPQ46JDL+OKBl92uAEsYH/wR/jrs88TJQtVu/23Fl4JgxH04F07qO92B+OK0keHFniNXdWSIm7s/NpfwDkjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433371; c=relaxed/simple;
	bh=eAY5XLYA4mfpfPr9vGq4U3HvZbAGIjijytVFdcL31aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw6toOiDa8WnEPQOnCwIIJEtnGw94yeqZuqZqsPwSXuGa5aJl9R1IQncrptVZqU90vCMMe0KEHwLBP3TrudnwxFD9vzBwM3txcB2OWQbny+rqkOO/t/k79pDS+FGpnOnFZEIppm3ZTfjZGwajwftSyyE676pDKdNvR5CLirGOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjUBoxZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjUBoxZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B860FC4CEEE;
	Wed,  2 Jul 2025 05:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433370;
	bh=eAY5XLYA4mfpfPr9vGq4U3HvZbAGIjijytVFdcL31aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjUBoxZk6Rms4kw/kYxkdd6eKSFU9bLTPMv0wpNzsiwC/Bp14SfV1NKKdPJ8WpLrh
	 4BioumljZFgdc9qTxz+VREa6wLgZg1hfllVZhSD6s2Dzz0c2F1qS1qmlqffijyHfnZ
	 /ZgaNkP3Xr03ssK20ZdNBo3kkhnyVXRGX+khYYJgCvW9WnHGcHlRJOPvAzvEurJyRN
	 b1bYq7oQqJebeWIjMTyZKWuPvxwBpFGhF5LtbB9JOkNC56fnWVL1486wmfw6R2WWTI
	 Qm1EHmh73ovoF+e5LxiWW2dqmO1zwoWYtScnpscxZi3hcfK3+9fp0MSPcjlCKy8JLo
	 zyXD64JeNAJGg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/6] mm/damon/sysfs-schemes: set damos->migrate_dest
Date: Tue,  1 Jul 2025 22:15:56 -0700
Message-Id: <20250702051558.54138-5-sj@kernel.org>
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

Pass user-specified multiple DAMOS action destinations and their weights
to DAMON core API, so that user requests can really work.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b9434cdaacdc..507ca7708078 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2576,6 +2576,29 @@ void damos_sysfs_update_effective_quotas(
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
@@ -2638,6 +2661,11 @@ static struct damos *damon_sysfs_mk_scheme(
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
