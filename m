Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4449E132
	for <damon@lists.linux.dev>; Thu,  1 Oct 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856540; cv=pass; b=I8TUynCsE3TRU8Symy9LFBLb0Ib84e2FfVF4ynzH6sHEhfqC8FqCYDVP4pLZ9lVaStdR957ay0yaRtIjpWRZFljFvE4QaV4YP2h4JAe2MBa+4+BztWGqfl5i3JsvxQzS2eNtt9c677fW9u05kA578W6cYW/eDreQ/n7Wu09ly+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856540; c=relaxed/simple;
	bh=RB3A0UCCoVU9gFVoVCmD5dfkjIj2/vMcngh8T61mom8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptnRcPjtA0dLBjlTBiQel4JOOU6vnqyXMKgAUVbM1ZT7McGd4cFtMwPweJylnaUVCp97um2p6q4LhfRNy4UZVwqQqW680ByeYaa8wQqyCT+nZe1VEpwagT1cvncykgnDZTJZLmpNXXPDdXY7/e5K34sfsfHcbyegTWw5gFwCtSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK+01906; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK+01906"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ab0d9260baso7422695a12.0
        for <damon@lists.linux.dev>; Thu, 01 Oct 2026 05:08:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790856529; cv=none;
        d=google.com; s=arc-20260327;
        b=rHTsAv6RLOQg1e7iNU0nTzz1lr6c0NW9oe22Cp0KO2sBbtvbSJI3/1zQ++3LRglOBY
         2xHSCqY4wvVNx929OHhdBgAZzSXmvXnHtXlVaXoA69wz5iImjUgym5B9ZQxg5NvuAF6e
         OGfGtBdrr7mMF/otOHFnJkghDOZwCFlkwPgQHa1ASnJ7DKLxjwuRJ/Axp2mSYKxNrTg2
         v0lIVElUVzpiv5eXta2GNuLE8nEaucIBkT0gwIHcDAgA6vIe6ERv7WT2bdDzGJPsgGFg
         4T1SYm0E/Y11cvGUPVSuGsDNY3bo0Ov/3zofzXpnZmbNyxKpyNm5KaDLsFmfrMpPN1pD
         KF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RB3A0UCCoVU9gFVoVCmD5dfkjIj2/vMcngh8T61mom8=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=m9AmtIRwRlPEo/C3Z9Q/ZG+A40t7m72wz7iymJinrXObwuohZB7ol17Z7wk6b4oN6O
         +VdDsrlr4uFv1CJemp35GEOVLkrDw+3yu3AfxFntDoYcH2tTtCQ4MRJyQ6w7L5j3x1/j
         NOrVNkI+gk9gqGGpi3SY3Vm6W1trBXBLfKdYqPeYHDbSkKswJwBkDTr1I2A7v5wNKLzi
         MtibtzmQUvy3jk3BohFR74mi+3NbzFa5bmDEEsawqsIS36u7VDA8Ei7pkBc7SsgIG76X
         FHXvr3hNfVLDKGCSlQZe1Unz3wcPX6tA/zj+OwrsOswWf36UFLUwbzyTfanz62Vnl53U
         ITUw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790856529; x=1791461329; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RB3A0UCCoVU9gFVoVCmD5dfkjIj2/vMcngh8T61mom8=;
        b=TK+01906YKme1sLSKuHjs+/lXSN4L2G8XGMrQk6dNA0tTtXrxBV5CwedmkbbTTTGoA
         REU4INOaATl1wCgLrfOkLiyardEnGQHj/WU9HS8e/3BLLoLHcV6R7wq/xEuieGycSFE7
         3EPMp6Lp6ta0HHhufLONI3wr1WlhySZZdJTwVxwomElHryjiXg/rHC9pzJfopp3oqspX
         vNnEvc+7ZZfw42V+mX6t1HTDkp3BwcFGp7amm/AtZyYvS0541JlULbKb8xqxLaXqNBf1
         AuUItNvZPjLfc3baPf++HWkQvm778vT0vYOx5dMyCFLH9Zg/YYI+zhF7i7OsdXFeiKqu
         14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856529; x=1791461329;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RB3A0UCCoVU9gFVoVCmD5dfkjIj2/vMcngh8T61mom8=;
        b=yfSWWrbCyA6QZIBTnqnnW0buskjGcQuAn4IH2T1ObJr0Tp+VHkMMcM8sol5F00um43
         tmBcADmk3G+BlN0Ch5go91wH34E2vcZugKDzfT3KalYQHVZsG1in4tQW+8noycyNe3jX
         QjMa6E7oU5WYdnq6sFGnrCnexiZS2AtAzdkTwBMK9YSKEDIGWFHNHQgMh4cksjTgVMqT
         hnyHUbGhRaE02M2rFpeQt3JJz0pd7VURt7rMq16hu3k7CFL7YDGFJ1n2qq7USnmVhEJL
         fdTP4YHR6tXCwFW4IyMUyu7L8QelYdaMkzIaDX9d/P1hp62QDZENDio1YgCOwAjcFoLv
         xvRg==
