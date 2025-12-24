Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E332937E
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550142; cv=none; b=CYkMTM6cTD1eDsnKNFre5e2DH2aF3pIlDryJxk9mlaotTl1uz+svbqLiAUQ5FwkinF8HciEYB+M6VkGiKhXFjNw9i7EZhbwkH78KTIE9H9o8RzdE4ubcxiqxTBNfiH4kYOoTzImMRojYrrnWZ7ZlsPkfhKhQ/4H3bea76rCYH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550142; c=relaxed/simple;
	bh=VUB9jdoQCowQvyEwmzuanxgF6kRtTz5+C4P5JKWJZWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=domwDA5iBGe9wp4/9dO+v7e1EsuLCci93l/J9BMMilEZ/kw/KJ8R1CBRAHHhZq+WXppDGS0ULWpRUkvltoJVivg9F9Sj9N9Attjdph7e/80dvrXqTE8I99zBRLDnT4i+7dQRlHuqIqY3N+9sM116JDrXzG9Bzt7OwmkgdamBqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HteM2lXt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HteM2lXt"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a110548cdeso78475745ad.0
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550139; x=1767154939; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w276wAFp2rXYTfyoJfyMT1dCfO/MaZhkGr6Yu9YkzH8=;
        b=HteM2lXtdqZIdEyDV0C4/0kKpKWCwCiEz1FKN8CQBh4FmP4k786FMOWPug3umJDtK/
         g2v80JCQ39HULsyy4fOuvivQNfmapGE9/7uAmuPhMIdoxSmLU+piazld4BB+vxXXUfPO
         sJbChQr+5zLr7eEf/w32L6RgoUVAFQpNxrW1SPios82p2zpMh0ElHRsa0qeHr2vLWXsK
         HaSGT81mQFZGnfBZwkhXgOYB0XGCMnluh9sN8ff0SViZUf+1LycLuhgyriFTIT67gTMZ
         ZUGd9HyPSNXKQe0cZVp32AdztOr0pzrJCPg7GfpwL6UUGTPZx1gdiw+D3Z/iawzaZltJ
         0ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550139; x=1767154939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w276wAFp2rXYTfyoJfyMT1dCfO/MaZhkGr6Yu9YkzH8=;
        b=tnzuLjzb9nU36xyTcKd6BsRld0Lp7KsVvjYVTAW6gAv9X8H5LiRMLCW9tBpXsNl2u8
         E380iSRCIzi/VSLmkQQThFu78SdQRXtUN6Ww8a06A9tACoUJF2ycJA7yjEgVOcq02UQT
         ndVJMW70S1EaCdez7eXn3WTH1sQfa2AUVopiYN4jcuvKzf/GGDRxH42q2l8cRCIC+AtA
         hNEV71llakUjqpUHh4yZanGSbI3QXv+NOWs2OmqPQVQXV9ap3YuN1OKMphaM0OdCznOu
         NThpy9dx1/F1wnOlHCchaOrb2GmU08tmlWGAyf7B1xXevVeM5JEK/EYzE5sbAPB4nrMQ
         PTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUecnLhLNCVvOq7oFNGA4jUV9wNMD4/AwfnIdEKP8xlW7wOoqhNOCS3IhRnlm1ZK640/1KoGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFksSpiICEmjyk2nvy6L75K1VRa8hl9CkeJSyaKa+jQI4XLjIS
	jGA8RnxKsPv7lwl/ppx3OwEDqYiwDISSF7GgUpugXs4rR2ezczgXN63E
X-Gm-Gg: AY/fxX5qMEB4z19XU9noFUQNNI+gaPZT4n6+rl8aozsmINI3KhuVJprLzudmrSZ0LSv
	lJ1BMZzIc8AY3nmWT7CGoUvdOvUK9rCDr6xHp+jDvxRs2Dk3T3CQl4xVJQz5ym8YCh/m/KmKD5A
	//OrDJpHdz2uDLg9V4o4+JIEKSy0u7U+mStWuCk/PjIZRUmUgsjk9u0KU+l7WjzHf0H116ngZWu
	N07t8/p3tzV6oPH0CLxmSk2dP/Ofr3nXxEf0MpJVaaBwNUtQKkJY8iqT6bCPbEzIpEt+/Ve0Ghp
	J5mVvoPUozGy//wOFfpAC8jx58tFZq6QOYLfz7PeKmujRpWwzdx/XcRL/UxV3v4EFytltE5yVDm
	/ptqh4aRnrDg59tsK/+URcBdTgBcUlOxePfYWxBJkmbWjDwq0sGkO+AC0+lg8ziuKVoNiLZnwtl
	hv
X-Google-Smtp-Source: AGHT+IEhAqxGeTZKj23GyK+SQ0+Vt5x+PYbcQPiunLEQ2r5NzuypeF7Veg9StfYdXugSobiGJ1npaA==
X-Received: by 2002:a05:7022:e13:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-121722eb801mr18312939c88.26.1766550139363;
        Tue, 23 Dec 2025 20:22:19 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:19 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 2/5] mm/damon/tests/core-kunit: verify the 'age' and 'nr_accesses_bp' fields in damon_test_merge_two()
Date: Wed, 24 Dec 2025 04:21:57 +0000
Message-ID: <20251224042200.2061847-3-shu17az@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224042200.2061847-1-shu17az@gmail.com>
References: <20251224042200.2061847-1-shu17az@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend damon_test_merge_two() to verify the 'age' and 
'nr_accesses_bp' fields.

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 88ec046f4942..6e301113e103 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -192,6 +192,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	r->nr_accesses = 10;
 	r->nr_accesses_bp = 100000;
+	r->age = 9;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
 	if (!r2) {
@@ -200,12 +201,15 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	r2->nr_accesses = 20;
 	r2->nr_accesses_bp = 200000;
+	r2->age = 21;
 	damon_add_region(r2, t);
 
 	damon_merge_two_regions(t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, 160000u);
+	KUNIT_EXPECT_EQ(test, r->age, 17u);
 
 	i = 0;
 	damon_for_each_region(r3, t) {
-- 
2.43.0

