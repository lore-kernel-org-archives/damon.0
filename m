Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A4F13AA2D
	for <damon@lists.linux.dev>; Sat, 28 Mar 2026 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719853; cv=none; b=oelEZI7PU/+LSh1WJXyqELBsjhxLFJtySozEA7y7D+3AKcNb9s5m5DRDEaaALQCfjmWkLuLYu+fZdjL7sWJXyWviOfmr0U74+Cw5oteL6gYJYaUzbCGyi8G1tPOhN+VTCLW94nhFegCrgH6/nEVY5hf7d2kGHerQnaPVnM7p8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719853; c=relaxed/simple;
	bh=5w/Z1bo5hUsKILQ/9Bt0LvB+QqTd0KhWD6PspvkU2zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcNEmLOdferaYvglFeQxpu/ZvCVxYKAKqZtCru96s4lJVvyizzXLJjr99zwm8jxizTbkmCQoFciGUhXtvYkqtXCGLSHzLgIrigP+Ks/0juYf5CRtFcIRHgQ4UCc7Slp9GcQbQgDHxDSV4ozXkfBpcxC6qCFKRsdDkYA7sRu34kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJT7YaFX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJT7YaFX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a07738118so1827479b3a.0
        for <damon@lists.linux.dev>; Sat, 28 Mar 2026 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774719851; x=1775324651; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf6/8DHJq7rfodeWx/m51AbxPYvL+rrJXvXUW3u7bJo=;
        b=tJT7YaFXpc33jM0rFIH+Dk5e4hpZtPCj2+EtxHqVv/pdAetq3e/6d6OSJQbyr/FWAO
         tjkDIzv4k3Msm6fU/9An1/LHnh0tNCfWq0oqCZLJKjBj62Lhvouwoh9MqATItjnF9z8T
         kXWDmfzUjSWInAP1MvQpcbC0/sL8bnIDHbEOAtsH2dBfu3tqegXVfCgxRs8f+Zc0Fvga
         CblF1GdxUQ5/6OZmH0gawEhBy29rjpdYebyG++vGqIEDYgoq4AaARjR76P0gy+j+bTIP
         SjWtDhhch3ZONoqdbubUbwcfZeWSIjZ53piH6V7KhtlqbnmknzgxGVoSs8lpdlPkl+nx
         AyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774719851; x=1775324651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bf6/8DHJq7rfodeWx/m51AbxPYvL+rrJXvXUW3u7bJo=;
        b=SVycZJb6mp3HFl35W9xBuBl8KBmd3bPSVV5jIns4Q1SwfTZRiT0vkn/SBFAgJ3gbDz
         8sCicVuiS4PE2UgHVJJ+bCJP2Bz9Chl9+6Pum0y1moPoqUcrNdGwUgTXhUpaH4gPTqhK
         wEkB1whDXnwbRQZgUi3oPpwQSPo3FzhpNreziS2NTkVyOxa+YB0f8tNdkydTwPVx7jCN
         /SG3DX0rGkYZ96C+jNvibruzaKxIW8iXEbqF6FYVxKbEesduNP4e4XG3JDw9iwgwag3R
         6soBRlDYYPxMGh3+vxPljCAHrrw/VDxfIHJvbz1IMuj1utAvDcac2S98uWRvk3hD71L8
         bfbA==
X-Forwarded-Encrypted: i=1; AJvYcCXpIWHFRu2G2wvad/8pe/YCy3FunADYXhO63Dlf5Fa8sMdV8RWf+rqA0LPq1ozOAbv+Y7Z4XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydqgjtEEqel17MDFGZHqScJF9Q9izTsy8iXf2SCAfLQdn7n1cd
	QJYvtNPlmao5xzTVueJGBK03vfc6pN7qSFnQ2hYW2taahCN4zlJIv7Gs
