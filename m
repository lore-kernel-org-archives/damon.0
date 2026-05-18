Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2E38F64C
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131536; cv=none; b=ThMCTFrFRCqFdjc/nfrm4FY6OJ7TS6a8ikjI2ZLrzcwPxji9T6elbksehk4hhFbRqtDFunKW+hKxqhtGSAjZ2lOp0UETBjKLJSSCwIMMSAK5dG5bG00NSJriYvyvZRt2Cy6TY9PIAg1yL/AKNKbRKDTtkA4djsHPwRNmcSxlrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131536; c=relaxed/simple;
	bh=SoXSf5SpGqI0kBoFXThh39QkImfKpBI2uqfpuW5aPZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m0Znen3G3fZOsRFrspi1ak5lO45r4zRUfcuo7ys8U2czzKWee6k5zIvDsrB1BPGX4JOr5EER0CCFFU5UA4iOR+JvbHyl5Vpr3f7BWvltNlzi0ur92Tb3UhFOuilCDAJ904uh+CqXCNuN/HrH5KnFEl6Ej/HLh7dU+G68Dq8e5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxKycmLm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxKycmLm"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44a74032ff8so1869227f8f.1
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131533; x=1779736333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvA0jsT56XFOzdzNJ2doFH+eXNoXIcVbsna/QX/3LyM=;
        b=FxKycmLmPQ1ycKryTYCFFzVC8wQ51LfXjz8P6t6ehCtoZ1crRW2Kcapqv/39Ii6Bzp
         IFKq7JQsBklkCHUZNU9fdQRrTj45BlKBP26qW/1aVB/W8fOnXM0H/KGEB7Jvoun3GRrW
         6yhT1K0WGTSttUKoKFlElCQd2HVSXUm23o+NizQcUj4SdtAGiNToWiQsC58KjThxAK3L
         43cOBtX4cikguILI0anteUjqkTUVSe1tWQaInU2uOsmBv3CeYzIHEUBtv0+XJ2319pm1
         sNrKw45K0CSrrqkzlFWKpxxrMJ8ukgs5Ny6nzDdzeIrtxHySOYaaIlfba0Ka/oFzcJMp
         jozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131533; x=1779736333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvA0jsT56XFOzdzNJ2doFH+eXNoXIcVbsna/QX/3LyM=;
        b=HvX4Y8Cal8g8JPrOuSArGbrGLlEKzQyvewYGnh5pLecV5Lihh9Ht+WjKukHuOwPAtK
         F6GrSk8dP3FGvlTb7r7sy269RGppAsJSgvGEbWaZadz3qNZGE6uBNcBi9b10CIY7+taf
         FSsH5i3Z/qpUq27KJEvmjljjc8uBqDBv3gCYlHRTGnlWtYMWzKVa9WCCNc0W4WW0aku3
         Ymy5Ct5NSrB848fbsogVfRZEN2mgzuNZNJl3r7IfWVvAixIBcOTJTkRRdRfG8MeXDzrA
         i/tVkpWoUtaP8+93DY4XrqtpAclQ5OXLjdRni1OGwfiSSNn2uccuePFBIyrjZw728JgV
         ydBA==
X-Forwarded-Encrypted: i=1; AFNElJ+yB5Qey73oluH3vSesHOlX6gIv3sFRcEkHq/7qNCno/arlEFnZlSYdQiJ5FD2EV9vIKUKnHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPQFdehOSfGbnjEXBI/3828e2YUCmxNGgNXphgslXyafW5oi+E
	qrZBrwksUlOlQJBPKdbGHlbOheplo8UP78h4J0ihgfbSI9OhFYbHJIEJ
