Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD33D5C2A
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540825; cv=none; b=Ls3LPZ0L2d/ZwPbFL5hmEUzHUSbrwsUdWZxM9LiPDZZ+txtAhWCa7zF4IeIFm439Em6CxK0qlqzqIblrhunvxSFcJvob+QDxMAq8RHRlPDUsU3D1KC/5HYhXQmejuowfGyHC1IqZ4aM7y2Y+gQVzN4CcRrS6IG76Ra8q04/QF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540825; c=relaxed/simple;
	bh=zTW8TcHF8TDtepKYrWzArP7NASIhAQQrPY+zcVWwmVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ais3k270HxMHCrPSlG4kg7OTB+kasgatSoVxGnMJv8aViKeL7iBK1yVEqxclBudJokZOff20hRiNhuc4274pYpIsDsbVLfE1JUqqJPjNQjd5yfg7MqDOhg9tM5wcitAayvZFYiwXYaA75HUhIgjxx7Pw+cHjJGMHIs2rsiiSEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvyCunjj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvyCunjj"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e88b60121so246874a91.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784540823; x=1785145623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXXO5Tq1xzHOucyWExyfULz72X/w8Civg1XxI0ISuio=;
        b=dvyCunjj9QRvUpJBUipmBoMNcqxowIi6L7M4+QCREnwMuwpUjyF+mJxZaW+cEDYVzE
         qNAEvO/mZNBSsR2qvhu/TTkwSVY6dvJvxSTAgZPxXAm+igU3ao1nOBGq2ovXfB7encvs
         2nOrolVbYS2fS8kQq2182wMj79T3J0Ay5wXE0jisKnvMnEzqsEcuwPWX3KTBYJTyZpro
         fKfihMHjY3a2TVoOMZu9zYdwEilnvqFcavnQu90BuUm5Pagmw0PasL7jobalwT5wcn8H
         JX1hBqvJT0yokuXjx2OLbbc/indt5WR1YNuMxxZEUW3LsOkgxWvbTy5lVIa2S7yXPwRS
         /sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784540823; x=1785145623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXXO5Tq1xzHOucyWExyfULz72X/w8Civg1XxI0ISuio=;
        b=fncyIf9+uakSkocRAFeQqSpMalNAASUKHvvMUusqnXqBHz4MRgQy4bvXmvgdLFBWKo
         hYZDUgJ3N1Dsj9LIW10brg1ryoQ2CO748a6lyVTlXMmR0GaccGoQ9mUPqf5EGK7dRx38
         Nc6duIg15DnyQqCWr60qpWGI2ic9qe5EvpmwTX5nKXxFsXcYO1oEDPeJ0HULFc+M5e+L
         DIdiIV7G1fgyJxwBbjVz+5yvHHDPJw+QnbgL6nL94It6ayZyW6C4CayMUpX3Z1sxoW5K
         9wxwXE8+G4EU/YH4NoL8iOY6gXDMuyh4Ym4L/8/FQ6r1/dpFQxXsIYJvT5Ygoa2QAeL1
         Tg4A==
X-Gm-Message-State: AOJu0YyG2Q59//kfS2H+QlSDnUvFGEwkrq0Cx9/9gGaEfEAqRnREA5Mv
	aW0pyb3K9iXEolL/w0QaBVz0914ViaEyuB7TvQUCL0yAlBqbptL7RfKt
X-Gm-Gg: AfdE7clKI0gHECzBWo1JXpcxbWY2mbwXK+tpiuKFi6rTz0wQWh1ocWqXW7jNnLeifw6
	rTW4/RpKXZiWeZyQaiDrYLytFXv2XQmtJQev6YQpkKeVqLfhusFsC4laX5A7JIETt7Kvr+d+yos
	me5qSZNKTCVKDAcKvw1kMY/TfPXS0Oai6+q2WR6XxuVFtqYDnHuQZkoXleLIFIvY+UZnBJ+zTA0
	nkyTRwWcNK1/DF1EXcB033fceTagF+Axij8iVr/BtozBAdtj8yIsQ2gjSlVhxvisI1s+r39RU7Q
	WMmsp9T3Ie/yp4qzjmHrxGEN31iNJt47R0H8UsDru55rs6QAHpda9znOjG4t9Oh4q3A1iWnd0O8
	Z7Jc0sifcCalXRNWmT+EGWyUGx3ps0bOuFFKaYPcFgdjmGqm/MihhzYu6PLRtmsJ349t/ElbaDn
	h/M49TRfBgqlkdOGZ6nRTfslf4Y3GIdw==
X-Received: by 2002:a05:6a21:488b:b0:3c3:bdce:27c1 with SMTP id adf61e73a8af0-3c3bdce2f1amr10290377637.51.1784540822955;
        Mon, 20 Jul 2026 02:47:02 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8d9:11d7:8597:c44b:bbf0:2c09])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcccsm39349563eec.4.2026.07.20.02.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:47:02 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org,
	Yikai Zhao <yikai@z1k.dev>
Subject: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Date: Mon, 20 Jul 2026 17:47:08 +0800
Message-ID: <20260720094708.243937-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2f54908fae211 ("mm/damon/reclaim: detect and use fresh enabled
and kdamond_pid values") introduced a typo in damon_reclaim_timer_fn()
where '!=' was used instead of '==' (unlike damon_lru_sort_timer_fn()).
This caused damon_reclaim to return early during the delayed work,
breaking early boot parameter configuration like
'damon_reclaim.enabled=Y'.

Fix this by changing '!=' to '=='.

Fixes: 2f54908fae21 ("mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values")
Cc: <stable@vger.kernel.org> # 6.1.x
Reported-by: Yikai Zhao <yikai@z1k.dev>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 016cd8d83ca9..bb4b705d842c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -198,7 +198,7 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
 	bool now_enabled;
 
 	now_enabled = enabled;
-	if (damon_reclaim_enabled() != now_enabled)
+	if (damon_reclaim_enabled() == now_enabled)
 		return;
 	damon_reclaim_turn(now_enabled);
 }
-- 
2.55.0

