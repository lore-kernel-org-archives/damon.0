Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D33228CB8
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781912797; cv=none; b=cp5RPOAa3hjoUbsxOOxVDIPkgt+7DvQrNljjLe4lEbBDtRKdCySRn+S9FfiownkiQbrXkYXLXmBUllfQK1ywZ0PoEO8cmQ0/LY/27GgDfaJiObGM3bFggwZ0++cSigvZz5t79rTT21Bed8UU4PTWx0EYYptsy0jQbYT/LTg5Lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781912797; c=relaxed/simple;
	bh=WBVZqcETYqVF1U7ufMY1ZzKK4cqj+O2DYXPq2WwOerA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZkkmzg3YMqg0Od+r+QIfR0RaTxp2H0ofy2EaGxHDycMkJpoEM/YLfQOmveRuCK1tPZR00f3D5+NZc5hgZqyP88brwkJ/xDUSOGxzB85ciwCKDL2MGd0xYNRfxgD9s73XHz1D2F6y1mv6VijKy2CPk4cgGuRzTNW2lTWusXIu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPvJXucr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPvJXucr"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4905529b933so24425805e9.0
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781912795; x=1782517595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVy21SE4M2vsW6vYL3d+PXiTMxevRAY3Rjncmv84CKs=;
        b=RPvJXucr/l2HzRnKXaJJFSw+lZSOmvoBnHJNWKCKO5IUa+sjqwSNS51FLi8XqVezJ6
         kBbfBIEXxzcEcHW6yEHqR4Gp8hxCy8YyJD0sImteOWWrJGpVbHriOs+3FR9sQ3QRGqrl
         WWxqgS23/tniW7mtIo4W4k/fi90yfDVLdOFllzWWYIbyNwjJpYv3y5Yi2OXercTVxgXC
         OcWUGSR4bAc3Ffz7nhWgnBQ3EuqrCICDeQ6wAn3d2DNrnglqLIy1uda7Zz0ouFYVWkNK
         5/WS1kPq+Nt7AlbE1cGS5bCmbBQNxUse8PhKsa4Gq4a/HtIdva/v3TG44FR6lEvG6fw1
         UtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781912795; x=1782517595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CVy21SE4M2vsW6vYL3d+PXiTMxevRAY3Rjncmv84CKs=;
        b=agRXoSLsItw4l/TcTxXNV6mfNVIgSar05A7QY56OYo7jgB4UFtiMrgplsR0dM9HmOu
         7LQn/Q/639IO/1o1xrf971cXKU8EF6hbkgCvY1jTAdcPFt6Lfhs0mD5mzUTkgImYu7a8
         kifQuBh0URP7zSO70cUGQseQwqei9/vAVoQcuJxWxRdlL9EO0+oitgUP0oPHtrvJXLMT
         qeip1fZZuDJx51mwNgNRWxM46Iawe7guKN1yV12FKNyzu0tX0NXzYylqRooHtbWJIEjI
         Tctln6TP93GNlSsGZi9xJaUpgoCu+TmbM0M/Clh2SkH35Rj1jE9lL5u61Yfk2NVCnkbG
         i9wg==
X-Forwarded-Encrypted: i=1; AFNElJ/CoLCyTWRsUHr5GZoC1WjyPe9ue9CH6GIyL3wd3SGGZDxf5RndIw19MN/HJ5pZFwo/QglJQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7uk2S8VQZGvO04nIQR2xyScjx7BDUeiE2ya9BhzrVE14pic0R
	a3vYkkehc/qkJ6e6UC/V6OY3fKE+d6hxy56kXzBhO7Jt8LyRDkDW4xNcJNCnydqHD8fGpA==
X-Gm-Gg: AfdE7cn7iXdEJ7IiNxWhpFk930Ys+awHETYh3VZtFP3dXWEWnaq3pxve0GiOikyZnEJ
	vff8qF/RuVBaNUgWawJ2S33YBVAw5TzHBaQALjZhybGP20uNzMUv1kUrsaNMtMCJg+bPyKg9Mwn
	Yd5c0S8mnZcy0v4XNKylxwJkxKsSN1+vhHSJnjVCBIZZmDTs95d9I3UHxcQ0euJYkUY1dfIxkFC
	83sUPdLhaaNPRXrJ/n69M7IEgwfkvIMEKIKVNlMPIEMIe9VWGzTxJBIqX58kEPOQB0GOGQSqFOV
	z2nIRV/jPSzAzjd3t5naGUTGmMacserlAd0r9sbd7CGExdQtTcN3gBxTH53mrJj18Y1cZxsX9lP
	n++jItqSl3UgylvgvIhWSYiEGE9+Bc/6cRV1R6B8k00Mp6tJJLYuk1cC4T7/pu3Jg3E6SRzePls
	CvGrq1s1n0anE=
X-Received: by 2002:a7b:cd0e:0:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-49240e85d64mr69314975e9.23.1781912794516;
        Fri, 19 Jun 2026 16:46:34 -0700 (PDT)
Received: from user ([104.28.163.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667882f7sm2868027f8f.21.2026.06.19.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 16:46:34 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH 1/2] mm/damon/reclaim: fix destruction of ctx
Date: Sat, 20 Jun 2026 02:46:05 +0300
Message-ID: <20260619234606.221163-2-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
References: <20260619234606.221163-1-yahia.a.abdrabou@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

Fix the early destruction of ctx if no error was encountered
by returning 0 on success.

Signed-off-by: yahia ahmed <yahia.a.abdrabou@gmail.com>
---
 mm/damon/reclaim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ce4499cf4b8b..15bc06ae7505 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -268,6 +268,9 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
+
+	if (!err)
+		return 0;
 out:
 	damon_destroy_ctx(param_ctx);
 	return err;
-- 
2.54.0

