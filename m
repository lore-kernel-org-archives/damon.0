Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423D43CEF9
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786443550; cv=none; b=K2riw8+cKeO4gjn69KX+Ps/27qU6oDaRfEPrt9Di0H42GHYD9RexYfgM8iXJ474AKZUrgABPZ8bovO4RW1sz76vmFC8S4A/R3bvb2QaYQjZl6WNRmhnIJ+cw1rKzWpDo9pgq6AvdS6QmOQoDo9dBt1+Kv8bCM27lSuNUoD8udpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786443550; c=relaxed/simple;
	bh=UlH+blDG+uLTjBpJepIWlreSmgRI2UfDh2JuCkSm9kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9G5TB5lpVxU+eDYUvssHiHqmxXh0WZuCDpj7uwSUPt5R1i2q6e1Vx6mIaAF69qHJ4q0EjrpK8lAREuD19e+AgtcBrUBpl2q8lTWBba2Qmanl+5UFto3uFLgvdN/rSbiAoRMQpPnkN/SySw8HLZvUvkK0FkxqEKvU8S+6nBR5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI5Fi52V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI5Fi52V"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2492962a91.3
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786443524; x=1787048324; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=of6+kQGm9cbK2+HVarcGd8ynPzUZKOBVXR775F0b++M=;
        b=VI5Fi52VIYp7EusYvQntWxD48Faz94TwvfatDxZnPdgC5qswuFL1SHqFdhPAcqhwMS
         7F17xeU/DLtx4OTVUd+Bq1DF4u2CgurrHLWuRoa6XqpK+aLv8OMiBnM/I8/Q1zClNPay
         WmwNHcYtDFAWtqruCFmZ+zA9LHI/p/ElpCy7n9LzO7d35XasJ707x5d8xrost8jpQ0e1
         63A3c+XV1aH2ibFij52XfPcj8nn214dxjy2g2oHdgItgIGyBOxJMnTh0dtFo7Fn5X+9c
         B7unnnGv4jjPwGpn192MvgRLf6wNjxSSbfGeV0EDOEqvJse1x3o1sC6cnhO3ZftBksEQ
         GjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786443524; x=1787048324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=of6+kQGm9cbK2+HVarcGd8ynPzUZKOBVXR775F0b++M=;
        b=PJDUtHzby6aiAxgN8Wozwx/04ueKxVBzwXobMVu7xD/bkuSrErBlDhCb0WTSVP9VGi
         dCN+5/AdSLGDBDn3Lb5AXPNzeVh+F5CmMlyuSAKoFPkTRaaTlnVecegJk70cf335K053
         hrffEx0uZZ30nDlXRyYRyDlxPaA+pTGldSag4Zxh6Dz8QRe4n/fgG6t+ganf6qK/Ohx1
         VCPgnonjh/SveS/+qIByykwEdq3hxd8ga/waH1DBGW3iJ9UqToxby1thWLbkca3XSfmg
         5fwR86EBz9O9gnh84b6LNGOVKmmv1iW0+IXrni6j2rxe/Fy1DfVeT7gfnJoTQ7gmd5vm
         pBCQ==
X-Gm-Message-State: AOJu0YxTSfe5QydQRStvTI2wQ7/V3kbD2ROBQ4cy/BrxIOZlZtUfaCeV
	R9BYnZeDdAIOa1G3WFFdhwcz1NBA2QU0hWeBzk+4N4wqSnVSy9s2q6Co
X-Gm-Gg: AR+sD12Gg4LhyJh51nvd/Pmr/iUZaQq0TgIXyChoDrZVaKOnzt0FwGZlcF1IzHPXyXH
	SpGTyxar8NDTh9JoGc9ZVv1TGgMvfYQK8gfh6Dp6uxSZr+Bxem7FOAd0DKxvpu3jrJMKysnJwEh
	LkBMPoqiRWJrw8uHTAfu27GzfRiN0vvvumIOd9unOTosi1udlmFeh2AtFkRvxU1MY689jgha87e
	FM+a3nyntVw2Ka/qsm7ECeOXGuMlkXlal8TvcpE7YWpxsD9Mtgplb8cdToFKfKQvjRaO1MEq0E+
	z69F3MgReY9FMLPpwLxk4VpxcH2nwbfC6A66hWQLKJWHGcrcEN5/QI+/GEa04sRaBpG3CSUIW3b
	8GqiYPo2OgCoOpaPX8KVxTFZq+m9o8NPxcPOy6C105u+iIq4pkfWYTYutmZJeswwXO75Yj4aJD7
	Wz4g0F2cGuG71wOlSiFKLrpuOxbVVG+MeK2BGcVZ60d/xuRMtapbcFkN1qENeul4I=
X-Received: by 2002:a17:90a:d2c6:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-392ec50d0eemr2377078a91.8.1786443524387;
        Tue, 11 Aug 2026 03:18:44 -0700 (PDT)
Received: from celestia ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412042dd37sm3752328c88.11.2026.08.11.03.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:18:44 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Tue, 11 Aug 2026 18:18:39 +0800
Message-ID: <20260811101841.804596-2-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811101841.804596-1-aethernet65535@gmail.com>
References: <20260811101841.804596-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "tried to be applied" -> "tried to be completely applied" to
maintain consistency between the documentation and the code.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 Documentation/mm/damon/design.rst | 2 +-
 include/linux/damon.h             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf483..939298f2a9b9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -847,7 +847,7 @@ scheme's execution.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
 - ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
-  be applied.
+  be completely applied.
 - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9ab..d642ce4fc83c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -357,7 +357,8 @@ struct damos_watermarks {
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  * @nr_snapshots:
- *		Total number of DAMON snapshots that the scheme has tried.
+ *		Total number of DAMON snapshots that the scheme is tried to be
+ *		completely applied.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
-- 
2.55.0