X-Gm-Gg: Acq92OH1idw6MWFdWXeY/+b/XO+z6lUnbrGlbA4OUIMB8watmkqkeudt8WDfcfgmY89
	R6qqqMDvoDARdVqX59EIvh8K6S4ghaWNrmozKrgxKuQCjkwh/3ynd2gvmXllTN88QBPijahE310
	N1JY53eJSPY0SsKjYQAu1UExSnDlPuNEJiRI4YldO5HDKGIZbvdW3HJw5CgXT6meTOlHT03IWNL
	Ry2Cqwuhh9fUSHVj2SE5k6PY4ehFSn7yy6gmFgGVQxcUVq8xJAGmd7lE1pq/8AWHE+7qf1bmz6F
	O6BnrXYNrV9IWtUzJJioQcbCtpQvhpLMJxzlbTN1jiqN6QU4OqFHbkH8x/G7u3ikXDL++SNeops
	qJ3iCpJAAeeqc8lWhPrwOx0b59aJn7bicBsnPYw6xL4upZQ0AcbvxaurZmJmjGXzq3SeqZmH32o
	r3HqF3DsIPEBZ9iWHcrrVe7CpXXpSmDtKrruqNOyXzdhpKiFvJSdc=
X-Received: by 2002:a05:6000:2c06:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-45e5c5e2ce0mr26609560f8f.43.1779131532440;
        Mon, 18 May 2026 12:12:12 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:12 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: [PATCH 2/6] mm/damon/sysfs: implement update_schemes_quota_goals command
Date: Mon, 18 May 2026 22:09:28 +0300
Message-Id: <20260518190932.42270-2-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the logic to copy the current_value from the internal
damos_quota_goal structure to the damos_sysfs_quota_goal sysfs structure.
Introduce the DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS command
and integrate it with the sysfs interface via the 'state' file.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 mm/damon/sysfs-common.h  |  4 ++++
 mm/damon/sysfs-schemes.c | 29 +++++++++++++++++++++++++++++
 mm/damon/sysfs.c         | 21 +++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 2099adee11d0..9703414fa15f 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -59,3 +59,7 @@ int damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
 void damos_sysfs_update_effective_quotas(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+void damos_sysfs_update_quota_goals(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5d966ac86419..5793659403ca 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2812,6 +2812,35 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
+void damos_sysfs_update_quota_goals(
+		struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int schemes_idx = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damos_sysfs_quota_goals *sysfs_goals;
+		struct damos_quota_goal *goal;
+		int goals_idx = 0;
+
+		/* user could have removed the scheme sysfs dir */
+		if (schemes_idx >= sysfs_schemes->nr)
+			break;
+
+		sysfs_goals =
+			sysfs_schemes->schemes_arr[schemes_idx++]->quotas->goals;
+
+		damos_for_each_quota_goal(goal, &scheme->quota) {
+			if (goals_idx >= sysfs_goals->nr)
+				break;
+
+			sysfs_goals->goals_arr[goals_idx++]->current_value =
+				goal->current_value;
+		}
+	}
+}
+
 static int damos_sysfs_add_migrate_dest(struct damos *scheme,
 		struct damos_sysfs_dests *sysfs_dests)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d5863cc33d23..ecc880b52b32 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1320,6 +1320,11 @@ enum damon_sysfs_cmd {
 	 * effective size quota of the scheme in bytes.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS: Update the
+	 * current value of the scheme quota goals.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS: Update the tuned monitoring
 	 * intervals.
@@ -1342,6 +1347,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_schemes_tried_regions",
 	"clear_schemes_tried_regions",
 	"update_schemes_effective_quotas",
+	"update_schemes_quota_goals",
 	"update_tuned_intervals",
 };
 
@@ -1606,6 +1612,16 @@ static int damon_sysfs_upd_schemes_effective_quotas(void *data)
 	return 0;
 }
 
+static int damon_sysfs_upd_schemes_quota_goals(void *data)
+{
+	struct damon_sysfs_kdamond *kdamond = data;
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	damos_sysfs_update_quota_goals(
+			kdamond->contexts->contexts_arr[0]->schemes, ctx);
+	return 0;
+}
+
 static int damon_sysfs_upd_tuned_intervals(void *data)
 {
 	struct damon_sysfs_kdamond *kdamond = data;
@@ -1656,6 +1672,7 @@ static int damon_sysfs_repeat_call_fn(void *data)
 	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
 	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
 	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
+	damon_sysfs_upd_schemes_quota_goals(sysfs_kdamond);
 out:
 	mutex_unlock(&damon_sysfs_lock);
 	return 0;
@@ -1813,6 +1830,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_effective_quotas,
 				kdamond);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_QUOTA_GOALS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_upd_schemes_quota_goals,
+				kdamond);
 	case DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_tuned_intervals, kdamond);
-- 
2.43.0

