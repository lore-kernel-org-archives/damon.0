Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.229.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795676620;
	b=jD/BFxPjnAzlI4cR6nDHSGuZ32I8DOB11ONjnNSgwHNXZKnYQ+EaYus6vtTMfQhjY/MO
	 byaqIZChNToFwsWnmByAKpdE/bjukCIcZphfDpRtQXdyBavev7c/6wcDaA09sMAf9PfVb
	 el2D7iNPUCFY+1s9ttiaTDO4zhYb80qaGlMjMXPF/ORxu3MreKauufWZc1VNndTE233zl
	 6+hFa5osp1XV6btNvcyXcniWDv8tMqNCeRjHDwjPDMApWeOKU5LBH6sqLEx08nE06ACkh
	 XOpm4sw+7ooskyEBfeAvlUEM3vtD5zM4hKLQUf7AkLcYZ2FEg8SN3uZj0k5XJk779xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=D8z4X9d7XTdPtdZKUVI1Q6jRe3rMzFKexJK1WGJD7qk=;
	b=E4aPr+4ys9Bgp1RSand2H4xcySojIs7fAWjMZAFZlUdes0RJ+Y4S4GOUdxllCDcXZ7PQ
	 IF/D79ElSJcy6m3sAzD1q0WqSBloiqI2Ct5R776q6lbUPeI3XGLmumRsi2HolkMcHLZzC
	 iAZ0hsA9ablTb7OnUJV+ZTVuu0DdEUvMoL/mPgT0bUtoaPi42exf5pN+HUiPFDph2K+Ni
	 2eTwKGZDLTwYWeps5ES76Y6Ngd7YZAYNaNxGE8C3GQWQW2qGd1aFHcCF+1kmiInYvZjER
	 Na5o8+KBTmeqSHZ32Q1w+0YtirRJ3KieD/NyGCnDlfDauh39PFSxxHVf3Ab4tV3ZfyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vs5aCmMW;
	arc=fail smtp.remote-ip=74.125.229.4
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F1606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 07:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141F1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vs5aCmMW
Received: by mail-dy2-f4.google.com with SMTP id 5a478bee46e88-36f2f262b19so2348973eec.1
        for <damon@lists.linux.dev>; Wed, 25 Nov 2026 23:03:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795676619; cv=none;
        d=google.com; s=arc-20260327;
        b=Fj22+Vi9aZH89vy8e6xztlUPNPyQIVf9IAw6GVjArE9Uk6lhBPgi9cVxRqosbeYvgA
         EzqS6WMScp8SnZGgz4L4qo6UcHqaCMkIUNryx5X//ofVmStQKDULdmZ5OwNjD8Yb2ZuS
         ZF4ppDKWBINkUCWUdI5gZMFMSet425vQ5uL24Tz4nsOUUD6xSVk4oYkngvoO3NXeKtuZ
         mNWnM6Lcsah8AiRXgzHJEPTNbr7pitkBrISjsG0g1Q8d2JQCBcaP2JcyVlopqoMoOVQI
         rIMJDY/d0cOGLQOHweXRx16S8/q59mrn5JTT6Y+EqX+JOb9TeALpFh6oKuQ8C0C5lFQa
         1v0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=D8z4X9d7XTdPtdZKUVI1Q6jRe3rMzFKexJK1WGJD7qk=;
        fh=6tYk8XjhnSGQEADKvV9vQKX9GZxo5Zz+vNeV4dAAztw=;
        b=ILjiancKH2KOoGEBmphYwx+V4n7ULcs89Wyf2kKc+Hc8PRvEHqU0SR09/qdp6XKCAA
         XuZ6j89R/R2NogFt9vjksiGjimaE7nvaZXnEG5zG/reDALhRI3ocp6nO/rJiaJa8WhCD
         Y1s64CZx7Mb4Anb9oVMoQsoIPGmN6t9Tyw80zNe91AaatBrd+76woMd5PziTyAd/Ff6b
         lO5cqVyqAZYvX4amYNOpjiuoqt6pRpyOEpfFHb5jEaYE2Ur5oEC8mk9/NsRb/rsqnHS2
         EhU/bUpj7o2hgeAVFGhs50pw2MoSiNovAAZrh8336yZG/xvGHZsJEmwwH3giOiP4oSQ+
         wnMQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795676619; x=1796281419; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8z4X9d7XTdPtdZKUVI1Q6jRe3rMzFKexJK1WGJD7qk=;
        b=Vs5aCmMWLptowly5mfd3qy+fqtwWqR/9jen1kWgSJGq2tb99hTCV8aNGtT4e11ZE6L
         2VT/TsYeRTp2a2DUmBThDvZdkHy87Cgjx70LBxcGVtITYABnoILLZnO3sj6CVCRKyvhV
         4tc9R7v74z8+bV5FPEzbyUDBzDQOBTW8fB0guC0+JcWQbi/MqUYnwD4uZUGvbmd5eJ+L
         mAU+DaQiql5OWrnU95VTOGAxW0yHM0cvLpZ1BZwavX6JXALWBqhvIN7DDShHSV4gLf+R
         TR5GrX50VJimEALrdb1PBBX/OR+iMoK8W+Dbjoqc1ZJHeVKfyrYZw9RXFncoLc8D9Zvg
         y5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795676619; x=1796281419;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8z4X9d7XTdPtdZKUVI1Q6jRe3rMzFKexJK1WGJD7qk=;
        b=xXPmpZ55WGDAFBxLlRRWE1LwpLOuC8XJGj3slIRgJIAsY1bzgbvcRyXpZyBzL66fIX
         mvDcHpolAuIqTrI/9mejX/bshpaVuIjqALJXohk66yUSXcyye8ISj3gp0+ugBPCPXwQT
         gwt6iyS4qp0kz+Fzvq/rqzSnHEh/a6LFQOmTiN3xSGMBOUvU4h9o4tb+D5ADDMPPKZ9Q
         c0N83bC1unSqecBbU5wLqTwkB9uozEP5v2XCI7d0sQeG27saw83yU/DF53ENwvVKXI0h
         gc5tFt7Wf3k2z68JcrGkaJhcOJsvUS5yF8wnzTuTsF7QXOqpp0mz2Dmz7zdWw/fKebKY
         6HEQ==
