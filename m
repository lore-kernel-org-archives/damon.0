Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11E3D8915;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087590; cv=none; b=hz987+jAC4BR3sixdret3ThR2Obsikt+p32DKj9eBndb8WDo30u15ekJ2rSB4R7O5Ytm0GITYTvk/Nkl47mQ6LelOaHSXPRsUxtMuHiTuMeU7Y0LnelFiRpG3s7Mfqj3Yuphsh/5FaHy+3qBeWGgExLOcyY+r5u29wHXCPStwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087590; c=relaxed/simple;
	bh=G8UyQpSSr7hx3KQele5DhO9AhR7lBDUtfyry3fRhzos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsl3DFvj5jpuwbnUiK6n+8SpC7Dnw1ol6TGHJIUwaT8hfdiIUgfyiqX/PW7Zm6ECQpnkAm4buG+NjD5Vn0RAi9rt/YQ16e4UfzU71AS3Kjwm1+aAWt250T0ut6lcHYHHZWMVYJBJ1MbOCDXe5ACEVbb1aObB/5848vSzMv8XaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDMR24we; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDMR24we"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D61E1F00A3F;
	Sun, 26 Jul 2026 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087588;
	bh=5v3u710N58c3BJ9vFyK6txOeRAXwyATfa8JLFV4jnT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDMR24weEPDS5GWYzlJdIQ6Od8yYpTFdlDpKGv3upAnjCAkSysFCdrGH3RUZpFWZ8
	 cwihFHXxbpAyCeTY6MPqhGXiOMqazBpjaAXoe1EhIgwp8jDmB1oOFpvHOctWkcBiOn
	 JsbE8oCQCCnpxRNF6lJV4WKCG0sJ9TZoRS+YhP0YD45Vt8c+p9361gfCM/gpAG0EIl
	 U82snu6JVmOe6eL0SP3A7cJ0MyABGP77DR3mFdH51Xh/rFCB3rT75l32T0BAl1OwHT
	 A8MUBISnhuoqvjLM5siCgBMLOakbQYyneqJ68/TRRAzx8aP7Dxp1v0Jo8gTv6nXGFn
	 4l8ZrIQB8tvxA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 13/17] mm/damon/sysfs: pass preps to DAMON core
Date: Sun, 26 Jul 2026 10:39:29 -0700
Message-ID: <20260726173935.94046-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface provides the files for setting DAMON probe preps.
But the underlying code is not really passing the user-set values to
DAMON core.  Pass those.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f275a6f73eee1..d7a2b62322841 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2174,6 +2174,23 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
+static int damon_sysfs_set_preps(struct damon_probe *probe,
+		struct damon_sysfs_preps *sys_preps)
+{
+	int i;
+
+	for (i = 0; i < sys_preps->nr; i++) {
+		struct damon_sysfs_prep *sys_prep = sys_preps->preps_arr[i];
+		struct damon_prep *prep;
+
+		prep = damon_new_prep(sys_prep->action);
+		if (!prep)
+			return -ENOMEM;
+		damon_add_prep(probe, prep);
+	}
+	return 0;
+}
+
 static int damon_sysfs_set_filters(struct damon_probe *probe,
 		struct damon_sysfs_filters *sys_filters)
 {
@@ -2209,7 +2226,15 @@ static int damon_sysfs_set_probe(struct damon_probe *probe,
 		struct damon_sysfs_probe *sys_probe)
 {
 	struct damon_sysfs_filters *sys_filters;
+	struct damon_sysfs_preps *sys_preps;
+	int err;
 
+	sys_preps = sys_probe->preps;
+	if (sys_preps) {
+		err = damon_sysfs_set_preps(probe, sys_preps);
+		if (err)
+			return err;
+	}
 	sys_filters = sys_probe->filters;
 	if (!sys_filters)
 		return 0;
-- 
2.47.3
