Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E63C2BB9
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955956; cv=none; b=CbBxrnWYHqAMkPYAbn6XRvx8VEGrzmv+nc6MV2ZTfJz8Tco0AYmIRqfFYRIMKXxXUf+FYaKIkS2rLKeMfdCeDDBJChbdvHNA/+9TeiBU0pYp6Uw48tAwHRG6xEEYOwxsyUzHCQMCMD0WXYNRKvi//xYcpiRjXO+Qp4lqFt6mye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955956; c=relaxed/simple;
	bh=eZlYPGQcU/+PTM+9+YI1JAoJFOp06njFaS8UfoF3gDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5FvPWLhxbcUrw0BBJgbR7otDFo030DE8WYz5J0mXBXaO8wU9g+j6uU7d0zt82pSkL23N/ZvWhEZiN8XE1BF+QN5bCvbjKNHLw9eloF+tdQAa4E3p+KCXZivWevu/SzWH/J2YpKkRJNp4cr+cMK3sdayztMg82mGXzth46qia6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5IpAV6Q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5IpAV6Q"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so3229205a91.0
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786955954; x=1787560754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEZ0rkuHQPQIomuCaD3mvVzCje7AyhhS8fXashblHp8=;
        b=S5IpAV6QjGxCoC0TO2OETT2vXmkkooj9LgGzFNwMXwHIqBFNcUxSJCSpfd7ZV9q2yc
         C9Epbo1KeVx/2nftYYBRhglEwebQevqfKvgo3s4pT443Hmkpr+fBNtNivcki3ky0CtEC
         h1xuQESJ+lul/oo2j85vrf/uIub5Y84VPJE75ZOoVuvtHB3wpZInKlUD3bZ2MFD4rDDF
         k9xW/ecuEqU8j3hONdd65ai8jH8ifd9doFBf842ejQMlvJxojZHdvHDDzAXf5mjKGDKz
         lB3SxduKK0+cLPnFUsvkQZq5rb1GmLC78snXfTHAk8bNQSXg+EPcHYqen3iORdHQ+lFQ
         BH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786955954; x=1787560754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEZ0rkuHQPQIomuCaD3mvVzCje7AyhhS8fXashblHp8=;
        b=d5Yp70+XHUkraRHqa9gdocw9QyoIb+pIeEM92cJx4MNUmXnourtNmEjZBmSmyoKf9u
         SynJz9wqA5ay0X24dswz6XDVjkH5RAxCbIW75vFqUsVHl9lonhH9DaqulPIbwWmdembv
         R5C6qc0zKgUZLbZTiyFfNpJ9Z9qOyg0m9jz68DSrM+ACwNvICt/uwsMBafp4olBWAt3F
         QtOcY5cco7LXz0aTbGZlzyC4kcM9CwNun0XKiNOEl5k8kEyLpKLxR+6xyPsKv0cLqjjZ
         /ml9VPbgEJlIfw9QNBskqlYXs8aFo7Z0gfD7LVv8qjA7BMlZcW8AxuG92pYvfX+g8nFo
         rpvg==
X-Forwarded-Encrypted: i=1; AHgh+RrOwymGJPzIFHjAIhChCQZhr0LLzOxx2Ux0x9+2vM7NhWqeGQQPqcc/Eu8HV6BwVk9iX3V8Uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjE/96rHPtqbFmZwmLBwFF3C4XivZIKvuHIDyPisoEWm+vb7xE
	c0dMMecztafBRyyd3K047QMVDOS5L3osO4R4mF1WR2KToKBPxb1DeRec
