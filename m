Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416B4B1E6E
	for <damon@lists.linux.dev>; Sat, 17 May 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747491551; cv=none; b=J3a6tCf1nm2L7VkG8MrWOw/CwH3NI57ZFD9UkTQXJ6ydK507SgyBF+iR/ASIRW57uvQYBmQHQJan10rLl4Pd1N7mBGdCl85F9d8CGIhrJgbRwVQtJnipfP2N937cxCUhnafTLRuU0cQwNiLJ8sjS8dLsS9FlCGXWnEESwJLI3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747491551; c=relaxed/simple;
	bh=QQG0qCtWrnzG0Vht23/X6/0uca2F38/QutFvM7LLCJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OF6csvG4jX4+a4Xk4ObP4wfveun+3Sswg3W5DMSEDNDZnBmzgEHnhNYgRHlCEpQ/ZHFm5/tyayVosAjeLR/IPgDgTZeC6mBS5dgKgv1opskwFE1eZKVleUPraVajtR8UsgT0pUq6MdOe3s9AUNvNAeUHhtPEtMve/rXK74ZvvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiEhDFKu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiEhDFKu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23198fcdeb0so28183305ad.2
        for <damon@lists.linux.dev>; Sat, 17 May 2025 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747491549; x=1748096349; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyjp7NdbiAJJ20Sr1sjlTYaI/Pi2yVUfPSdZpWP5cT8=;
        b=KiEhDFKuFA8EqQnHVq4fzqGrqM53hTveCr+/UKtbatYV9pqDGsbmk9dBt/m8snWSt9
         Yv85ymvSm4AcXgZXps/mTH/F5eDB9vulT79Ic+5ybEnI06fbe5cUG6nXLPFINpc1Nz5H
         EXW7wW7JyiXrDJ5oR35a8Y9xvE0tBkLylcNTxL1CjZ3r8l+Q68xZKn1xGvRMy5mftbxs
         QpzVYslHjXG7e+wHiXy4d+nIhH1l4JBw6likY12Kgt/RtY84Iks1+qSs2AyV6fzfiRd6
         HiNCme78YCWvKZiDoU9VwB1qhR50AWWc5gIQW6TboGBhaUCXu8v5ZbYnz+k75njKFhWF
         dv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747491549; x=1748096349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyjp7NdbiAJJ20Sr1sjlTYaI/Pi2yVUfPSdZpWP5cT8=;
        b=oKzG9RVGslBLlf//XDwqZC5z99ouRXwPd7J0vwS2gnPCU5LSRWLat07tnYbB4tbTIv
         93wSap18LvX9qA0g5LXbg+9vLtYsjMy5jG0BAYXjh0ut2u1vy4hnJpyhHfGxFqw2zy+T
         zmgdPeikcTT+3H//+ViGQqHmdQdsoBHR+SdF0ouob+CSCGIH0JOx3j3ms9SGByIr9QJ1
         t3XcxxEgGw1/QFxDqJOL5X+RXUHc3iCWWhyPJuGP53hbdZsWAZSYP21eNZXYrIH+Hejs
         AX11zmLnqBQA/nFq5RCuQ7JbPkjKB/9ZOU3igSfLL1rr0VoBcumogMfgcr4hf0ufA2YY
         tGJg==
X-Gm-Message-State: AOJu0YwkQYc1SaDiX9ZC2KOLKPbikApWFx7I0fKOQdEbYea9h12mUA2Q
	VVNjhMYBFSMxUALc7Xf6TAZaAfDlw6S+ibkcN9yOr1/oEYxV3opwji4cUr6GoHw2
X-Gm-Gg: ASbGncsgly5vboznU4fZTcsLgoYwF4ClK6lYrLP8dvl8I56mCNhBCYx+hNKgg7oxZsu
	Zm9DpeIe0JIImQ5f9izSfFV6HYBst1y0g0KIH+5BA0htafJMbmnQJolPO+P5F9fi/0ftvfIbTZQ
	p7KFpH1UOg6iHksq+Rrk/FyGq9ebFslOUE6STuNBvhkpnL1l8+Yo3NWas9wSvSI+7SvZAkDyyZn
	iyzfkCiHCXYhYTqYovIIl6wv5IgLQSVZbdeKIBJvB2S7P+9BR8nPkL8ivGQQT1hvXoxqzUcgWUZ
	j/+ChyzYv5KId7k3nV9OBIVpWR98Ba3OnjZj/hN193tlrf/zoL0x4SzsFmwr07u16lE=
X-Google-Smtp-Source: AGHT+IGp7rGJAxlftJ7jCRQB6tQ+u7a3ZaPCrFyMxY5PH4b8st6dDXCpC2sRaJEgATwvugGgV+fiWw==
X-Received: by 2002:a17:903:1b6d:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-231d4541fbamr102307875ad.29.1747491548573;
        Sat, 17 May 2025 07:19:08 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:6ada:5ff4:a301:c919])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4b1020dsm31209265ad.104.2025.05.17.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 07:19:07 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	akinobu.mita@gmail.com,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/core: avoid destroyed target reference from DAMOS quota
Date: Sat, 17 May 2025 23:18:52 +0900
Message-Id: <20250517141852.142802-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the number of the monitoring targets in running contexts is reduced,
there may be DAMOS quotas referencing the targets that will be destroyed.

Applying the scheme action for such DAMOS scheme will be skipped forever
looking for the starting part of the region for the destroyed monitoring
target.

To fix this issue, when the monitoring target is destroyed, reset the
starting part for all DAMOS quotas that reference the target.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 587fb9a4fef8..6df13586155b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1093,9 +1093,17 @@ static int damon_commit_targets(
 			if (err)
 				return err;
 		} else {
+			struct damos *s;
+
 			if (damon_target_has_pid(dst))
 				put_pid(dst_target->pid);
 			damon_destroy_target(dst_target);
+			damon_for_each_scheme(s, dst) {
+				if (s->quota.charge_target_from == dst_target) {
+					s->quota.charge_target_from = NULL;
+					s->quota.charge_addr_from = 0;
+				}
+			}
 		}
 	}
 
-- 
2.34.1

