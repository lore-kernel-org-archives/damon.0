Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742A36492D
	for <damon@lists.linux.dev>; Fri, 29 May 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067835; cv=pass; b=R6DlNl126nMqMIR+y3vkDotB30jcADTYNfTMqxvUgfYl1aWyMtm1fOFV4Q1it4sof9uVxx9UascUKf5s68FMEMa17eFvVz14rgkIYcHlA7Vlz7wsTGG/9T0AzqqNWGvxphG8ESY71rAFK44TNkIDcNcVm+mR0UZuQJQD0tuBBPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067835; c=relaxed/simple;
	bh=6/62MmoVTev19ZuS/obXd08L7V5do7eHW2JgULwy9bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UycWdJBQLTaos9iK7jN91b9rLFsYDe+msztWW6nDK51jvMvWaOVx0h8ATx2Sw5HLiFdxDSnUtlxx+JAPuGij1awZzhSGPly9pwGfcxmlnOSXk9EyamS2Ykg/ynPSGkINbLaP8PKfWQY9Eorm2Bb5VqPZHeAPJBF4NzBOSCEkBuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=poBhnrHF; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poBhnrHF"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so1184198a12.3
        for <damon@lists.linux.dev>; Fri, 29 May 2026 08:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780067833; cv=none;
        d=google.com; s=arc-20240605;
        b=ScCO8+/vSJCRqfqu8E5D8EiSKFhJWWg7nYlRMm8VdK4M4J+6qh+Ky0iVitRfcSxwAe
         78eoUQNufDQvnYiINQW+6zDb0HjUB3kmjNwJBIxVoQ+kvH7ABLaACGO1xZypoJHaQCFb
         5rxE7BXIvz/xpp9IGQ/G/XZ2kSsFH3Sp9lKHJTT8IA7HAUfqRZK+Gk9eAJ3ulRKRVccJ
         J3r1svHENIdFv1SF2nuc+dAW15/MAApWSTaFdhcnlb8qkKsRmD1MUA8Ix16VzohcI+iR
         bLBwWVNe8SSLGqMvJJ6luN7F+6RQhF/zco/USVYLuhyjwrdDZaPa25Ut+pM6Cq/NWzsQ
         4NoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=422uQuN4lSGGFpmZWWpR93/cChKRMGbONBnG6JNiRpo=;
        fh=zAASRns0pdfJVIIr+psCaDRCpSWtRutB4NfcEVbwMjk=;
        b=hT219jT5SLAOJzp1b67h6vhUDNRfvnkx3rEQ7y+tbsXibF6NWMtMUPSAjjxZYMUU2I
         J84Lg2VMuErJ2IFCTzuG61+czM5ZNKo7IVg+p+QlEdOPm9DafTDXF0LtfP13nHvfTjgW
         ajNPBfPK1NZnDv6LX1UbiK16aYYS67H4T7xc62EDi7OQe6fNsKDnLnMCfj9BtE6ZdOio
         JMW1uwcVQPfGAHzFRn1QJdUypbXee70QbQEQ6jSnmMEHBm9nD1L8nvOIozq7GAbCL0CR
         NZiGCLIXpZt3MKxIgoFARWXHcLV7AOxrh26TlxgkB+anmfx+Yjj/uh4ECgQ9nUq3I2mK
         nr3w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780067833; x=1780672633; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=422uQuN4lSGGFpmZWWpR93/cChKRMGbONBnG6JNiRpo=;
        b=poBhnrHFegWHD2j0l5X5zj7wr7FFkHcJkdwVGeZLTY/nP6E6wG3zWyrf6hT0ZMAfBC
         WU/MVabZgsXKEe8hPqxG933D8Ukm+rBRaygaVSk6c9hAnRVvQRjZtVz8wD34ERCFid3W
         HTlm3tByMLUtu5XADXfkf4SURZJLxJjn4HTs9vNP0eNIl/tLLd41zakhs+0vqtMfQdqG
         jCgtT5S+0wD1Tc8OFbv9u0h1n/VyC5TsydVvx2p/kZ+NXN8s2XVEqjEc/eUqUg+lmJvO
         WRsrr8zzs2DZ/Kf1f8zREaoW4bezJ5r+svxRzgxl5dZBtKDvWM/8TmjP0lwVhjpwvMAZ
         Lk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067833; x=1780672633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=422uQuN4lSGGFpmZWWpR93/cChKRMGbONBnG6JNiRpo=;
        b=IeHA7G9cXp6hcU/nqhfsWbRUyV0AqCnWZssdpEAlQPFyl0LUpBv1uWo/m8/xwRac8Y
         3K7f6ruKsujmsBnA2kbTR7dZE94Jy1s6Tu7fylo9K4FQdlMoNCx1H18j2WSeXFEbG4ih
         05Wy9wWhyYSy572agFXGid/YbG27YlckRMLwgVyXSeN397c17q49GFXtg84S69YMP9cU
         h+qUSpy9RwMbsI6eqpPVcVpi23O9DHnOZElaLVMA2QO9fSS7cHsvCDmw3Cba4tXEpvas
         77/KISIXbStRE/m/OMULoFzRyVbSpPI1UbmU4FGzNk+cGcC6voy6x3ZaKyNMokCf2gwD
         BUYw==
