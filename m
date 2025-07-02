Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2BC2F5C2E
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487253; cv=none; b=cw1Ipo9MqaHxCeAT+WEwaIX8i+fiSFRM8+s12xz6nhpVIMDnqszkueVkF+w3XHGy34TG/bOl3cZS0fsMPCe4EYh19liYkXRi8uTIdIXk2rfafVzlR4B447Crols51nhOtvK7EIVWaAWvnBvkaN8IAokB9WhYleqr4zJ1UauIad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487253; c=relaxed/simple;
	bh=U18qlnRMvF8tUiyKZU0+IbBdjXfq6BXcXM/9WyxXLgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+fIYQNirKncwbXjCf0KcPLUudOrmG+KumVg6RtVBtdxXlgoz6vlseKOHyoP0D/KuO28lMDvqxkI6uvgCUS5rxz1wepnwkh1l7EnvHI4ou9Rr5EjEHlk9lXddph1ZueUxxxsHa0HWKkdtEU1IoY4VSVWBw9X2enMuBB1V4lBvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elz3LVmB; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elz3LVmB"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8259b783f6so4162505276.3
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487249; x=1752092049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvXOgWEj8gwTOX4Hs4by3xf7fHgpjkffGomgqbs6dfI=;
        b=Elz3LVmBGeo/bpcACa7Nrn6+dxUJa48O8YSv2OJ2T6xT3QWhJNv+KW+RDKeM/+0gOY
         9x9p9lGM5TucdEZG+vhG9q9k9bEjYvJrgdSnhLamnSAf1DMXtnptwL2We/64q4itxyu/
         MlFaq4uACwKiIFsQtAIB2QAhv5xYVaJTb1RmnrN7MaoF2u/D0SDWEJnbLPAtaPD/J0iW
         zt+HL29+NOoVMfPYGlWvlmDh4/4ncBrWlBe9ujbqG4opTsST4TLZarusAUfH9sNle0is
         wR43HdtQgCToqRSxs+MIMZz8DAY5g2YF11T76gYgk2ucROh3li+v0J6AWyKPA2gtva9l
         zPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487249; x=1752092049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvXOgWEj8gwTOX4Hs4by3xf7fHgpjkffGomgqbs6dfI=;
        b=YOWY+p6q50OB0ZaDE/LUYIEV+YD0VUk4qcsjgRTbXd67lueumzyX3TpZpyxc2vdWqj
         86XFIwlj4OPZgW+cyWW1orJPvrx9NUgKl3TT47x7cEKwL6bqI8KpE5/5A22YXai6ElhP
         SpE8qLrEKzptFXTGbmyLdAXAI2dr4f7K5e8j2H9Mtl8KUlv1zsoT/FhM5eJUlzyFKNUK
         0kyevQtJ90WqUqhSqj+S7j0xxl0/ckQXtc6tVGSX8YGeoq91J0kK/VsY07b45+LsFVts
         L8c11L3V6Mn1dyXYr+16TT3qwdNhnF9KtZlkL9iLdy/L7j5HaO1YQQrysP50a+kM5QjI
         witg==
X-Gm-Message-State: AOJu0YxyC11BaucwOhb5uUEnQHe3gYKZyU++gN0/GpcMSEXPHFYrm6bd
	7CW/sjNP44leGqBKxs9s0SWgxoAPpROJmHHYo/Nf4Uq6lvv6EqyjNWvRqGECgK059Xw=
X-Gm-Gg: ASbGncsCtdb5+VcwCWy8mgDppVfMdy5k9nFAVtzSeDji9VEFmPms5dy/mo/pcKf/CMV
	Ktrb0jFFuDadkmDL8QRL1mojtPAcPshhA4BxoMkKenEqxi2Pe2s7CeyDNkmngIsTH8cT7Yrj6Si
	/qaMnMHLrq6s7ubr6fj9O20059awUQV3UbAlCd5pI5ksop+YwREmoZRsKMbDPsLydl2dTlgteK+
	mPXfP8B3swWnAbFqLVZp2+clDnUZLtNVNj7m8lRp4Pm6/8VRw4rltq3uF9kZoSR/gRx3KUOieyT
	3ISCIeH+46yudaRRTQWUkOLEw+0zItDr93CzY4Ry5LOUj7E2ddadMzsFrgHPpPJcslVqXNWDcKB
	Kmp3EcaQ=
X-Google-Smtp-Source: AGHT+IEMpagG6TfDMWsd4PaHLbt64WDw3wuuBzpUTGHseeLoF3CNFN3ySWAagT01W26Pujp1VTRWLQ==
X-Received: by 2002:a05:690c:7092:b0:709:1529:c24f with SMTP id 00721157ae682-7164d26dba4mr55420177b3.4.1751487249337;
        Wed, 02 Jul 2025 13:14:09 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:08 -0700 (PDT)
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
Subject: [RFC PATCH v3 02/13] mm/damon/core: add damos->migrate_dests field
Date: Wed,  2 Jul 2025 15:13:25 -0500
Message-ID: <20250702201337.5780-3-bijan311@gmail.com>
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
index 24d387a972dd..6f0b0806236d 100644
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
index bc2e58c1222d..a4c3cfe531df 100644
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
2.43.5

