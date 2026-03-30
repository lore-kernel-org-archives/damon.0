Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D6A937
	for <damon@lists.linux.dev>; Mon, 30 Mar 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855060; cv=none; b=cNoofM/OZDuLsorI0nh7GfzlFhr1EZCo/zj0LCKUDZFBi9MzpIABIKpVyefenVHjyaqeL/CVGFqZGZg28eNlY29o3dKfZPxNxMzr2pc/3gxvHHkT9oxBrAn72dh5FG3aZQ0++LrHtfkZ5e1l9hC9DfFI3ebU8qz4wsvK96H7dt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855060; c=relaxed/simple;
	bh=rXdqLr6PqFyX6kyBJTqvPleohrCccdzi/6ntq9CUh+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAHCvD/SyDzj1aItISL4EyINFcMiXsGAVIn22idiuvsqmV2WQJJZpN8dFgsWZpnz85aEJWQNP+xji7A0HRtuK1nRNGsS5a7LMubWnZujtHlKdGj9qwl23YFfGKm4G1gqRoaVG8PZdpBJAfTABj+9VJ9MfeRuqW+Cg/A9yZ7X0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5R0Vseh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5R0Vseh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so265456a91.1
        for <damon@lists.linux.dev>; Mon, 30 Mar 2026 00:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774855059; x=1775459859; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGWPqeK9KiWv8GW7kijJn4MfGQ2Rs0APPG4sisBBxLM=;
        b=q5R0VsehOUiIcSJ+Xt4lGW34g633iB+j5qXxEwV8TXTPQSy7HI6lGenifU0Wvhq42N
         KMs8vvwgb4eebNq33afH0c3Ekk3Q8N78fYqH61M9KgoP6YuyW017hgRNVXa8e/7tQV0r
         GrAy2NiPFdcRXJNtyL/biF+biMXbnp56C986vJ47IqeLsqXnN2MsYhZz3mwGLzYh/UZ/
         DvGM4V7rorC1pnPe5lBef3DYuIf3/ADRCyAloxKwj9s8sDbf99Vf+Mir1FAZTy9Mxp3+
         hOCiQu5lq4v2B8/k+Spm/zDErfoTfUZJyafum0gqhSX/+rGgV9dzOtLcmY4J5Hg/4Wio
         /Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774855059; x=1775459859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGWPqeK9KiWv8GW7kijJn4MfGQ2Rs0APPG4sisBBxLM=;
        b=MBDGmprL1FxNU1CEaF4mAwpME3Jvu4SMqTL3OfVNDotHtjwSMJgCoJ82t4EAO1bGWf
         NuOizCxC820di0e3/axyLO4rl0mfdZaonNo/0X9vUN0BM2V8TydnffF8jFjGRmSUcSW5
         etHFnOCMfC15Fzdlt+zOGO+3Vibil/6BuMIjl6ommtl9gmzSlp9oNg2azoVyicgD2dON
         McrTpoShoKn2zE/NKUvcWD6oJ6+PCpFzp0+ZMynOZIXOxyi7XAGzNnbrE9XV+R6Bmay2
         pgJ5XJfGttaTH83UNlMkoiRWS7MSFzPrwcmmNxgr6fxkBlBdRa41+XXd0EcFp8BmwH7i
         MDzw==
X-Gm-Message-State: AOJu0YxMLDOL3FEW29HhEtA8eGmHcWeKXMUuHDtHYE4ogN7pBevO9aPU
	QXvUlSBb72PBJ8wbKQDS+dvJltmKys7a4QzxSgowZ9P83iyZccjRfuRy
X-Gm-Gg: ATEYQzy3dO+KcOkjneAk3/2u928JukdNEhaMxtcY0WQu+AxHFrCEX+SRQe4D5YbD9rh
	m+yAfn+vyKwNDc6nN2tVqbnLEGJqmXq2v6/hz8iIVeXt5PYHNLqIMbFnDuzN/B/xaQJ+qSYR5dG
	L/Nf6LtbuKNQJpxEujKdsL3xxLj2gmnI4j3nM1LjBYOUJU7MrZ/kXUb6HZ1rsDR/z6IE8wkChJU
	uzgNHYcOio42iTQjkSaGKtWcs6atiLfBsQvM9SHVuw6f39zdZIwsoed46bCAmkLuMJcQYf9/S7A
	0rMB8bAfilKewKYkEY6HVGaBON+Fo8KHvEAPka5EaikZSuR5VmM/jeYtQZXjyPvDYkoLHrt3usM
	mI1QRzLCHPiH69nkzxCF8XS5dO9qQhsWoHEee5aRQ9LMGmGVMNI0tVyGLD0KgkwGt6acD8Y6moV
	VUzn3IkExvyZsrbdpKvA8wz5lpg7kGXdiVQPswrBQgQy6zXfaMiVE=
X-Received: by 2002:a17:90b:4b0f:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35c2ff1be37mr10325599a91.2.1774855058782;
        Mon, 30 Mar 2026 00:17:38 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2d8d47c6sm4624349a91.1.2026.03.30.00.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:17:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com,
	sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Mon, 30 Mar 2026 15:17:36 +0800
Message-ID: <20260330071736.17143-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330060851.4659-1-aethernet65535@gmail.com>
References: <20260330060851.4659-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 30 Mar 2026 14:08:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> [...]
>
>     min_region_sz = max(PAGE_SIZE / input_addr_unit, 1);
>     if (!is_power_of_2(min_region_sz))
>         return -EINVAL;

Apologies, I just realized I made a silly typo in the code above.

I used PAGE_SIZE where I should have used DAMON_MIN_REGION_SZ. While
they happen to share the same value in many cases, DAMON_MIN_REGION_SZ
is the correct semantic constant for this context.

The code should be:
    min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);

Sorry for the confusion.

Best regards,
Rui Yan