X-Forwarded-Encrypted: i=1; AL+hErEjhghh2DqRO2Ev/HMm4NCnJN8lTC13f3EEFebp86swsIaConxu2wiwXAtwCOsxokjxjgQROA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ALyS/Quils5THuB4UkYrdv2W1r0ZwTciEFM5v3CYzNuOS41py
	umd1MQ1IWoZfTDqEVksM/U0er7+MoPxLqjJH9tPUi9KB+oI/P1CP1WUSu/VhT9hb0uc9q6saWqF
	ghCV9VLi/fjvoGTjk6tfe37vecDOqUQ==
X-Gm-Gg: AZFdTZdB2JJpQa/fBwT125pDMWLxOqZ2Yn5TvrXRkLftHzjVbp2nnzD8nJg/utrAKAk
	kLdgCVR1X2dFPXFuH7ZM7JR9olLeqn5j+zm8GhvV5iAO7GSqNjCKtDpxcTdG+rM4eIVF0MbIpTq
	NwaHsCmcjLqpVrECbSqFCJ6ow+N9NZwFq6Zq6TO5CYPO/nmR+TWlW6k8HVDelXbGEyLCcXgS4eD
	Uuz/Z0lTbasb4t61eDAhrhbKsC6pjkYNvg70to0qs88HO0dDvToR+hFOd8aAQAIsetd3Z1ZEahs
	Z208JtYuyQ721l5x6zPzCBu0yzavZblSij6lE4Mt5RwDrqYK5GCZWSw4mJ2fwf6j7NQasqP0ZpW
	CJCZdncFML6+s/7qS3oT9SOK7l9SLFYfQLRWr
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id
 a92af1059eb24-1b55688dd29mr28250607c88.19.1795676619107; Wed, 25 Nov 2026
 23:03:39 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CALa+Y14BNfdWH3yBY+ky1+Sb0YvRzW=gRcKKyGWWaBQkysPUkA@mail.gmail.com>
 <20261126020416.87656-1-sj@kernel.org>
In-Reply-To: <20261126020416.87656-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Wed, 25 Nov 2026 23:03:27 -0800
X-Gm-Features: Aa3M54pr7zZt1s4Atym5UQrDZXCPmYeOf41IBUKmR70FxfH89wL-58DBqEGqTME
Message-ID: <CALa+Y15wc4bgERo_FEwxL4m-NUjx=_o0yPipUN+ymv7HTSUL0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] mm/damon: let users report their data attribute findings
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

On Wed, 25 Nov 2026 18:04:15 -0800 SJ Park <sj@kernel.org> wrote:

[...]
> This is the expected result.  The implementation is more strict for type
> matching.  If it is unclear, it says the type is not matched.
>
> For example, if filter type is PGIDLE_SET and we cannot confirm it, it is
> treated as not PGIDLE_SET.  For example, DAMON could fail at confirming that if
> it was unable to get the folio for the probing memory due to some races.

That makes sense, thank you for explaining.

[...]
> In my humble opinion, , the user could work around this issue by not submitting
> the report too frequently.
>
> But the more important question is, if the user really need to do this kind of
> frequent report submissions.  I have no clue at the moment.  If it turns out
> so, we could improve kernel side.

Agreed, user reports through sysfs are unlikely to be submitted this
often.  The main reason I tested at high submit rates was future
hardware samplers, which would produce reports much faster than a
user would.  I was checking how the queue holds up under that kind of
load.  I am happy to discuss this further once this series is in and
you share more on the next milestones.

[...]
> I agree this could be confusing.  In a sense, that said, those are working as
> documented.  There is no documentation saying addr_start should be less than
> addr_end.  DAMOS filter design documentation mentions "support of the filter
> types depends on the DAMON operations set".  And the probe filter design
> documentation says "The filters work the same as DAMOS filters".

Agreed.

[...]
> Good finding, thank you.  Maybe we could ask Andrew to fix this up, but this
> might be too minor thing that readers could easily find out themselves...?

Agreed, it is a minor nit; can be ignored.

Thanks,
Ravi
