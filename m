Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C93A7853
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774723407; cv=none; b=JbdIE4Awb2OL5ATtmnDuGaGCnLt8Dv0yioK7ViRlOvmgey9V8dZxheDXkC+uIJ7Kl87TR2MhbQO2IVRWE/3btvsmedugYd832R+LSuE92Up8Pm8v4XHlcIee7R4FzDp4Qcw7qnOuT5qfp9rVPjjqb6spRLlqN1NxWWPHNnLpL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774723407; c=relaxed/simple;
	bh=WHgUvoWefmXQ3BzFXgYvxXxi0gr52c17ry7Ec0jmc5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j538/a5dqJAihYxRsgpBb39QoyXL9HliZL2wT5AcwmXxwCFRv7hPj0ZD6/iRv2mgfOu1Qk3+8n43T/Aw/CZdKsqYymh/+s6kUNpyzoQrUELDSxllhSDWW0/zve/LyPd/aQuz2yFC6q2FV63tuk4E+hLZNoxNFKJRolCszDuMG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RupWARWM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RupWARWM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35c16db1b53so1730348a91.1
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774723402; x=1775328202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EP2ckNKWBPmkFolP75nur6z6WVdO4BalIzs38VivV8o=;
        b=RupWARWM9jk+AnZ9dzEZBXSg4KyuoQ7AE8UQiTzzkEQj+h7uu+un+q+ZDbCO/TkmuN
         Sw1c9CBnbhsxUWqh8U6QdBpzgqW7unAwObpeaym4XemaYaU52nzw279mOjFGiCSwx/a6
         airxL5tUf6Lj1hH/6YvyhyFGHXL0jYu5YT51csIH5R+0uoc8w7/MFxwudFfqt/0lDcyO
         lqOvKcyIMsORLW7RPOrX4x/kYrugyglECP8mL7zwwraQtIH6l4ovK086e/jkklG3TUFS
         c5znnW3VzVCsqjilidZpJLxN0ZaS221AISuDogLhsTJmp0Z2QvzfJ8gZDDf+ZJe0Tchu
         44pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774723402; x=1775328202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EP2ckNKWBPmkFolP75nur6z6WVdO4BalIzs38VivV8o=;
        b=Bzg5XVdEYEgbMh4/idZA2r2qw77vxAyIYXLaA6pdVeszGc0M67I6J1LPUw35v0fpAe
         co0szWYezByisgpTTPO3KCeVY20h+v1t/GZ5Y5xeNXHg841y11pLs/6HxlGuj4xlOZE3
         8owM1Pe8ygLQ8w41RTUMsgMuyjOv9IoBv8q9xGZdQrQ+9HPHgRrvu9HwE0+DV2TjwkBF
         KdSJ018YjtqcDZDPRzE8kn5xcPz3QnDhAEGJCp74U36Xeuoj2IPY3svhsN3Cfg9OuNWK
         qhnnZnRM5TdRUmdqZfTo2ZoadtXbxWD+/TU7O2RlFLCeds+MixiwgDHxQ2OC4XDhclWU
         eBKg==
X-Forwarded-Encrypted: i=1; AJvYcCWj92dRdsWJC/ZESu/WR5GdhqdbKAu270vAbqg8BNY1lgdSj4jLlReeTVpAyeFS1Usg6/xx5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQn5760C5nzIyvJXa7m/5PAwYCtpyOlwluxenTGxq97AcxeYMe
	r94lCbGGjAV4FJwm7cekfKHmz3tWXk7WPwm63KwIXL1h+dyRTB7r/hy6
X-Gm-Gg: ATEYQzwrOQT2HqlF6AJiTRqBonbkRfqeabBw+vmlwkI0A/XGgKASYhmCY0wTd4Kz80C
	/dBz1lFDh/V33mqbLIPH9SR+gYH7MPoAUkXA2K5s2eM61My5ikRoTupuYl8QCmqsrnhQKqliB9q
	osk8iS1stMySr8/eySScwPOKQjYegAihuc0OshtTrVnh9+BXMCUuRcgys8uQmjdPIlKKt/pU6NY
	4snwMH5k3f1U7ZDrCPefi4eDM3NkZy63MQ/GfRq+jBZd4jfgZF5irViPa42X63DvigsPG9XnKNV
	52hXgtvND/yilIeaJMZQMA3h8qd9MCNBBnwh9eexcKNdQsnXvsXZvg3xB2/EzAEWxQTvzF3GfxV
	o9kmDPu52maQsTUKsLKD5Qi8joyhVnapZ+NCkgmTm/Ohhb4vLTB9y8Zj7ruqjwm79E80phz9bt1
	wJ1ZLiExaG6E9IBpShJFSOzLsqsV0=
X-Received: by 2002:a17:90a:da8d:b0:35b:e550:e68a with SMTP id 98e67ed59e1d1-35c2ff1be42mr7049890a91.3.1774723401883;
        Sat, 28 Mar 2026 11:43:21 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2ebe2c98sm2617321a91.6.2026.03.28.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:43:21 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sun, 29 Mar 2026 02:43:19 +0800
Message-ID: <20260328184319.13176-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328180629.55498-1-sj@kernel.org>
References: <20260328180629.55498-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Liew, I suggeted two options before.  But you are skipping providing your
> opinion to those, and adding yet more options.  That makes me difficult to
> follow the conversation.  Could you please answer to my suggestions and make a
> consensus about those, first?

Apologize if my previous email was unclear. Let me directly address your
two suggestion.

1. DAMON_SYSFS Type [1]:
   I fully agree with this. Centralizing the validation in
   damon_commit_ctx() is the right approach to avoid "whack-a-mole"
   problem. This is exactly what I am proposing.

2. Adding a simple check on existing validation logic (in callers?) [2]:
   While this is simpler to implement, I prefer avoiding it for the
   "whack-a-mole".

So, to clarify, I choose your first option (centralized check), and I
believe my "Option 2" is the simple way to implement it.

Does ths align with your expectation? If so, I will proceed with this
approach.

[1] https://lore.kernel.org/20260328132937.9580-1-sj@kernel.org
[2] https://lore.kernel.org/20260328141323.10540-1-sj@kernel.org
[3] https://lore.kernel.org/20260328174409.6786-1-aethernet65535@gmail.com

Best regards,
Rui Yan