X-Gm-Gg: AR+sD12Dvrbb/b2cmIKsFBmBxLpbfM90w1TcoEhj2JrlZDtS+54xFdAFzyk/9ALhHV4
	ODOOjdQaKvW6bga7u2+g9bAAmEKd4WbjndRwr2Wcgf1aEoTuh2ZlD9+4z5ZBNCZGjKVCAPfe4lf
	kErsEzPRMs4EwOkxuO78rwLKVrNJ1D76jIgyBCnvHK8LVu9Sr+hB8le/xr29QuSEARf/JTcwnbk
	Wegzhyl9yRwBVQa9LfvLnfDCHZZ3ADlZftBpiQBUYA473jCfQSzdlpx4rIUVf/rGWWeAisN8msb
	8IPDUpGQHO3RBHzNocT7hf8kjAaaF5bLLUADMNLMA2fNcl/wDx872p+WI6x8AgKZFBohak4t8M9
	Uyintyce1b+Uvi1bZM5Zmv4XwiMIPsLD32jUrBqWQ4571jFoKQbAEnkdrqUtSLOhHr00WohVNn5
	tpbx7rdWYI3D6wnlKsjkCqZYq47kTccYuPStPv1CPoCTJQfuRvshLt4zGl6p9sti5o8ThzQPgC/
	FAcmUSGvQ6HjKMIzg==
X-Received: by 2002:a17:90b:3b42:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-3933e638862mr21181094a91.16.1786955953953;
        Mon, 17 Aug 2026 01:39:13 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:89b:69e5:1f8d:8b25:88b8:b9fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e8904dsm4086253a91.8.2026.08.17.01.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:39:13 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	gutierrez.asier@huawei-partners.com,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Mon, 17 Aug 2026 16:39:23 +0800
Message-ID: <20260817083923.4374-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814145414.91204-1-sj@kernel.org>
References: <20260814145414.91204-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Aug 2026 07:54:13 -0700 SJ Park <sj@kernel.org> wrote:

> I think watermarks is bettert to be deprecated due to following reasons.  First
> of all, it stops monitoring.  It means the converged region age and addresses
> information is lost.  This is the biggest problem.  Secondly, we already have
> similar and better features including DAMOS quotas.  For your DAMON_RECLAIM use
> case, I'd suggest using it without watermarks but quota_mem_pressure_us.

While quota_mem_pressure_us may not be suitable for my use case, I
realize that DAMOS Quota does meet my needs - only proactively reclaims
memory when 'MemAvaialble <= 30%'.  I used it on my machine by
implementing DAMOS_QUOTA_AVAILABLE_MEM_BP, which can also be achieved
through the user_input of DAMOS Quota.

I think DAMOS Quota is indeed similar to and better than Watermarks.
The main drawback of DAMOS Quota at present is probably the lack of
wmarks.low like Watermarks, but this can be solved by adding a parameter,
which might be called fallback_value or some other better name.

Therefore, I agree that we should improve DAMOS Quota instead of
Watermarks, as it is indeed much better than Watermarks.

> 
> Hence I want to deprecate watermarks rather than improving it.  If we need a
> better watermarks, I think we should improve/extend alternatives like DAMOS
> quotas, or implement a new one.  But, we should first understand why we need a
> better watermarks.  You mentioned you want to use DAMOS watermarks with
> DAMON_RECLAIM on your laptop.  Could you further share why you want to use
> watermarks, and what was the problem?  You mentioned it was problematic due to
> page cache, and you implemented memAvailable based watermarks.  Why you use
> wateramrks?  How exactly the page cache usage becomes a problem for you?  Has
> the memAvaialble based one solved your problem? 

1. Why use Watermarks? And what was the problem?

I now understand why we do not need better Watermarks, so my answer is
based on my previous thought.

I used Watermarks primarily because it is the only mechanism I know for
stopping/running a Scheme.  The problem is it can only monitor MemFree.

2. How exactly the page cache becomes a problem for you?

After prolonged computer use, the page cache can become full.
DAMON_RECLAIM might then mistakenly assume there is slight memory
pressure and reclaim those cached pages.  Unnecessary page cache
reclamation can incur unnecessary overhead.

3. Has the MemAvailable based one solved your problem?

Yes, using MemAvailable as a watermarks/DAMOS Quota metric can avoid a
lot of unnecessary memory reclamation.

Best regards,
Rui Yan
