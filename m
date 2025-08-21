Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926C4C6E
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799912; cv=none; b=Nmp/8kCNHHMUn+fGAwLWKXNdMuY8vDI3Uouu/G4BDjbYF+ygNIWCUZ605JJ6BuhwaCknNyLLlHhTINRiuWpgHiUrPfYA/khfiz05MEFHFZbTDTLKCyLnk0NanKokup50wLI8UVHFxhqHQCOehHz2Vj1BokgfYu/rzw5A0hc97Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799912; c=relaxed/simple;
	bh=r2Qq0121Zy7qmPJtGbjdDDoRVirmmaNtoOkITw4RTvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5M58bmB7VsUqSRsGZ66edrJgu2T66lInIW3BphUlGR2bOxewNuZ6MVhCDlARuaJ30OfzpIM6IuFZMme8NBmF/Ul8GSkLDT+fx8u2tJh9Qf2RVbYUL6A0aEoXImlBJVq1XH+dF2CKDdYQVDN/06wjeEp4toKKolcQjT0tDhRWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLZ7KW0c; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLZ7KW0c"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61bc52fd7a4so1295041eaf.0
        for <damon@lists.linux.dev>; Thu, 21 Aug 2025 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755799910; x=1756404710; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQkE0seXAq/T3Nrv5ePjrAqrwGHMqBbMT9R5vFioxIk=;
        b=fLZ7KW0cqzgmtlmBixvIpAVTf+NDcpygu1eX+7Y/KkFt8FANe7rQflZnG38gW0xccE
         4i3uftR38Gh7ww8oZ4e98f0OX8IpqDtFqGyF6jAg6E8GeNmpjou1p5WPS7Ek/7dHHxlB
         EQ4rn1ycOvdb8x3KvGsLULWMsRAP8b+3YcetEMt9hWDq3Yf88KMiq0omlNCWMw+9dlv/
         oLOwx93A7+c98htoEpRQEBxExjAGFcCjQg4CbK2mxfFZ9PbD3X5KcjRVIK0SjG6wUC+2
         dLRzUb5dac/VU2WgvB5iMEwCv6kA0dfUyTwgkSp/dRF0BdmwUM8mcjfBLKwU78GgiwSL
         yOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755799910; x=1756404710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQkE0seXAq/T3Nrv5ePjrAqrwGHMqBbMT9R5vFioxIk=;
        b=LwoFzawpykPN30sNMpiX/fvbHuDND7kExasLDzRZ9vuAfpykn1mjENRo34rJzJIXpU
         XRJwBagYEHmQTa/MxzJ+2OlqgHJkzmlUq2rd6nn8CC35HlfQYcMM8J/vqVximaqRHSwD
         FoMyP963c1UgQZmy4HOMHoLvpFGr5qPEVLqfn773k+LgXCXGTlWtQzZTdoBIjYdKo23G
         ckKC02sC942Taxkod6N5gwJweGk+vad57yw7v/iyRNr2eAjv+/G3cyuTfi7get5CLz7f
         qmgWGymdvJoVePINDEPj2kelC2JirUIRt7ELwvLHoljMmavuOkb+QsHT/ZmQAda5CKhE
         7ZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+xWifpB+0lfUx66D/aKsKsnwGbMBITr0rudsyfeLGAwC142MHzO5H6iLiyDpvwn6bNrWI5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm4jZswWEbojdtensFschxnEE8uyqB9Pwiiv+CKtElTyOaU+m3
	uLnCoJJ62UpOGQhM/nzIXFcNVxeF10NM1W6ovd6i1q52VUKJ4Nr5JgfwTH9aAkisci4QAKgVGND
	3dYlD6fBKOQG0d8sJ93r+bzN926dFGKE=
X-Gm-Gg: ASbGncudkS40cCmdgM3gPd4VBe40L26lUs3lZnftiwog/Jvfgfl1E06oSHgNXxk5aRq
	IyDbmn1zL4rmfUTrHZqL3LXBG0fvlpLHGVmW6349TNaY+LQIXqfNPgnjEjVBNhLKdyJgHoXvOeO
	WHPmFPPkUZ26co9WXhKNXsT+CSL2WK5hIDhnZXGqhjJaVAF6abU3JT2hKpVO3LAvGcD8cwz+o+x
	ub5
