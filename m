Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0564328B61
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839572; cv=none; b=FWN2d8EBz5/X4JzNEpxh9hFla0jT4eVmAG1pNmNEB4m3pFOpkfgmnc5SP0NLnGtBwbEOA7bkBQHcchGDSrtUNHt3r3x3acar8Y+5naH77UlWg2CtMhq5R2XBQIktT6zGJjDh0IWXGWWAAA/UB1Mzwoj6ModhNmASXO03Z6RU/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839572; c=relaxed/simple;
	bh=b7+MYpwBf6PYA1nWAdVEaqv4HlLvAkwM9gmoDXgIHzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5lc2OvwRqOjuaUMU3otqafR0t7FG62/JhCLqnPyo5uWsrTtytwYiygwEm4gV1vhAPJiCaxQclI21oWZNzOPrSyIb9pyagvZ2cEOLcqNRi4YhoBpqkrfXLNIPW25YGlkYSY+ccdnE8kYy3iEu194BVeeKqFMq4PynD18H4xzOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyMwsJAY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyMwsJAY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ab46931cf1so13257385ad.0
        for <damon@lists.linux.dev>; Fri, 10 Apr 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775839569; x=1776444369; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVGQnjFC3UmJlO8LzJSr9La5JYFfjcbaaKaPS+uHiy8=;
        b=JyMwsJAYjqNoa9+B/+LW1Ns9qKFdYzv6CF2sHJJW4s9MLBbabxrITfCzvWg6VLzz0e
         uprCas6rkoEb7y5gS/YoMq0fXWjeI2iTuAbJ7sg5u1K1yB4xywYyO+S2RsjzxBGHVKdN
         4wE0zv7Fl/YO4ly+zoUAuGMYKI/Si83yqZxO8NXNhXRr6pGELT/bBmhwO4MmNavPWlNL
         93DcQ/M9v+Jaej1tuieZBcvTZ0wsWLRAVsphd/EmODM8zr/Pq/0GNd54fUPgYz2KHva/
         78WOy6OiX7M5tXYufIcqCwI1DDGgAPZLPuj2f/C0bAKS4/bRxZ46A+tfLwKXKyjBq22p
         b+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775839569; x=1776444369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wVGQnjFC3UmJlO8LzJSr9La5JYFfjcbaaKaPS+uHiy8=;
        b=HPV5WntbEDKqnMDb9fTOBVfKLp30t32vjnT3j5rmwttjyvxC+aL78ZUvWT5cbG/Fe6
         6NYgWvLoRa1I/GHIavGROCJ9Fc82eBBJxIp1ByYWtr9Pk4d/SVSxSyCeg7SrdDiJyarT
         xGn3PNoXYEdtYUrq4rLU4NTkkKiv1au6Pz+7frYmAQpw4U5+uiQ3ohnus8W/QLNGBIRD
         LmxxKcKJE4u+vPG65QSE5NyaI+PbeHb5Qwjauwd6OixX47/M+RVP4KMMRy+0EWqrKNTR
         s5v+4Pmp1Zm6pt0/NJEp6yV/nL4JKPXYkOZ60e+4rUuvTGnFi/nfD23zbAX+gwLBxVJN
         u3/g==
X-Forwarded-Encrypted: i=1; AJvYcCWzmkEP245dIaFa0mcBIIF3293E6rgPChpMEU8PKcpMwg44RqVR20rTa8eM/nW1hA6e32PgAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5jCih2fk7gbl0qHX/vJvSTAlkLjlgcrVmd/GN+Nz7eINyJAhY
	+bTinBv0lJtiVKiPWduBQO2rWDDPygd9jkoW5SvL8IpS1lt3b+pbydIWUxuRpw==
X-Gm-Gg: AeBDiesk7LvUycOmnhnnJYL6BmCA7cjzoxxXUUR07ZPJAeKvM4QpBHj8AnSc8OodIxd
	7+xt1eVKaCbVudNmN+tp7//FpPwM3HGW/RNNgfNP/bfNWJH3pyK5IOKEaRtU/ONmTX1C887LcW6
	T0YCPmnqim/yxEFZ3HSi4oxFRauLN1j0CifUC4CKZ0WOqr1ljU93NeVJYo88SbG54byCR9e5OyF
	Qi6YEShsP5UnlHaHwNplQg8hUlKLnMmvPYSEYv2biduy3d14e9HxCKU30+J+jIW4gy8x0gGEbQ2
	OU4FyI78vdNRX87sIoW6r6qv5rSTPdBmL17xeh3tORgVobGErF/AkJ41l6UNRBdeATbOGDvTrjV
	xb7+zi0WBZiXooy/4eh6QoYIMZi9SvlIt0JLMfPJOjTKWWlRlvLIw2iT60gcZO1wNHfJ4MklSyw
	QrtCXpZP43LC5NkZ3p6YqwICfp1ZrybkGZvYL/etI1DzZurLCdL2KL
X-Received: by 2002:a17:902:f64c:b0:2b2:5168:2f82 with SMTP id d9443c01a7336-2b2c7384dddmr73308085ad.24.1775839568869;
        Fri, 10 Apr 2026 09:46:08 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:88f:af89:dcc1:f22d:646b:4592])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4e15f71sm36613165ad.34.2026.04.10.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:46:08 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Sat, 11 Apr 2026 00:46:10 +0800
Message-ID: <20260410164610.6764-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410135500.81989-1-sj@kernel.org>
References: <20260410135500.81989-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Apr 2026 06:55:00 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 10 Apr 2026 17:40:04 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Sashiko found some issues.
> 
> Clarifying what is the following action for the sashiko finding would be
> helpful.  For example, if you say "Sashiko found some issues, so I will post a
> new versiuon soon", and if I'm busy, I can save my time by saying "Ok, then I
> will skip or delaying review of this version and wait for your next review".

Okay, I will keep that in mind next time I foward a Sashiko's Review.
Thank you for you suggestion.

> [...]
> 
> Agreed.  This was unclear to me in previous disucssions, though.  I still agree
> it is out of the scope of this patch.  But now I think we need to let users
> force-restart.  Adding this to my todo list.

Just to make sure - is this the same issue that my recent RFC patch [1]
aims to address? I want to make sure we're not duplicating efforts.

I'm still actively working on that patch, and I plan to send the next
version next week. I've been holding off because I didn't want to send
multiple patches in parallel.

[1] https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com

Best regards,
Rui Yan