X-Forwarded-Encrypted: i=1; AFNElJ/t0shYddl1zf1ybqLVKuJdOf/jG3JzA/DbKJ1KZEqC5zKGuYitSMvAIPaccEt/goExcOls9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5Iie7mwSg3B1QCvUbjwAwo0rGyTzrHzaKXbkJOncUepuR75VS
	T/4jJVIgN4NWJ6HISE30CXk5n7bD5vdr6FCktOGRQe3BLbmmXlFgaFslhddCwUcgIO5gy7TP6DZ
	l/P1nHFnWn1GRVky7or1c3IkHnEAeybU=
X-Gm-Gg: Acq92OGCvzE8B8jr1ooOYfMdhHnBOt9E96AnqM6FCY7Y6iyzlgaW3mDkeKnEKDEIITT
	7KvQXFshkTyaCpuJ++0dlRD2dFArNmDI5SEUp4kDfxZVp+Ex0DMJDNhrLLbWlHR5iQqqs1v7Yff
	1PdxUYXZnRvmvVSgFlguFeKB4m2EErB+L8IdLMuWXAny6tUtOBgEpXlEcikKRaAPqf9n3ZPT2we
	kfhb4SJZg5n/3SYFSHfIyOTdm8oY0pzzRn4q2ff5rV/m3phZ/8LNGyCM/Z4ZFsu7upCp0wOAStK
	D7BQi3c28cvoMVBupTeDbjqromed
X-Received: by 2002:a17:906:5a47:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-be9cb20282fmr140019966b.35.1780067832744; Fri, 29 May 2026
 08:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260529031519.1617000-1-dbgh9129@gmail.com> <20260529144435.83930-1-sj@kernel.org>
In-Reply-To: <20260529144435.83930-1-sj@kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Fri, 29 May 2026 11:17:01 -0400
X-Gm-Features: AVHnY4LfUA7LxM08-JOQeLV2s6GMBtHuAdF6kpv6DseVHeWASDyQQhyK7FI4U5A
Message-ID: <CACrCO_XCxTDk7b8wo66CrxzfOXG50-uCxdE9tjJppH_ei5Wo+A@mail.gmail.com>
Subject: Re: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear SJ

On Fri, 29 May 2026 at 10:44, SeongJae Park <sj@kernel.org> wrote:

> But, having one damon_ctx object in the memory is a real problem?  Why?

I agree that keeping one `damon_ctx` is unlikely to be a serious problem.
My intention was not to address memory pressure but to maintain
failure-path consistency. If initialization fails after the context is
created and started, the internal state remains in place despite the
operation returning an error. The cleanup is then deferred until a
subsequent retry.

For this reason, I think this is worth fixing as a correctness issue.
That said, if you feel the current cleanup is sufficient, I can drop
this patch.

Best regards,
Yuho

> [...]
