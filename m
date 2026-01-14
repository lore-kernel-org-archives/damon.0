Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB331ED67
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370728; cv=none; b=aECV/gB5rB8LJ2T0z2M7+5Hond+sCO6EwilK0EOkejEoGjcNSBUDJ43NbQ+qqXgVtKOArJ0uWT7nPixDlwPCAOfW2nlGOXa4MxjGrk+vJR+Ga3yV3oCkcKygl5JPU2eTGIlavli18j5ZYFtXXDgLC1B/v4S55KEZ0pF1Bzm73Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370728; c=relaxed/simple;
	bh=UuOoBajVj0wkg0g4yo/s1ny3PHf3Yl5+HedHG//0BQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAY9H1OncbwkPYi77MoG8w6Bvu9K2b36v7UVugBrOVzAd6osH5Bi2gN5csxN3Kq3ggOCfZFrxJ0mot9UKieR128vyctXzjsyGXczm3Hyf1II5RgHqI9M4KlSKmsShQsUOsIk4DYjwrFYWIYsr4s1hqOIRzDvC7R7N+AL0dui58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnCf0b80; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnCf0b80"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-11f42e97229so70885c88.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768370718; x=1768975518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuOoBajVj0wkg0g4yo/s1ny3PHf3Yl5+HedHG//0BQQ=;
        b=mnCf0b80a99CTBAxP3iIUkS/lXen1r6isaWaSvnZkki0PHGa72XC5ZVFLfF2HOG1c9
         dtsM9OrOJw01RvThGyAKt0SHEFkeQ57r8VTtDjoSGMOMCDx5AA4BETM/dBnKGT6bbWew
         Ze7crYqeDJ0oTvhm5CPNSTza3yeF/pQgdnX5HO5BonV91BMXANj46+BkWV6njw8q6nwt
         vS3gnO4i/0CV2SCekz8RB+FwwLaSzvMHknf9YBVARjg4O5yd5ZODOdXI9/aC28WN13oX
         ZXMImsqsT+q+ir5icP3rir6aSeAzN9JjmKfXJMVCWw90sgxSVmOFMm4+6arWSBMarDv8
         UIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768370718; x=1768975518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UuOoBajVj0wkg0g4yo/s1ny3PHf3Yl5+HedHG//0BQQ=;
        b=tDKG69ubwb411eW8W7STMgxzn1/cYu3vQIEIiVqt+YlLvY2sNgv+joCJqrwb0EZJvS
         Hu1BoYpqZhHs5Q2kMrYtmV/LKvasae7bUzsz7gyvF86xaTdqyP43mxezqMpVwsUOHl79
         5WlOPk1QQtVa1gfADPSlpvkWhlOK53LN42GsjVDDKSYX35jm9jvsKcvZ+XwNlls/rb0v
         JmxQMH74C763QxYBwH/oMq9+wBj4gG+Rq2k8hFi+kIz8K6zYYycTZQ4HpXm4Dt8hBjQp
         gd6gzoP+u1Br8A8053FFP1CDNKuMVmqrFXjY8Fp04MGiGvf24GHJGR80JL+mK7mzycNw
         MDPA==
X-Forwarded-Encrypted: i=1; AJvYcCWfmro28zvdgFQ18a6YWTkI3kgsMrOUHbXvula9WsUr8pG4mjuHw1VcnraIABt/3AHU2pQ9JA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzkeH11gGTMD8zsDd0AcqYS+9W156Kh52VqPxthn/bNQKlAmOK
	wpOwhw18EOW1gpbtgtazHZGRRaTPa6Gl1o8M7muamXIp3W+OGQ1oun0S
X-Gm-Gg: AY/fxX6sp3mfRWdW+zhRR9Dpa3+wxvvYQrO7c8xfNWz6SBh8msNhxilazqdwZVg/FcE
	8MdvU1xgkboIaaDKypFH/2JhofmA+y12v/5lBwp9UYmzc7I7gNrPdmjZ69i/YnBxzsj+HPYhcO+
	PGwGJRQ5HQIHk5oir00awW6Nnl1mafQEow3l0CkmDjgUoHJvoQETjdKcHOkm3OHZK2spmrXXWTB
	+NSEzi0a16NK50bQpaAdHRYDi/4QlTUiCry+pQtvmDcn+g8BMP0zTfeW/vm67jSxpkSvV4EuLEI
	DxmXTCEy4mitAMk5xLbZSFpbk5/5YXhw11zxleyD+4ZoGH2d+5CRiei4tFhXozjL8R7PtJGM+XG
	8BNkYY2kGTthxZPBSGFzt3jWnah4WySLFAL3iUu2QA5HRngkqt30RW/5EDl0MwVANQtUZ799Y4Z
	9U
X-Received: by 2002:a05:7023:906:b0:11a:4ffb:9825 with SMTP id a92af1059eb24-12336a47f3cmr1905143c88.6.1768370718015;
        Tue, 13 Jan 2026 22:05:18 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm24911154c88.9.2026.01.13.22.05.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 22:05:17 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@suse.cz,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 09/11] Docs/admin-guide/mm/damon/lru_sort: document active_mem_bp parameter
Date: Wed, 14 Jan 2026 14:05:04 +0800
Message-ID: <20260114060504.87119-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-10-sj@kernel.org>
References: <20260113152717.70459-10-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Document a newly added DAMON_LRU_SORT parameter for doing auto-tuning
> aiming an active to inactive memory size ratio.

> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: wang lian <lianux.mm@gmail.com>
--
Best Regards,
wang lian
