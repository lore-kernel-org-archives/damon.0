Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C419C54F
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 21:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765402653; cv=none; b=QH7W6n9Yh12p/biXaxGWkLfE5xdb8HZxy6M071sJiuBJ+6VUws7RkKxPqZQgVV4WKPjOcf7dtYXhvs+4Q0j5VJuMTFaLh3/kYcQDFRoSvbE1C4T/bDfOzUVEKph/3oIYTt5JlLVZ6PpWEvBl32m8/FaMKlGzGzKsMAezxtfbiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765402653; c=relaxed/simple;
	bh=AyEbySivgLXxF2lNHpPjplLtb1DpRYpjqjealx++z0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq3H5WkGNb5pvJr7m9GE10zSNbfEKTzpy2vd+2+enDBiDvM/zLlmlN7IInF6No6fahZZUq3aXG41+2weLqsoCLDx1L4ck0RXSwvl8MlVJyF6dwUaiscTelNUUIrZYaK620Qi0yaqHwVY4oDet0O0WTxIj2hhuLXZ5EW4uI50SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0W2qMfk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0W2qMfk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29558061c68so3725085ad.0
        for <damon@lists.linux.dev>; Wed, 10 Dec 2025 13:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765402651; x=1766007451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hLmL5UBaH7Jl//7hZV10HWpa1IsgMF0lpOrAgcARCs=;
        b=a0W2qMfkTLxak1QbGLgKmmyYQt9KYP1AJdJ9ukxc9iU7h++mOj58T10jYYZ+Inx/LQ
         D6CUf5G+XxfOQ5d0/zqNvLFEQ8dO8UaU4sImcGHiyGFJbarhzrsS76LzqA8UR83OhVkv
         sJVFx069B6XlTpI66UHqcBVTtRfItBG8+GYju6qDKrEGM2HzqIae7UmfjEUQx0mjnlo4
         3YGCQk5iVmfUUz8iW2s5oOGiHhBy8U+wiwAAlWEZW8nhsZd28RGtp4uTrm1E4rynRR7l
         Djwq1gcFEgdiU9Oo5UZEEIKkoF1qV83PlvrIP/CEykEVt0t3bj1rNAEsQ40OFKMf+Aum
         U2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765402651; x=1766007451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hLmL5UBaH7Jl//7hZV10HWpa1IsgMF0lpOrAgcARCs=;
        b=WiCwnCzN6OZqcoK4LR3VjGDO/7W7ftRmL9EAnrKjcWLyyfq/3IFzVo6vwNQBZrEbyk
         AenlWnj+GX/M08HMqlxUB5ccRpY2E7Vx8W5LI1rtqBRTZttwDFtXBHlVSutsz//wa9Da
         CAyQEJeA3I/05JaAuRSllqjQG6sD+ZJpvHsn2dChc9AgVLkqRyWHQG9D6y93wzyA0OvP
         R8rmCD6OzBHKe3zcGrLBtrC540mbFGQubuB82UjfzIyoWvnxlVafbQ8VI721IqsvoLuP
         pFaPJgxomLkjYzPycwC1NzkJ0OpesM+m/a0T77ZL6H5nzs9bavnq/7mQ+jHgACWVMh32
         rvrA==
X-Forwarded-Encrypted: i=1; AJvYcCX7aVwyMl1PUGf9GyPsBnmj/9NAUglMBfj89Ux53dL2dFwmJO5TKUKQu69IglEuEh8Dw1hQEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaHu6jmgPcfVjqIDngFociZ/tHtQh9Rf2sptxv6z/EEnIUfpqQ
	GjuE7Ja2BhyYJ9uxhump4mvRBngn1waSzz9NzKoRBWvo1K0KvBfxzgfU
X-Gm-Gg: AY/fxX5BI7LcuhMdUoePV78PHD5CNvZ//GicDTf0vPRP0ytTt1qv+hMFrq5t/xpHTSa
	IKeJ88SwowgWMMp0tspiSnACfbADsE5xw4lpPk/LLPKuVe0Bk2cMw9tcC9+2CUoKpOZBcp0iK4C
	fhsECPmuPSmNn0+Hfgy9iO+9zt9HBVR2QmiryZJeWstqFxUS6qGx5ft2VS7GoBHRZYHvu1nMzys
	hVbNf4Syy87ldPpo9juM8ybrWYM6yay/vvSMzpxcEMmA6ROPqm2O6AeKtkfxB3FdUtUmwjO7EKz
	BsqY69CCUi/E/i7sPcS6kWJA0POzLb60oPa2xOCiXgGQznbK8NIvPHHPLFSlM1xLZCOfn/uw6vF
	Izpz15/Q4t73HM8wGj+NK3GDeJrqdNeWUFJHQLf0DxTgFQndmGUmkDukTB45U3973M+YaITSMv8
	68mFiwriVLiPq44yPvOGxQ83Fqj58=
X-Google-Smtp-Source: AGHT+IFOKeCD7SLJaoyaxSzMzfFpQdgEfp6KhJDB1eupbtl6YbSdpyQhFlSIJb3jOZCFQdhFRs3+hQ==
X-Received: by 2002:a17:903:32d1:b0:295:8db9:305f with SMTP id d9443c01a7336-29ec2d40dd6mr37532245ad.34.1765402651414;
        Wed, 10 Dec 2025 13:37:31 -0800 (PST)
Received: from LilGuy ([2409:40c2:1056:3997:289:7d28:d8ed:a86])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29ee9d38b3dsm2922135ad.36.2025.12.10.13.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:37:30 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	swarajgaikwad1925@gmail.com
Subject: [PATCH v2] mm/damon/sysfs-schemes: Remove outdated TODO in target_nid_store()
Date: Thu, 11 Dec 2025 03:07:08 +0000
Message-ID: <20251211030707.16417-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210150930.57679-1-sj@kernel.org>
References: <20251210150930.57679-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO comment in target_nid_store() suggested adding range validation
for target_nid. As discussed in [1], the current behavior of accepting
any integer value is intentional. DAMON sysfs aims to remain flexible,
including supporting users who prepare node IDs before future NUMA hotplug
events.

Because this behavior matches the broader design philosophy of the DAMON
sysfs interface, the TODO comment is now misleading. This patch removes the
comment.

No functional changes.

[1] https://lore.kernel.org/lkml/20251210150930.57679-1-sj@kernel.org/

v2:
 - Removed the logic changes (validation) introduced in v1.
 - Updated commit message to reflect that only the comment is being removed.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 mm/damon/sysfs-schemes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 6536f16006c9..14a17da350ab 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2245,7 +2245,6 @@ static ssize_t target_nid_store(struct kobject *kobj,
 			struct damon_sysfs_scheme, kobj);
 	int err = 0;

-	/* TODO: error handling for target_nid range. */
 	err = kstrtoint(buf, 0, &scheme->target_nid);

 	return err ? err : count;

base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
--
2.52.0

