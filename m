Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33574361DA1
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774159596; cv=none; b=VXWtHPhtzmOtb+HCn2B9eFsY7WXfYFvY7d02sNaNJFc94VV7ftkqenRax6t7wvImrUtpBHF0PzWs//alUGRO3sJXnM7Nveiqy/F1U+qf5ioJ9ZNexjIKzvCsx/C/riqaTputqfN6jd9neSHhuFO+iNaUMu7VSbFuLMpNMIKlSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774159596; c=relaxed/simple;
	bh=qwzz1BkjhhuKbVhwdYCMDaQh9oHfyBUl01ecUTxl5eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4kWePNRUD/ZUWTcbsFfli9jKXWO0tPClJsgoE+0v7laud22p3g30+SbWizmYDpvgcadJj6Q1007kyc3wiW2DkcwPX0VtWc4IqO8lW+dE16hppgUBv0pqDK6WFt7bPxsnhAY/kvuJjOdU6muArwLiworakCN39O3dBarhvURBD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahDh7LBo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahDh7LBo"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf43014d0so20661525ad.2
        for <damon@lists.linux.dev>; Sat, 21 Mar 2026 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774159594; x=1774764394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGTrddMpoqNlMDtLVg/NZ7xDSHSql5ga38DOEBpNYTM=;
        b=ahDh7LBoiptPM73hvdq49jSYcd0e/WGj9G3iiVPeSre156TrXg/OE/lef4YcNYHuMb
         Bk8Opf0DtDSimYfRNKIPPZy5D+/s0st5THVKcpbX9l5tMZNELggMgPSLvA2jK2Z/53X0
         ZkL2kGBV2kfwvK0REKCw8SAUtJzSPUyEl/IfiIXHth4b/gox8OzkbcpCiGH2Z+AgsQBe
         MQZABO1tDCl//8EGSKfOGjksyDkVI2TPye+pLOwnBiNJSvTxvBp2i3JTWEIVRBUWxPrD
         zoYz8JhPzXxMFW3FfNtEB7FgfxMK34Dpap3fPYarxPOtoSqIh0+ej854BlArhiCiUHl7
         ORmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774159594; x=1774764394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGTrddMpoqNlMDtLVg/NZ7xDSHSql5ga38DOEBpNYTM=;
        b=Rb7NBfpT97rpDfgONbaFsqURcyY45/LfTitO0Vrk2crPyl/9moI7U6ghVRvvgZV56a
         Fgns/a3yrjE0+8jvO8HIh0uum7y9Wg0jC2s4DVbhlapY9qGYH3WiKOYR6xY1bRONPxrD
         GENdT2EUBNNzIVaolynYbNrIm/pK55d5kh55xH55zimjp6u/zQr4vIg31mFVexsiSSP1
         PrVp5Zm4+ztoMnXqdRjBfKxVD5kiSrE7At57V0QoS3aYR5RU9wc6Vj5ozF7oIx30e/Sz
         ROdejQQyExVMGnSdYJvNYJn4dWg2nk2paTtpEiHB+6eV+UaThtwizhmnjVCD6mpAFVCW
         i52Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHpcNgYdX0BnkAToozoIvPm1kO5EPhvyHlgfoBsR2h4OQaM2r+SlI2mI4oCHVg4y0WVP3R9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR7+980E71ZheABnBRDTw1e8v6ryzTg6w4BgizujB7nGtwqRm5
	dXpBuBIdXGH4mhqN0Asiqc7bcMHYzsQy39bE2sRBlef32uLP2suEIXqy
X-Gm-Gg: ATEYQzwD8bMFyetPbhK+g5sFFQfmze1qO92I4eh/uHIao4ht7Q8+1vidcJfWG7754rG
	kqQ1UFRhQdqVl7MEruMxvHXlkX0i/iVnEJL2pch3+9mw6FeQ4pzKUew4VRg1PaPzmu4uE8UdOcS
	eG3vmlj8Sq/aVsLqGV7xXaHDG7MeuM4QMCn7xW8st3uNw9Ppo+jwA3XqN55oK2Ik0AbphHaoEcS
	jnewPvV00qEvscJodvPc/ZHzuvA6pX1O8UB0mJfxzxABMpcqtcNLwS/C/0EfvG6x5xmzSIkVWHI
	2dgMIhUDHCLzgrdjbkDUmQ7d/C4RaOXthqGtpnTmLQFevJFIFoONWJkyvNWuas+2pp7lbITN3wp
	YlbQpCWBqhjS16cE05nhClPvnICdv0luf+voAO7IUurAXqS94JKTjvT2HBj0KboiUTpgqswvB6t
	e2Fq/eEPS0oqAIvqnfPkmvZ1F4KVCgRQAz/s2ZYTNNrKXsUo8i1ZTjUTr1IFwA
X-Received: by 2002:a17:903:32c5:b0:2b0:52b7:e82 with SMTP id d9443c01a7336-2b08270ec51mr78290875ad.16.1774159594423;
        Sat, 21 Mar 2026 23:06:34 -0700 (PDT)
Received: from fedora.taila51cc2.ts.net ([2001:e68:5472:9397:f52c:8e34:31f3:462c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b81sm93042045ad.41.2026.03.21.23.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 23:06:34 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC v2] mm/damon: add synchronous validation for commit_inputs
Date: Sun, 22 Mar 2026 14:06:30 +0800
Message-ID: <20260322060630.82964-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321173235.84923-1-sj@kernel.org>
References: <20260321173235.84923-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

I tried implementing the synchronous commit using damon_call() as
suggested, similar to how damon_sysfs_commit_input() works. This
successfully returns errors to userspace immediately instead of failing
silently.

However, I observed a side effect during testing:
Since damon_call() waits for the kdamond thread to process the request,
the latency of writing to 'commit_inputs' depends on the kdamond's
wake-up interval (controlled by damos_watermarks.interval).

In my test with DAMON_LRU_SORT:
- With '.interval=5s', the write latency can be up to ~5 seconds.
- When I temporarily increase '.interval=50s' for testing, the latency
  increased proportionally.

I understand this is expected behavior for synchronous communication
with a sleeping kernel thread. However, since 'commit_inputs' is a
control interface rather than a hot path, I wanted to comfirm:

Is this level of latency acceptable for the 'commit_inputs' parameter?
Or should we consider waking up the kdamond thread immediately upon
receiving a damon_call() request to reduce the worst-case latency?

For reference, DAMON_SYSFS seems to have similar latency
charactheristics when using damon_call().

Thank you for you high-level comments and the suggestion! :>

Best regards,
Rui Yan
