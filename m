Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAD235E1AF
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314207; cv=none; b=WCQTA6yijQ/osvb2maln2bxE5Hu6xVxj6Hj5zB5gRa86dVY0JqILpKdPhnTtXwn9oo1fvDHxYDVxhYkH8AVqkd7mbPFrCCRnaXBmZiQmk90Am8K1p9Lbf7FPueRxMAcxjMUHf/gEXSuuNLauRZZPjod3FVuvG3T2j/F+2kdK5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314207; c=relaxed/simple;
	bh=B7FskVfDnX8Oz02fpEp2GxWVOi19S6IVI9O1jHf5Twc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6pzFDOk9cySyzdah9akz5mdlMNLyEI3lrdDauoSpPTHox9fBr/GhEE9M8V/UjOuFXHqpPjOd6LawhtqplrlXIP06WSQCbxkefUagX3wYWQKo7NLjb69woZRgKDqHjM1UCbqDveWIdxJ1tNzIzN7PkpOg1AgK1yCqbjxnxiCvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+OuE65+; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+OuE65+"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848643382fcso583720b3a.1
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 18:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788314201; x=1788919001; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0iE/WlAJeXqXVC99kZcLf0HoTEM4Su3/szAnydyeKE=;
        b=o+OuE65+WNa32wIZmi6g91S5ErpXfDk2MKrpK/pWa8YZUibxwAcwdFXdRQ+j0GCK36
         qemhZFtpz7gnIySnm/ojeMmgLv90zbHpSmCww3vnxluy21YUec6idCYW7fse+k+RBBkv
         /MzHz0D7qum17tmz4/Q9sB6dqn+oYOaWGAGEz5aboO8vYw55xi6nO82FzK4s2Q76jpAB
         F8vdCYERdpfprSoeB+1OBrpQRfHexeAYlLXORZg1GPZO162SRj7ZBfJ+Z1j54xo+b54I
         BM6ENqZWs885mF2qFCPI0w9kc3aJ6wQkOl7kL0M6Srnxg38H/cth5CfpH65BxsJuOpkt
         JMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314201; x=1788919001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s0iE/WlAJeXqXVC99kZcLf0HoTEM4Su3/szAnydyeKE=;
        b=jAej8iDuwrx247sj4YKoIFMmrbZ9fNNJvXT90lr+JPhS231nPZvmFDGxeevI1UlXT9
         HE4H08j7p/F02sEm2A1E/DRIjQ/J1eSzkeeoICNnW8Mqb8DF547Vjg9OOOAPrStfvobZ
         rPRPRCLkgshaWa4cw8w7X0oWAqfyEuvakh4jfR/tyfVl6ztNqktrTmzw64vGXEM9ywIO
         ijVl6YoiwHB1cN9t3mGSQ7WzcV/P4ibd07WyOuOdNk4gsmX77uS5NMX4vgjvZgY4O+ox
         eNt2gDJsIdmtodpQYIfZfIzxw2xDPpTMzkhA5IFKg/GXpFvFgtHqo/ub8+0y/YD0J4eX
         iwkA==
X-Forwarded-Encrypted: i=1; AKwUvBzJg6wc72B6Dsxpj56jc5ZZav5AF+FHTAq12nrH/xmH+CiaWkRdiwfInzoWWmY9/HR3mYm2jQ==@lists.linux.dev
X-Gm-Message-State: AFuF++muWUr7gUcRxJi9j703vriXZxhA4g4fgpI4OZ6+57rYrkvm20Sw
	CWySbaxBi6DARFDQqClCZIAj+cxLNqXEZd9Q54U8TIloyBhwKUMJZR1m
X-Gm-Gg: AYBFou17FSi+dZExiFEAQIz1vFMZsAtdMnNteMo1LZ6u2aK7AJwgLIPbebWwid46wP+
	u8a9hCCHU8UIGRZ9yWiuBjuXux2kg3p1DQKz5PhvGDQfml8C4Np/R8zyTre8ev3Q7dFYc91U/ae
	+PD0qJ5RxTXwNvPZOYnYyCiFi1HcegaYhlX2g+7By5JE+TIgfR+ljx4KkpkSFVhuLp7v23jCBdZ
	NLfV+MXXbUJ9Xr6qeyRA8WTrNvmt4gJLh7aj4qdRAtj0xzyNWlwj9l+d09s1BrlP0YeChYWvOf7
	84iptB4GDV4TsWyqdrvF8zw/zuJJllkHqXzOprAkKrxuguWf5mPsnfvoz23gqzK0oqCCBxXYdTe
	VFEkjPZxrK3r9R7vFu510UFJPkv8kAJjDjOIDFIWYreX+j9SwUdz72/vGrVvJ6iFbZjymt7nVaB
	H2hzi3hay//L4KxmknqG67J1gLsdbadyuA+OoAJU/Z0sJ74FGWHRNIDYDlUgCh433UGKVQx4kEv
	kBfcJAr3Xffa5RiqaoYYZUI3bst
X-Received: by 2002:a05:6a00:1da5:b0:857:72ba:ff0b with SMTP id d2e1a72fcca58-85ed3f70537mr3178673b3a.19.1788314200492;
        Tue, 01 Sep 2026 18:56:40 -0700 (PDT)
Received: from localhost.localdomain (vmi2317720.contaboserver.net. [84.247.152.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2ad8a45sm590819b3a.18.2026.09.01.18.56.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Sep 2026 18:56:38 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Wed,  2 Sep 2026 09:56:01 +0800
Message-ID: <20260902015616.57702-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901142307.100701-1-sj@kernel.org>
References: <20260901065847.42869-1-lianux.mm@gmail.com> <20260901142307.100701-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

> Seems using MTHP_STAT_NR_ANON that is exposed as 'nr_anon' can be used?

Thank you for the suggestion.  I will study MTHP_STAT_NR_ANON and nr_anon
further, and document what I find.  We can continue discussing it by email,
and I will be happy to review any follow-up or updated patches.

> I'm curious if you and general reviewers need or prefer to directly be Cc-ed.
> I was naively thinking people can search and review DAMON patches by
> subscribing to the mailing list or using the archives via lore.kernel.org like
> tools.

I subscribe to many mailing lists, including linux-mm and DAMON, and I also
follow patches through lore.  Direct Cc is not required, but I appreciate it
for DAMON-related patches.  Because I care deeply about DAMON, directly Cc-ed
messages are filtered into my important mailbox, so I can archive and review
them quickly.

I am very happy to contribute to DAMON, and I look forward to continuing our
discussions and reviews by email.

Thanks,
Lian
