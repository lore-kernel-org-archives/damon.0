Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FA7DA66
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106122; cv=none; b=seNx4JKb8GFcRPHpOOu1peG0voKJg2yciS01mIBInwokHVpI+y37ISPweLBSJy7NeKQkGxSWWZwKuHgjSoP6dZ2wdkTbt3S0DDTA6cE8ISgzXHHOQZo3IpwS5NQrZjTdPnfCUTyOlRziMw+E7LhAf4FvvHxLNZFES1uJiA9cnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106122; c=relaxed/simple;
	bh=DWjl5GP/0+PH1Xd7t5o5/slCTsZH+Hw8XYQoHO4cseo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eavy7kC3jdd5nH0YyExVaN0sRWCS04COY9uh2Ruswv0KNQf/he62bNvUpyfkJ1mbLjdV5edqe8QoLrHamdddjs1Uew8/mI6Cd6PO3h5Jv1M2oiLYdPas4mNqPnK3Gl1A0z5bKNlhCSJzj188wfJl2gfq0ffJMT2RZbSMu45a1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbK+P5hJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbK+P5hJ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3076885a12.0
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106120; x=1776710920; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aREDMjRidCZcq4u4mnPv8wxvNLNH8eRVKWhe7k1qAs=;
        b=KbK+P5hJDgrkq0i5rb+ZVLudT7rNlIaQr5MyO1vXVlnoJiQ/bvn6iDWsJ5hKEkHig7
         iOPvB1bgoydnJxBQyH6KVqjKlyg1hq35XyZCL07yW/a0HTB2tYMdRvraHb5K/5P339zE
         4QFh2JTHOL1UPDf/6meb4BnUEPX+boh8i356ku25HevHaRyOJeO/j2FfDY2EU/vfgzDO
         tWwBWXWe2u+IUGhJqqdoJFaJpOreRIUaQcmPSwfoiTo8iIPUVIhPwoeSM0sjTR4SEhX+
         L6Wz+RQl+nqeTz2QIRcmOJQYoUiHTkBsN3QVkJ5xXGir1x/LxjehcxJ4WzjKK1H2HfYf
         qXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106120; x=1776710920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aREDMjRidCZcq4u4mnPv8wxvNLNH8eRVKWhe7k1qAs=;
        b=L8Lxo9mccYBvPrzmfdkU8p5qeQEbV7gogvC3kIWASxmlQuxhSctrVADw7MLELi6w+2
         kuxCyn50vqIl2VFq6kpwRYs4NGPUJE8veol+QhFPXFNQAa/14F5ugIp3o6j3sd+IRDt0
         34CF1+Iyk3Bq3vdRCgd5IkCiNoDizXxD1gpktTXy9xtwJh36EgMJrmOV2tHShmd7Snbd
         3QnBszpvfdf+8bthIV1sM7j/9FvjOkdOyBFpwTfTk9KjNLgYuHRIWK2vpfP8xG8A4Znk
         NzV1tfxUGzeNMlciWtq+fFPuFvVheANDYHthom7XsZ3Az4WnKt4g4GEnXMUrPl2NdEiY
         ZCsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qX7vaqzF4ss8WvLKI2e+c2xu6EoOMSe2iXkV9zW3rvftLPrvbw7FJbCB08nUCBPfuoleuPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2QDXL6+XYm8GhZh7NTCAoK2WWKx2QkUDC9XMmc/zvTlab6WYY
	5RM+bhy+8dXd1A4Xm+ouQehatkVorL5+xeXBdBrwZE3fzl4x27gG+8KD
X-Gm-Gg: AeBDieuv9VorvgCutnb4pQNpAl+h8vxCeN7SMGuO8bhcQpan3z/LwDUjFH2ZXwYRz0q
	GWV0cXcyiegQDT0pzQX6GvltAg1eGtatkJYrFwFN8/jP61LjIHHjc3gA9nZBx/wHYcXuT9e5zR6
	67OLKsV2VWiH2GtMmzzjoPS4N35lktnooOxYETMWSC9m4ruMSKL3N4mc/HQOg9YjXx0Zch8n3CO
	ahjwYDn11Om4w4v078s0bQt81+SlewaTvwhHLbnWZz38xgV/dn+8C0lK/K90iDA73WAaIAk6yGs
	qBfPgEwgZ9DOuATNfb5gj3fiuMw//arvex3Jrl6NPl4S2MrHYmiOO1Jys2D4udqNQufDMp7KDcd
	8NrsYFgzUYHzMZBfxnzoxQQbkgoFcHKHflhR+yVroiC5dtFUgffaZOY+Hczvrzr44LgGjGINfJ+
	mYgfdeE39gBUe3rTjtvvoBdC6qtnOZZCz9xQ+nnKuUeetRpQRivkg=
X-Received: by 2002:a17:902:6942:b0:2b0:6e12:bb21 with SMTP id d9443c01a7336-2b2d5a9e7bemr101327845ad.41.1776106120273;
        Mon, 13 Apr 2026 11:48:40 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd5cfasm151072175ad.18.2026.04.13.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:48:39 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Tue, 14 Apr 2026 02:48:45 +0800
Message-ID: <20260413184845.5130-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412213720.89145-1-sj@kernel.org>
References: <20260412213720.89145-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 12 Apr 2026 14:37:19 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Liew,
> 
> On Mon, 13 Apr 2026 03:04:55 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> [...]
> > > Next Steps
> > > ----------
> > > 
> > > So, what to do?  Please prioritize series B, if you still willing to do.  It is
> > > ok to keep doing series A, but only as the minor user experience improvement.
> > > Clearly explain the whole context you are aware of.  Don't Cc stable@ for
> > > series A, as it is only an incomplete fix of it.  The fix of the one trigger
> > > point is just a side effect.
> > 
> > Yes, I absolutely want to continue contributing to DAMON.
> > 
> > I realize most of this confusion came from me misinterpreting your words
> > or making assumptions without asking. So this time, I want to be
> > explicit:
> > 1. I will remove the Cc stable@
> 
> Please also make the description of the patch clear.

I've been thinking about what you meant by "make the desciption of the
patch clear" for Series A.

Here's my current understanding:

"
This patch only fixes the case where kdamond terminates because
'min_region_sz' is not power-of-2. Other causes of unexpected
termination (e.g., memory allocation failures) are not fixed by this
patch. [Seires B] will address the general problem.
"

Is this what you had in mind? Or is there something else you think I
should add or change?

> I'd like to avoid delaying series B too long, though.  The bug is not very
> critical, but better to be fixed sooner than later.  If you have no enough
> capacity, please feel free to hand it over to me.

Yes, I have enough capacity. My exams are not until a couple of weeks
later, so I can focus on Series B now.

If my schedule gets too busy later, I will let you know and hand it over
as you suggested. Thank you for offering that.

> [...]

Best regards,
Rui Yan
