Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F62190462
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022834; cv=none; b=kLVAtJmJE6vu2PiUzvPH6kgNhh+BS8cIy3U+Co6H+1d5dJNkvwTPAUHy27ohK/6Nt4Fm4uxxuJ//tvPN7jX0jCdQAPfRtxEcJ4+UmzrvRUodL23+0VYaeHA+D0uCy8p238jmoKDfVVkZvceionr9QgRD49GO+q5j93ncNl5P8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022834; c=relaxed/simple;
	bh=kBGVCYlBO0JURIWpfIht3mgfCTHSB2GXv7bsD1cphHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOOKEzFZWuV6qU5al0nYuOo0Mx0Frlt6qDKmwh6En1othbDT+aqCwzm+hGy07v5KSMKmlsCN2ALGGtmUGs2tLBaiM83RQyfVLJgUFOL1Q9Z7XoxLJYgkzYiJdX34Beqs8m+4Oi7QvEHZnEpzvfEGhzRlSdgcllVcQN+LvuwwoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imHLytmJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imHLytmJ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e812c817de0so3927143276.0
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022831; x=1752627631; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqZ7kP81Zaq1arwauUEMN4RtZnPWf0LKmXEbv9bw+8=;
        b=imHLytmJAcxU+NR3lQ7dw8bhJXYjA+Izfe2B+fBXtzxm4ejrQlLs1J3/BHawAx9p+e
         ATzvRAaOM4ldHE+ZDKqFWm83Q451BbFwQO1rK91dgqnrmYquwf3Wvp2H0vcMp7swFvRD
         EqVcH5jpt9W/EWXO7OqYBvoFAytwg8QQjGnO1RkxlMnP0IixNUE4XrTzXQaWuC2Yl+2x
         A8nKjywpgqvlMRm8hK8EvlTd97LTpaSolEIDxMCMV7Mpji/jxUb+XVyvExlSrok4poJ3
         HB554R39CxEW/d1ihcNMCB9say9h+Lfy/0qz2wqAVcXUrnXycixhWiSL2O2TB1WO4T9f
         y8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022831; x=1752627631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRqZ7kP81Zaq1arwauUEMN4RtZnPWf0LKmXEbv9bw+8=;
        b=FbNSWbMk5U6CDZ+JTR1F/YNu0arYNUsCtyQDjpfISP04u02FIcJMjfa1JTxcYj8OJw
         phr3FX3qz0goJkmc/0pjLiEL/rZ1frKPJNcY5YGBjf9aoaOv7wP/o3FZvkofye5caHkp
         R3bhV/XOfhA8wfowfII2frVHll9UKR1dfF4lI2ZoUCtGCCyosCgx7axEP2SakydxbWpL
         ydKMZ2xLKINgyJtClWlgWLbb3Cz3d6Imt0AMXWTNjQBlWnhcEPAw6E7zelNGbEL4nLdS
         LuDS2WB0aETl8xN47+sLCL9vCroE0kicX8Z8JAXR/PlOTZptj030OjJPxzIzZ+JCyJbD
         DJ3g==
X-Gm-Message-State: AOJu0Yxry29IixmHlIMwzowPwevFX+N5RqMTRlHcjjokOQDHusyXkvq0
	M0UJyVhOdsBcIgZKwKk4ejXor2C/E0oiFHQB+7HZqXPP6QridUtY/gkxqq3/ZxvdyUs=
X-Gm-Gg: ASbGncvX1Inaa0O89cirBV0+YaxRioRJADRUKdWfBnSbqDX1BFmeJTxNCfpGL0vxqF4
	W/YQRfVejwxRXE4hBQi8cQ3v0kuOJMSwRpjHxv2Ar89ig7EQ25zaZW73hSYhow2gteUZayI5LYI
	LX5/7UhD0obsMOEss7C9TJ1aJgYfEyI+rerZXw1ne5FcZPjIcdWXYIzpTQdShxi+WrWGhaZwy9y
	e+sBkTlBctuAxI69IunBmEGKHVqL12l28gBslv5c2+i5z6llRJc03V15I1WdaroqpQ4bnMO8Isd
	rJ6dGRM76onlXLvZ89vfd63Pn+U2XsCo6aI0l+MW08VFwdVibJBJZHco+HP/b9bo+n5J72Fim7/
	n/NX4dkOcLJUM64VLUw==
X-Google-Smtp-Source: AGHT+IFFk12vBHKfYShm0xwUy70JkBS9iNu9v3bAoNdevYxQvMw6G4nHxm7r8pPOOSVJOc1J+GaBlQ==
X-Received: by 2002:a05:6902:2846:b0:e84:3769:d7e1 with SMTP id 3f1490d57ef6-e8b6e0dfd76mr1151677276.8.1752022831313;
        Tue, 08 Jul 2025 18:00:31 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:31 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 04/13] mm/damon/sysfs-schemes: set damos->migrate_dests
Date: Tue,  8 Jul 2025 19:59:34 -0500
Message-ID: <20250709005952.17776-5-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
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
2.43.0

