Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4C295510
	for <damon@lists.linux.dev>; Tue,  5 Aug 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410863; cv=none; b=dzOCshfJFPi8grwVN/sHOmQUeRSpUPZkBRxq7FwAgdSbFU1XdcGqXzEry5r7XCbUN10o/G3+jO8iXCkC09CgRSlYF8I8yUz7hX9DmRw4E3jAlJN7/l+1nk9RFxAuqeluvRdDL/HWkez09wU3z1ETLmyUhh7CrfkXeDtX1/o3Ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410863; c=relaxed/simple;
	bh=UK5iJbYNS2bkATUR/j8SSeeGik5UMeQlVxFcKrIdg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghm9VklX/5cSDNaU/KLTbyIE3FispLbo57993rd7urSKSGYPf6qXZcHj5iOliklrW4GhiPzEM2kmN+p4CIZqF5+anGB5KXfwLN11NhOpNI54/I+9iBl0j8M8CzsqxY2uLI8cEFeWe3vufD8BiN25gyjSfTvYSWhRLT7BpnGjKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg+KqT92; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg+KqT92"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71b49a8adb2so52758977b3.1
        for <damon@lists.linux.dev>; Tue, 05 Aug 2025 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410860; x=1755015660; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTHZI7K9+4GxRlV7Vt7J0J39jlZPj/iqR6Wo5lhHevk=;
        b=Vg+KqT92iwVPjWrCOKJyc4EFblAEryMABA916nF5bcsVqU9xq8QtpG/iZRf0co8Kjg
         59U62hv2C/m015031sPtJ0BmCXOo55Q+ksHiBzucD0QMPLHwwfLvo3X36pnOekRgZG6J
         UF2sTPHSuXGo9L0Nua7Tul3mFFVTYuH/sBIrAoDozGjCM9fQVhh/uypAeH7THZipBitN
         CHdwe7r1CtthfSyokougBb0IGjH38rh3xPoiuMGIEqv3Do8LEsEsjHTQSHGwNqOrKZh7
         l6dnv5sId3XLfBi8uxVtYsdNErARh+OPafaNpKdkb24knCnqWQUFJFElUCRaVui0giiQ
         g+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410860; x=1755015660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTHZI7K9+4GxRlV7Vt7J0J39jlZPj/iqR6Wo5lhHevk=;
        b=crwaYtWHKzwxcoEtV8bXXP+YzQ0K0edICUpfzpyNUBHP4fCVO0/qJTNApnjeuXvHVD
         ap5EI+/SiAYFXAWVMVvZYrvFdRoAyauBMgOvUmHNylvFRsNqCnHKE6mKGIZkxvP4jl2q
         yvr5ApVYvnk4VKkf8Hq2kxVZUCOhYgOHF4DQQbMbHm6EjgY9DG0+dYly3rqq3RXW4lBY
         gd/Mc+YAGGQTKvtzcI15lGh9Qtu+C+JP9OtxhPHHCE/xq+tZpAPFvmv3gubr+oTVLF4V
         xXm82x4+6i1f1vJqfrGEysxgZg0fQffSZqmHTkTJUSvB/PvJMLHmTuNSXTSfm5WM4Opi
         4+tw==
X-Gm-Message-State: AOJu0YxSelsiqMG3RB2AEZnzeyuN0p4tTxylKZPQhIsTEtixrMxxQaKq
	xLdZcgVKMMZHu3YMHq4dna3DWj8x7S1cE6UfICNCKLqKSzWPNb7cuic0FoYf9Q==
