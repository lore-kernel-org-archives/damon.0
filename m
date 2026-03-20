Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5163016EE
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985317; cv=none; b=dv2yWSMJSxwk/ATxdlY5Pk8qHm2Hleotkf8sV9xX2l++gomUebJu1ZYAdfIZFETRMcF71FVo42v4yJ3xvMmHhyt6RFbH7xaTP93p9wQicRFOT63AajYT4SvlVY2NKmF1P3R+jpO0CdGiCl7+/VoJcToqJtH1qlelkQeSDoC8tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985317; c=relaxed/simple;
	bh=BGYrJ0QxuzHFARnTiEidMOinf4xSTXUjL5SK4rWgNlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HI5KJQzFOnP+uuCS6M3ua8bzAD3XOCulJoM2SPMU4oJXj89PHDK+WC/T9C4qCDWZ5MIhgQGa6G+iPI0tQ3V4eSZgZQ9lv+hryGpV4YWL74dbFB7fVmQAx5myw+ooN04YCUV5kweaXIYrgRhu0uU3mMrsC6jgV/+aZOnqj9r0KDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSGxMOK9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSGxMOK9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c74280e3468so91751a12.3
        for <damon@lists.linux.dev>; Thu, 19 Mar 2026 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773985316; x=1774590116; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGYrJ0QxuzHFARnTiEidMOinf4xSTXUjL5SK4rWgNlg=;
        b=gSGxMOK9hhd07n1j3X6EjlsaDON2k49a6Cpdt/pwzRK7hk+qj/G0jM72z030b/Fc9J
         ORy/0G5AujSO/6lQX3ngzo91gwxH+YWMfJIq289SWmLLQyz/CmGiXT5Ys+lBbUISp7JI
         x4biSFixs2NprgRU/mqedQDPX5rFquXwKkFSWUApVk2Ph07WppACgQC3KjA6FgMXGsF/
         AXqjia7/tTpigOULfIFkzEwq6+ofErZT7vTNUoC4HLF5zb60AQoGzziRuT5oN2VMD+nV
         P+HnDF3MOKP5uR8mKhU8ugLIm1miVrT4tCOs5vrRPKkkNPhuCtqvwjAm5TPDbSK3lldA
         n4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773985316; x=1774590116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGYrJ0QxuzHFARnTiEidMOinf4xSTXUjL5SK4rWgNlg=;
        b=ooD0d5HQEdBtJ3gzC0oaleHierS05rpFZRJceKJgYsebvwwCfuvRKWvOU3Vd3kUJ9l
         c7L2ogrI/HfQfSt3Le7jolJXlxica+YeD0V9rve257dDrkZhVu4ezZhmcGdlFjgFFIyB
         AMfateGj2TsIwNdkHvfSrDLvokX9kRQ6tPTiTonlVrC0M5RIJgMtXlLR014z1E6gIsmV
         LakErtTf6x5oWqOEM8PoCI9p1K2P3Ms8f1aGgGkBPiLRUtimYGtOS9bZ41uZGQs2G6wo
         ps3knR6GddWVZD2HsMh30gTOziJ6bKWI5IxXQRIIBEmedBJDnz0qhBStFKbujDYl5IlP
         6azQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmwP7SUu/AjaT4m/Rw/V3lkb83fbwzIM/lKC9iVGFALIf0Vl+QtipVHOc/7+3f3PcQnOOrfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwDBEL+vlCnzccPkvaY8OxMd6magnYCcYKZAvZz+MZ+40B/Y8j
	B5Z71J+GMB3jykFjd8t6CGaSOBNgFI9zBVe4y8UDSvkx27Z6jupVGOKS
X-Gm-Gg: ATEYQzyvXYslOwo7mt8Ud/ulKMXHrAsyCckKnOqiJ+fhOkwD4GMaKRw1ihTlao53HoU
	mU7y8WLgITAHnBfAu0sFzMx22lNUVsqW3ldB84COsoNE3fu8dIKcHcceGMtW5kHWfG5SPzaf8HQ
	FbUUlGpbqa8pUC3KPp46fKpVsr3CrjxZKnQAOtkYpUdo9uCMy2P5QwrD9Kz5uNE6xVqNsnNERM6
	bUMdgGeeoH2n74pGNRhf9XBvzqL/nAWqf16g9O9/jy1Ye4gegTnOUi39pF3QSk1uEpxi7kPPu04
	kmeT+ez2LW/CaOv7NNxxMt9el7A+gXtQSN9e6ipjY+qvZzMGpyO2ZpAqVrXeGzNxJwto49wa+sm
	ZW3o76XUuJ9Y8VzbviVB5AeJMWSZDvt1YpkRIsvUbWqLxCZeexG6KU9FgfexqFqRKUHY61whV3+
	dTD4l6y2S9Ivk9+Zp6uFFaKroM1/1wNSee9oMgoQeCiVZ/nbRmpMQ=
X-Received: by 2002:a05:6300:8b0f:b0:39b:c0b5:b0eb with SMTP id adf61e73a8af0-39bcec38ef1mr1624946637.67.1773985316235;
        Thu, 19 Mar 2026 22:41:56 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc9edsm852792a12.23.2026.03.19.22.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:41:55 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] Docs/mm/damon: document min_nr_regions constraint and rationale
Date: Fri, 20 Mar 2026 13:41:45 +0800
Message-ID: <20260320054145.213945-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320052428.213230-1-aethernet65535@gmail.com>
References: <20260320052428.213230-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae,

I'm sorry for the noise; please ignore my previous reply. I accidentally
sent the commit message instead of my intended message.

What I wanted to ask is regarding tasks 3 and 4 from our earlier plan
[1]: should I wait to start both of them later? Or is it only task 3
that needs to wait until your fix is merged or abandoned?

Also, I'm preparing to post an RFC patch for 'damon_hot_score'
optimization soon. It aims to provide a significant performance
improvement.

[1] https://lore.kernel.org/damon/20260319151528.86490-1-sj@kernel.org/T/#t

Best regards,
Rui Yan
