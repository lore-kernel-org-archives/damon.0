Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DC36492A
	for <damon@lists.linux.dev>; Fri, 13 Mar 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430968; cv=pass; b=JSlgQjIMI3idGPwNCoZa82b3NN+mJAQeziKxnUobGjak3Nd9RuK1kCbtQz+knGaRpjHONj8pHTILQWKHJo8ITJUe4IAatak6Pqj/eJloKu4s4BpjxvGeCv53CR9uAKEV8BRCvNo8S+m2UGahNLKfB/BxqupowWVAz5fWGbKp174=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430968; c=relaxed/simple;
	bh=zaDc/CxfqFLuWDkt7oPOwVuhZzmONVJpyG4HpjlWZMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmwYjr6HjdCkY2GHSplQLI/xi2EMBJDpPKIwLuN1dB+8ErRchJT3Mb1R2yTl024cXK9yAxwbAapGhIGv6rQN0f/wlk/7CB1Gf5B3+rZ5q60KMhmraBh6CaXayeqMPpEuhtgQzQPj3wGQjto9Ol68LSh7412ttfmmKEUCrcJpNng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXBKS1l7; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXBKS1l7"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c31ca77b4so2785308d50.2
        for <damon@lists.linux.dev>; Fri, 13 Mar 2026 12:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773430967; cv=none;
        d=google.com; s=arc-20240605;
        b=h8zHQh0Lj3qIZwt1Kj4xXgbkcvgvENKyAzy2Hlwam6ukmk3Y48zC32eaAf6wdvMahU
         hsX0Yp3cZzn24BIkEVb67bd3sm/Pom6sS9VSziuznOWU/VI6g6jt+RnqJggSVqN9ho+b
         ZZbgsFd/UbX16aKEVM+xrnpabpqWyLYpgLZ95MGGcQU1vUlmnGc5O+18ij9knO66DwmV
         LvT9M2J1vaTPXeamFy1WMBjBUIiuFC2Ib9jOhsRqlK6kggmtjBRDxhgbCE2gBrbC9l5d
         6uHbO/9rQNzeGE2j3TeFxSYlADm6Cc/DcBdfoFX7Lu3vjdkaI8wM7SadJsW6wlXyhwwc
         QG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L6tap4Xvv6Aj398CJevRoAsoPEctM1t3K/HC/O/0HwY=;
        fh=OTDbqs0ebC/UxWQ+2LCVlZTGRgUjgOu1VtlWWmYjcnA=;
        b=AkR2z+tzTzzffiZnQ5olaXWa91RUaAyacwZH3dvdlnkojeYP3ZPj7ZrHVXJxjGcrPv
         XTdEUo9P+CJZ8NxbgNvszWsG9ixj/d1+c4171Km0PldqGX11+18x9UfTYGJ3uAHlsYNN
         Sp4pRPkUHpEyDQVx8eyYi8A68RkmflHeLqjDM1HwHHceBg17u/Y3QkaPb5UFjhweybSq
         7I4nhTrJ7trFKSH1SfVQBzMPrD+vGneYdHBFVNB1QL/FAaRjKQ1YLsxjtonujrus+41e
         /HuQtz5u8q/UT5EowpVAFNnJhYQXrBLVgPpIZ7MfcYKC3udxTQ4999rE+EuTY2/HhDk5
         iHVA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773430967; x=1774035767; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6tap4Xvv6Aj398CJevRoAsoPEctM1t3K/HC/O/0HwY=;
        b=LXBKS1l7CSSHI+XDgB8MNOHkvsxaYVZJHbjoPc9QaIvY5RvsSU+imXiuytFuzCWn03
         KJ8RGaFCp28hmIdTZCtaAH7XnWu5GRqXnPGEOT4ojglGi8o3HbsbVjPUV87HWfkUBRDe
         BPY9ahl8OKTn+W8/pqNHIIilmBBbH5ffzMVQW4QnUkJa6DCZ1nnuWLcrPHWk4F/iGRmT
         p1c/1Js4mh9WO2sJdqPu+xdnPHMxm92ew31mlyDPOlu1R5ua+YRncTUp18+cGeWnthRc
         ILNKpNaxMuEvqwBUkZTGtfydx5l3gM3hdrYHkvU/9kc85a/fcmruV2sZP/bQLqAq8KE6
         Nw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430967; x=1774035767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6tap4Xvv6Aj398CJevRoAsoPEctM1t3K/HC/O/0HwY=;
        b=Wo3U/IaviSNjkvWywlAdzjwyFLvVHZY3OHL7hs9oPqsp2mH5gxJ4fh8ZzSOKd3GDGA
         jhA73ioypB95POvRr99W5hKFXJ1VmgRFLCwtOXl6xbx9rZFIAN5Kp3jRolaMPat4/Qmn
         QeQU4Nr9Tsl6wcseIrAz9knGBf+VjgkO2C2tScaxyd+rwHC0gk60m6JYKCGDGcIzRkW/
         49hSk3qHsrTGPbD38h2rLbShk1uk8RM/0TX+audoV1URLGA6DP1x/MhkrRRn9nrRMPSH
         WDVf2Oy60A09ZkbSHyeRrIz3pUqwLPPf5dwbFVb6oOzXkT/4p6NFBOm1tJXiRKToaaT9
         /7FQ==
