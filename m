Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0C352921
	for <damon@lists.linux.dev>; Wed, 14 Jan 2026 05:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768369008; cv=none; b=MSUtlIGXXv8+xxbuZqtPhYFzL4y8ldMiqsat6uH+vJNz5enH97Cf5LXrVF0HTLHP0PPO1zfXqV//PQaFJJQg2P/wTn+voMY0FV+LWpLg23877SgBhyAuZl1rtJDOUp+Qv7E7JxTHNrLzC7tKSNAgLao7ll6dQcAjqOMxUJ0/jKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768369008; c=relaxed/simple;
	bh=GVYwNtq82+vv7MWdJtztjjuDn1cNdSTPyWMUQ3cg0MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0dWPKGFUZ1RnvHXO6HEBS+H7U3cT5kq9/AP/WvMqbmXR8Q4gIEktOGx85eXXgkgrIgNVg4r2JzRZlJmsCeef8O0KtdN524RSmFKjupM/2hgLVR91YTmUsDvt/H7LlhA1a3fbqvtJBEMjmGPI/nivvzBI+T5ziKHxpPi3czBFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoRjH1+J; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoRjH1+J"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b04a410f42so7415397eec.0
        for <damon@lists.linux.dev>; Tue, 13 Jan 2026 21:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768369002; x=1768973802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdIivE2ldlrwLIiUkZ/Pij3yXzKqAKo3oC21HuvVTz8=;
        b=AoRjH1+JyyZNkR24YW6e2uGKbVPD8R3Wpt2aACYldA1NbDs33KNk7TKsuD/dUqWzZw
         40Ojpj7fjfTpEoBER4thpb5uYId2MtcLKKkLM2Zvh59hvNR6jGSEJ6WtE1HCyN83D2Qf
         J7M+CqXxxqP5HL5x0Mt5ApQivkxjA8dOPLzApBpQcCubNhLCU/5kcg+z7b0SftvonNry
         1uhwt+2wExUNqK7J3gi2Nb5/8U1aCo1NTF7eCA63ptju+lRRzKJu6dm+7cFm+tpc0DCT
         V7IbxaGSXvbyy3cxlC3RSwE+SECr0136/8sbqIuse4CtRePuRKPU8pBl+6SVaAZAMlJg
         hxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768369002; x=1768973802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdIivE2ldlrwLIiUkZ/Pij3yXzKqAKo3oC21HuvVTz8=;
        b=TjI8S4fUZl0po/l4uz+7jj0rM/axbDF8XohJV9oDG5ErNk693aaA14MO9T3BEE4Fmf
         EMW3iHlwA2FiQgL/1EDKKLyoog24o8ccRNblqM/DrG6K+VsygXKMAFU0wb84bv2Y35tq
         LyRxl8tm3NRfH7fyqxCua+6uQYSvnrt7zIim7As5v0JReDTiCTZLrq2n/AZ52Z3JEpD2
         wGtw8+WZj1o1qfYoKRawGYuTHOWATGtaAar2U7/x1Tm1+qAeB9I7Ixoh8Slk2UyZUxMj
         WIuP1hLeLTYcg8oAikeg7F0ExKce81W3ZlYUreQzkpVDluTU1qeNNhB4a7cuhNI2zB5F
         M7bw==
X-Forwarded-Encrypted: i=1; AJvYcCWY5J6xJDCIGZRt8GzB7dVYPjE7gegO1bLc/It0e+rRhYulOGY4nLeqTtvNQCQJ8E4mrSih4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf6DX0ZTzlgf/dDneqBXWBWfh751C8pblp0nZvdaaO3rbgdseX
	FRQG0R6ZCseUv/LBbXCqzfWbFSUN70/WxBL4H2fizjnx99b2fmbjQUJe
X-Gm-Gg: AY/fxX5Z5nx4givXSrAu25dtuAPR3RpoyhswZx8J+j4kSoTrQDQ1Rrn6Ey7qEEY1BtL
	ZWkpxJCw3f9mb/tSZ6H8H5NX7ojfgP3ci7W6PbvebJG4xHTD8YuUrtbD1UUVDOm2f/HPardih3B
	baxgsNsGDUIn/vyNOKrL2FBf8SP3CVYlx/heAVxyU5Rnn3iQPkqKPZkePFHrEBdHt3u7FBzBHCA
	Pm8yXVnE3P0kcDDW13priVNY5QWtzv9L98NRFeNbxwgjRA4spufkOWkN+ZSRoaSRmQyhEHq4tEG
	Wq038Jh7dSALK4ZD2f8rS8fQG0296rWWXaXEPSdvN1s0JyJWgiZYk/zzigkK7ZX1F1wP/VElThU
	FWTa0v0auSZxCyAVCaZB2Oiy1QuQp3VctbwUVJ1ndnz/GJ8P7Bm8NR+HbAtcJFCFYLom+mKMBy3
	ZjBDGYixUPR14=
X-Received: by 2002:a05:7300:1484:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b48706e7b7mr2010368eec.21.1768369001549;
        Tue, 13 Jan 2026 21:36:41 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a6386sm19226783eec.14.2026.01.13.21.36.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 21:36:41 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH 08/11] mm/damon/lru_sort: support active:inactive memory ratio based auto-tuning
Date: Wed, 14 Jan 2026 13:36:28 +0800
Message-ID: <20260114053629.85750-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152717.70459-9-sj@kernel.org>
References: <20260113152717.70459-9-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Doing DAMOS_LRU_[DE]PRIO with DAMOS_QUOTA_[IN]ACTIVE_MEM_BP based quota
> auto-tuning can be easy and intuitive, compared to the manual
> [de]prioritization target access pattern thresholds tuning.  For
> example, users can ask DAMON to "find hot/cold pages and
> activate/deactivate those aiming 50:50 active:inactive memory size." But
> DAMON_LRU_SORT has no interface to do that.  Add a module parameter for
> setting the target ratio.

> Signed-off-by: SeongJae Park <sj@kernel.org>

```
> +static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
> +		struct damos *cold_scheme)
> +{
> 	struct damos_quota_goal *goal;
> +
> +	if (!active_mem_bp)
> +		return 0;
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem_bp);
> +	if (!goal)
> +		return -ENOMEM;
> +	damos_add_quota_goal(&hot_scheme->quota, goal);
> +	/* aim 0.2 % goal conflict, to keep little ping pong */
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
> +			10000 - active_mem_bp + 2);
> +	if (!goal)
> +		return -ENOMEM;
> +	damos_add_quota_goal(&hot_scheme->quota, goal);
> +	return 0;
> +}

The second goal (Inactive ratio target) is added to hot_scheme again. 
Should this be cold_scheme? Currently the cold_scheme parameter appears to be unused.

--
Best Regards,
wang lian