X-Google-Smtp-Source: AGHT+IH5cYePY4LWF+yUbkxUmI19KRzSY9VkjyJnD/MWSa1UbpylRasKtorNCTewDJ8FF3suBgFD7LYcg9l9HBkHfr0=
X-Received: by 2002:a05:6871:54b:b0:2e9:42a9:be4a with SMTP id
 586e51a60fabf-314dd38b1e9mr45823fac.2.1755799909600; Thu, 21 Aug 2025
 11:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821163346.1690784-1-ekffu200098@gmail.com> <20250821175307.82928-1-sj@kernel.org>
In-Reply-To: <20250821175307.82928-1-sj@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 22 Aug 2025 03:11:38 +0900
X-Gm-Features: Ac12FXyjW6YGm8vBrKSBZJTi676GRJ_lE4WNPgVhsOLOvxK4NT6otMlFppJi6xE
Message-ID: <CABFDxMFk3TbzOcZd8tgLJtQTav0+7=BV98f9=YVYfea9ngCsEA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 2:53=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Fri, 22 Aug 2025 01:33:46 +0900 Sang-Heon Jeon <ekffu200098@gmail.com>=
 wrote:
>
> > Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> > include/linux/jiffies.h
> >
> > /*
> > * Have the 32 bit jiffies value wrap 5 minutes after boot
> > * so jiffies wrap bugs show up earlier.
> > */
> > #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> >
> > And jiffies comparison help functions cast unsigned value to signed to
> > cover wraparound
> >
> > #define time_after_eq(a,b) \
> >  (typecheck(unsigned long, a) && \
> >  typecheck(unsigned long, b) && \
> >  ((long)((a) - (b)) >=3D 0))
> >
> > When quota->charged_from is initialized to 0, time_after_eq() can incor=
rectly
> > return FALSE even after reset_interval has elapsed. This occurs when
> > (jiffies - reset_interval) produces a value with MSB=3D1, which is inte=
rpreted
> > as negative in signed arithmetic.
> >
> > This issue primarily affects 32-bit systems because:
> > On 64-bit systems: MSB=3D1 values occur after ~292 million years from b=
oot
> > (assuming HZ=3D1000), almost impossible.
> >
> > On 32-bit systems: MSB=3D1 values occur during the first 5 minutes afte=
r boot,
> > and the second half of every jiffies wraparound cycle, starting from da=
y 25
> > (assuming HZ=3D1000)
> >
> > When above unexpected FALSE return from time_after_eq() occurs, the
> > charging window will not reset. The user impact depends on esz value
> > at that time.
> >
> > If esz is 0, scheme ignores configured quotas and runs without any
> > limits.
> >
> > If esz is not 0, scheme stops working once the quota is exhausted. It
> > remains until the charging window finally resets.
> >
> > So, change quota->charged_from to jiffies at damos_adjust_quota() when
> > it is considered as the first charge window. By this change, we can avo=
id
> > unexpected FALSE return from time_after_eq()
>
> Thank you for this patch, Sang-Heon!  But, checkpatch.pl raises below thr=
ee
> warnings.  Could you please fix those and send yet another version?
>
>     WARNING: Commit log lines starting with '#' are dropped by git as com=
ments
>     #16:
>     #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
>
>     WARNING: Commit log lines starting with '#' are dropped by git as com=
ments
>     #21:
>     #define time_after_eq(a,b) \
>
>     WARNING: Prefer a maximum 75 chars per line (possible unwrapped commi=
t description?)
>     #26:
>     When quota->charged_from is initialized to 0, time_after_eq() can inc=
orrectly
>

I will fix it. Also, I came up with a way to prevent these minor
mistakes. Thank you so much.

> Thanks,
> SJ
>
> [...]

Best Regards.
Sang-Heon Jeon
