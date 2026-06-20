Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F001A682C
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781926182; cv=none; b=D3LXsWF5cRZrdEcm7tfZfNuGgubm8M1gkfZoKOOLlYezIYxNQbsVjMmhhsK/6w4GTl0bY0zU9lMC/3DK9Swy5MlkVPQ2RIoDcRRi8J9vq2uyqFfTI/fIxSyo48IbUkNMQJjnd+foyQB/wd05m+gFaghwQf6VV/DxHpMNpKNL0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781926182; c=relaxed/simple;
	bh=6ff25Wp99R3iIdToLvtlG9aM0UEXiIDuaYaqoiOHok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ise1cE9039/7pThEoTWsW02UeafzHpRNVq4LaaY+OkeOLg3NWZ2G8Pye7CuyX7196R/HNoIua0yA0a6chCSCar7Zi/yowmttG9J6vmG93hA/NYXetA9+0onxHMKdLQyP+5uU9vFyXLC601iXFAm581rAIpaAUqIqb6eGCMrmy04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9aZzrEP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9aZzrEP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4627adcf4d6so1731719f8f.3
        for <damon@lists.linux.dev>; Fri, 19 Jun 2026 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781926180; x=1782530980; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKO/bKY66Ocp5lpRa+SnULzcfr11NnLnRjMS8RVn2Cw=;
        b=q9aZzrEPnPdvDKjs72JbOblot9dszwkRmsV1SQGyyJb5ZireQ0kkKlR+xIZ+aqL6mM
         XgAqR7sovnlMsHwqNFDM3IILkR1nx//vFMSyr4KHO0HjeaDtG7PmZFR88PbozZ1FXM+H
         nmEzf7Mh6qeAk4H3zPnwOKTesLm0wDC5wFjaa0+rKGrVcOz/kimFG2VlwiBuy5YlBrNn
         TI4pO+mozLgsDCuD18nklMeUSWAthya6Uc1WRrQ1wKGUeCG5MEpKHv+O9Sz8lYbziC9K
         35HLq4GZcJ9coscvtNeBtWoBY0fubSgnwDeQG8ybrhIPxZNUZIASg6DAMHWl8xFzTZ+f
         qB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781926180; x=1782530980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKO/bKY66Ocp5lpRa+SnULzcfr11NnLnRjMS8RVn2Cw=;
        b=mZ3POnVwd11ddC/T27IAj4zh3Tn6LqGvBxQnOqKUSfx4i12Qf1DVCQxhLjDmndHwlK
         nfRlHQrTLj8vRDJiEwsyub57+Crr7DgNRYhP3TALSlnIZlcevo6lDQsCMOwCWhstC02m
         XEHaW63hf1pHmW3XxJ6KWHmaxwx762L09Cn80slcU2GDaFI6VtmsxeivX6XOUIOq4lDs
         faFoKlLgH3rSfSFgQfC6jKKvwV59LVBdvQQ9SoEvrIqAGLD3UCIyFAPgODAUjKm1ddZv
         MeXMTv07gh6f1p/aCMYgK3uMYG/71ivtexH9+sD4BX/aFKtiSUv2U6gOaqA9kuUaWpYM
         9uOA==
X-Forwarded-Encrypted: i=1; AFNElJ+hD4FIWCYmJ/oM+Mh0864d66/8df85xR8JFn5kkRrNvnYPB6Eam20JNLS0XRUu1Xn5G3HgVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqVopB3y2TtH5a0janok/AC3tiBBQ3dIeRbunVaUQeAk42Ow8x
	hlrBX7LcD4knHfJB12J7ChbWlRQh0f1F3rfmJmRmd8zOaBcHSu21gclz
X-Gm-Gg: AfdE7cmaWFq5LDZVhkMHqk96hmlcvKvqcIFQgLoH6OgNR7RK11mC3JoO4wkkkBkHayP
	c1jylvJ4UyUli5+l4J6U5vHeySCWzOTm6UL/Jwlgui/3+K31abVlauu9t4fpQM/+Lm/v+yioVAf
	FCMX4H+ZQ1OFGpz6tuLp62KPG2dpB3ZauHnLzaqStv2i3hIR0abfZzZQlWR0xS5cWNFKUvbsKEk
	0jym+pSYbPIWlG2t0Bfwz+Iq9UC5DDf4Mu9P1HPyiWfXEn376wBVlMMpESBCopFsV1LTUmP180a
	tHQQYTO3CO1p05uSljvlkTYgCt3XPsyOmZCoQipIa9W2vYmPH4Y+DWBCRoDlom8Xrkx8rzlU1q9
	oBaBZCE5Al2hdHQzSWOtEQ/SEh6P9K3yNieUJGDoYSQqApEYS3nb8sEtcAf85s9kIX3ZJ6I4KCo
	FumK2WC5YW0IQ=
X-Received: by 2002:adf:e004:0:20b0:464:f0a6:74b1 with SMTP id ffacd0b85a97d-46509d57e7dmr7848435f8f.33.1781926179740;
        Fri, 19 Jun 2026 20:29:39 -0700 (PDT)
Received: from user ([104.28.154.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e93sm4475001f8f.7.2026.06.19.20.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:29:39 -0700 (PDT)
From: yahia <yahia.a.abdrabou@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yahia ahmed <yahia.a.abdrabou@gmail.com>
Subject: [PATCH v3] mm/damon/reclaim: fix potential memory leak
Date: Sat, 20 Jun 2026 06:29:31 +0300
Message-ID: <20260620032931.14281-1-yahia.a.abdrabou@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620003557.243313-2-yahia.a.abdrabou@gmail.com>
References: <20260620003557.243313-2-yahia.a.abdrabou@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yahia ahmed <yahia.a.abdrabou@gmail.com>

Fix a potential race condition by locking the ctx
then using damon_stop() to eliminate the thread then
destroy ctx.

Signed-off-by: yahia ahmed <yahia.a.abdrabou@gmail.com>
v3:
- Add a mutex lock to prevent possible race condition
- Stop the kdamond thread before destroying ctx
v2:
- Remove early return
- Set ctx to NULL to avoid a use after free
- Fix typo
---
 mm/damon/reclaim.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 6601b08996c6..ec5558b7da41 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -480,6 +480,15 @@ static int __init damon_reclaim_init(void)
 		enabled = false;
 
 	if (err && ctx) {
+		/* Hold a lock and stop the thread to prevent a possible race condition */
+		mutex_lock(&ctx->kdamond_lock);
+
+		if (ctx->kdamond) {
+			mutex_unlock(&ctx->kdamond_lock);
+			damon_stop(ctx);
+		} else {
+			mutex_unlock(&ctx->kdamond_lock);
+		}
 		damon_destroy_ctx(ctx);
 		ctx = NULL;
 	}
-- 
2.54.0