X-Gm-Message-State: AOJu0YzlHK/4KY2DNhh6b1iQD5KHx8hocVSXYKjTbpLv7hA+aF/doNZd
	s3vVmCrMJqndBnl9l5ZEOxHMtRQXQ5z/VrtmuwTo2HcvepgJ4xMie1GmQpwwQzrL3vckO6Z+2HL
	kwkZhqoyZ6dF9Bl8P/HMfL2eN/sjHez8=
X-Gm-Gg: ATEYQzxe77wxBkSlgJNiJiyOc5Z9kGHMS/Yiahs9aPi7e+dcL3FG55rpoyJfsoZfblK
	GW0yqrUeilH86uWOelVLwzQEVEc2JV9dK8jvT8iL2jzhhFhpybBbEyVVS2QTZxrjHVXD7sxvV3p
	qyZMaZKqukV9dd2fMZVaiPPPuN9wTmTOasN4gcGYeNjhuX119LpVwrWH1xzlf8hDhJV4fgpA8sm
	+tj1Tjbm77QyeSmB3PeCQt5F7RAnHZ8P6L562bZSGkZsoq5tLXsasGrfqCXCKCMHe07fTGAlai3
	WEllelxzUBEoVtcSjNa8Oa76YuC/R9zgGn8GjdjXrg==
X-Received: by 2002:a53:4c08:0:b0:64a:d74f:2583 with SMTP id
 956f58d0204a3-64e62f32b83mr3773314d50.8.1773430966683; Fri, 13 Mar 2026
 12:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313111702.38667-1-aethernet65535@gmail.com> <20260313145247.46643-1-sj@kernel.org>
In-Reply-To: <20260313145247.46643-1-sj@kernel.org>
From: Liew Rui Yan <aethernet65535@gmail.com>
Date: Sat, 14 Mar 2026 03:42:35 +0800
X-Gm-Features: AaiRm50ChEh4InPvjYO_yVBmE9ldBcHvaYymROpXYmMM2sWnTfV5xLuyxfxPYQg
Message-ID: <CAPLv50pLx+Jk+7so9uWrpy8qzOnvSr5QkbJkQL-kctEwkx=qOQ@mail.gmail.com>
Subject: Re: [Question] mm/damon: conflict between DAMON_STAT and DAMON_LRU_SORT?
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:52=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Yes.  But, I think 'Special-Purpose Access-aware Kernel Modules' section =
of
> Documentation/mm/damon/design.rst is a better place to document it.
>
> Would you mind sending a patch for that?
>

Hi SeongJae,

Thank you so much for your quick and detailed reply!

I'm happy to send a documentation patch for this. As you suggested, I'll
add the explanation to the "Special-Purpose Access-aware Kernel Modules"
section of Documentation/mm/damon/design.rst.

Additionally, would it be helpful to add a short note with a :ref:
cross-reference in Documentation/admin-guide/mm/damon/lru_sort.rst
pointing to that section? I think this could help sysadmins quickly
understand the reason behind the -EBUSY error without having to dig deep
into the full design document.

I may need a few days to prepare the patch properly, I want to
familiarise myself with the reStructuredText syntax and the current
design.rst. I'll do my best to send it soon. Is that okay?

Thanks again for your guidance and for maintaining DAMON!

Best regards,
Liew Rui Yan
