Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52003346A5
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609125; cv=none; b=OMjeWA+hEJ2rkbJjwx5Naulv1v5rzZ1N4/sGyV0w8oXai78PeLbg3PRwFuU8r79pnXkMq8ychOC5v7e4THvTeXvwOj+FL8vz9Nq1sZmwh2Rd95omrhIloJusaizWi3RxmHYCS8el8UEJp638UeGAP3UfuL1GPcieL0dcUdevT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609125; c=relaxed/simple;
	bh=7p3fOD11xt5iB0wCw2rgjR9L6cWQ8/qyfL1jiFK+wLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiUfkq7G5k/Sap/X2irT8P+Qnr2tYUO+9r2yIJ+sp2RKyH5Mokw8zxN/5deYWoHbeMnUy+y6gBN+V3osLRkS7yT/GyqFyiYTU9Uh0Y00Fn1OmFN9XMAfzHVtQ7+QUYpW096SJaGSFgd/dOMva1jaB/HpeP7kvouiNht771CNJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mV6TgWTS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV6TgWTS"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso2823625ad.0
        for <damon@lists.linux.dev>; Wed, 16 Sep 2026 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789609123; x=1790213923; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBi200xN/LUb2MXPCKUJDiGUegD8jgMjIoX4dvMv9gg=;
        b=mV6TgWTSFUCE0rpYabsp5ILG7VpGThiPv2LdHYA8cCjQbzKRKoJ/fDE/szBEU8KwCn
         0jKhiZFDnfYL1EyAcGjoN3j33gRSzMIwXICridjHRfX0eBcGOumhCDTy86yFcpZltWGP
         +gpxlkm9mTS0htUe9dT2OsOG5J6/HKS3agphcH/NiCSFLz2qxWOArfwxedaUKmrzKnfU
         HyZzRsmZ4fz69QirHdwzmH1Aei4BHUldr/plT95oWb0dyLRZN/IS/wiqjz0zyw/+cuuA
         Uq5ZZHVJInBjWAW/Ux5EZKePt9/kvvS5H3cWiTYVmyguzNJM8bripbPNOXUtjk2c0xqD
         2wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789609123; x=1790213923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBi200xN/LUb2MXPCKUJDiGUegD8jgMjIoX4dvMv9gg=;
        b=ZYEIDwqEAUDj6AZ0JE0N2iQuCnDkuUvZdueZyVmixQR5MhYPEcU1h+df1E8dVR2CVc
         EeHjJ1JyJrTvhlohorcxqZFXLoK6Dplj0uSUMdsFEoBnuqle6iFXXigbjQByFsHvAss4
         DkE/sQnuaS1LMNioiQPiiassrzLQtgIY2Bs/OOWTWRjlxofXlJ7EYk/ZX0qsGzbjCK+O
         Dt8/YvriMHNsLFGOnjTHQRe1LmpVquSivyIIp1+4OhG/wBaRULjB0ObBjxhSlcaedwrY
         I47nQ1d4jvRWI9Cyk0DlJrsNA8Ze4yDRssz+IrB7WZSkY36++gvZwwWJdERTbRN5Wxqt
         ROCg==
X-Forwarded-Encrypted: i=1; AKwUvBx9J8QdqKqoNpdKkVqjvN0yyaIUD2Os87BUyw0cMYk2IxhLAHZ4ZqVkpSRZ7UWe/n1G2O8RIA==@lists.linux.dev
X-Gm-Message-State: AFuF++mQc4zo/BRKNw9bKn+bHPe9Hun+gyzbctKIEYhCjUiyAC+IQhxO
	PZqBf5sYd8I8TGtCBJkSKhS/6myKFzv64a5Fjgr5y/UkzBEXAGxoyUs=
X-Gm-Gg: AYBFou0cRfFI0jQ1vnhf/oOUvCzuT5T/C8mRVvZz5T3F+fVaKy5lRSwAJGdJD2JdSbl
	JkxnYD56FI7GwjskrItMClFDjOmRU5w7Gk/ABQ8U5kZ4ODmUOIhDWnE41NM9y+Fxo1NEV4y3jH+
	ODYSmGBmUqxjcRXErwY4v8T0t+tHQCwoMwdYZEkti5v3qnoJa+Zfwjj+S7g0R+gYXk4A+nn1oPA
	jKta1c0TjSdGaafLAfLhJcsdWPr6LRcHbj2jo42Zrb4y+w/nY6R6CBGXNwyc4wTZBqUcMEjicDV
	x8icZvsxG1NA+n2apFcEic5SCh9egZJgr9Jf3CbsMcAM7rqYZIH/U8FHifOxh6Ks65Wnmm1weYl
	CGsyYzaVWmEQ4rswC1kVaqktWrCAxtdXrRp+RUcXbdbvPw3oEqhP6HuqTjRboj807nLn0q75SED
	Gxex1Ni2pyQiuDgdaLl5NOCcbbLv5+adYtd4np5Z81aDjRgzfnWSxiQu5cc3Jo3xhAY0MEtIl5+
	1D/W7uZouY7AQqge/ij5r/G3qpb6erfT6RTuQ==
X-Received: by 2002:a17:902:db0f:b0:2da:dcd8:713d with SMTP id d9443c01a7336-2dd8e635b49mr90622135ad.15.1789609123093;
        Wed, 16 Sep 2026 18:38:43 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b6f9:c198:e14b:34c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89d9007csm18335155ad.5.2026.09.16.18.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 18:38:42 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/damon/core: charge only the part of a region the filter left
Date: Thu, 17 Sep 2026 10:38:36 +0900
Message-ID: <20260917013836.100213-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917012420.101087-1-sj@kernel.org>
References: <20260917003553.2465523-2-donggeunyoo.kernel@gmail.com> <20260917012420.101087-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Wed, 16 Sep 2026 18:24:19 -0700, SJ Park wrote:
> The user impact is that DAMOS could work unexpectedly slow, due to
> over-charged quota.  Also DAMOS stat could be confusing.  No critical
> events such as crashes or leask happen.
>
> If above is not incorrect, I will add that to the commit message when I
> add this patch to damon/next tree.

That is correct, please add it.

The stale size is only ever arithmetic: damos_charge_quota() and
damos_update_stat() take it, and nothing dereferences or frees against
it, so there is no memory-safety consequence.

Thanks for the review.
