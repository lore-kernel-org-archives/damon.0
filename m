Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C873009E5
	for <damon@lists.linux.dev>; Wed, 10 Dec 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403879; cv=none; b=RGhmkIM47xlj5Ul77VN2XorOX5w/vD9q1jvMuc+wb17g2hNlVP5ALxKDdNt5o2jRs9XJ0qPjYMJPRPZ8Gfgl8vcw+Oh1eSBX2hyuvmFfIwXPyQNRn4EJw7pQva5oyiLsinHaTpqRcfqGsSSJQI9foNJHq9OAd3vYuBSNPVRgj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403879; c=relaxed/simple;
	bh=hjFMPk59DGnxn00qcVwY32mfbF1V9dBUxD/wPXoJNFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoT0GnY99keArv0cyxly1aPVBbBv9N/j5v6NXkr/RFAvvVLKaACyW1WBgMVHT/yL/XLHM73OBRdJ3+kvkHg6cgdzfDhfxfIzQwI/Fnn31KlFDgxzwCeC0KHeXIw+/RBciGXKORZ9zZqVgDpvFIzUF5JxU/RLbhS0EmV0NSFAu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX/uwXmy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX/uwXmy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aab7623f42so349551b3a.2
        for <damon@lists.linux.dev>; Wed, 10 Dec 2025 13:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765403877; x=1766008677; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hm1NbizhX2u/6oOBSk1ArXnzSC2i/yu4zfAVJxLwRo=;
        b=TX/uwXmydXoS1mhIRKLYUNchEGOqBH98G3TpfQI10UaMGFta03JfCUOJPE9qX50Nuy
         q0zhPCm7ilGRcosZHG4fH1mNlRAVYd7TH9Sh5L61QEBaEv/l5Oh+GDMmOnvKAjERFtpn
         lb1gbl371uruyi21fuQVRvFz9p+A9uxvooC85wQD0adgDmKwXKHSKpdll416mO34ydjd
         /omMk5u/9mNdzr8bJHwyeeEcZexEeLbpjc2RZv3Sx2rNiMrlN4o6WA5Fdv0bDkJR3FYZ
         xOI5g6iUBLsI3qfgfeBZtv7+E1gJdtPnwilxUsXs1vdDbHw2sQMYN2rFu4c6TpCXcTd0
         Z50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765403877; x=1766008677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hm1NbizhX2u/6oOBSk1ArXnzSC2i/yu4zfAVJxLwRo=;
        b=p6dgtWRRrGzrjV7XcLkt+xRsM3T5O9Yb+sAkwGlpfOM64Bs8q6AKOqI3preU1jdIr3
         XxlKjYB4+Zw2l10NuIgIL9pzpsKEr7erIxgZQ8166F8959UVSdpiUNdupa09GXVMM8Oi
         +fIMUWONXTLzAbU/gvVQzJE230zb4rH8AI+Y9OCVWpiQBw4mCKeGRlSwiHIM+q9c0l6+
         kNsrYUwU6Nc3TltM3Y8HcJxQ+Ii7Vs8ZaUXP2ekZznYn7r4PHv+S3FTnqRSKgxzoZwSO
         696JL7dEZh47gUDMPHRu/myRsqCytVCok7Pvw9t6mOe3X8ZTEhF3ylbXox7eti/TxSQd
         TeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigIhoCpXOTveHAB1z69yirdrKFgl28gVW9aO480rGL1VoSVJ/wc8GrwHhXjzlUKacuGsKAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwq/mtnwCJd63FVGSRd3cEiBbuST5L6L+OBGPfq3TU1lVxBXJM
	rfZK565pN8dnxKYO2uQ6pl3+x//D3I0sqAcwcT5eFWyCP5BVmToaNzr7
X-Gm-Gg: AY/fxX6mnOrkMt44DgKmHM8cqOyTRodMO1SqfFWFYh3w1VKwgTpdMq52brbdn8SB1VP
	mNbIQS7A8D4tOwt1oIF/f+BkSOus4ybxqffQXwK4kWOpWKvblzdY46BBbLdsCtpD5g5WYcCgmCu
	kcEDz5oljUMftGceXGaVbkSC3U1JTeibCGYLazWgrHF2VtEzd9/Xz0VsslS/ExOXVZLMBLLMc9E
	zmSNumZBugxTWrtfSZd9QpKp2INdvatiXN6ew9IkgH4CKR81WmwF6N7JDK9Orb4ZGkiKr6uJ9wq
	zkpASEbInfTZCtbuSMboiT9DdAlqEcgso2lsCP/jhlubL7+Qf3A+poNP/Y3PNnHTDbBM4EZ/yR0
	4Vfj1EfnqTgDm1hMgwl6VFA9VrjBgKrigOQ/twKVribJ6xGcio9oXgOLuwLNdZG2ry/TMVJF5yC
	c+q8+kC44TPAEpypy4MUfHqSoAal8=
X-Google-Smtp-Source: AGHT+IHA+9Qz7ydU3Ty9NpHFSEVIZQE81z8wV2mYZQOhee792sM2qH9nyagSd+BRXofaMXiX+aNkbA==
X-Received: by 2002:a05:6a00:4f82:b0:7f1:7c82:fe2e with SMTP id d2e1a72fcca58-7f22dabffacmr4111460b3a.1.1765403877452;
        Wed, 10 Dec 2025 13:57:57 -0800 (PST)
Received: from LilGuy ([2409:40c2:1056:3997:289:7d28:d8ed:a86])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7f4c54812aesm453133b3a.65.2025.12.10.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:57:56 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev (open list:DAMON),
	linux-mm@kvack.org (open list:DAMON),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH v3] mm/damon/sysfs-schemes: Remove outdated TODO in target_nid_store()
Date: Thu, 11 Dec 2025 03:27:22 +0000
Message-ID: <20251211032722.4928-2-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
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
comment without introducing any behavioral change.

No functional changes.

[1] https://lore.kernel.org/lkml/20251210150930.57679-1-sj@kernel.org/

Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
v3:
 - Added Reviewed-by tag.
 - Moved version history below the '---' line.

v2:
 - Removed the logic changes (validation) introduced in v1.
 - Updated commit message to reflect that only the comment is
   being removed.

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

