Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2336145B3F
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022826; cv=none; b=i7b23p9f+kLvyOEtYvQqyXVYRSXbuCMdIn+Yi1g7hSQ/HoER2TbcHESVXRSGgnVFuVcEDk4IF5lZq69IJtMuVkL1gnzxPAWxwXe6s47RhwOxTaPg+Q13h5K4o7AdpW+j9gMMzYR7Ydl56M1+5ewiCZZ0md2D0zEpLr3ME84AZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022826; c=relaxed/simple;
	bh=TF36DmJ4gRDLXGKB0dablkBerf4+G3+9gH3N4qFv2Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVBHvIRIVpOWyM4xuI50JQdHKAwtTv0Wg1h9B4WC4YsMlvVA9qQqtPxZS6/VxAnOzPYW52Cfl6tbt5C1fgEjU/a48dZ/NufcJJJKdAV69XEPGDyREpUI+ekAdqO4LGz8bjZ0QYCWzNeZ2JvEyjNxPET69QUN7OcvywDXrDVidb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuQQo1MY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuQQo1MY"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e85e06a7f63so4528340276.1
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022823; x=1752627623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TgSHi8o+LhWVBXZHtMiPoCLNZyL4Zo3x7ltlQyypVA=;
        b=BuQQo1MYGRjnlik4l08BKfnsxpVYZDnAiitQn6A8FBxBss8hHRM+Eoj+sDfmwI6twR
         GVTO8njHYmePrBch9V+58c0LZcHh6PSbyf415e1lILyzNu0J8+wnTLQJ47a5A1QuVy42
         Q7fpwcqQA3wH3uiFQwOsi5nqoEbkrQClZ9sbtogu35YEIPlM2GnrT9WfxM1eShvL8S+b
         NtbMM2dvu5nlseg8xpCVEiQX8oRmzRBd8uAP9CF5Ee+Nbwng0gYOCX6edHGw4FGqeP08
         3QSGxK/7dGDt77+PHN1ar9szkBopxGvOFt6eAAnZ175YLBoAtNE1az1o8wY1cMvNILCc
         cYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022823; x=1752627623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TgSHi8o+LhWVBXZHtMiPoCLNZyL4Zo3x7ltlQyypVA=;
        b=PVw6+XPmoMCImXCWaZLJ56nMxlNxdGwrhMTICvJOMVdsjzsTLRZncCM7eyhfAlWDzr
         WSxskXPlgOGMy+eGZqcyj+YShU87NZSLN17hD/k5yjWa1Vw5KF9MNGi9LuKz9mJ4p45p
         meqr7HU5Ts5QOQTRJKySM83+AmiwhMOZvso9jqFCIr/sBm3ATNDdsF1wJO5xQFmFA+yd
         rfYoSIV3c4hSuaojrv5MHhzwStY27CbEHs7IZksAVmk4TjhzoLOe6dUR7KfegNo2vlQ2
         JYN0fE+jWYhkTJkoORHIz7H7TnU4YUZogwijd9uFEOsVcjRDzSbJ0bE/TI6wI310GPjN
         WI/Q==
X-Gm-Message-State: AOJu0YySfUJri5eYSJID900YHVnt4X/VVaERqaS5qXrbLTzDnTGZQsmZ
	PENnEX7tX3J2wYps6d8PQ+csVJCLfTVfwlEl6/Lh24E+H5XGqmALp3VhZYzEW0FjvpI=
X-Gm-Gg: ASbGncuJL+LB+FgdxHToUrKo62VT2jJMse2lbFne8GLTeaYEXg4sIMPDgGR4/6yt3nA
	Y4Ks8VgSm7+ue08Ce/6QBiuvAb218TBANW2dxovgiK/mlZHwEkp7Ut6HZWnl7gvjvbxHUYPHVXw
	HBo3PZfmbOWw0L1Fm9foQFwUh1EFUlZL8sd47Hhv86xNMD0krFt2GN5CYba5+zuTN37JIe/rolR
	hW65ipX7ZGjFAgraq6f4PTJVFZlhoA9fiYXcQR7+ZbWxJUpQ9MGmsHsX1H3umtC7PVwI6RGjRzQ
	kKFcMOjZ1WdeWJ0peC8u9an0jHOydh49ybJPPnwQ/6ukx85PqiIrpRqjvTu4YVr6Kc0iWpvXVUS
	QzeujU+Q=
X-Google-Smtp-Source: AGHT+IHKEK977MUyeP+iX8FWA6em280Bb2xxq8On52e+HzVmSP39OMEedbCQWl+WgqWCiO+aaXyLvQ==
X-Received: by 2002:a05:6902:18d1:b0:e89:97db:e13a with SMTP id 3f1490d57ef6-e8b6e0bb33emr1141015276.2.1752022823136;
        Tue, 08 Jul 2025 18:00:23 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:22 -0700 (PDT)
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
Subject: [PATCH v4 02/13] mm/damon/core: add damos->migrate_dests field
Date: Tue,  8 Jul 2025 19:59:32 -0500
Message-ID: <20250709005952.17776-3-bijan311@gmail.com>
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

Add a new field to 'struct damos', namely migrate_dests, to allow DAMON
API callers specify multiple migration destination nodes and their
weights.  Also update 'struct damos' creation and destruction functions
accordingly to initialize the new field and free up the API
caller-allocated buffers on those, respectively.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 13 ++++++++++---
 mm/damon/core.c       |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 07cee590ff09..1f425d830bb9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -470,6 +470,7 @@ struct damos_migrate_dests {
  * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
+ * @migrate_dests:	Destination nodes if @action is "migrate_{hot,cold}".
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
  * @ops_filters:	ops layer handling &struct damos_filter objects list.
@@ -488,9 +489,12 @@ struct damos_migrate_dests {
  * monitoring context are inactive, DAMON stops monitoring either, and just
  * repeatedly checks the watermarks.
  *
+ * @migrate_dests specifies multiple migration target nodes with different
+ * weights for migrate_hot or migrate_cold actions.  @target_nid is ignored if
+ * this is set.
+ *
  * @target_nid is used to set the migration target node for migrate_hot or
- * migrate_cold actions, which means it's only meaningful when @action is either
- * "migrate_hot" or "migrate_cold".
+ * migrate_cold actions, and @migrate_dests is unset.
  *
  * Before applying the &action to a memory region, &struct damon_operations
  * implementation could check pages of the region and skip &action to respect
@@ -533,7 +537,10 @@ struct damos {
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	union {
-		int target_nid;
+		struct {
+			int target_nid;
+			struct damos_migrate_dests migrate_dests;
+		};
 	};
 	struct list_head filters;
 	struct list_head ops_filters;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab28ab5d08f6..62acfd5cf4ea 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -407,6 +407,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
 
+	scheme->migrate_dests = (struct damos_migrate_dests){};
 	scheme->target_nid = target_nid;
 
 	return scheme;
@@ -449,6 +450,9 @@ void damon_destroy_scheme(struct damos *s)
 
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
+
+	kfree(s->migrate_dests.node_id_arr);
+	kfree(s->migrate_dests.weight_arr);
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
-- 
2.43.0