X-Gm-Message-State: AFq9FYIlK9KF85Y8BAsIbS7NenEk5V0jD1o3JGuoteR2qu45MB2IgD9y
	AYCZQXQGBav1f6eQMpgYxdNyxGwnoq1WOTbj+ZRVIIriVCQiQ+2DolPIaKrwtxjE5+n0mde4b5Q
	5xcUrJPJ58sDfAQOurgEsgWwmoHuGPuRoOfRL
X-Gm-Gg: AYBFou3WGDHVINmIxFJbceaAHHXcDjwYDSlVKTZWuLwa+myr2wpuwyei5doZit2JhrP
	kpXOQhNsgDHNu7D1BSaCbLKaPqqyNoV5y0oDyYFAc2mehgUlXfuNYzG4nZCfZTWzUvKkYTRMILf
	g4f9eUzgjxvk6Wn+KGHDiN1FJhs88EDbREs7GY4AWeouuJXU+k++sh1bPCfKS5eJG84vFu3Oyed
	CWx/P0rZuIXx1uIJm1LWQqDX3amSwbS0f/L/OCOb+J/2YMsSBOC6t8WLOkbXFxvioNvHsseWatr
	dymjEa21wvaA5/wQ0RpszsdPhUHCJk6wYrIMi6qo+crmTg8E2W2WmA==
X-Received: by 2002:a05:6402:535a:20b0:6ae:fc0f:e19 with SMTP id
 4fb4d7f45d1cf-6aefc0f0fcdmr1149667a12.42.1790856529087; Thu, 01 Oct 2026
 05:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjpkSvWFu1018-wmOn963u8kjrzTWgG=NERQ3RudG1di3w@mail.gmail.com>
 <20261001102608.46491-1-sj@kernel.org>
In-Reply-To: <20261001102608.46491-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Thu, 1 Oct 2026 15:08:38 +0300
X-Gm-Features: AclHuK_xbIq1OzshgXGsrSqCHYdhz00MbnGMWcZpmS6OgdHpLiU6a9nmXGsTclM
Message-ID: <CAAiJnjp40164tbVXhJ9rP4J0UP9m9r4_Zo2phBvQ64pCzpxS7Q@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

With your support, my progress tremendously faster than I expected :-)

Moving forward.

In my VCF9.1-like example Demote/Promote bandwidth is limited by admin
up to 8GB/s.

With CXL/PCIe 6.0 it may require moving pages between tiers 10's GB/s.
In this case, kdamond single CPU core limited or can use more CPU
cores if/when required ?

~1 year ago I played with AMD Zen5 9455 and 12 channels 6400 MT/s DDR5
DRAM, single thread core-to-local-memory bandwidth was ~49 GB/s.

Anton
