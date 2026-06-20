Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E619C553
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 00:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915770; cv=none; b=VakZ6Rhc7O87CPT2SYe/akW32bdCWlQkfJzTEG5e6OxG3+usPORK67LL3akLT6XqiMC5/xrceFZ0EJ1PerLwbYABrMgZ+rm/Kov4dgkEYdTvISc7sSxXiAsct/VxuhzET901UBCByW2IlFcXfkasiyZs1MXf7MxgcqOpyiy7P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915770; c=relaxed/simple;
	bh=2bE4ImrZ9UdonKeKOAXifOWKKCwYPBW+WnFXsLxbx2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWX0F/fdp7/ViwOnv2LvhmFx8Ur4+HRS67xuW7s8p89hlQFjyFhHbiH44y/vzOU0eRP1Wb3p1ZnZ0rZ9uAbUfZ1Gz7tEyEVkIaWw9IKMWPNfaphzK7G3wjAH34irJsAH9RMYjwhBwTWmuANqiaYV+/c0s0q89xGpcdlkIkX5ZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1RVxoKr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1RVxoKr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49222fb062bso25433465e9.1
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781915766; x=1782520566; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l61wqrGf66LLbRNZjHAl/GibXycfmnzPDWP2VbrWWo=;
        b=G1RVxoKrexU2Bda0GOhDRfquB9y7Frazl0vVSWveKYzgZuqXu5sLjYAYmCyKNZRJsK
         xsoESd+1FHIBITwlnezsDz+ATyt3W4cM20GvxJJP6r7K3KN9R4v2qtAKkn8EZUJbOssU
         9l77OIGXyPdqjntkai/980FKZIwFWBmw5hEfHjX9Kn6gUuhx1sNyrEq8SOhpcGoLNM7p
         zDD3OmJOsLQvh10iHVCO6ZaDMWBM+TPEkh20iAtuxsrPXfOTGKC4tHCYse7oWvjJbRfR
         KMsVvR53L4OSb1e10BcNCIaTtZsJDp1Ww6zoDewTbheFBnnLO7eZnW5VfAwA6F3+k0z1
         l9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781915766; x=1782520566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3l61wqrGf66LLbRNZjHAl/GibXycfmnzPDWP2VbrWWo=;
        b=MXEohYohPoUdG0f0ERAxNxUZvdPb5dp31nDW9p+VYXKM8br+whJcnwuwz9+ZfQy+du
         51w1EfKrrYKG7oIudye8ywC6k1PrLl61CAIltm2vgykQXTXrpG60x8T78x76oHkVtfqZ
         IpqKIbjPZeXzuAamLyHZbimCDjhbQmk0O3r4IagxR0qSPV1U5uL6lycW258HMf17d3qk
         WMFwWZrXsfAp2xoKsPqiaA80jueEHTqjFkXOJHDT8g8kOUJv3x9ymqfoNckUgyjhGNzi
         FRaOQ5FwdPoVD9cLzKwAhJe2O9Gqil2HVqSC3VDQLZ8p8RzWt8bdV3wAYyOl/P3Zr5io
         Kqaw==
X-Forwarded-Encrypted: i=1; AFNElJ9qBo8WjaOJsfar8dcgexHbNYGXPLte8ubO/2T8JU3zfKa3GW9wAMOBiFBnHwVbz3ccDU8fCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCWpZKBOSV51dMMgFCWih7of04k90KEljn0uI32Lepz69q3OO+
	hpTpVMDyxamKq9PR+ynQk7elqtS9ZoC8z+MgDIZRFJQAt7X38Ugb6R+f
X-Gm-Gg: AfdE7ckUEZR4Rl6qCZUvAK1dp/YcQT3wwrvYoflZHHYdMp/LHtIMj51miX8+E1TrldY
	oGmYzhXuBBJAahe3BIXrAf/7vmhcefXKstcIKhp/aHlYRwz0eCmnQ0QJmo2Tql7HU+pS9/p6DEa
	agY0EVhKitG1sZ02DiOCG6x5lrFCIhDiwFDEeqGx02Yb/xCbHCo5YlFlqTa2eYxGy+FGZKuJcyf
	YMIHfPe/38aq1C3SJw/+cxUgF9oTc2PZzWdI1XZ0jGjqXSf5/pfKN71A7YBcOZyAVfqc2Qo9XIf
	veJztnINCZLEZk7qUd9FHbXQW1pqHwAPcaRS4+9Lew/tunVIC2uZv5l4PJHFFQUAQcAGhXri+NV
	HmJmeFTGPEmwAM8I3RGOUsecSDpU0ypNZcPSEbfPoQHAASoygKcUFH7+LfxQSrKC4fHVuv4absG
	5FZ+8QWwxBojA=
X-Received: by 2002:a05:600c:3510:b0:492:4161:ae9d with SMTP id 5b1f17b1804b1-4924161af05mr83964385e9.8.1781915766153;
        Fri, 19 Jun 2026 17:36:06 -0700 (PDT)
Received: from user ([104.28.163.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492494497ffsm22020185e9.11.2026.06.19.17.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 17:36:05 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia <yahia.a.abdrabou@gmail.com>
Subject: [PATCH v2 1/1] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 03:35:57 +0300
Message-ID: <20260620003557.243313-2-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620003557.243313-1-yahia.a.abdrabou@gmail.com>
References: <20260620002614.83004-1-sj@kernel.org>
 <20260620003557.243313-1-yahia.a.abdrabou@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: yahia <yahia.a.abdrabou@gmail.com>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index ce4499cf4b8b..6601b08996c6 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -478,6 +478,11 @@ static int __init damon_reclaim_init(void)
 out:
 	if (err && enabled)
 		enabled = false;
+
+	if (err && ctx) {
+		damon_destroy_ctx(ctx);
+		ctx = NULL;
+	}
 	return err;
 }
 
-- 
2.54.0

