Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC51C9EAA
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802125; cv=none; b=OWU93oDx0vCxiA5GHRCTIwi+vnRp57HLqzc0SMa7GR8fck3z4B0IMJD39oGa2OwOohAYRtWZPE8qOX+4DkXx9z+oYd5yit6O+tfY4zstX4toXnES86fi3tQGzZ1zJjw9+YZyUujm+EXGnr17OLKzdFFnFU9Crm0coPqRUmzaKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802125; c=relaxed/simple;
	bh=+JSsTP8kIMKWtfZFJUavv4mn5IpfuVorZIJsToS7o4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnyGaApzzD3H670pfJhOeuuT5GpXvkS5yX8kgJPGRIab93y1ZgP3F2L1sWOUAVQBCdlngbmbU2+B7kHzj+dVMsHy0HFjOa96zI1O+gE7zk2b6SdMMSshhvNLV2ZGCDYvohsmy1j0CcxzbCeqt5kXQEoEWArvI9TV7ll6IbYZ4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoEjusTw; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoEjusTw"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e549dd7201cso8613001276.0
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 13:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736802122; x=1737406922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CsPltl3rf+aszSkn/zoUX72WoPGcRbYKILIx7PZGqT0=;
        b=BoEjusTwihdZa1KQ2sb2HknqIPLWKn32Fg2f8wxM0bumlwmcsors53k6nU2y/KuLjL
         x5fpEhsvSF1xiCwDt+9g7VbP/k1c5WEt7IWlrj5LMERwKFOeMJsTHfV3hlVbUzJYrMQQ
         zidFCukyvmpNU+cEKEpAwBJXaw6BE74lRPqjXBiz5Q1zR0NBo+70gtPFbqT3CMD1TybI
         qvbCqfcwFyUxgn+ySHZuhZMQbBa4Tvo7zKlpkW6fe5DDn39KnWGh1fTVfVrCC+XyguiL
         yOb3G3n5cjrT6FZxQolA/jLv2VKc34p5Nf5iSYyJDtJCRhpfsrg7p0iG39nUd11PNFh/
         u7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802122; x=1737406922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsPltl3rf+aszSkn/zoUX72WoPGcRbYKILIx7PZGqT0=;
        b=V2gh/665bZskqoZpNAAnT6J8CqXIKy7ZQUfb4U1ADPS+7b1DYNoutP88EAOyuAvdzR
         aNyeHPmvVajjrMlfK7VhvS21DxasG3wJUXs8A0kaHLt3mu5+cRHOBZ+ioa1ubOZBFmgN
         78/aOglTvOsB/UTCGMP8AzwrAZS08BLAATSwljtMrDtr36h+INdRBCKUJN3DiFty5EnS
         q7u+jZR/OBA3yHjV5y8HDlWyrwGMsSN5F6y4bbwbCsNwpxBspNErSbMCiFxEXoXO5GED
         CwhRsbTEcOF+Uxaaf17pqYAPWPffMaen5dPqheWgNkNbph+jZVv5gl945PhAIEkk0p9N
         H6VA==
X-Forwarded-Encrypted: i=1; AJvYcCV2XOSEIyA5yLLq7xEuivWzkSuVawK0kL1hNkVoJJxB2NZn4Mme3vVHhGteXapbwldO+W9dfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJKS6re4iFMxXhsAdZl4JuqHXpYri5eM9AKL8BWN0ZI622zI5W
	SfulQQ/w4F+6IDnGbSLf1eDmNiWQGrT22psvwVQgzf7aHTSdmZqa
X-Gm-Gg: ASbGncuJNmCMupuZVcS/87pjxoTgdSYHt6z1Bys9Merze9pOyfL2BYQWz3BOczWBnyJ
	FN6BcCigx6WcDGI6Oj3PVqQmTsYrL0YeozE5XrYLvDs7DAMByx11pleJwzGGtHlHV8DdVKZLOr2
	0M2AaeoMXbibf6tku/TE+5llQhwIiE5Xh3SwWg0UDvY9qDzlnka2VMJ0ob4dRoQuMXKAKkgP5i2
	SiHW2WUoAw1xLF+cLAles3UKlE16D4T8XwGwMXw5ICr6fU1J6JyE5I=
X-Google-Smtp-Source: AGHT+IHOKnrP82pMHAmLLLzeNGP7pn9YOeeAXy8YQYQKgmKSgDo3F2kKkmQdnSrnETBO2gkxIwwfJQ==
X-Received: by 2002:a05:690c:680d:b0:6ef:61b9:dfca with SMTP id 00721157ae682-6f53125c889mr189473677b3.20.1736802122470;
        Mon, 13 Jan 2025 13:02:02 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f67c99c9d7sm10281607b3.47.2025.01.13.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:02:02 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH] mm/damon/paddr: Improve readability of damon_pa_stat
Date: Mon, 13 Jan 2025 13:01:56 -0800
Message-ID: <20250113210201.446051-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_stat contains an unnecessary goto statement, and the if/else
can be re-written to be more readable.

This patch is written on top of SJ's patch series [1], which in turn is
written on top of another one of his series [2].

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/all/20241219040327.61902-1-sj@kernel.org/
[2] https://lore.kernel.org/all/20241213215306.54778-1-sj@kernel.org/

---
 mm/damon/paddr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b0c283808ba6..8cdf8320f9a5 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -509,11 +509,8 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		if (!folio)
 			continue;
 
-		if (damos_pa_filter_out(s, folio))
-			goto put_folio;
-		else
+		if (!damos_pa_filter_out(s, folio))
 			*sz_filter_passed += folio_size(folio);
-put_folio:
 		folio_put(folio);
 	}
 	return 0;

base-commit: 2c0573ae5b4c9c0f9d81fa0138ed0014e1baf41b
-- 
2.43.5
