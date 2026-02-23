Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A1362137
	for <damon@lists.linux.dev>; Mon, 23 Feb 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850426; cv=none; b=X+MJg+M+ePNw0tlMpayLdboQDXFF5/Ux+aB5VUsjEchnCzjcneaUdk/J1KvkgYY5Oc/tG5hQR4eFLa0Kj6RrvtVxqp9Kvz7jgEm3zzTDMvMZD63xaKSfsYwavbJrwearXZXVWfXUJX/3O1DahLkn+pYc2kPixoXJGFaQ856lHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850426; c=relaxed/simple;
	bh=tIR9ZTfFc43iogKN4VnltVCT61CN1KDGtyex8888EAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK0kU6WNUsF1PQevdXBYlP7o7+GxiXxuV7RwJ4SyUBZe4wbEtku6VekE/6qSBOgQb/9RX95bw1ZS5gA5/oELqVMdNHFi1DwHVFOdvsG+Fcja5qoYimBZ3RULnSzYypxnTHBUM6hXuRh82nvaUaTpAtIyYXWlOtsovZNDy9Chbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC8Klpjy; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC8Klpjy"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-897023602b1so48996646d6.0
        for <damon@lists.linux.dev>; Mon, 23 Feb 2026 04:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771850425; x=1772455225; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9zxhRiY07QYTGDQv6Cv2204Go1scw2vYwkAtxLUmkI=;
        b=lC8KlpjynhC42QRwae/n0u3hMCEw91zsVy2FVsh71NSVLg2aAHAnIChGnXjz5Ux4eY
         +5W4QEbTm8QTN8b2AqC6ach85gbzgLtvD+2r5pfMPjldghfBVNMWEkqufZuIhs0NuttT
         JDfPctw93eKyGdmIR1pXLhh4chlUD2WQuWccmHhjFiv87uL4ghKPQ/4/VKU7iw4WJ/YX
         LQ8ibjzQfLzWfEcGukJY7HPqUgRUmgCpSe5Fv1aoB0oamE0PpYFx5Hg7BvL+ntqT8IbC
         fWYs1+30XvkGYqlEz8U330s3HmNrxouUDRn7dImgk8tfP3TxT9DnEGLvySefcvLrXC9O
         gyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771850425; x=1772455225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m9zxhRiY07QYTGDQv6Cv2204Go1scw2vYwkAtxLUmkI=;
        b=XXoSHxuMRVCpAjE/5TXQVFr6mimiqJlU0Qp04nG5pAQ3+FQI4u28LPbyBepgU72BFE
         PjwMBKHrcxDnnzL9hBKzdisc/JIwyL7E7eyH4zG4ra4mesGeXJG3NM8U5ksDUOQ2xZIQ
         omuGUiFko8knkg7FVxiajmppc+blWJZTxgA16/ALKCJN9O7FHWqLKdaaYPKt91jGy7uW
         tGrmOlIfWZJRTgr62RTyOUQGH0eZUCiK/izKLrTE34UmjnUaa4ZhKx3pjXcBfPx34Gy4
         F3EZHxHCQ+KIg9zysYpQn2JxfUM2t2zgEmEbF09tkG90tYm6DGMHVcwlX6bgaSCSwNPl
         cQnw==
X-Forwarded-Encrypted: i=1; AJvYcCU1eV+irfRvBGOQY5TBbub9bgalRSqFMuES9XtFSVbpX7fXvFcC+ItQi1EegbFOxOuH7avVLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmMxuMyuyPzr7Gzy2jPs0eNoGNp/vL8/u3Lfi5XJvSGGS56K4O
	WsYe58ye9JsgAv++bNlfsL+2OJMC9i4TiY+kMawFZfSUsgPf9zAuXkX44qAvmPeQbg==
X-Gm-Gg: ATEYQzxUR+39hdM+r0/Tgabgy7bQdaEsuIieX2Janzd7uasJXH6HSHxdyAQ4pgLfoTg
	IKWq6bqjj8u0XSjMb1Lgb1TV89dMcAfwOtlAwjPtKFQxAYnbDJWASu39J3KCOqrK2AG/CLv5cOc
	+MlFezsbreXyUibVblgV1ILzNGg+Nw4h4y43BxO4uc/LO1QlJgm9LzxN3xhvVY5SOzBPi4lYR5y
	UK1K7xSQp6vwVtO/FFav5Hab2/dsb0seaCyWeOmThCnCjuAfrv5vc8dAtoie64qAAaJ1oOfOKwS
	94yxv4rVzO3N7nN5mPnsEu6Fz5SRyQn5rMWVeDvITUBtiv5fE3egOlQcP4hOdFwapMh9FmbzTJJ
	s80Km7VMPfZZczv6l8psh71WxRJoh/2nvKCoW+hhHVxT5TxGyfoMmpGlUaaJ1SuI/BlpYDOys2s
	J4Io9gDNWHF8W9oguQbX4Ul4IEq0bZvMwIwX+WcXoXPv4v
X-Received: by 2002:a05:6a20:439e:b0:394:6023:a0fd with SMTP id adf61e73a8af0-39545ed05cfmr7352911637.29.1771849978382;
        Mon, 23 Feb 2026 04:32:58 -0800 (PST)
Received: from LAPTOP-FDBL0TVI.localdomain ([49.37.157.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a73e1sm7454739a12.13.2026.02.23.04.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:32:57 -0800 (PST)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: [RFC PATCH v3 2/4] mm/damon: fix esz=0 quota bypass allowing unlimited migration
Date: Mon, 23 Feb 2026 12:32:30 +0000
Message-ID: <20260223123232.12851-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223123232.12851-1-ravis.opensrc@gmail.com>
References: <20260223123232.12851-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TEMPORAL goal tuner sets esz_bp=0 to signal that a goal has
been achieved, the quota check was not actually stopping migration.

The condition:
    if (quota->esz && quota->charged_sz >= quota->esz)

When esz=0, this evaluates to (false && ...) = false, so the continue
is never executed and migration proceeds without limit.

Change the logic to:
    if (!quota->esz || quota->charged_sz >= quota->esz)

Now when esz=0, (!0 = true) causes the continue to execute, properly
stopping migration when the goal is achieved.

This is critical for the TEMPORAL tuner to work correctly - without
this fix, setting esz=0 has no effect and migration continues until
all hot memory is moved, overshooting the target goal.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 614f1f08eee9..b438355ab54a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2394,8 +2394,8 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!s->wmarks.activated)
 			continue;
 
-		/* Check the quota */
-		if (quota->esz && quota->charged_sz >= quota->esz)
+		/* Check the quota: skip if esz=0 (goal achieved) or exhausted */
+		if (!quota->esz || quota->charged_sz >= quota->esz)
 			continue;
 
 		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
-- 
2.43.0

