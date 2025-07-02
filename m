Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5630115A
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487279; cv=none; b=QP3DCQiBbiLeMd0DzWbqxkFZiU7WbVTppI9phUau5PjVKCBbsWwamFTg67ykA+67K3e+W0n02+6uNvQSCfZRmqGq3EWIJjvNKMceCfOBxbSUqOGw47TS+U6d5wjPHywlUXO4fxIYDpMjyIs8Gjvpc1djc9Y6eM6oAZJxRv1njM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487279; c=relaxed/simple;
	bh=7ntNinQfVlf+pugu/WTlvuD/GFP+GYiXqJRcWk0ejH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si3fyzTXh236Hyg9d4Zrao9vdivufNNR+4Tsk/AqNMJ5ppSxI9dsqfAcb47r4TXacjA5HF83YAJRPSqtX8g0bQxsB0ogi0ShgImnLL0EJluB2AkSyMo07vBk5y6FjH3UoK0dEBbDnZRHZSFxzWvdYprg1a1LoHtaziBtHIK+rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRBpHWTG; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRBpHWTG"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e898fb745beso151898276.1
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487276; x=1752092076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws2fCY+40qz7qYM2UXMSStun9zyhHrsexuHO2VyV7ZQ=;
        b=ZRBpHWTGaal9dEQWRmzCpu4/YynGEfImIEI+upZDsa3X3YcqjGJGh7xrl5kvtuZv4Z
         g3DN2KgW8qK/hV8DLm7t1U/HxP1sFDpVz4OcDSq6aFZQG+t1iKSPb3b8MYooablnfkLA
         OyVGfOhqE+coWfdB7LGgmBLR0N78faOEBBmMZtMMjTqz8NRQTdGUIRIyfKkEIi2GdRLd
         pPmTuHQSZml7NW4pOd2+jwH5GCOzODc1o5rTEcCSkUNTp2cUyfibBGfkQbz98V234bZP
         7X1wnbrj8h68vFsdrlIs6BASkHdrBBz98AeRnKCvB8uxPt1bcIituW+jqC0G8hgkN3AQ
         yxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487276; x=1752092076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ws2fCY+40qz7qYM2UXMSStun9zyhHrsexuHO2VyV7ZQ=;
        b=gwQ3eE1PQzjp0iyMAfM4BeOhGJTXfUCGEgtjDHUUPHXOQHQpVbkVCjJVmysJdkmvtU
         KUJb0Rlfh1Ous1sj/FC+FYscrwr7pT3oFG9LpSePoqlyorzG6rZOT44Mgr8JF7he8YZs
         2ZaEMBiAyvBp0sLH82m2gIk7whqOH/6+7ggYAVwKR3fRLC/6pf5SDS6zYTd9x4hG1MP7
         956n1EjChqiGDGYCdcD4Vq49ZenHcUdUqqvbCLkQZv2V/x+TVZv2xp8rOEeJEf5vwD1F
         EGgzUa5hgMDYi1y8yFoX2Qir+MgFCkYKoqvWcu0HGD/p7AVgBV+2Ne5Fq189dgVrxNO1
         lsFA==
X-Gm-Message-State: AOJu0YzpoZWqdgOA72sxBYKAan5WMYZUwQ4UqcQajwcIj0Kpe/v+iSlM
	7MmfPqNRSMInd8CKi5R4sY7+qmUF7CeZPY+pLui0UYE8ImsGGoWV0oYcZ2pb69jRLFM=
X-Gm-Gg: ASbGncss/P1s/ny19PhMVPeEaC2cM3NZfv/rHZ9RQYDhVyTUdhdt5+pbE7J0QJFFfQV
	XIARsaiEIuJWaoNePEqJ8THUA/EsNdB51+QtaXuqgWN6tHqkCMhLI1vL7Yc9a3eIJiIlRw3UO0r
	nfyyQ9wpl5ZExKpGmiYVWCZZuaHC5OU5CTgczoQy51eHNGXgle3a8SKpj+CMHkIOpIvDpTcpmoU
	hNABLdAD74Rv6XwIzVGvuNCWyTzw+tbIa4appnVVpYQfRmGj3nDhQOcjFF2O+V0e8YozI3KTy8c
	UOL3tJag7+6yB5+kjaQiu18yP/eu90Dnb3Irx7bhx+LKTN2Fv6vv03yLDuCNKrnW60buHO1TDZT
	cO/wsLLU=
X-Google-Smtp-Source: AGHT+IFMh0Zpmv4j5OzZGutnmhihaCWP4mrmEUdEh5Fn5yyRhW1DwP6dI+488wgyAG0GH6wDYQKuKQ==
X-Received: by 2002:a05:690c:8686:10b0:70e:4d8:5cab with SMTP id 00721157ae682-716590c7964mr10179957b3.2.1751487276493;
        Wed, 02 Jul 2025 13:14:36 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:36 -0700 (PDT)
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
Subject: [RFC PATCH v3 07/13] mm/damon/core: Commit damos->target_nid/migrate_dests
Date: Wed,  2 Jul 2025 15:13:30 -0500
Message-ID: <20250702201337.5780-8-bijan311@gmail.com>
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

From: Bijan Tabatabai <bijantabatab@micron.com>

When committing new scheme parameters from the sysfs, copy the
target_nid and migrate_dests of the source schemes into the destination
schemes.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a4c3cfe531df..0565aae8d1fa 100644
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
@@ -983,6 +1018,11 @@ static int damos_commit(struct damos *dst, struct damos *src)
 
 	dst->wmarks = src->wmarks;
 
+	dst->target_nid = src->target_nid;
+	err = damos_commit_dests(dst, src);
+	if (err)
+		return err;
+
 	err = damos_commit_filters(dst, src);
 	return err;
 }
-- 
2.43.5

