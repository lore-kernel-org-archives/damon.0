Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE72F6FA6
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487265; cv=none; b=QfPnFWu2h/IkAa2iEwmUMiGRB2qih5VJa140kZ1ZTpTSKhojSImX/ZdJe/U4gRObgW+m4R0Y2onfPLfCVbXTYAJS9W1EIMbaOBtGDm0Sa7zXk15yJZNu9FUQGmvvHdU05bn1sudmKraFXR/5boYCiswyLlI3+/hWAvVA+IMV/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487265; c=relaxed/simple;
	bh=6ckvsTJ0k3MJxqXPk4gHWmVH8SQj1M0to+OoYwY2kBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT5uDum6OfGE2JHk5yHJROQpZugBisVy19ynOoYclN3A1IneEkgqmE2WOn0PRTP3zeaz5LW4kLtWiq5AP9TdfYtixYNVuPMpokIJrmyQOajGvMK+cHzHvT/KW6LQI5nLJuSB2T9BxDkwwt9mZaLL7r7CwUoRwiY7BRa5Tzff+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2qwlgM5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2qwlgM5"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710fe491842so69407837b3.0
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487262; x=1752092062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV7c5B61vQxWIW6brHrpvujjHlceZq5NHO+Y3rO8xqg=;
        b=B2qwlgM5UJtAt2cnMIJRqgaeEAQTf/gEJqHpa3vXGu3NibkVC5xgBGYOB8cjm+Xvsw
         XL2NQIc1nia9kqJzOl6fx4Clt3lZFthE+zfw5U9dhCEpM4z+huS94hy0qMcg5qYbt1wQ
         lGw7J9/oJ1B7YLh/jMMqA5t7hNAwTQfoN6Pbe33EadBnfA13UZ2fmAELwX4yOZUDKgOe
         Oo3En6uSRwxPFjE1uvxDnqFFcZDZGiosuf9RlBjNwnOhYe3HFWLixtYh3R056CTN43Lc
         b8REaHlc5afCvfpbS5GBlCCixWE06PG04Am8ZzIdPll+xuTYLSFzf9JbHKJxA7y+2q41
         UThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487262; x=1752092062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YV7c5B61vQxWIW6brHrpvujjHlceZq5NHO+Y3rO8xqg=;
        b=RfIKVa4IAnSCVKsFFQaKPAkWlzHUPUHFLhv+iys1eLp/tHjr2J5tLAIFDUf/nqgm+E
         j97TLlXQ6Az9RYUsyZbKUWl97uNzWb9otulfaPOgn4Cng5MIQJBgQffiWkGHwDgSfLP1
         U1yIjTCP+gmbL16bRtsv69QcHHnegKUCG0lk5Xzs3KIqa70KmJRdNrFb9CBDgqNuxZ5H
         AlDBmxVvk3LsZTrhjOGhZnyLNSIg2uQIwO/GSJvoV9CuGP58l804NHMQJGMyRKcDljuj
         2aR/nHeBC9+0z57CY/DiX5V7zVn1ByRxsPi4D3l6inDGyDc8FHe2J7kens6b72HcntGu
         MYvA==
X-Gm-Message-State: AOJu0YySuJsXDlwGJcMhxo6hyZvY7a3AyT26+1gx4mk49fTBYOjBAIot
	md1CUF7udPjGDSWwQH0GzxwGQ5uvjJIO0ThOIICkwk4u5gkz3RxyyN1rkyr4I4LHaSA=
X-Gm-Gg: ASbGncvbr4ZQVhkDqWbIaS14fNXnLbzvXoduiIssox1KbkQhOi4u1BoAvYnjX3c3XbW
	+Papa3EPA4jZ5MPGB8wqAkejrO4o0KAkcB/KI0rNG849ES3bUtH0gBrVtSrtDjqQpdJddhte5nS
	4KyuT4tsmf8bHami83iO+MJAKV76ZtUnyrWktH0p3GHuwKDpRBQM235WXvUrODG7Hth8m0EvORQ
	/9Pd0ZXlR3lqYJLa0V4Um7f9fVHaNtoqznYb0x/mRM+EOVbhBrMmG9JImXeEFQqqG6XFwcrzvDc
	DlaeUUqngc2vw8FSsJXYVpIIqM3DUxhucZ841EtaFKPD07PuUZVmio9YMEdaf3O53LFOBvT3SCQ
	obgb4NyM=
X-Google-Smtp-Source: AGHT+IHp1CXE+NbRDNbbZ1RkBJrHvXGjBoQplUW4P2ktChHA+wcWgIrifVUCN244xHgPY9Y9aBH+kg==
X-Received: by 2002:a05:690c:6ac5:b0:712:36f3:f6d7 with SMTP id 00721157ae682-7165a3e0987mr5233677b3.32.1751487262117;
        Wed, 02 Jul 2025 13:14:22 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:21 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v3 04/13] mm/damon/sysfs-schemes: set damos->migrate_dests
Date: Wed,  2 Jul 2025 15:13:27 -0500
Message-ID: <20250702201337.5780-5-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Pass user-specified multiple DAMOS action destinations and their weights
to DAMON core API, so that user requests can really work.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/sysfs-schemes.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b9434cdaacdc..74056bcd6a2c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2576,6 +2576,29 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
+static int damos_sysfs_add_migrate_dest(struct damos *scheme,
+		struct damos_sysfs_dests *sysfs_dests)
+{
+	struct damos_migrate_dests *dests = &scheme->migrate_dests;
+	int i;
+
+	dests->node_id_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dests->node_id_arr), GFP_KERNEL);
+	if (!dests->node_id_arr)
+		return -ENOMEM;
+	dests->weight_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dests->weight_arr), GFP_KERNEL);
+	if (!dests->weight_arr)
+		/* ->node_id_arr will be freed by scheme destruction */
+		return -ENOMEM;
+	for (i = 0; i < sysfs_dests->nr; i++) {
+		dests->node_id_arr[i] = sysfs_dests->dests_arr[i]->id;
+		dests->weight_arr[i] = sysfs_dests->dests_arr[i]->weight;
+	}
+	dests->nr_dests = sysfs_dests->nr;
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
2.43.5

