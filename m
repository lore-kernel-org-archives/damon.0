Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445E53D0A4
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.199
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077430; cv=pass; b=jFMrZrRNPfiQAnLrizjAvmtzEDX+ACaPmLuatdCR6A0y5FrvlTddRgi8fMv9hLohnHERQ9z9ZQXESrCm9wXAYXf7WobuzxBHKudRwsm9rxi3xS9HH2fs6ePgJWqdlD2+TCQFPXHhXskJ5HTqrtYXieKqhvsnG1Qk28K8VwdTPds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077430; c=relaxed/simple;
	bh=uoPPaZGYiQ7utfzHBxmkQ/zq1fN33eNhuTE+ayh5TfE=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XorI3LMyB7ECMdPxe9VgPm6YmTQQWYuzQ3YOysrfVPPj5k+blOUPjXbKel82LRzL9SkcmDwsQDWtfAeJ3rpRSeafatgET2rlu7dI7uU7alHEhQW9oCkHOGN40RXi5yJ2eGLoZrblRkw8QJEvlv3AbsYd4DBp8Xv3inajwKGsNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMLppQmf; arc=pass smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMLppQmf"
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so2147612b6e.1
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 08:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792077428; cv=none;
        d=google.com; s=arc-20260327;
        b=HxeNdueZ5muGvbZKYx7ktSwKNdHsV7jh0ZBkvC/2z2uvBti74sh4nzl2pdnAySnQ1a
         Eij8LdFy1+GhUWIuoLfARusomZZajk0J6GNq+vktZeDo+wL9zG+uUKm4UQndS1aTf6Lv
         6LpvVCagZPakvqkR8wuDHmaBTp5VfcLbJlx9wEJ/IjB8HhwjD8Pqi6Yra4BWJ+GIp19r
         jYhTJ35Vfr5L7KcJk5AhxnABDfMn2Lo6DzroAn87ugi0YiEXZCtw8NVm/4g6xd8jnHKe
         u4p/Qd5IbBA7JHEutSd7Q6LIsmB5HYe24A57MCpKxddc1KuQMVyFEJYb+C8qqeiH6cZu
         TX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=OeZR/JOPa/KrDeQOVwy6UcwSPvI8j2bKhcX8zNJ+XWU=;
        fh=wypHHdzHa+0mXiCZClWh1P6Vx2igTCXOXczymGzkmRU=;
        b=Uyd4zfkb6YqkROpJI/+mUzJ2z4tjN6Ga18c0nLauSmoOCudknDru+Zg877Tus+jJ7h
         OMdqTBmkxXapc0gWXj1Zar/PGmsFVVIYRVlpv3NyB0HLPKRukds9w8D/AaOczsLfUP9m
         ooyVFg9cM8z6/EmpFNmhZmBlAsbnDTmN8nWIBDvYoiBl6rgbL2s25fh7j9JcBvYxe4Fd
         l7UawxP48ASjQj6mfhrSg0hGqdUjZv9oaRVN6EdLUlza8y8yWcp9ljcSNz0/lVQ+cDc5
         chJPwE+ZDDL7CBnpnVBPXuEVrTQ1voc8i38mkadmbpgaaNByvwtd5m4iDFEyBr1Jdogo
         5+nQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077428; x=1792682228; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OeZR/JOPa/KrDeQOVwy6UcwSPvI8j2bKhcX8zNJ+XWU=;
        b=LMLppQmfgfiNhWh79XRdsQ+zH4GPqAPTwAQEw36oFtM6izzUBtTaUhinDYNG0fP9DT
         YsP8ZkYXeArbRiWPkltpg6uyF9l4jJK9emw4xnPGVSZQFVMU5Dox8IqWIzVrYweT7etg
         /yUSh4kGy1+qLz14jtwREZzhfeG8nrGuiB6BXpm04DXJKo1rMyBTAxlmjfsvq5akZHzD
         P2V1j+3nL1hmwCX7ayAffZ94j5ZjT2WKb+MtSQ1zlHtlEyrCGPBdOyvl80ciD3EFcdgE
         WkwTQBkl2lGN8NGPxShy6RjtMYsCHON2a33ujd6IB2Zxe6hL48aiX5WL7kPIN6oYsVJJ
         a8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077428; x=1792682228;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OeZR/JOPa/KrDeQOVwy6UcwSPvI8j2bKhcX8zNJ+XWU=;
        b=cc5/KAyAv5AZR70ZYpTkjmTV7si26T7YUCEPbbs1TgwKWUGc5YhFyzmaCbeuSkzI1g
         1hlTxa+ix5GVJVxUSFf7NXojUQ9GWrxzf4DjQ2beLIQ+C90Ys4N3Ni7dGGtpXTQWIO7M
         waSJSSyOoa5FCN/KxHE9bBRXFUBP06cofhXRmgvclqya4qDO9kuVCt+dmFJH2iRodYNC
         A64eC566zI808Iu999tDD5xkpR55WnaddX5ZnwOu7jmz2a19TRiTAb/gtj3G4pRMuzlx
         BUU4lF8wVeU/CzWo8GFXoi8ep0EaXQh/yCcp2Gr66oS08T/vr11RW7jmdDPqH7wFFWoi
         TD8A==
