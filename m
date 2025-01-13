Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439491C1F15
	for <damon@lists.linux.dev>; Mon, 13 Jan 2025 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797783; cv=none; b=KBk3TibWX/5DC47DSfWEfSl9UGtNbB6AvX3KDARfM/SLCRgFi8Q7X0sDMx3mN3ReSa4gZIEuC+7/DDGLdRYH6JTlj62rlRUqHUv4aCe/Wwo/T0qPqhE8pi0x+iZg7ybV1PiCiozhYiLkrjvqu47zm1T0+USnguJcmIgQV5c8NYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797783; c=relaxed/simple;
	bh=lR/WBakLcTsc+9QKCxHOPRnkofH545Q0HT8gbAblqm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmGTpcGpZph3ppYXa1qPaLyeHITw3MacgQv0g1fWNw/2WmxOdWNliG/SA6a21Y8fki0fRyjRLo51NZDkX4/2B6wOMllGS3p+dID9u5dquACC1wUQjSjHVwZsOjkiHIq4SXfvETuptu9XVDCrzxhMjadlOoJgAM50sIXQcSKXk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgXhFT2m; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgXhFT2m"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e39f43344c5so6778871276.1
        for <damon@lists.linux.dev>; Mon, 13 Jan 2025 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736797781; x=1737402581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5va5jWwAbDGwh/AsKuECI4Z0BHCQ7OToQ6lsu8L9Hc=;
        b=RgXhFT2mTIyulhD7hqkqh8d7zFmn0G4KREOj9OJYMj55Ka92C/tB0uBmFSwxxyaKTl
         EMSuRv1RhPea48qegLWm4269H7q2heCK8tGWgLOiZyMdnT3EUr/NGS5DtK3wOOepSkfu
         IZuZL0y/27fryK6vtEhwjzPgMDqi/u4+hy/vjHRqq4QAOwYlBpefPRTwGI8K201KvJCx
         YqkXJQlsWlA1DlLpzo4Ckt2taZpm97wsmntFyWls4IsJ1S3Bz9OnVOlpqksrUPndDW4J
         YtimJITbIToJn7YU35IqSIOgz2P9+jq+TAcqxeXEngG7Zk3IMbfMXu4wxcELV8Nvqcn2
         obcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736797781; x=1737402581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5va5jWwAbDGwh/AsKuECI4Z0BHCQ7OToQ6lsu8L9Hc=;
        b=ABNs9dPxLcbnhUbAFSVs04Shg6EDrbUOtmdB7Lo9xuiYdnFNtwj3H1gQW19kNtykF7
         SsHNsFskZjcOKbv13JRxLZywO+qL+RtcORzZkUchGiD1in4Y4mWMDdUeMJs+I5qPnJ96
         lAIirmqXNvA3RINXeGzECAzFyQGL3yFMhns+Uv1peExa/KeYj69bWHR4o5/nUScviqV1
         tO811sKcE5N5ATf1XHGzuegtZgFydDSUfA+j0nboI2UNGoHJoTyyBG2xld6oIhgDIFwj
         AlAkhTUXPqBCrhY+NJ5uxxOALf7DS7wOZT2KVtJoDYgOy+EMHcUZ45HTCC4gTmuX6PKT
         zQsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXRQYv8iOKxxdF/GyN1+vRMU3gAkNNTWCc7qGhmxwNbUtPb6yLbXdNfntQK2xLZXi/Rg7bfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEFN7GAZor25xA/Ms5UJeKhIMlSn8q0KCYKicwPJDk2RQGfXN+
	20KXk4dEvmuQoUx3ro2ZHhR9Fa1wIPVyuGUov+nJJUuEMxTcSFjE
X-Gm-Gg: ASbGncsv8/7bTCSyTUjs9EPshi+AMY2/hDwcqVsqjCw5QrtMgkdOkIJgKzwfGGXM4nB
	x6JFxfvnL8tkqgEJr8BjHYtlZx7NXxXgOO4m76qYRS9lrYri46OOHkuzhhQz7l+rmcKutJDAQ8U
	Yvg4DAenZHP9OYFphoFk+qbGsrgChs8Z0yQiq1VfDNHJJQ3lcSVt+F8OSEJSuUeZ1dtHTJ6QXA4
	HKScs0fqBg5B+eC3Z/Kyjv4tG19baapjZZ24Ve9h+4+MuNJ+47Zn40=
X-Google-Smtp-Source: AGHT+IEHBPVK4kU2cxlZ5OJpAtOhFzgtyZpnXsiwUMAkIfdY4zoEeIntXA7r2ltkoO7RGnpLj8tkCA==
X-Received: by 2002:a25:11c9:0:b0:e39:a3d9:48eb with SMTP id 3f1490d57ef6-e54ee1824f1mr12001205276.26.1736797781244;
        Mon, 13 Jan 2025 11:49:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c25df1sm18417067b3.12.2025.01.13.11.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:49:40 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: kernel-team@meta.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/18] mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action
Date: Mon, 13 Jan 2025 11:49:37 -0800
Message-ID: <20250113194939.4152203-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241219040327.61902-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Dec 2024 20:03:16 -0800 SeongJae Park <sj@kernel.org> wrote:

Hello SJ,
I hope you are doing well! Sorry to add noise to an old mail, but I recently
saw Usama's patch that improves this function, and it brought my attention
to this series, so I have been reading it today.

I was unsure if I should send this mail because I had a nit / naive question
about the patch:

[...snip...]

> +static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr;
> +	LIST_HEAD(folio_list);
> +
> +	if (!damon_pa_scheme_has_filter(s))
> +		return 0;
> +
> +	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> +		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
> +
> +		if (!folio)
> +			continue;
> +
> +		if (damos_pa_filter_out(s, folio))
> +			goto put_folio;
> +		else
> +			*sz_filter_passed += folio_size(folio);
> +put_folio:
> +		folio_put(folio);
> +	}
> +	return 0;

Is there a reason that we decide to use a goto statement here? As far as I
can tell, this is the only place this goto statement is used, and the else
case bleeds into it as well. That is, I believe that the following could be
more readable:

		if (!damos_pa_filter_out(s, folio))
			*sz_filter_passed += folio_size(folio);

		folio_put(folio);
	}
	return 0;

[...snip...]

Again, I am sorry if this is a naive question. Thank you for your time,
I hope you have a great day!
Joshua
