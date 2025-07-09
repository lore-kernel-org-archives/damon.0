Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE61A5B8B
	for <damon@lists.linux.dev>; Wed,  9 Jul 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022851; cv=none; b=FeBAWmaNIsu1bNmwGSyC9eU4htp/c+UtxEcNPR7YbKeaFNWhLm8oMv7yrtsVn8NILUVSx9KbkcnSz0lJIw3nD44DkjsSG2RRcztgVXMWiGNcHJOkDtyWA1xMYeMzhEHm7OXttKaomME7YsREeOY3HmazIMELWaNaMEHBmma71Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022851; c=relaxed/simple;
	bh=0MULHU7ToE1y24HCVFh8DYPWr9UIZ8/yXBxYBDmNcrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRUDPGqJdy18oer7pjYozGMEUf1md7pzyIohpcpi98gs24KI0mi1HPSgFed867IOyeafy0JUWTMxDxa9TIitT/aHRqLtweszvSMz+hHl0COgfbYr840UsqQhscc0TCUt+255f0+yRFRAi5ltJvFADsE5Q78B85iWZaQsVO/4f4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOH+SH8T; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOH+SH8T"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8275f110c6so3525718276.2
        for <damon@lists.linux.dev>; Tue, 08 Jul 2025 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022848; x=1752627648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1rQEZ3P3BWEkub0MmK+N1X97w+uXKLbRycfS2a+MLc=;
        b=fOH+SH8TPlY8Ws7t6L5tNqEw+W8vSlvnjv3xsY2cv209NzcWwmEtLbO4I12cNspqen
         Q0kVa9QZwrx+YrMp5sgdtBwPf9PZFtpqUxJsMXtQoBxRRRdRGCITlj81LkJ5N5Xzvau5
         Rw+sbFQ5vBgVNCeynZIEbnyRBrYhbp8VQKdz9eByocDwZO/i8mbgbdwV9dI0//2TeMPH
         NKfjpwwLboAV+TeNF+28ePzwvneiLauub7AoRjJzLoOXnJzcp+AEE6W+WiMpSV6h0Yu3
         EDSpRDs2l4mPVKZDjZqNfZCWm1AK86gKBiOGISmz7MTyVGkt48nuveuEonp2LkYxixoJ
         snfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022848; x=1752627648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1rQEZ3P3BWEkub0MmK+N1X97w+uXKLbRycfS2a+MLc=;
        b=Pyzqh0O5/fgQxGnYQLI9rBpIFTQv3N+XY1uJMa6QAgc7ZXZCSFUvSwpWZfPUow8REm
         EyMKmpSYurNZh/i7CeG5fz2JNeTp8S7pQyXzdenfk6LZZ57DOQH8SE7QoF2r7mgWkO5Q
         mz7/mCoW1Pc+eVM6n43OzvOIwT9kvFUbwOaPy7/cew0gEOJZDsTk8EEY1b6A8ldtxNM5
         9s34AiUNiyTU66MFLFTh47sKmDZ2zFwU+g+82oOR8yLkvUgM7twBPlszyCRmA207QR/I
         lLgAqChUqKlP5N09PwOKvnLdKWTyTe9BNJzP4Eutw+yVNxJXYrC4zfNZadXxCFx1tJu1
         gA9w==
X-Gm-Message-State: AOJu0YydIYAvHZde9ffhxqnClkP815Y4psw6HwOs2VUJfyzwqYPLwyIH
	21C4VMzBdPwA2I+OCoeQugFR3VzIM65CCQJt1D6CyQ9A7h5S7c71TzO2CHLRR5ttB90=
X-Gm-Gg: ASbGncvIOUPs8U8sbwUTEDT1AhqOCANx9zIQp0pUHWqUZ36rGA1+MNbrKIIg4cS+lUm
	ebae0AZ1maIiP8nf7MJH0zmQi0V3/S2pv9LNTrJgR52ZZe0wOWU0D/cpUzASOlZ3h/RhWNRBVHx
	GseC+PVVC9hSwzy/n+iLvmhCiY1F62ySqDnlyHN+ob02gL+n9LQ+1PeBdQndlh/FtwddlNLQGrI
	TkYbSVTYdkRdIWFcQozVytE1spWeWRvOn9Oqntq6SyYpQv/OUqQvdOtvzndmyLeW+2x0AKA8WOE
	P9mo1zN462nFuPpMBC2CLDo3m49IqYxQCDxZu4RmbmMa4/A4AWuEZlv/jIpd6PNOvtR0kymmbDt
	S3/LjN0U=
X-Google-Smtp-Source: AGHT+IH2cQxk/EywgLp+UgmsKikCG6qPU3Rfx8V0pFOQ6x3T288Qg0dLaeI6mBOGtVGc7IHSd5hNEA==
X-Received: by 2002:a05:690c:680f:b0:70e:15e7:59e2 with SMTP id 00721157ae682-717b1c36f17mr11095217b3.24.1752022847915;
        Tue, 08 Jul 2025 18:00:47 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:47 -0700 (PDT)
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
Subject: [PATCH v4 07/13] mm/damon/core: Commit damos->migrate_dests
Date: Tue,  8 Jul 2025 19:59:37 -0500
Message-ID: <20250709005952.17776-8-bijan311@gmail.com>
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

From: Bijan Tabatabai <bijantabatab@micron.com>

When committing new scheme parameters from the sysfs, copy the
migrate_dests struct of the source schemes into the destination schemes.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 62acfd5cf4ea..8d54bfc3ce0e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -943,6 +943,41 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
+static int damos_commit_dests(struct damos *dst, struct damos *src)
+{
+	struct damos_migrate_dests *dst_dests, *src_dests;
+
+	dst_dests = &dst->migrate_dests;
+	src_dests = &src->migrate_dests;
+
+	if (dst_dests->nr_dests != src_dests->nr_dests) {
+		kfree(dst_dests->node_id_arr);
+		kfree(dst_dests->weight_arr);
+
+		dst_dests->node_id_arr = kmalloc_array(src_dests->nr_dests,
+			sizeof(*dst_dests->node_id_arr), GFP_KERNEL);
+		if (!dst_dests->node_id_arr) {
+			dst_dests->weight_arr = NULL;
+			return -ENOMEM;
+		}
+
+		dst_dests->weight_arr = kmalloc_array(src_dests->nr_dests,
+			sizeof(*dst_dests->weight_arr), GFP_KERNEL);
+		if (!dst_dests->weight_arr) {
+			/* ->node_id_arr will be freed by scheme destruction */
+			return -ENOMEM;
+		}
+	}
+
+	dst_dests->nr_dests = src_dests->nr_dests;
+	for (int i = 0; i < src_dests->nr_dests; i++) {
+		dst_dests->node_id_arr[i] = src_dests->node_id_arr[i];
+		dst_dests->weight_arr[i] = src_dests->weight_arr[i];
+	}
+
+	return 0;
+}
+
 static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
@@ -984,6 +1019,10 @@ static int damos_commit(struct damos *dst, struct damos *src)
 	dst->wmarks = src->wmarks;
 	dst->target_nid = src->target_nid;
 
+	err = damos_commit_dests(dst, src);
+	if (err)
+		return err;
+
 	err = damos_commit_filters(dst, src);
 	return err;
 }
-- 
2.43.0

