Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8038C2DE
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975175; cv=none; b=sY+RnMKnrM5AZVLPJDVKXV6+k93uk2G5S3igTMx6aiQHP8P/mIu5oiAXzqdw0Vxtm1mknSv+V4KvfAXrwZINIq6Hgf2LwQ474e/LRv32K/PYRmR4lObvEMUOQBd60aCWbhyHCKf/e3fnoeUBazWR2F3qHBRr+Rj7q3yv5nqrE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975175; c=relaxed/simple;
	bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0bbrvkaMlyLt/HWKpAN5NmoZiiTntoQ4rPHmZhe00RRxOMlZHDnQI32wdyo2SL6EZQn6bT/m3eYufSlWlkgbNWv1V00jecwPOEm8fNAhzhwAIag7HlsMU2xqi9MK8nnRmYZ0ZsNvSBpvLksQBHW1Vh7DWJ2wKudwYratVYADvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE1WZBB4; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE1WZBB4"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37febcda057so647547a91.1
        for <damon@lists.linux.dev>; Wed, 01 Jul 2026 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782975173; x=1783579973; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
        b=kE1WZBB48QDVVOa6ABlcuMEWusTg//flwNrojfYVKAuJ/D2R8CCVQJ8DcWy2yULoqD
         bg6k1Y9K0dytBfbS6kZ38+LHqmxT5cI8qFxl49P64BsO9497yn7FKkOISzrvPFVX1d4Z
         FlPmoyIyqxmsU+0t3q/4estfmytxmX3wbnGp02lCBPuxVp36ziM0ddXJmmvznDqblUtq
         Nw4mwMomSHfZvbpZBB2Iw4HZSVGAQFNjrOXRXRLNlJJmkT8tii2vZcy3O+EGWXkqhubP
         vtaFzpFoJiFEo5/TvzxWOStIsE20WxIPd1kzYUUsU8iMhd4CVKNe9EMtC2Bgl+FCuLXr
         7AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975173; x=1783579973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+7soT+TCrSVIA+ZgeYOhCKYh3ZYEoJSNWdBgMBvfB0=;
        b=DZ4XYJh2/l6WLlQ3k46ckjTrifRweJDy4EO+hgQyJrLk64o1OvQCSnWTNgzhJaAAQt
         9Y0dZ9CwmI1jPvOY1eQB4ci0u5c0b7xqiJObuwPKrxXbC9eHN9y0Kok6zcZ8Y9ip5XLN
         NbGz7TSz1d1nAKT7sR5Uzs84X/wIzub/icXbMFyNKfn4N5qDCDd7/zRQekcRqH+izqYw
         Nkd9ZJv/k2dMO8Gb/wfMpPk39na6jeMj2Z2TndQfSu5omf2fldR/BNu6lG6Bm/MxeM2m
         jGVYhuXa/I4vCjYF/eyp5ej7WJj8kUCSYIjMbpqYIotk83v95dUy3WB6a2j1nRnvKq/t
         E9Tw==
X-Gm-Message-State: AOJu0YwhKZAVs/R/7U2UkuwnZbTENnFAh9Mm6rTLocPIZe2uzrEcOMm7
	WAAkI3Yc4DfBk4jVCypRyPCl+sRtZwjsFaGHdWzY5PMbC3Bvi0H0FlWE
X-Gm-Gg: AfdE7cknIFsw2UnoG+XGiLhpwF1CzDWuanwS9RV6YFX/ut3Jukhic7r871RHl5Z9rg4
	n9sd+X8ENifGWH7fAeEe7p1PK/d5RWxzB3/EcsVkfSo0TpyjDvcGsfecYUEYLKUQnX1ds0JA83I
	QrT8yCyHI590NX07MkIRs8BlvhJ2OrqqAUTDmpJc38YuYxyFSFzsCjSmb+68lqOLgJGO6hRggOD
	FVKuBRwZzvfmDEr6SQsWw0K0m7+Uj5oAZALZBVxztTWEw+RD8gJImk6sStuMj3vEQxSq+PzmSPH
	EerkxQeOyYrJ7usg4h3YfKTkRlhc1+BzrIA2t+7nHYGZbeq0UlCaaVSNZGJIeOq1fR5hLVjtvDr
	U5Nxzh8GpQ9Rc3jS5/0QeRgAELAAY3MHJBnhi5k6YhrpV2Az4mZTG8MLm+H2qVRCIn3r0L+R0YN
	YJ/g==
X-Received: by 2002:a17:90b:3e50:b0:37f:9ce1:7359 with SMTP id 98e67ed59e1d1-380ba91d27emr3511769a91.26.1782975172519;
        Wed, 01 Jul 2026 23:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc4eesm6343395eec.24.2026.07.01.23.52.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 23:52:51 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn
Subject: Re: [PATCH v2 0/5] mm/damon: add mTHP collapse and split actions
Date: Thu,  2 Jul 2026 14:52:44 +0800
Message-ID: <20260702065244.70360-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701135220.93697-1-sj@kernel.org>
References: <20260701135220.93697-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Lian <lianux.mm@gmail.com>

Hi SJ,

Thank you for correcting my misunderstanding of the versioning rules.
This was indeed a mistake on my part, and I apologize for the confusion.

I did not intend to claim that this series is ready to be merged as-is in its current state.
I fully expected to send this iteration as an "RFC v2" to continue our high-level architectural
discussion, especially given the major structural pivots we made from v1
(dropping the debugfs pipeline and shifting the telemetry to user space).
I mistakenly incremented the version number to [PATCH v2] while
prematurely dropping the RFC tag.

Since my true intention is to gather feedback on this new user-space control
plane approach before any final merge integration, I would like to fix this immediately.

I will re-send this exact series right away with the correct tag:
[RFC PATCH v2 0/5], following the versioning pipeline you suggested.

Please hold off on reviewing this "PATCH v2" thread;
I will get the proper "RFC v2" into your inbox in a moment.

Thanks again for guiding me through the community conventions!

Best regards,
Wang Lian