X-Gm-Gg: ASbGncvEk+fgiD8q9qCVxlSOo89VuFfo4gA1gifdKLXT2KaCmsOgfBP7vwSzOHw2lZd
	Xowc/CcI+bU0fqL3kH/11aqdduH4ElLbcfZGiIDOOANNHoS537472CgAHO1sylU16I1wC66Wrvm
	Vgm4Fp3FWE5LEyRj43DG7nzrWtyI5BeA9uglNeSa9Tft6lGLaRYQrAr1Hm//fZBUxXolcDhCH/O
	EAz0R0FaQy0ZE8VJ2IjIebwtlN3PIeuyl1Vu3Uvrz80klnwFAqyZyzVKbvzz1yItFJa6yMh1OhE
	U04fO9UDOpNv5BN+y7kDa0YWkFCDUhxjokhi/otOzzhSIJCe78VOQU3DtaghhBw8aZQ5qEYbzh6
	ZsLoapdL4fnv2ZldVtjXVNY5qVH1riENcb+Ht029RX/w=
X-Google-Smtp-Source: AGHT+IEvW39T/sWp90HWrVkoCtc3N9MROV6TVWwJCqhkh0uDVhaEZjbOJNyDmjL1eVTf6OAsvjkH2A==
X-Received: by 2002:a05:690c:6085:b0:712:d54e:2209 with SMTP id 00721157ae682-71b7f5f743fmr175406147b3.14.1754410859891;
        Tue, 05 Aug 2025 09:20:59 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:20:59 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 3/5] mm/damon/sysfs: Implement a command to wait until schemes are applied
Date: Tue,  5 Aug 2025 11:20:20 -0500
Message-ID: <20250805162022.4920-4-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Any DAMON command that uses damos_walk() internally, such as
update_schemes_tried_bytes and update_schemes_tried_regions, waits until
each scheme in the DAMON context have finished. This can be useful, for
example, if a user wants to know when new scheme parameters they've
committed have been applied. Another use case could be if a user wants
to record the system state every time a scheme is applied for debug
purposes.

This patch adds a new command, wait_for_schemes_apply, which calls
damos_walk() without a walk function so that all it does is wait until
all schemes have been applied. The same functionality can be achieved
by using update_schemes_tried_bytes, for example, but having a separate
command for this avoid unnecessary work. It also makes user intent
clearer when used in scripts.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/core.c  |  3 ++-
 mm/damon/sysfs.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 07b4fc5a9790..56a13d16e4d1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1731,7 +1731,8 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
 	if (!control)
 		return;
 
-	control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
+	if (control->walk_fn)
+		control->walk_fn(control->data, ctx, t, r, s, sz_filter_passed);
 }
 
 /*
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c2b036abb25b..ded3f60e4e22 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1223,6 +1223,11 @@ enum damon_sysfs_cmd {
 	 * intevals.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
+	/*
+	 * @DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY: Wait for all schemes to be
+	 * applied.
+	 */
+	DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1242,6 +1247,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"clear_schemes_tried_regions",
 	"update_schemes_effective_quotas",
 	"update_tuned_intervals",
+	"wait_for_schemes_apply",
 };
 
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1643,6 +1649,25 @@ static int damon_sysfs_update_schemes_tried_regions(
 	return damos_walk(ctx, &control);
 }
 
+static int damon_sysfs_wait_for_schemes_apply(
+		struct damon_sysfs_kdamond *sysfs_kdamond)
+{
+	/*
+	 * damos_walk returns after the next time all of the schemes have been
+	 * applied. We don't need to do any actual work, so walk_fn is NULL.
+	 */
+	struct damos_walk_control control = {
+		.walk_fn = NULL,
+		.data = NULL,
+	};
+	struct damon_ctx *ctx = sysfs_kdamond->damon_ctx;
+
+	if (!ctx)
+		return -EINVAL;
+
+	return damos_walk(ctx, &control);
+}
+
 /*
  * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
  * @cmd:	The command to handle.
@@ -1688,6 +1713,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_tuned_intervals, kdamond);
+	case DAMON_SYSFS_CMD_WAIT_FOR_SCHEMES_APPLY:
+		return damon_sysfs_wait_for_schemes_apply(kdamond);
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5

