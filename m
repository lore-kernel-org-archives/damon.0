Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97955333423;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736435; cv=none; b=FRFIJM2sthTMix0OACStsSx5jJ/OFYhon4C6FcoC3yuqrE6Qy+uz8BGYRk/p2DT5Z9nC2CcMqM2vjNDDPPUnkb9X8TpD1ix1/JR9agzv6v3oS8L0eYgSVmGbcPcwZZfe1GoLw6KtO+7KECiUCJNZOAAsXtCACjB0MERPyqMAocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736435; c=relaxed/simple;
	bh=PeYfeE2IAy0+xdX4Fi40UdJR+73VcJkJ2XijKRhczHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxY7DYZ/GEKJxSFJpoRoDyOACVrA+SZ+ZVXzo2HCorkyCBL0ZlKUBJMoSuNXYZPY4wnvycROFpgPAX1isHWQDN1YdXEhgaAZDeNcDiia0YfxT+XdPLATFbz8FvqHUhohiti4hENRaSZebJrCdy57Hu1IXpgV43TwJZ6IgBKcNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRBgGGWz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRBgGGWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626AFC116B1;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736435;
	bh=PeYfeE2IAy0+xdX4Fi40UdJR+73VcJkJ2XijKRhczHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRBgGGWzBbvi48oZxlBMJilkQ39aJ5kTPsrxNezkedQxg5ESYKEAoiBMBs23dJlZ7
	 iAxuFABZq4nh0DVOcsCx3oeluVIoFlLUDRJTGQgUwhbx46BQMlE4vDbCa43JuKODEw
	 v+IkO6XF/YZK0NWK8QPx3p9wv2MGqN4VrPNaDuXaOwaCV4mQE3kjhTmG/5pqwEfm+F
	 18SgycU4J7Mntq5hoiAokrpztEmKXIuM1yZeNCuQv1q775St4DH/yosDqyR3/igebY
	 0UK0uSFPQR2+Z4VxYYIdw43Pw8Z0z8A3NGPPV1INCqCvs4M1PGndx3a5wdSDV2eex4
	 gSUwbiCKiX84g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_FREE_BP
Date: Fri, 17 Oct 2025 14:26:59 -0700
Message-ID: <20251017212706.183502-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs to support DAMOS_QUOTA_NODE_MEMCG_FREE_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index c679e62fd4b9..c98cf4bd2fbb 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1034,6 +1034,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
 		.name = "node_memcg_used_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+		.name = "node_memcg_free_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2552,6 +2556,7 @@ static int damos_sysfs_add_quota_score(
 			goal->nid = sysfs_goal->nid;
 			break;
 		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
 			err = damon_sysfs_memcg_path_to_id(
 					sysfs_goal->path, &goal->memcg_id);
 			if (err) {
-- 
2.47.3