X-Gm-Gg: ATEYQzz9HBte9M0BVSIXikIcEQeW2LaFDD5YxM4YgkzdUY4RrbiNgFtcsIsZfwhvgke
	7Ro4DaH3uDUG5xU1XAgncPX4ctNsnSjzFKmmA+m4Q+z+63iDrleU/Od8u+aHg8T0YVVvV2HpzGA
	a3tjIi1xV5iUpVC1gT7z3CwvaJycRak4sEhf++pKo7Pmqe4gjpfw262gmW9MnLWpiBpe5WUoH0g
	2FyTMbfMOTeJ6Z/fgZNtNb9E5oBDFiECudHpSpr8mk3uXBkJ1LhMZ8J0QsTni9/LP8oNf/d+9wF
	vmJGdHzam6ZdpoO0AjS0B8To3RUgsSdaReDKjQuXtI6M+/yCG0879MyF78zlPfMd7IzH/dLWS2j
	xOLvkQYUhj1ycByvOgq/7C+AGxvjQ3IfoNdrzKVnK65efMJSrZyxrkEk8VTYs0RpnJC/hV0XWQC
	Bz6T3iNFNAhRaKgnervo6TGBoBPOjv6AzxIRd6dxWjRN9dFVihK94=
X-Received: by 2002:a05:6a00:21cb:b0:82c:651f:3385 with SMTP id d2e1a72fcca58-82c9605d217mr6721194b3a.34.1774719851366;
        Sat, 28 Mar 2026 10:44:11 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8464b75sm2726877b3a.16.2026.03.28.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:44:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: validate addr_unit to be power of 2
Date: Sun, 29 Mar 2026 01:44:09 +0800
Message-ID: <20260328174409.6786-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141323.10540-1-sj@kernel.org>
References: <20260328141323.10540-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Mar 2026 07:13:23 -0700 SeongJae Park <sj@kernel.org> wrote:

> > On Sat, 28 Mar 2026 10:26:51 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> >
> > > [...]
> > > - Would a lightweight fix be acceptable? For example, performing
> > >   validation at the very beginning of damon_commit_ctx(), and returning
> > >   -EINVAL before setting 'maybe_corrupted' to true. Since no
> > >   modifications to 'dst' would have occurred, kdamond could safely
> > >   continue with its old configuration.
> > 
> > I suggested you to try something similar to what DAMON_SYSFS is doing.  But I
> > didn't get your response to the idea yet.  Could you please let me know what do
> > you think about the approach?
> 
> I was thinking this one more time.  So you want to ensure DAMON_RECLAIM and
> DAMON_LRU_SORT not passing wrong addr_unit to damon_commit_ctx(), right?  And
> that's required because exisitng inputs validations of DAMON_RECLAIM and
> DAMON_LRU_SORT are not checking that.  Why don't you add the just one more
> check there?

Apologize for the confusion in my previous explanation. To clarify, my
proposal was indeed focused on implementing a lightweight fix directly
within damon_commit_ctx(), rather than adding separate checks in
DAMON_RECLAIM and DAMON_LRU_SORT.

The goal is to safely handle the context state transition. Specifically,
I want to validate inputs before marking the context as potentially
corrupted. Here are two approaches to achieve this:

Option 1 - Using a label for cleanup:

    damon_commit_ctx(...)
    {
        err = 0;

        dst->maybe_corrupted = true;
        if (...) {
            err = -EINVAL;
            goto out_reset;
        }

        ... other code ...

    out_reset:
        dst->maybe_corrupted = false;
        return err;
    }

Option 2 - Deferring the 'maybe_corrupted' assignment:

    damon_commit_ctx(...)
    {
        err = 0;

        if (...)
            return -EINVAL;

        /*
         * Only mark as pontentially corrupted once
         * we start modifying dst.
         */
        dst->maybe_corrupted = true;

        ... other code ...
    }

I think Option 2 is cleaner as it avoids unnecessary state flipping.

> 
> I remember I was saying this kind of change would be a kind of whack-a-mole and
> therefore prefer DAMON_SYSFS type damon_commit_ctx() based checking.  But
> that's not a small change.  Just adding yet another simple check on existing
> validation logic should be fine and small.
>
> [...]

Best regards,
Rui Yan
