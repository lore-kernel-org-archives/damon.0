Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420861;
	b=emy6oPTTMTvS5UeCx7CZjhl7lJwHkpTdVAp6/+tzGFuLqU2i8v8v6ar6azc2CCQAfXf/
	 qMPS58ZDpX/5HRDUR7YlNhsTIHd6djC+O1/nh9BEfETn36jMLoGrWPz7AtZAR2DengNeR
	 1YHbo7rLqw40E6yRdkZ9b5QkQqNwhsFRhnxvihFYWUxynu1IEPe6HAjQF4Uxo6RIv/xGu
	 FD4TQBumdx26FgQ8kc0tEpYm54iGJdVC4dIp4T2glhyI8uwhjmK9gjQjxVVo89zUFvE1G
	 k7xfMD58Vnz4lgAgRyaCKfFYSM1/mRG1yu9KzPjNysX1lcXnYBZBSOc5/HDZaNLXwlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=f4kxL1RSmgNIZ5ncBejETsrMHrpcYl0Fuets3/kxcc4=;
	b=x+NnXeIQtJjwAZGcZ6+WqHF8FzXIQq90B15SX2gD9NGsjUWrS2ag8qYKDJCbU3iURT6w
	 i6JULwpjgmu6SGN1NqtuQ94q3oFcOGfvkUWkZrracZDv5GjVTj4Q5Z44L6CHBVg7ShVgL
	 T9dlLDb1I20aDGapW7q36wrDEsB2xTiP89jWlGITKl/Bw0vZdKefcM1O4h7uQZq/rosJ7
	 ef07OgHYj7x/gHKkfcPyjILKmTMRkDt0bQc3Mh2eu9uSlPLYlMaNWbgpSTqhLXki1GFcS
	 PJERtBix7+aBwDvpfKkmsPNCXKaOwb8frXTUB6yOXziEBhlL7xtwrN76sUSmG2rqd6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHIANvix;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4460A381C
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54A4460A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hHIANvix
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ea993271f2so13122365ad.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 00:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795420860; x=1796025660; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f4kxL1RSmgNIZ5ncBejETsrMHrpcYl0Fuets3/kxcc4=;
        b=hHIANvixaKa4DRMiTuJ2yDbqyuRP+VBFF+bWWYN7bsmGDIsDoxwGLDIMcMhVePO93C
         3S5yXAqDVHgqyTWWeVlwjhb6dqc6CI2tAyXXRsokOnxGpbnbIks6b3vToSYB4TM5pL4K
         loRoKNEWdlvw8lbOpQV8DvVQT/o+ExR4GVglJ5ksT4dRDU6suMya+kk6K95r2ZtM4GEP
         QyhhbVIRRLVnKyj9nHIc5Kj/P/fRnS/zow4zrf1QtT3Wr02FxBS2a/AVgm13hIGdpLPM
         eSYoyhmBKS45KHLl1UvOFEZTi816ziNQBcZli9jRXdZEpbXyB9a27YrEWk4hXOu711Wx
         gLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420860; x=1796025660;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f4kxL1RSmgNIZ5ncBejETsrMHrpcYl0Fuets3/kxcc4=;
        b=jUEmU+gwt5yx9OWSbat+pzYsugMDd1ZTL/R40cMv4IFKnC7q9TDYYAzTrqIdeJ8Jxa
         B0ucR4kTfP0god+W22+JxKvUqj6DmaqjiKvMoIdKpHAkY5YGbCN045n03Pk0A6w+Gbg9
         sLtH3fhW/EwuwMuFvHENi6n1oYWUjRVlqgDjL+WTReuq2/PI8Ighgpuhtu9DjTHadHnR
         bYVZ5vkWNzTXOViOOCaqyPyOFqsO7eeDDggsiFnvfS5Cd7GmwZw2oGmzVa5eSZM+GYZm
         I6Y/DoOOVTxGufp0r3Jl7Ps5FVyd/dnQ0Ll5ssq9zKczyxHlIeTMuLOpewkf9syP7kxF
         j5dA==
X-Forwarded-Encrypted: i=1; AL+hErHeq3yhtfu3Pg4fTnO1lagfE0NCHL21T7w0fovAXWpvasuBGOMLbMUTm8BBYQWnbopKGqtsjw==@lists.linux.dev
X-Gm-Message-State: APuU4Z83nRuXLHZweo6UzvwY2YXdd9IrI01E3gvZBIwp53qnnf3DsAJe
	hcb6vtH25X35cS0rfZMDCZ7cdt2lLc3MVIychATQJgPuAOkaI8ihz4yX
