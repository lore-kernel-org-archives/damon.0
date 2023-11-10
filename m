Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53DF1C3F
	for <damon@lists.linux.dev>; Fri, 10 Nov 2023 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpTY5Ff+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1411770b3a.0
        for <damon@lists.linux.dev>; Thu, 09 Nov 2023 21:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699594651; x=1700199451; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yghova5iSMKTBA45oZLzkBRYbxARDuNDN2cHtnXgdHM=;
        b=lpTY5Ff+1CblO+Y1U34cOw7bmuT/Zj4azkyrtnCAlW1G+OqfYxa4XKRByV9lyUoTTn
         1nJoWrnVDCr+bd1oyvObuP3ouCeqacTh5/hMnl8XN7UZ1lzkvf+GajFqSj0O2xiNmmey
         wtOJj/LcAFDiWJMLwa4L9zhyCEvxXi20pkkAVzP+PlSZUXvD9gi71lOJLzuzeEZ1wGU8
         l8/fCWXHLfNxsRTkKJoXMtV8/QF1BXB5YAtxpvdVZpBySlKJfBPmomDKQ0COSWaxzft7
         aJRzEEB4e4DXi4lNJy7gHGTZB+MEkZ7EOHgkoe7UCLLzSX4UKli0MPTut4XtUqhxR4kl
         fGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699594651; x=1700199451;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yghova5iSMKTBA45oZLzkBRYbxARDuNDN2cHtnXgdHM=;
        b=rZCbh73B2OM8cZNMZOcdey+lGaWLpI6bTEOEP7TpVHZ2TjYHXYGFDNGGpxjZjNuM8u
         xo+3M08KkAbpOplfP4SQrweGOXnp3lWgIiGK78Q/U/7Hg1YApx6nTmiiRwMtFb9GcHVe
         bfPmVoJaDAVCbhNx1FxeKKZ4qubE7IjBEMvhBRu4oxSW4svTTcT0mD57PzB6nYSpCMSo
         YIvPaVWLYr4ylsoRFuZf3IJCco1J/tmFMyfilqJgSfDAajTgh/EODou90D8L7zDm1f1r
         h5LsAgESXYyfwKWefG+3l0Dny4YTFdrbouUkWyy1GHBZpgUbf7sAFSldqIYUS1xE20ku
         yeaQ==
X-Gm-Message-State: AOJu0YwJ1nGOOcWSC3H5Cx601cum3yt5UogbpxgqMcApQr/6g9VaFOk3
	P5PM3IvdLwIj08owwMaTtOc=
X-Google-Smtp-Source: AGHT+IHX4POyeIQIz3//DRgsH7ndWRxaItYPn9ftalpBFUAuTC2B6xHM8UGp4ejVrIZQm3GdPGG0ig==
X-Received: by 2002:a05:6a00:8cc8:b0:6c3:3cb0:d85 with SMTP id ij8-20020a056a008cc800b006c33cb00d85mr2116768pfb.0.1699594651019;
        Thu, 09 Nov 2023 21:37:31 -0800 (PST)
Received: from localhost.localdomain ([1.237.29.215])
        by smtp.gmail.com with ESMTPSA id 33-20020a631961000000b005b93dee7fa4sm5682522pgz.50.2023.11.09.21.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 21:37:30 -0800 (PST)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hyeongtak Ji <hyeongtak.ji@gmail.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
Date: Fri, 10 Nov 2023 14:37:09 +0900
Message-Id: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

The function '__damos_filter_out()' causes DAMON to always filter out
schemes whose filter type is anon or memcg if its matching value is set
to false.

This commit addresses the issue by ensuring that '__damos_filter_out()'
no longer applies to filters whose type is 'anon' or 'memcg'.

Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..d5ef8945a343 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -920,7 +920,7 @@ static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		matched = true;
 		break;
 	default:
-		break;
+		return false;
 	}
 
 	return matched == filter->matching;
-- 
2.7.4

