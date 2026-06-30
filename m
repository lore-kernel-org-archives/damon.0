Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A0411660
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824887; cv=none; b=JCpws2/AFeLTyPvZtnRrqFdL16xAxO0B0CASLxQpj3tX4AG0cI30WOiggMXeUEqaTlWkiY4ZCJVoOJpL7nJRGpnssAEiFklvrrfNV24nulOe7cw/wsGgKGJoWMnGr07sk6srlR+4yYkM0h2BXOZF2zm8wDwFbnQBjHIC/E/7+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824887; c=relaxed/simple;
	bh=CC/w+B198FpgtYT2Pn3JPW04Ck+vlB47f+Ei4rz+w3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeYIcC4xSLvhDGmgv+3FwIwn7VxxO7bF5M691I/Xxbra+qgaOOLtDbiZtsYOEbsvpz9buyX4JUVjd92Z38dwARB70u/8p4pFNtGDs7sQ/gEc7ajnV5WX0yNyl4SV8KeeRVOOtDBdqV/u+O9VMxejXcDXENKVA2ramaUD+TDKvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzFWHN+H; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzFWHN+H"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aea0fff535so4644390e87.3
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782824884; x=1783429684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KY372+MQDnRqZEpTjqFttYs0FH8xWsPm7tex4XKhkec=;
        b=FzFWHN+HCDPGjeggyIt03sxqU0rbei52rG7WKuZJwdz1yo7oVds7tKwCRPWl6nT94u
         U55DflwQzsC3oWz+2vW/IWGCM2dkLtNiSQ/D66/Z4Uyw1ShAoZiv8yf4B6yPEIkqU2TK
         Ac/JTv+4XCBB0zIeNwqmQnnMx63cX6gNtKUfGKWIjOnxqCV88IfuS/GKp7cz64CRrzP+
         BSg1epsUjL9jd/1scP1dgVG0GHaEty9zWKiQxEPjglej+ZYvXUsYedtmGjWO3N7wi48t
         yw9El971z5zU23fAfJOS5ii2gpMVpnxYI8ZtOrJEPJTj88kmF3K1sExbrDGE/LDHAoqg
         V+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782824884; x=1783429684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KY372+MQDnRqZEpTjqFttYs0FH8xWsPm7tex4XKhkec=;
        b=A06/z4UyueKHKuzbgO2ElNexGqCXqAItU4+VERo0VNKp7amgEqltEhIXucYEDDw5IL
         SycQI7FWSOuOCRlUsKKSpU8+gzbCcKfplLRrOwRNngXwOzH68By4OP1atxtEG9XsZIwE
         ae/fjYYppjuUJX8WJb5zodZRpmvTzY0xD4+xjiJDPktaWkm0bj3eV4V4vEENhPUGpSZg
         HHywyFyK7l5v+VJZQTsoKOgsi7R8Ft769P/R9ssNpwE+HrM1h39VUY7Cgz00qoOklT0N
         n59e0jhDWQpagB84KzwSSJ5F1yMAXO6BEagEAmg0bi0fzhnmBoZHvOCERUlK2S7VUJ32
         mT/A==
X-Gm-Message-State: AOJu0Yx2D56Z80faaNhkIyOk7JRlTSuvld9ck8oZFg3wjQ3zMJdEzQEU
	sKbgh56BWe4ptx2sOSdyLAd1epGSe4YC4QDDL/7XCOQgFj4BJNIREZPsKCHpKMkClRw=
X-Gm-Gg: AfdE7ckMAdCG7T/soEGBXU/sxT8pzWzNsUIh9Ph13cQ6ircXasw77qnJ2JvwniKmcun
	uMNHDhDpl0fcZAfUWvwjYcqTvXp73gOBym/5XslenYqrFg4uJsAwol67VLZkQ+qDHmma9AnUMbz
	G04kHGoSKAIIprcdRlR2HHN7n2bmynnJNHHIfV094CBBwWWglIed67j/3tDBeoDC2CODD902xyc
	PkZ0B9vxAj7BfvZLM7DlINyjzu0lDc/AFbx9CpVHie6Zgo4/rMsEuCI6O1/oRXEGB8p5A4N3A5W
	sKm6Qmk3O895h8DvGxrwJm53HgqEJ4L0CEwWUDkjRZdmvafNr8J3BAVc6uD0CJouYGgbd5r5jAH
	zrkjc+p+/3LxVfx3onb4MkWLVAitlNb+0KxOdGkFA3ERQC/T61TenS7orE+hxRPK0LWeGbBGMC8
	uKbF1JktltM4QzGKtRqSSvUVHU+riRlyBCvvo413FkCUVcBhlsYUz8qpkkGeAeX0krhaxU3mTua
	IFwx4+3xPu+DvfmUg==
X-Received: by 2002:a05:6512:3a8d:b0:5ae:bd66:553b with SMTP id 2adb3069b0e04-5aebdbca242mr916807e87.38.1782824883845;
        Tue, 30 Jun 2026 06:08:03 -0700 (PDT)
Received: from debian.localdomain (95-25-158-125.broadband.corbina.ru. [95.25.158.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b1da4d298sm5022501fa.30.2026.06.30.06.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:08:03 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: 
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>
Subject: Re: [PATCH] mm/damon/vaddr: remove redundant RCU lock
Date: Tue, 30 Jun 2026 16:07:43 +0300
Message-ID: <20260630130748.3908-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629165349.4260-1-igorpetindev@gmail.com>
References: <20260629165349.4260-1-igorpetindev@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

On Mon, 29 Jun 2026, SJ Park wrote:
> We prefer using a real name. I show you used 'Igor Putko' as your name before.
> Any reason to change the name?

Apologies for the confusion. I recently reinstalled my OS and misconfigured
my git setup. I will revert back to 'Igor Putko' for the v2 submission.

> As Sashiko also commented, this may cause lockdep warning. Actually this was
> added to fix it. Refer to the previous discussions [1] for more details.
> 
> How about moving rcu_read_[un]lock() to the caller test code?

That makes total sense. I will move the rcu_read_lock() and rcu_read_unlock()
calls directly into the KUnit test code in mm/damon/tests/vaddr-kunit.h to
prevent the lockdep splat.

Regarding the pre-existing high-severity issue reported by Sashiko AI about
missing check_stable_address_space(), I believe it is out of scope for this
particular cleanup and should be addressed in a separate, dedicated patch.

I have just sent the v2 patch out.

Thanks,
Igor
