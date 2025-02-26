Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4597A25E828
	for <damon@lists.linux.dev>; Wed, 26 Feb 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611253; cv=none; b=Bnel/MtvG8Vfj3Qa2jYGe1TdtU+JIOmsEK45H1h6ojjslB5buzO5/JRlcK6fc5Tqenw3zSaOXWaYI4QDlTiQxNuAL66BmnSFTRhqztqT6YjrSHYzGnG5eqW+FgORzXyZS2RXEw/IIXLM8CP2qhAtzCucWCUrZKZIdHBXj+4q4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611253; c=relaxed/simple;
	bh=pRoo4kt1j3t3xYS1cGP1drmXvTtaQO/4Q2bHSnftOEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXkOLFXMGX6aovdIGjrvuRwJYQsyU6TiHhFs3ef/Nz+ylQSktrdMJiFE+ukwVN0e1bKQk6bKdT0x8hdPI83Hw3s98Ugfwxqd8Iw47wCWGf/96zeRSYnAXan/MvZ9k9SOv3FqsA+l3ekzpnejnj7J7fqr9Iik3TOclalAa1jnknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ6RCSdv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ6RCSdv"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30930b0b420so3040431fa.2
        for <damon@lists.linux.dev>; Wed, 26 Feb 2025 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740611250; x=1741216050; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6EFFgter9gAlebiFMms2NvzaWeJFYWFjYw0olSs4d0=;
        b=LZ6RCSdv2hfswV2pioBWkSXZuvitxQ818PV6kngIFOyefanxRUCfsQ2JZMXpvAj8eS
         8OA8/4yIoIU7WRCoI+p0lbCmP0oeZ7BJmN2mDBIGByxKE5eRsAArjx54ZLe5UeFwpwD3
         tnKeOqaEFyMqTQC+Dljc+owQvMssOJiIdwBZVvn87ORS8ic7kCU3+3Vs4jpB6DWY0pc0
         fYmyuTix9eMDDIAPnYdoK1/mitCItSS+AdVIdPBoj/EN5q1CRyirfByQrRdWoUN18Ecs
         UfKYXe8WnWNMnY4PhS3DmyK2qPBqJaAfIitewRKZZ7Tg4R0m7NikQb5l42zC+EIdI+1R
         zSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611250; x=1741216050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6EFFgter9gAlebiFMms2NvzaWeJFYWFjYw0olSs4d0=;
        b=trzo2m2YtQl8NuJNX4y5vzX7kenN5JKHKMGqv753AeZMstNS7l18GZr+piF2KXw3JS
         IN1REKy2wDKaw9wmfHgjjbk+x9BjwHxCVuggAr4smpZpVyDBip9Peg/NWL49lD/W5TCN
         N3kBzcPL5nDb8HQuDgK0meTo4l2xdgzMFQKz2Cl26MxGh8B9vYSjp+qCO5gzQnv5SMe8
         ZI9krOsA1VUV0pNxwNkejeph8lQLViIWVKdludqPd4yuwbATtATgJ2myaNZ+1u+MG9CC
         gdeMPCygOvGy2Yp4MCCRuCILkXTmE7aQO0qp0BND6/pEFzghigaLeyQRZlA172P4mtTf
         TKfA==
X-Forwarded-Encrypted: i=1; AJvYcCV04XWikSRYiOXjJbDN+pGTpr8yeshJWXsbUcOuifeYXVftoztviU6r9a6IaD6rjqO1nK6rlA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0S7OVhSipIcLhtnVHbFCi2qf1E/NWczykyR/injiBt4F/497G
	2GrIS2HVOpBYJN75ZxuhVSnnP8AM+VFK2UsqOTBlMB9hU/swztu3sLZDOravta9Vh2bldf6OrL2
	NSGTvWFANIs+Q/Up/GpfDhyMuPfY=
X-Gm-Gg: ASbGncvq1M/Xyf9H4k6SS6/puSTHn+MDJZIaOQgCHUYEoxHnov2g9y0UGvJHloxEB00
	g53eXYa+w+PFB685et9tMHGg8zEQPTY/i6HQVxnGLUr27comav4gO56JmzZ1MgDGx8973ZnAiaL
	vqHoaHWG0=
X-Google-Smtp-Source: AGHT+IEuqB4IJ3OP9zoL3qsGgFn5WgCkzYkJqBEXvTaf6Vi7/Ve1nDsh1ZOGXPkSvwiNAEYISejaABGjP4jGd1d8vDQ=
X-Received: by 2002:a05:6512:15aa:b0:545:944:aadd with SMTP id
 2adb3069b0e04-5493c5aebadmr3654432e87.37.1740611250067; Wed, 26 Feb 2025
 15:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250226133703.3c9775c9e50e198abc9b9f6e@linux-foundation.org> <20250226225605.2000-1-sj@kernel.org>
In-Reply-To: <20250226225605.2000-1-sj@kernel.org>
From: bus710 <bus710@gmail.com>
Date: Wed, 26 Feb 2025 15:07:18 -0800
X-Gm-Features: AQ5f1JpzFvrGUf0R0qU0JfhyEu3jv6eTcZL62UzJE6wu__9AYfAiLdLM7x0iDbc
Message-ID: <CAJGd785Eu7iuVwYnewaUm38NJcKzB-xkZwdRiYR9Yo9Qwaoffg@mail.gmail.com>
Subject: Re: [PATCH] samples/damon: a typo in the kconfig - sameple
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:56=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 26 Feb 2025 13:37:03 -0800 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> > On Wed, 26 Feb 2025 10:42:04 -0800 SeongJae Park <sj@kernel.org> wrote:
> >
> > > From: bus710 <bus710@gmail.com>
> >
> > Full names are preferred, please.  Actually I think it's "required".
>
> Thank you for letting me clearly know this.  I'll request full names to D=
AMON
> patch authors from next time.
>
> bus710, we could still update the patch before it is merged into the main=
line.
> If you could, please let us know your full name and if we can update the =
patch
> with that.
>
> >
> > I'll apply it anyway due to the patch's minor nature, thanks.
>
> I agree this is a simple enough patch that the name doesn't really matter=
.
> Thank you Andrew :)
>
>
> Thanks,
> SJ

Oh, yes. I was a little worried if I added too much noise for such a
small work, but I shouldn't miss this opportunity to leave my name in
Linux history.
Let me prepare a new patch as soon as possible.