X-Forwarded-Encrypted: i=1; AKwUvBybkV5amYz/nD4THqWID3Y8nZaIsTbNr6XYAVnAFNAjC2yZo8hurhmmOjQOvG6HXSgHrKyZxA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKHTwaTp7fVDAB9A3QU+qzrHceLe4MyRT0YPemJivRCsZo4U3YP
	L6Dc7s+10jtrrlNXElz7sIsfe8asSM2zeAgwBegG0VQsiXeo20mkXqUI7Ec4B/EAVxQnemRsoSu
	WcfFs4hqtSvtUYInJp7K/s08UBj1j1q4=
X-Gm-Gg: AYBFou3KoP1moV/qV1YeidtW2MDD75CIMkd8WMly9VM2Xjz/s3BL5NBMEYdi5cIVKM2
	oYKXamGYzFgD+eV7hMINTcIGVxEiQqoKz49/vpmbRI4GrqeCg98MmjSnJ5m6PqSU0bUog+x/Jdw
	ss9Vvt4R0YiBqhzxkHuan83gbGZeOFgF/uhjoqsPgiq678EGFjsQHjOAkiFr+b4JlroQ9TmA+2z
	5IcXTxU1ebBHniw7sv0yDwiXsloF83zIYG0TwHxgZcoeKI476w45L3fCDL7Ou4EudjrRQMyo8Fu
	a1xJCrxRDn19LnXwKFGe7gFeU7f9Phl8f7SWDBhww+qJsLnL2UhTIRhKPZp48AQi5xLjlwhZKOX
	cak4/sxw=
X-Received: by 2002:a05:6808:50a4:b0:4d3:6be7:c5e9 with SMTP id
 5614622812f47-50c4e67b316mr20247148b6e.24.1792077427501; Thu, 15 Oct 2026
 08:17:07 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 10:17:05 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 10:17:05 -0500
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
In-Reply-To: <20261015140502.87975-1-sj@kernel.org>
References: <20261015140502.87975-1-sj@kernel.org>
Date: Thu, 15 Oct 2026 10:17:05 -0500
X-Gm-Features: AclHuK_GMaQKMIsKIixwyygc0aElEhr0PiYnJJZwMfa1CmbK4jR8xC8YVujhE6k
Message-ID: <CANOyQmHhCJEbHpHUZ2P0hui+We7wxWkEde-Vh4k2rRXWovRYrQ@mail.gmail.com>
Subject: Re: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SJ,

I haven't seen this affect a real workload. I found it while testing
the DAMON sysfs interface.

If a tool tries to refresh after monitoring stops, the failed request
can delete the last snapshot. The tool then has no previous result to
fall back to.

I built and tested 66178e4ec30a and its parent cce0b334c310 with the
same config and reproducer. In three runs each, the parent kept the
4 MiB snapshot after rejecting the refresh; 66178e4ec30a cleared it.
Both returned -EINVAL.

Thanks,
Aveline Noir


On Thu, 15 Oct 2026 07:05:01 -0700, SJ Park <sj@kernel.org> wrote:
> Hi Avelin,
>
> On Thu, 15 Oct 2026 07:22:38 -0400 Aveline Noir <jm5905938@gmail.com> wrote:
>
> > Hi,
> >
> > On mm-new commit ad9f2d463666, requesting
> > update_schemes_tried_regions after stopping a kdamond returns
> > -ECANCELED and clears the previous tried_regions snapshot.  The final
> > result collected before "off" is then lost.
>
> Could you further share your use case that this behavior becomes a real
> problem?  Also, have you tried bisecting this to find from when this behavior
> was introduced?  If so, could you share the commit that introduced this
> behavior?
>
>
> THanks,
> SJ
>
> [...]