X-Gm-Gg: AZFdTZdC87qfvaWXqlHkoRcvYbLaHXf4/Xtt5I/6A25YHaFSxqmlCbgwbximB5hEGOC
	Dv2DR3yjE23R0u5QmF4wAVvskAlfjQcfs5yhMnC45/sczz3QQTNwHwufxTwOK4PZYVHxgEcCF5u
	q2Ds9iwxkavoBIbogbNUyZWWlJ5U5o6ouoo7Ro0wKxcB3uG7pI7vJMrJWrSJKMXn/oyH2maGnh4
	sr5bsiZUHqawp8eTEFuTsXO9HL1oLhIgj/PUuke529aBEwex3INMYtzGCe+p8g4diplYMZl5mXt
	nn00rlOrfsJhMq92+cE2kI9sSV/+RTGzyfHyOixsKhssLE6v74Gga0d3ZVNHpy9V9yXdAsUjvER
	tZ8fL6ecunb57hH77ioLFqGkh9371EALesNMnbr7HQyoQllQi11AlUkA6WLUx3SuYHCbfguNUq7
	99fdSQfbrt4ujE12Hjw3sjejZ/DkxGu/BXCEi2yRii4BHCjFnc1ipXkMqoSX8l73W6DgcHbiFgG
	NptM3TWaza4CB62EK0C8zwgoMHVqH2U+iKt1UfNjIKhmDaZkPsSgHH8Ohq4aDwArU4fcUhiB/t/
	pcqgJ/sPed99OkCEbtSJ6or89yh4YWfpDgijvBhvnRBkXpfpKwwPyrPdMgg67JffNd8cQCk5X4Z
	hH0FJ5JatCmgRODDJLdwPdsPtEr4CUmxs9d47uLgjTYEFFS/iGjjOAbhF2jubPA==
X-Received: by 2002:a05:6a21:32a0:b0:3e2:90da:9594 with SMTP id adf61e73a8af0-4014a37929emr10127148637.9.1795420860377;
        Mon, 23 Nov 2026 00:01:00 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cf4fsm5020034b3a.49.2026.11.23.00.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:01:00 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 23 Nov 2026 18:51:45 +1100
Subject: [PATCH] mm/damon/sysfs: skip registration if DAMON core init fails
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ6CMBBEf4Xs2U0sJoj+ivGwLQuspqXpFpUQ/
 l0Qj28y82YG5SSscC1mSPwSlSGsYA4FuJ5CxyjNylAey8qY8oQN+SGgTtoqSpCM3UipwdbVZ67
 qmhwxrOOYuJXPT3y776yjfbDLm21rWFJGmyi4fov+3qdEZB/zhDENlhW9x8Bv3P/NBZblCxZgk
 SS0AAAA
X-Change-ID: 20261123-damon-sysfs-init-guard-fc87e688acae
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Lian Wang <lianux.mm@gmail.com>, Dawei Li <set_pte_at@outlook.com>, 
 damon@lists.linux.dev, linux-mm@kvack.org
X-Mailer: b4 0.16.0

Hi SJ,

Here's the sysfs fix I mentioned in the report queue review.

-- >8 --

While reviewing the DAMON report queue series, I noticed that DAMON
sysfs still registers its interface if DAMON core initialization fails.
If damon_init() fails to allocate damon_region_cache, starting a
kdamond with an initial region can pass a NULL cache to
kmem_cache_alloc() via damon_new_region().

Check damon_initialized() before creating the DAMON sysfs directory and
return -ENOMEM if the core is unavailable.

Fixes: a18709442869 ("mm/damon: improve damon_new_region strategy")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Tests passed in x86-64 QEMU TCG guests on 9f004372ebeb.
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 779c98205a94..7de0f03a3fd5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3035,6 +3035,9 @@ static int __init damon_sysfs_init(void)
 	struct damon_sysfs_ui_dir *admin;
 	int err;
 
+	if (!damon_initialized())
+		return -ENOMEM;
+
 	damon_sysfs_root = kobject_create_and_add("damon", mm_kobj);
 	if (!damon_sysfs_root)
 		return -ENOMEM;

---
base-commit: 9f004372ebeb18fdeb699f9880a0e472df90135b
change-id: 20261123-damon-sysfs-init-guard-fc87e688acae

-- 
Thanks,
Aveline Noir
